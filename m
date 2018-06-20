Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F14C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B527B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oiu1o0Vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B527B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeFTJ4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:56:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39546 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751340AbeFTJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:56:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id w7-v6so2611262wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zac5Y0LicY3PLeRJ4OB35SJHiFjnTI1OZRueLJjzOk4=;
        b=Oiu1o0Viezksx/fxVy8I2updh2FCYLCPtUVPy0YuaW2yqWyRD9ACcn9ccuocTtbEyD
         1r5KKzPI2qTOXr/n9YnMsf4cHjaccd/qqLfpvL2CnyHqC4T9Sqrzl6wDTtitdvEjb9eQ
         21tYZrx8FpskuKszZzN8ai7pgezb/FDBStfuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zac5Y0LicY3PLeRJ4OB35SJHiFjnTI1OZRueLJjzOk4=;
        b=A2awV202Xzu67U0Yfwkt0FfPYTl2Fik5Fe5xYBlFggZToGUs7i41ZGMnfiJW3pH6PQ
         tVW+3ZySfa4AI0MSBLxPtwJKaYhs/Ytt2S3Um5dq3RSS8X+OZyMsSgSegZXUkKH2Z8td
         NKRmIbDTzyGY193QpfT2eHSKcovoiWeutuf+9Mvog+orCd1TsmgfQVHkzRtjjFXZziHN
         VwQ9gPY/EDsgw3/amekWeh+fuR1iaTDaPU2vooIrKaSqaOD460JVOHYjoAosROoWCe/J
         JhPIGMr1Js1SDrT7RHPB+kfCKHsMKWxkIIh8qBcqhdlnGRNmUbLCHXeBxkAZQ7EHJZ8T
         XGtA==
X-Gm-Message-State: APt69E2sNQl20jvprw6sZpfOLic24iWD/8FjytFkSXcnYJA2fWroZEGf
        VRwNgmtzJlYc1kEc2GLMMfkEgA==
X-Google-Smtp-Source: ADUXVKKfiwNxqm/JRUCEsHDkdnLdl1nH3kA9EQw9CfUfHQN/OS9L1iLz+Mq5ezPOh0v7B/cxYW+ZyQ==
X-Received: by 2002:a5d:48cd:: with SMTP id p13-v6mr18442709wrs.0.1529488560951;
        Wed, 20 Jun 2018 02:56:00 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id i4-v6sm1843099wrq.28.2018.06.20.02.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 02:56:00 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:55:58 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     paulmck@linux.vnet.ibm.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Kgdb-bugreport] [RFC PATCH 1/2] debug_core: move all watch dog
 syncs to a single function
Message-ID: <20180620095558.el5m5pvexz3dqdl4@holly.lan>
References: <1281330732-17164-1-git-send-email-jason.wessel@windriver.com>
 <1281330732-17164-2-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1281330732-17164-2-git-send-email-jason.wessel@windriver.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2010 at 12:12:11AM -0500, Jason Wessel wrote:
> Move the various clock and watch dog syncs to a single function in
> advance of adding another sync for the rcu stall detector.
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>

Small but sensible tidy up IMHO (whether or not patch 2 is altered).

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  kernel/debug/debug_core.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 3c2d497..e4d6819 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -470,6 +470,12 @@ static void dbg_cpu_switch(int cpu, int next_cpu)
>  	kgdb_info[next_cpu].exception_state |= DCPU_NEXT_MASTER;
>  }
>  
> +static void dbg_touch_watchdogs(void)
> +{
> +	touch_softlockup_watchdog_sync();
> +	clocksource_touch_watchdog();
> +}
> +
>  static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs)
>  {
>  	unsigned long flags;
> @@ -523,8 +529,7 @@ return_normal:
>  			if (trace_on)
>  				tracing_on();
>  			atomic_dec(&cpu_in_kgdb[cpu]);
> -			touch_softlockup_watchdog_sync();
> -			clocksource_touch_watchdog();
> +			dbg_touch_watchdogs();
>  			local_irq_restore(flags);
>  			return 0;
>  		}
> @@ -541,8 +546,7 @@ return_normal:
>  	    (kgdb_info[cpu].task &&
>  	     kgdb_info[cpu].task->pid != kgdb_sstep_pid) && --sstep_tries) {
>  		atomic_set(&kgdb_active, -1);
> -		touch_softlockup_watchdog_sync();
> -		clocksource_touch_watchdog();
> +		dbg_touch_watchdogs();
>  		local_irq_restore(flags);
>  
>  		goto acquirelock;
> @@ -659,8 +663,7 @@ kgdb_restore:
>  		tracing_on();
>  	/* Free kgdb_active */
>  	atomic_set(&kgdb_active, -1);
> -	touch_softlockup_watchdog_sync();
> -	clocksource_touch_watchdog();
> +	dbg_touch_watchdogs();
>  	local_irq_restore(flags);
>  
>  	return kgdb_info[cpu].ret_state;
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Kgdb-bugreport mailing list
> Kgdb-bugreport@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport
