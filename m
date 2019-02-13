Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1308C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89765222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKjafkJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390779AbfBMIs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:48:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42203 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfBMIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:48:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so1482441wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cEpWGg1h+mnrJufQh7Ng7TE3wjG5O41fk+jfrTVIKNw=;
        b=cKjafkJTYOLTG4ho2NBdRPJuHJRUCROn4QQLCiVbiDKGab2p54QMizO3CM961ycXJZ
         6ukqMH1AnlS8ifhPgvvl/2NuL3ExnBDBtdcHB2BdmbEOxvLNdsLaL9z2JtvdIVOyOUJW
         lRPcc1gKVg1rwxPUDZUb8tXECWg9feqt5L6YKKJrNVfuk+qAvRaLvQijCUAURYOlow7Y
         tm3HrdXcy5sDscxbsT0WFLJ2MyoZaDmouiXCLqTvSqu/i0OWudWvbe80G5dsw7qP7GsW
         9OfNgpdmACEAB9Sx7Auhupq0lE6wheTuJtY/TfllBM3gLTKOSptHAQlymzS0Xt6O6ET/
         HfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cEpWGg1h+mnrJufQh7Ng7TE3wjG5O41fk+jfrTVIKNw=;
        b=M9T0QpfUcFr64A22twknjZr7e39cbSPlXY8M8pribbuqOeAjqwEC0MkbAVbRg3nAxJ
         sRoVgC235isGusj5aMHQ5R+otMFQ+RwbCQc88zFiapcgp5ZxvnH/AI60VU3M144vBSoS
         3fz+xRBrrLNuYpvCwEwaOuX0/GQqEmNSzcGJoc7ipEPbAWDGUGE4kRzJduHWWvoz67GX
         9bzWfwHT33fE/P3gU86VAY8OVu/TFuZGoPz/ppfOpJtsipYqjG7TqO1m8rbjwfHzDGkB
         z3nBy4rW2kJ9ZdNl39/buSp28O+TnHl+FyGR9uRlyaG8BYWkWA0djgnr5cSac3FcKwLQ
         fJTw==
X-Gm-Message-State: AHQUAub4Wgm54U6WG1T06VRcK5PM1WGEEcUEp/G0Zz4QzSFH2Z34tUNo
        XeHzYoylGgf+QSFj/QyQE9AtIg==
X-Google-Smtp-Source: AHgI3IZxSryTmgOpTAXNToofH1y31OBOFXU/hKGdkp6Qr9p5XiWEADAeifWveE9JMRRTS+EDLC3SMA==
X-Received: by 2002:adf:9f48:: with SMTP id f8mr6314943wrg.151.1550047707235;
        Wed, 13 Feb 2019 00:48:27 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id w16sm11901697wrp.1.2019.02.13.00.48.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 00:48:26 -0800 (PST)
Subject: Re: [v4 PATCH 6/8] clocksource/drivers/riscv: Add required checks
 during clock source init
To:     Atish Patra <atish.patra@wdc.com>, linux-riscv@lists.infradead.org
Cc:     Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
 <1549969812-22502-7-git-send-email-atish.patra@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7bd250fb-c896-64e1-d73b-6f3dd284e2d6@linaro.org>
Date:   Wed, 13 Feb 2019 09:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549969812-22502-7-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2019 12:10, Atish Patra wrote:
> Currently, clocksource registration happens for an invalid cpu for
> non-smp kernels. This lead to kernel panic as cpu hotplug registration
> will fail for those cpus. Moreover, riscv_hartid_to_cpuid can return
> errors now.
> 
> Do not proceed if hartid or cpuid is invalid. Take this opprtunity to
> print appropriate error strings for different failure cases.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Do you want me to take it through my tree ?


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

