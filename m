Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E776E222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NN+GXW5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbfBNKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:24:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45290 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfBNKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:24:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so5800140wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UMBFCAKL92/Q/MudKCxdvcCfgzMzaNRtyfpVp1Xip9U=;
        b=NN+GXW5OwtOog0fhdY6oVfREZ2kPBXclT+/OkDuXIxa1osiCxeAlT/pLmV6PLRzQgB
         /D5n/jv3cpbVdqUwJMuDtr1ogLNZwSSCYlrgBQWk6bVvncvbZ7RCQkLNCXHLkIqYTHg8
         KgGExCHMqV0R2lbrGWzYEsz2kSxAd8xf6a9CKzqPLWpp0h7P2IjwE3TVcYj43c0gaOQz
         XdNBH1Kz3wUBzIVTVOWu339IItxeq2WaBQBn80nFSi9cQs+SwmyckGNpFZGdFvAbHcCY
         1ytBPGV4kPVauYaICy113k2rrIwGhUJ7FtPSgy7K8nQEvEHab7O0xd6/r1g4PW3yuamr
         c4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UMBFCAKL92/Q/MudKCxdvcCfgzMzaNRtyfpVp1Xip9U=;
        b=nDrfjTmVoYN+4TmI5cDU/hb0hIvrwY1w/aLq/dlvXC6lLWtk7/iDMcE1d98hJ56vz8
         Cm/J/GNuUfl1yKmlklN/jaU9nyk/+Iu5CCoBq7ZdZJeX1InpNrCGOcnD1XHvlkSeeF7M
         Z9+D77ly1b2rKgEwam/EPWyOPPGeudhIcqxvky+BP/tVQNwmfjZrbCdfyDRM5Pj9TnNs
         qvqKhkS6+X8bK/Blc3sxRq/n+En7qjEjxJo+bm0xTqmpDCVItlMJphETBMRCY2UK4dqJ
         pjE/HujsYrjXNsseaeQ1tc06EEpE3DMuoFQoQBzH5sqg0XLX1OGOQgspvT0Y4bhmj7TS
         iang==
X-Gm-Message-State: AHQUAubuep2sw0ojkxIFxPm81GdNjy4xtPYB/P/YeLbe1f6VptPhx/YX
        kG3qeC0YDHebbdkSsEORQg+DOA==
X-Google-Smtp-Source: AHgI3IbjB3YttdZp6MnipTngwslPbQ3Xy73uZ2lNUUi03kZMsryha8F37ZlYZb5z25rN8BvagF1Lbg==
X-Received: by 2002:adf:e290:: with SMTP id v16mr2337596wri.100.1550139872790;
        Thu, 14 Feb 2019 02:24:32 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 126sm2304113wmd.1.2019.02.14.02.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:24:32 -0800 (PST)
Subject: Re: [v5 PATCH 6/8] clocksource/drivers/riscv: Add required checks
 during clock source init
To:     Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org
Cc:     Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
 <1550089092-28783-7-git-send-email-atish.patra@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bf8f0535-26d4-843a-d89c-8ab235411b4c@linaro.org>
Date:   Thu, 14 Feb 2019 11:24:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550089092-28783-7-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 21:18, Atish Patra wrote:
> Currently, clocksource registration happens for an invalid cpu for
> non-smp kernels. This lead to kernel panic as cpu hotplug registration
> will fail for those cpus. Moreover, riscv_hartid_to_cpuid can return
> errors now.
> 
> Do not proceed if hartid or cpuid is invalid. Take this opprtunity to
> print appropriate error strings for different failure cases.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Hi Atish,

I applied this patch for 5.1 with the typo fixed and the reviewed-by tags.

  -- Daniel

> ---
>  drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 43189220..e8163693 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	struct clocksource *cs;
>  
>  	hartid = riscv_of_processor_hartid(n);
> +	if (hartid < 0) {
> +		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> +			n, hartid);
> +		return hartid;
> +	}
> +
>  	cpuid = riscv_hartid_to_cpuid(hartid);
> +	if (cpuid < 0) {
> +		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> +		return cpuid;
> +	}
>  
>  	if (cpuid != smp_processor_id())
>  		return 0;
>  
> +	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
> +	       __func__, cpuid, hartid);
>  	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
> -	clocksource_register_hz(cs, riscv_timebase);
> +	error = clocksource_register_hz(cs, riscv_timebase);
> +	if (error) {
> +		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> +		       error, cpuid);
> +		return error;
> +	}
>  
>  	sched_clock_register(riscv_sched_clock,
>  			BITS_PER_LONG, riscv_timebase);
> @@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  			 "clockevents/riscv/timer:starting",
>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>  	if (error)
> -		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> -		       error, cpuid);
> +		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
> +		       error);
>  	return error;
>  }
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

