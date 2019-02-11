Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9102FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7E02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549870275;
	bh=YuIxbco53CaiC+Yr/JoFQGobjBIUetmTvmtV1ZRrO7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z925GyfnzIu4D05YV5ClMZYB/oOtucdKpd36uCYWt6/244YbIytO/qy/DYXmjblti
	 7+rsVKKRdR6lP5B3syaMPU6Dy3D5BT6LJkdZjjgwxPu44QuR460+kfjyxKZfJRiy3b
	 /bq68UX5oNBj/yI5Jwy+hwNX+z5gXD6PpJrgw7Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBKHbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:31:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40811 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKHbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:31:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so14904652wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 23:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=51Qe1V6B4SIABTH74MigaU4YMAk/o3qreP0X0ddRoic=;
        b=YEb/a/JhO/ag3sgCPK+bOyLNOU7PX3Plfa/2LsRHDsJTDMPSYdGqhuYb/F4/phKdhQ
         +RGD6eSxwIDNJGB3iu3JtgmG0vywUZcBU5Xdk7tgXYh6M0ALmidHWDTAk4OcppnCYvwA
         +beFb+v/H4dLs5lGmwdPlhArhyGmeU2g+BFyLqYEEQNKsqmj/ma3STWBauxoDZDq8qRt
         feUSycHxUro01Cor5IuSlVQyrbWniRght6IdFEuXhDr7PodXDv0cvLQ/GL/gwU72l7Oa
         n6fsGywXi6BAwVDxoQUIy6VoiLDgHfzikps5F6uas520gmfiyPsdl3zs16H69zWRFuA6
         9c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=51Qe1V6B4SIABTH74MigaU4YMAk/o3qreP0X0ddRoic=;
        b=ODSB7U+Qi+fhe5hwL0pTlLV6aYkso16b6yUirvZXl2LEVyAwqJ4hCe7LZTSwIu/kp5
         sYFz5x8XZlJz/3wlZvgZ4KOmIpR5m1Qa7TYCOzTDRbKSrB+T1YohXJ2hNqgoW9gdWrOI
         te8cavoY32JE+YtucWJNTAl2ivDtqOJ5FLd78KwCZ31q8eHLvt+uwtePJw1VR2+q6piU
         ws+pRGG04TRrVuHjsXWVpgzNnHVDT2YOGGcxQ6qwdlt726MS2/kfhi+9EymVT7LGbIH6
         +ObowXBpD+CwzZ2M7Adrv/9DXSqu+RZbAT+DkSwChuU3xD2S+PduxeCq2tViMhQGddPL
         xuBA==
X-Gm-Message-State: AHQUAubY3nDv20a6IVQ4QOI68JkUnCaAP5vko0PGa/T7mEnA1o/4CIIe
        AhoByJL4hN+Uhj+z6BL5Ik8=
X-Google-Smtp-Source: AHgI3IaPCnmEzoh2Y8Ytr2KQU3v0osYlj+P1olZ3Ml6xXWUTPAopN80dUIpvOV2xReQcm3Z0vrSBdQ==
X-Received: by 2002:a1c:9e94:: with SMTP id h142mr7743370wme.4.1549870271698;
        Sun, 10 Feb 2019 23:31:11 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f8sm7556874wrv.41.2019.02.10.23.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:31:10 -0800 (PST)
Date:   Mon, 11 Feb 2019 08:31:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 1/2] sched/wait: introduce
 wait_event_freezable_hrtimeout
Message-ID: <20190211073108.GA106308@gmail.com>
References: <cover.1549564792.git.hle@owl.eu.com>
 <83f5fae47b56e79aebaddcaecff1c1a6d9c292cf.1549564792.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f5fae47b56e79aebaddcaecff1c1a6d9c292cf.1549564792.git.hle@owl.eu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hugo Lefeuvre <hle@owl.eu.com> wrote:

> introduce wait_event_freezable_hrtimeout, an interruptible and freezable
> version of wait_event_hrtimeout.
> 
> This helper will allow for simplifications in staging/android/vsoc.c, among
> others.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
> ---
> Changes in v2:
>   - No change.
> 
>  include/linux/wait.h | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 5f3efabc36f4..c4cf5113f58a 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -483,7 +483,7 @@ do {										\
>  	__ret;									\
>  })
>  
> -#define __wait_event_hrtimeout(wq_head, condition, timeout, state)		\
> +#define __wait_event_hrtimeout(wq_head, condition, timeout, state, cmd)		\
>  ({										\
>  	int __ret = 0;								\
>  	struct hrtimer_sleeper __t;						\
> @@ -500,7 +500,7 @@ do {										\
>  			__ret = -ETIME;						\
>  			break;							\
>  		}								\
> -		schedule());							\
> +		cmd);							        \
>  										\
>  	hrtimer_cancel(&__t.timer);						\
>  	destroy_hrtimer_on_stack(&__t.timer);					\
> @@ -529,7 +529,23 @@ do {										\
>  	might_sleep();								\
>  	if (!(condition))							\
>  		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
> -					       TASK_UNINTERRUPTIBLE);		\
> +					       TASK_UNINTERRUPTIBLE,		\
> +					       schedule());			\
> +	__ret;									\
> +})
> +
> +/*
> + * like wait_event_hrtimeout() -- except it uses TASK_INTERRUPTIBLE to avoid
> + * increasing load and is freezable.
> + */
> +#define wait_event_freezable_hrtimeout(wq_head, condition, timeout)		\
> +({										\
> +	int __ret = 0;								\
> +	might_sleep();								\
> +	if (!(condition))							\
> +		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
> +					       TASK_INTERRUPTIBLE,		\
> +					       freezable_schedule());		\
>  	__ret;									\
>  })
>  
> @@ -555,7 +571,8 @@ do {										\
>  	might_sleep();								\
>  	if (!(condition))							\
>  		__ret = __wait_event_hrtimeout(wq, condition, timeout,		\
> -					       TASK_INTERRUPTIBLE);		\
> +					       TASK_INTERRUPTIBLE,		\
> +					       schedule());			\
>  	__ret;									\
>  })

Looks good to me - unless PeterZ objects I suspect this wants to go 
upstream via the driver tree, not the scheduler tree:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
