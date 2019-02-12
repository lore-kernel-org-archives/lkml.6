Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E72AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE2221773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+M+GeOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfBLJP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:15:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43054 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfBLJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:15:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so1766318wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=naHq3JAsKTQBTMdAufMA9vX5f6pogu5ad5BwYCVfZpY=;
        b=G+M+GeOqid2G2UraPPaIIMYijXMCnETN/+snpEXyLkbO9aOz/hiI+v5xRMAcytpBF5
         KmTjz80ZEpJFfHXRuKTKFtFYISBV4R64LxZmwK+8JEwxncx2vqwkgNGQFEsKmO3lHLLi
         0ThQqLDvy4VdtGGH+Pmwq/eiQhMPExm2xGd2wJg4rxUH+wGnAvd9aphsWRjD8o1IydrN
         SJQbksWYmBgqhnrvMw9PL6nYAFOEZkhK6dT2UwVgiy+8v/rl7N0BIuoRHLyu6DTCEW2n
         /a8ulIIg4JMfdjDad0+d0XNbIHsJP2MWcdTGVX57CTn+30AqC5RNZMgZyEHkz+4/T7nL
         RErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=naHq3JAsKTQBTMdAufMA9vX5f6pogu5ad5BwYCVfZpY=;
        b=uZdhsb1xZ/+Fq7+sAMoxHh8aYfiJw63twcgX8FXbfqSq6Cmn1l+BZlBRH4j4SispPd
         TJo98c4yTaUkt1KRu/pMcQux7SE6d48DYjhmv+Ar4SMf5g9/xERnnuixthG0RI5rxk4w
         mSmCdUOC2JUGMvi1fxUXwUFuU3dzSQsf5dzUHjFKPxjcI8rNakptUKJ+k8Q4I1dgVZLl
         L8APz0xY6fuJqdcsMw6Vg22rrfWEfOGaN1XNPBsuifxkHJdsw67MluPxjK+JYr72HcN/
         kcnmLwdfGydJyc33IC76qsTdmF4k2q/EmKOrWzUMmsvW7XR0GN6qE148zh6mVvpNtoKU
         OVBw==
X-Gm-Message-State: AHQUAubpOCv7Syff/ajAwSo8ymfZUxSTaMYZKlBIvd3EdD469QJ5CLhU
        VhOZLWBWgx1NxYbuYWOr3nV7Yg==
X-Google-Smtp-Source: AHgI3IbAwWQgMs6yQy3m8ojm0owzi85MgfvkdRjSHPs06uBnTx/Vdgit+41ejd3NCGfKXFAwIBVz2w==
X-Received: by 2002:adf:8068:: with SMTP id 95mr2063500wrk.181.1549962924472;
        Tue, 12 Feb 2019 01:15:24 -0800 (PST)
Received: from [192.168.27.65] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id v4sm2512202wme.6.2019.02.12.01.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:15:23 -0800 (PST)
Subject: Re: [PATCH] clocksource/arm_arch_timer: Store physical timer IRQ
 number for KVM on VHE
To:     Christoffer Dall <christoffer.dall@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Andre Przywara <andre.przywara@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20190124134612.7487-1-christoffer.dall@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <49f5b2c1-8bbc-9475-e7bb-60857f622357@linaro.org>
Date:   Tue, 12 Feb 2019 10:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124134612.7487-1-christoffer.dall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2019 14:46, Christoffer Dall wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> A host running in VHE mode gets the EL2 physical timer as its time
> source (accessed using the EL1 sysreg accessors, which get re-directed
> to the EL2 sysregs by VHE).
> 
> The EL1 physical timer remains unused by the host kernel, allowing us to
> pass that on directly to a KVM guest and saves us from emulating this
> timer for the guest on VHE systems.
> 
> Store the EL1 Physical Timer's IRQ number in
> struct arch_timer_kvm_info on VHE systems to allow KVM to use it.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
> Patches in preparation for nested virtualization on KVM/Arm depend on this
> change, so we would like to merge this via the kvmarm tree or have a stable
> branch including this patch.
> 
> Please let us know your preference.  Thanks.

Hi Christopher,

sorry for the delay. I'm fine if you want to take it through your tree.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



>  drivers/clocksource/arm_arch_timer.c | 11 +++++++++--
>  include/clocksource/arm_arch_timer.h |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a7d4dc00b6e..b9243e2328b4 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -1206,6 +1206,13 @@ static enum arch_timer_ppi_nr __init arch_timer_select_ppi(void)
>  	return ARCH_TIMER_PHYS_SECURE_PPI;
>  }
>  
> +static void __init arch_timer_populate_kvm_info(void)
> +{
> +	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
> +	if (is_kernel_in_hyp_mode())
> +		arch_timer_kvm_info.physical_irq = arch_timer_ppi[ARCH_TIMER_PHYS_NONSECURE_PPI];
> +}
> +
>  static int __init arch_timer_of_init(struct device_node *np)
>  {
>  	int i, ret;
> @@ -1220,7 +1227,7 @@ static int __init arch_timer_of_init(struct device_node *np)
>  	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++)
>  		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>  
> -	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
> +	arch_timer_populate_kvm_info();
>  
>  	rate = arch_timer_get_cntfrq();
>  	arch_timer_of_configure_rate(rate, np);
> @@ -1550,7 +1557,7 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
>  	arch_timer_ppi[ARCH_TIMER_HYP_PPI] =
>  		acpi_gtdt_map_ppi(ARCH_TIMER_HYP_PPI);
>  
> -	arch_timer_kvm_info.virtual_irq = arch_timer_ppi[ARCH_TIMER_VIRT_PPI];
> +	arch_timer_populate_kvm_info();
>  
>  	/*
>  	 * When probing via ACPI, we have no mechanism to override the sysreg
> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
> index 349e5957c949..702967d996bb 100644
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -74,6 +74,7 @@ enum arch_timer_spi_nr {
>  struct arch_timer_kvm_info {
>  	struct timecounter timecounter;
>  	int virtual_irq;
> +	int physical_irq;
>  };
>  
>  struct arch_timer_mem_frame {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

