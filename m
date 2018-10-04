Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF6C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C9020877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTzW9MGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C9020877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbeJEBy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:54:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJEBy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:54:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so3588192pgs.1;
        Thu, 04 Oct 2018 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ByrrTnNKG2Vk0e638TtaEFEqX7jB+JOThk7pu3SU1H8=;
        b=dTzW9MGKgZm7H0fZ6OdXQxb9DisUc8f4C+l1m6vFHJsnMBsBiCWmcbwDSag7msCjNI
         Jf8cIp2iotlP6+oFEqUy+ZvRNU513lcSxD5gCuzHk86Cef2i0XQa+RLBrWQUB/LsiXMW
         PDc2LGFyQyW+3wOho2rDkQQ+IfgxEYhVR2hxPVq11ri4hZE8ENy8qV4+t3BZAYANgyIn
         vJfDU3Lb42FABJrDdL5rffhcsGjzSnTVluN5U7Y/0kJSB9PO8aU9c4i3Ght/We4Vay1t
         G3Fy7pJCNH+FVnqjb0/xeBPj3JMHkBdePC6HJfVO3YdnAJsVCnrMuYYbHikD0iHZP/Zm
         8UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ByrrTnNKG2Vk0e638TtaEFEqX7jB+JOThk7pu3SU1H8=;
        b=D5Agx9lC0ZPHoYlOZKTX9fGZcPPuS0ynq+ARFM45crUBRhb1WmH2+kR/NHh0MImk8z
         fVCfEPlnhIfE48aEny6UysQnTbzkHuf/SFBFbVnqiewegzQ4jmh0OwoClDqZJOpGrhch
         72FSzvcPkq6m89GOsnkw7APQT+sYptYZGkBVqv8TkJfb76i8aT/tvf3MfxjhDvwiZWKT
         0gJbqsOZlO4eDkuHc0KSik7NOfRJUCSZsX5au6YDV+0gCwL0S89d+JmBzNv40mT2V1RC
         HFOr3IittiZDXrHk+k/ZAxlNo+OamDpNCpvUgQpe0hU1gjiYpRlZ2TdvwYZ13Y4m4mSo
         jx9g==
X-Gm-Message-State: ABuFfoiTOf96sBZrTEvlekriTeKl/8wj8sgOtWxCs200hVdqBghpfdS6
        fdOQlLxYndTY1FLc8CwAaZz1yEIpcDM=
X-Google-Smtp-Source: ACcGV60UftP5aVTJ+201BQGjQAICFDpG2TZAqH64tEN/QFsMs7qDdKUgVtKr8ePdRATgOF+scY18TQ==
X-Received: by 2002:a62:c8c3:: with SMTP id i64-v6mr8280765pfk.183.1538679592998;
        Thu, 04 Oct 2018 11:59:52 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p7-v6sm11007052pfb.101.2018.10.04.11.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 11:59:51 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:59:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-input@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
Message-ID: <20181004185949.GA233675@dtor-ws>
References: <20181004154749.111595-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004154749.111595-1-edumazet@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> syzbot was able to trigger rcu stalls by calling write()
> with large number of bytes.
> 
> Add a cond_resched() in the loop to avoid this.

I think this simply masks a deeper issue. The code fetches characters
from userspace in a loop, takes a lock, quickly places response in an
output buffer, and releases interrupt. I do not see why this should
cause stalls as we do not hold spinlock/interrupts off for extended
period of time.

Adding Paul so he can straighten me out...

> 
> Link: https://lkml.org/lkml/2018/8/23/1106
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/input/mousedev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> index e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347 100644
> --- a/drivers/input/mousedev.c
> +++ b/drivers/input/mousedev.c
> @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file *file, const char __user *buffer,
>  		mousedev_generate_response(client, c);
>  
>  		spin_unlock_irq(&client->packet_lock);
> +		cond_resched();
>  	}
>  
>  	kill_fasync(&client->fasync, SIGIO, POLL_IN);
> -- 
> 2.19.0.605.g01d371f741-goog
> 

Thanks.

-- 
Dmitry
