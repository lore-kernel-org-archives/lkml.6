Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091A9C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DEE2089F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=evidence-eu-com.20150623.gappssmtp.com header.i=@evidence-eu-com.20150623.gappssmtp.com header.b="ZYGXIXju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DEE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=evidence.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKHUdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:33:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36110 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeKHUdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:33:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so754184wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 02:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=evidence-eu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACAP4ZxbcC2MUD/08hrvNKsWW1ZR3xgu6UsTFMVtww8=;
        b=ZYGXIXjuIN4bDLSZ+3JAa7EexVqyScCZ16NKlZuNaPSKjopQDo0KcdRJ5CXfZxx8zV
         S1Isx+k+k1gDe3qf01ZgoWE7pwR/hAGCx3+hFNGlO8CZs3esMYgs3WHEU47yWPqIT1v9
         auK5SSSfbthaNNVFuvPPMkdIzJiiXywoz0VW+fppM26N+DTPq0nrQMAnPVdm2vl82mcW
         /uwRPaK6p1K6ku6HR2IJar8/VCTr4zag8LxAWqKeuADMluHIpL+tyVj/+AmgzY7Q/mlu
         PvxOTg8bcnhFXtRWcgRzS2MMaejZXN+OlTcG/Q8kID9cLNTCvRjesNehS7FlYBWlBGl6
         lafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACAP4ZxbcC2MUD/08hrvNKsWW1ZR3xgu6UsTFMVtww8=;
        b=kO4dj8KjUAnduIBR19yfdT8f6HngNRAEJrI/GrHO+HZhpPeesozz2uegWYkEoU6gs/
         ke5TyRXJzd/jwB9DdatIly+ORqQN/3GS9tMT60utj3+BgiT1x8C7lAy2oHO54GufSTws
         pieyTYCwYk8ETJnHE8KZ1qQTGWyVlvxCz7HYflH4JsypsTJW5a/sKwJphGxUrObWWYLD
         72zMf1ZjmQpGsUOQRX8DuM0AY+IVVTjoSW2HTelFlWnTE7geLYtJW6FMrnk0yuKjvftX
         4Du16T/sRPBzZBKG6WWGc0nW65dgao0AnW6qXTBWdeJSypayCes+KM4phRk7gcq9GoMX
         91yg==
X-Gm-Message-State: AGRZ1gJRyYzslcbu9AoQBP/dz+NFvkYdRKRg+3QGBHclblmoNA4C0Iy0
        PkyRdogceOtJB5MPCxHd3EVdzg==
X-Google-Smtp-Source: AJdET5cPOcO9y7orXFFHEWhytIMbpTf9lXlX99z9N1kTBlb2WzbiycgFxHFa0HBaB5y0QxhPYJGi3A==
X-Received: by 2002:a1c:4683:: with SMTP id t125-v6mr832037wma.112.1541674690889;
        Thu, 08 Nov 2018 02:58:10 -0800 (PST)
Received: from erbrow (host92-93-static.8-79-b.business.telecomitalia.it. [79.8.93.92])
        by smtp.gmail.com with ESMTPSA id y2-v6sm7770709wrh.53.2018.11.08.02.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 02:58:09 -0800 (PST)
Date:   Thu, 8 Nov 2018 11:58:08 +0100
From:   Claudio Scordino <claudio@evidence.eu.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, bristot@redhat.com,
        linux-rt-users@vger.kernel.org, mtk.manpages@gmail.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to
 check_dl_overrun
Message-ID: <20181108105808.GB13282@erbrow>
References: <20181107111032.32291-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107111032.32291-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 071118, 12:10, Juri Lelli wrote:
> check_dl_overrun is used to send a SIGXCPU to users that asked to be
> informed when SCHED_DEADLINE runtime overruns occur.
> 
> The function is called by check_thread_timers already, so the call in
> check_process_timers is redundant/wrong (even though harmless).
> 
> Remove it.
> 
> Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  kernel/time/posix-cpu-timers.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index ce32cf741b25..8f0644af40be 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
>  	struct task_cputime cputime;
>  	unsigned long soft;
>  
> -	if (dl_task(tsk))
> -		check_dl_overrun(tsk);
> -
>  	/*
>  	 * If cputimer is not running, then there are no active
>  	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
> -- 

[ Superfluous as (fortunately) already queued...]
Tested-by: Claudio Scordino <claudio@evidence.eu.com>

Thank you for taking care of this pending issue.

          Claudio
