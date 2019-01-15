Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508B020859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 06:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz4BR5+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfAOG4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 01:56:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44429 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfAOG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 01:56:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so804182pgr.11;
        Mon, 14 Jan 2019 22:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lgA604QTl/yEqXECru2x4UDjh+7W0tzUSdgMW3tISwM=;
        b=Xz4BR5+AiDdYExeqQANk38tiw4wHLlkA75DGjuwTcxffZcNu8hvtMQSTLOQjnYRJtN
         uDQ2dI4mE40tlIU7uYigpv7s4NqC2XSnbKqmQA8LLpvfhc5ZnLKzeWK3rUSXlE0UQFTs
         lJ9DAVX8WaOTnu3asdojuJRZkc8yTq3yeSv1vskeCSdL5zGCXu6Zs1CDARTUau+f9zT9
         cezvRWj0sGZbVvn7Dmqjrl4aypKX8vT5TTqwnzqf+dyRu6usX0xK28exnoO46QuMO+dx
         NW18NFaVqwr2JN9jamyHTM9BViUn/p+qxjG61tczPK6yOeyJkRRHpmAuRXge1PH0wSZV
         3wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lgA604QTl/yEqXECru2x4UDjh+7W0tzUSdgMW3tISwM=;
        b=BXRe8fcOSDqABQ6Ijc1UvIygdCC0teZLrzsxeHihNIndT704b9tprSRPOLJvw9YBUM
         b1Fw9Iasgd8xd9E8llEqJhq2VAOkqi15RJzCcXBd6mdpCdpeIZaO+guCmBG8u/dNpvmn
         4uOT5bWMslK3AsZcevlCxk1gX5mPsHDgLTDAT1iwJNzD4vFsCYUjJGhkFPsE6NTXdwzk
         eScqBNBo/dXzF27p6Y/Vy1uWA/qqvpjkuy0xp/1/qZ0+iSWUoHrubEDFiEKZhP1Ll7z4
         lTE50nkUtP7Qt9f7q31EeWUoGYAf4/7LsW4kxZ24YyvLwCCZqQvlOBeKjvUJs33nrnQh
         tz3w==
X-Gm-Message-State: AJcUukdlNSec0sk6igTrgcS8YAjX/a95TVKvrQXy5CfsaNNGT+xJMMcM
        RznAFavlXI6M6zA13ClsQTQ=
X-Google-Smtp-Source: ALg8bN44miKJOkvp1c8EAA0O46L3fa8Ar+nfQS2d/gcRVBX7eNMXjj7fO4D7i6OOqGepgZk7hbnJYg==
X-Received: by 2002:a62:2292:: with SMTP id p18mr2547351pfj.9.1547535362457;
        Mon, 14 Jan 2019 22:56:02 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id i72sm4003432pfe.181.2019.01.14.22.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 22:56:01 -0800 (PST)
Date:   Mon, 14 Jan 2019 22:55:59 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: protect pending flags in ceph_con_keepalive()
Message-ID: <20190115065558.GA7165@myunghoj-Precision-5530>
References: <20181227190842.GA19565@myunghoj-Precision-5530>
 <CAOi1vP9G=-ZLBKH6Y5MoDRUjX4YkN6GUWKm1=fnM02odQX8GWA@mail.gmail.com>
 <20190103035027.GA26674@myunghoj-Precision-5530>
 <CAOi1vP-FC+X+DeLMBcefYuSjxzLgAsxQg+RNskaZsUvVbmXuYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP-FC+X+DeLMBcefYuSjxzLgAsxQg+RNskaZsUvVbmXuYA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:37:25PM +0100, Ilya Dryomov wrote:
> On Thu, Jan 3, 2019 at 4:50 AM Myungho Jung <mhjungk@gmail.com> wrote:
> > I reproduced on vm using syzkaller utils and verified the fix by syzbot.
> 
> Hi Myungho,
> 
> I think this might be a better fix:
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index d5718284db57..c5f5313e3537 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3205,10 +3205,11 @@ void ceph_con_keepalive(struct ceph_connection *con)
>  {
>         dout("con_keepalive %p\n", con);
>         mutex_lock(&con->mutex);
> +       con_flag_set(con, CON_FLAG_KEEPALIVE_PENDING);
>         clear_standby(con);
>         mutex_unlock(&con->mutex);
> -       if (con_flag_test_and_set(con, CON_FLAG_KEEPALIVE_PENDING) == 0 &&
> -           con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
> +
> +       if (con_flag_test_and_set(con, CON_FLAG_WRITE_PENDING) == 0)
>                 queue_con(con);
>  }
>  EXPORT_SYMBOL(ceph_con_keepalive);
> 
> WRITE_PENDING can be set without con->mutex held from socket callbacks.
> This is the reason we use atomic bit ops here, so testing WRITE_PENDING
> under the lock didn't make sense to me.
> 
> At the same time, KEEPALIVE_PENDING could have been a non-atomic flag.
> I spent some time trying to make sense of conditioning queue_con() call
> on the previous value of KEEPALIVE_PENDING and couldn't see any, so I'm
> setting it with con_flag_set(), making ceph_con_keepalive() symmetric
> with ceph_con_send().
> 
> Thanks,
> 
>                 Ilya

Hi Ilya,

Yes, it looks clear and makes sense to have an atomic operation in if statement
but it still triggers warning. KEEPALIVE_PENDING should be set after
clear_standby() because con_fault() can be called right before acquiring the
lock here which sets the flag in standby state. I tesed the change with syzbot
and confirmed there was no warning.

Thanks,
Myungho
