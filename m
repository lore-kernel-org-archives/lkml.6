Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FACBC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC87217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeGyDJmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC87217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeHDTdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 15:33:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39312 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHDTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 15:33:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id q8-v6so9802333wmq.4;
        Sat, 04 Aug 2018 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rDCc+1pbzDhtKlyEZt94GtHgCQyOS1ly/P+5CzkzmV4=;
        b=TeGyDJmceqLYK4+pc+ZUQzSFlQnBRRRxn2Dn2yjIMh2yD8nT3iP4iythhu3EUgVR9l
         ujeVdLr1/GkSRNZG0a9YbvBYclLOv+Zh63A4VEIRdvyKrPiNdV32sRnKzMT04SsCj7In
         FN4aApMj1eU+XAKo5dw7A0xA0S1oMygRIiBj051dTfFHnjPKPWKiVwrDnM5rA7xLJldJ
         CZgTmKMcCU2UipC/9Yn1NRtdW3J1Msz0lDNdT4hU2ooAdyP5G31pFBFX4dpQ3MjGZ61h
         jphJ+kj6w9YZ45IjnKNRj7IhVzIYF6Q9yXsR0Ftppw2vBRj+tBMh96Voex3009RCh2p1
         yckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rDCc+1pbzDhtKlyEZt94GtHgCQyOS1ly/P+5CzkzmV4=;
        b=Y7K7MSVBAP6KDj3KNe9hk3hV31u66Dm0DDxk+UrQTALxFak69rBdbObVwKT8vhiI/c
         aPez0BTFrq6RYxGFV4XQAjX9zdx6++3J/i5RP/zK28rkaDB7lZ/MfSo3ndaapwCc40oY
         PYWAtKO4YFIqR5/s8w8Tgq/bVey56dIr3k+24J/K1v9x47bEIcTwGisPf57fTeNjB/SN
         98ri3ay5/SGyDcwZmR7KOlsJytf0aFBz1lZl1BuOZRVPDvju3VEV0iOLtI+EtI2bke09
         xHjEcJHBuvUldBNXtzcmOzXCydpbCXppzlcoDhQsd3r8V+lurnnffv3sodeu1fUpz6v/
         URYQ==
X-Gm-Message-State: AOUpUlHVrZpATySDbYDfVFBdMbXpNhUaXybH/Cp3m1y7joU2tCh6If1V
        B3kQNngI/DP0O0WwOtFnxp4rd6iI
X-Google-Smtp-Source: AAOMgpeiTr4YSzxruBbcyTWEF9MEdaF/SgXfwLCwDzjAyjyBD5sPXwBxVpNRvsMIV7UaSADOMVZjag==
X-Received: by 2002:a1c:e146:: with SMTP id y67-v6mr7467688wmg.108.1533403911813;
        Sat, 04 Aug 2018 10:31:51 -0700 (PDT)
Received: from [192.168.178.21] (2-230-197-194.ip203.fastwebnet.it. [2.230.197.194])
        by smtp.gmail.com with ESMTPSA id v6-v6sm958654wmc.43.2018.08.04.10.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 10:31:50 -0700 (PDT)
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy()
 interface for no_turbo"
To:     srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180804152932.3861-1-gabriele.mzt@gmail.com>
From:   Gabriele Mazzotta <gabriele.mzt@gmail.com>
Message-ID: <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
Date:   Sat, 4 Aug 2018 19:31:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180804152932.3861-1-gabriele.mzt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2018 17:29, Gabriele Mazzotta wrote:
> This change does not take into account that some BIOSes change
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
> If the turbo is disabled when the system boots, policy.max_freq
> is set to pstate.max_pstate. However, if the BIOS later enables
> the turbo, the CPU will never be able to run at pstate.turbo_pstate.
> 
> Since now intel_pstate_set_policy() does its calculations using
> pstate.max_freq and pstate.turbo_freq, we can always calculate
> cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
> with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
> speed when the turbo is enabled.
> 
> This reverts commit 983e600e88835f0321d1a0ea06f52d48b7b5a544.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3c3971256130..4043aae2d611 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2068,9 +2068,8 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>  	/* cpuinfo and default policy values */
>  	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
>  	update_turbo_state();

Commit 983e600e8883 added this update_turbo_state() call, but it is
needed by intel_pstate_init_acpi_perf_limits() here below. I should
have mentioned it in the commit message.

However, I've just realized that a similar problem to that I'm trying
to fix can occur on those systems where core_frequency is adjusted
depending on the availability of the turbo.

The call to update_turbo_state() could also be moved in
intel_pstate_init_acpi_perf_limits(), right before the check on
global.turbo_disabled.

> -	policy->cpuinfo.max_freq = global.turbo_disabled ?
> -			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
> -	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
> +	policy->cpuinfo.max_freq =
> +		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
>  
>  	intel_pstate_init_acpi_perf_limits(policy);
>  
> 
