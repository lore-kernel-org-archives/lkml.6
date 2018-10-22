Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938EAC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE2220651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQd6s/W9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE2220651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeJWBWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:22:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38747 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWBWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:22:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id f29-v6so20225179pff.5;
        Mon, 22 Oct 2018 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbfS97ueMh/U3Uc84irH8w2tyfm3vAFNCKyGURRujkI=;
        b=CQd6s/W978y7rX/gbBfjV5SaJXoTv2FTXbUGfRY/UCI+kU6MI7uDxGgIntkx5V6lx4
         EcNjtoO9FtvVoAdzawfzkiJDWyZOaZKg8hXBdgfOtOMlYxKkrEY1mSXCgbHxwPpZEya9
         5aAMePIA397cnxeKcLQPv8krZ0I+8kmY/vG6UenYsGrDPvIUQBVgetCSMcUkDCU6z/0c
         5v+pnRJkBESI0gTMq7aJ95FChbcWZfuY+qTy7OVLAnCaRVZ1wA9Y7VdlwBi5YJHoRSuN
         GYLPFAi3iZ157s0s2cFDSVqGULzaTlwuuBFtYrZ/mdGaeX4qYILcO5SkcQEkusgjapqp
         tIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbfS97ueMh/U3Uc84irH8w2tyfm3vAFNCKyGURRujkI=;
        b=DXSpEA5ziMNLfrqMLSvDZF/kE+FogsY5ArgaOvHP0xOZx5uJRwBqggWzlK+3tImXP6
         z8yVZ6s6URCgfAx/xDvYgl6goe+KmMKTZv0AhdyLljpokzFxXvmd0H9OY4WyTAZ9b+zf
         7LTMCEALBEktgJlb2YFzPSXvOTQA0O8eyk9MkUwhjzPWqqsqAo9Ff8r0tM57IlvFWATm
         wnLp2BmtLLvRoJ2Fh+jgoKVxoCJ4aJG9v9cnFcC1+HpSfuYqBt3pFzW7Lccpb+mBgSfC
         vMwJtSRJJhKdjcqDauqeA+e79ld5t4Qo0VuZLFUBUqvtb+EHpJ/ypAlbF/MyybBLYIs3
         p5tQ==
X-Gm-Message-State: ABuFfohm7oe+St9+43SOQVWRFE1vjX4TrqqejL6raU4rcIjPeoXWRV7D
        2kVF6U2MQthSQgoWOY24GqXHN69A7qg=
X-Google-Smtp-Source: ACcGV635iwThS+q6mLtvCt57JDEAGzgnlnJLh3XFkBZLfTWE6fKR5atSj9q62/UE17xh3gG+vLhQEg==
X-Received: by 2002:a62:1f9d:: with SMTP id l29-v6mr45544391pfj.121.1540227768203;
        Mon, 22 Oct 2018 10:02:48 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n7-v6sm32235549pgv.63.2018.10.22.10.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 10:02:47 -0700 (PDT)
Date:   Mon, 22 Oct 2018 10:02:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.18 08/27] Input: evdev - add a schedule point
 in evdev_write()
Message-ID: <20181022170244.GB27929@dtor-ws>
References: <20181022101924.40531-1-sashal@kernel.org>
 <20181022101924.40531-8-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022101924.40531-8-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, Oct 22, 2018 at 06:19:05AM -0400, Sasha Levin wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> [ Upstream commit 36d2582ff235b4e01ad64a734c877a52dc762d9c ]
> 
> Large writes to evdev interface may cause rcu stalls. Let's add
> cond_resched() to the loop to avoid this.

This is not needed in stable:

- the interfaces are not accessible for unprivileged users so there is
  no DOS concerns
- the issue can only happen on non-preemptible kernels
- the issue only showed up with synthetic test and not real life use
  cases
- this is not a regression

The same goes to similar patches to mousedev, joydev and uinput that you
autoselected.

Thanks.

> 
> Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/input/evdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c81c79d01d93..718d5622267d 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -564,6 +564,7 @@ static ssize_t evdev_write(struct file *file, const char __user *buffer,
>  
>  		input_inject_event(&evdev->handle,
>  				   event.type, event.code, event.value);
> +		cond_resched();
>  	}
>  
>   out:
> -- 
> 2.17.1
> 

-- 
Dmitry
