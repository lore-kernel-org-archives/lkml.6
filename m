Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC21C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6912A20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfAHOQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:16:38 -0500
Received: from foss.arm.com ([217.140.101.70]:52954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHOQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:16:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3455780D;
        Tue,  8 Jan 2019 06:16:37 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 445BE3F5D4;
        Tue,  8 Jan 2019 06:16:36 -0800 (PST)
Subject: Re: [PATCH] ARM: irq: Add IRQ_SET_MASK_OK_DONE handling in
 migrate_one_irq()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190108135805.5535-1-dietmar.eggemann@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 mQINBE6Jf0UBEADLCxpix34Ch3kQKA9SNlVQroj9aHAEzzl0+V8jrvT9a9GkK+FjBOIQz4KE
 g+3p+lqgJH4NfwPm9H5I5e3wa+Scz9wAqWLTT772Rqb6hf6kx0kKd0P2jGv79qXSmwru28vJ
 t9NNsmIhEYwS5eTfCbsZZDCnR31J6qxozsDHpCGLHlYym/VbC199Uq/pN5gH+5JHZyhyZiNW
 ozUCjMqC4eNW42nYVKZQfbj/k4W9xFfudFaFEhAf/Vb1r6F05eBP1uopuzNkAN7vqS8XcgQH
 qXI357YC4ToCbmqLue4HK9+2mtf7MTdHZYGZ939OfTlOGuxFW+bhtPQzsHiW7eNe0ew0+LaL
 3wdNzT5abPBscqXWVGsZWCAzBmrZato+Pd2bSCDPLInZV0j+rjt7MWiSxEAEowue3IcZA++7
 ifTDIscQdpeKT8hcL+9eHLgoSDH62SlubO/y8bB1hV8JjLW/jQpLnae0oz25h39ij4ijcp8N
 t5slf5DNRi1NLz5+iaaLg4gaM3ywVK2VEKdBTg+JTg3dfrb3DH7ctTQquyKun9IVY8AsxMc6
 lxl4HxrpLX7HgF10685GG5fFla7R1RUnW5svgQhz6YVU33yJjk5lIIrrxKI/wLlhn066mtu1
 DoD9TEAjwOmpa6ofV6rHeBPehUwMZEsLqlKfLsl0PpsJwov8TQARAQABtCNNYXJjIFp5bmdp
 ZXIgPG1hcmMuenluZ2llckBhcm0uY29tPokCOwQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYC
 AwECHgECF4AFAk6NvYYCGQEACgkQI9DQutE9ekObww/+NcUATWXOcnoPflpYG43GZ0XjQLng
 LQFjBZL+CJV5+1XMDfz4ATH37cR+8gMO1UwmWPv5tOMKLHhw6uLxGG4upPAm0qxjRA/SE3LC
 22kBjWiSMrkQgv5FDcwdhAcj8A+gKgcXBeyXsGBXLjo5UQOGvPTQXcqNXB9A3ZZN9vS6QUYN
 TXFjnUnzCJd+PVI/4jORz9EUVw1q/+kZgmA8/GhfPH3xNetTGLyJCJcQ86acom2liLZZX4+1
 6Hda2x3hxpoQo7pTu+XA2YC4XyUstNDYIsE4F4NVHGi88a3N8yWE+Z7cBI2HjGvpfNxZnmKX
 6bws6RQ4LHDPhy0yzWFowJXGTqM/e79c1UeqOVxKGFF3VhJJu1nMlh+5hnW4glXOoy/WmDEM
 UMbl9KbJUfo+GgIQGMp8mwgW0vK4HrSmevlDeMcrLdfbbFbcZLNeFFBn6KqxFZaTd+LpylIH
 bOPN6fy1Dxf7UZscogYw5Pt0JscgpciuO3DAZo3eXz6ffj2NrWchnbj+SpPBiH4srfFmHY+Y
 LBemIIOmSqIsjoSRjNEZeEObkshDVG5NncJzbAQY+V3Q3yo9og/8ZiaulVWDbcpKyUpzt7pv
 cdnY3baDE8ate/cymFP5jGJK++QCeA6u6JzBp7HnKbngqWa6g8qDSjPXBPCLmmRWbc5j0lvA
 6ilrF8m5Ag0ETol/RQEQAM/2pdLYCWmf3rtIiP8Wj5NwyjSL6/UrChXtoX9wlY8a4h3EX6E3
 64snIJVMLbyr4bwdmPKULlny7T/R8dx/mCOWu/DztrVNQiXWOTKJnd/2iQblBT+W5W8ep/nS
 w3qUIckKwKdplQtzSKeE+PJ+GMS+DoNDDkcrVjUnsoCEr0aK3cO6g5hLGu8IBbC1CJYSpple
 VVb/sADnWF3SfUvJ/l4K8Uk4B4+X90KpA7U9MhvDTCy5mJGaTsFqDLpnqp/yqaT2P7kyMG2E
 w+eqtVIqwwweZA0S+tuqput5xdNAcsj2PugVx9tlw/LJo39nh8NrMxAhv5aQ+JJ2I8UTiHLX
 QvoC0Yc/jZX/JRB5r4x4IhK34Mv5TiH/gFfZbwxd287Y1jOaD9lhnke1SX5MXF7eCT3cgyB+
 hgSu42w+2xYl3+rzIhQqxXhaP232t/b3ilJO00ZZ19d4KICGcakeiL6ZBtD8TrtkRiewI3v0
 o8rUBWtjcDRgg3tWx/PcJvZnw1twbmRdaNvsvnlapD2Y9Js3woRLIjSAGOijwzFXSJyC2HU1
 AAuR9uo4/QkeIrQVHIxP7TJZdJ9sGEWdeGPzzPlKLHwIX2HzfbdtPejPSXm5LJ026qdtJHgz
 BAb3NygZG6BH6EC1NPDQ6O53EXorXS1tsSAgp5ZDSFEBklpRVT3E0NrDABEBAAGJAh8EGAEC
 AAkFAk6Jf0UCGwwACgkQI9DQutE9ekMLBQ//U+Mt9DtFpzMCIHFPE9nNlsCm75j22lNiw6mX
 mx3cUA3pl+uRGQr/zQC5inQNtjFUmwGkHqrAw+SmG5gsgnM4pSdYvraWaCWOZCQCx1lpaCOl
 MotrNcwMJTJLQGc4BjJyOeSH59HQDitKfKMu/yjRhzT8CXhys6R0kYMrEN0tbe1cFOJkxSbV
 0GgRTDF4PKyLT+RncoKxQe8lGxuk5614aRpBQa0LPafkirwqkUtxsPnarkPUEfkBlnIhAR8L
 kmneYLu0AvbWjfJCUH7qfpyS/FRrQCoBq9QIEcf2v1f0AIpA27f9KCEv5MZSHXGCdNcbjKw1
 39YxYZhmXaHFKDSZIC29YhQJeXWlfDEDq6nIhvurZy3mSh2OMQgaIoFexPCsBBOclH8QUtMk
 a3jW/qYyrV+qUq9Wf3SKPrXf7B3xB332jFCETbyZQXqmowV+2b3rJFRWn5hK5B+xwvuxKyGq
 qDOGjof2dKl2zBIxbFgOclV7wqCVkhxSJi/QaOj2zBqSNPXga5DWtX3ekRnJLa1+ijXxmdjz
 hApihi08gwvP5G9fNGKQyRETePEtEAWt0b7dOqMzYBYGRVr7uS4uT6WP7fzOwAJC4lU7ZYWZ
 yVshCa0IvTtp1085RtT3qhh9mobkcZ+7cQOY+Tx2RGXS9WeOh2jZjdoWUv6CevXNQyOUXMM=
Organization: ARM Ltd
Message-ID: <9288fdeb-8eb1-28ca-f950-ccf36d63688a@arm.com>
Date:   Tue, 8 Jan 2019 14:16:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190108135805.5535-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On 08/01/2019 13:58, Dietmar Eggemann wrote:
> Arm TC2 (multi_v7_defconfig plus CONFIG_ARM_BIG_LITTLE_CPUFREQ=y and
> CONFIG_ARM_VEXPRESS_SPC_CPUFREQ=y) fails hotplug stress tests.
> 
> This issue was tracked down to a missing copy of the new affinity
> cpumask of the vexpress-spc interrupt into struct
> irq_common_data.affinity when the interrupt is migrated in
> migrate_one_irq().
> 
> Commit 0407daceedfe ("irqchip/gic: Return IRQ_SET_MASK_OK_DONE in the
> set_affinity method") changed the return value of the irq_set_affinity()
> function of the GIC from IRQ_SET_MASK_OK to IRQ_SET_MASK_OK_DONE.
> 
> In migrate_one_irq() if the current irq affinity mask and the cpu
> online mask do not share any CPU, the affinity mask is set to the cpu
> online mask. In this case (ret == true) and when the irq chip
> function irq_set_affinity() returns successfully (IRQ_SET_MASK_OK),
> struct irq_common_data.affinity should also be updated.
> 
> Add IRQ_SET_MASK_OK_DONE next to IRQ_SET_MASK_OK when checking that the
> irq chip function irq_set_affinity() returns successfully.
> 
> Commit 2cb625478f8c ("genirq: Add IRQ_SET_MASK_OK_DONE to support
> stacked irqchip") only added IRQ_SET_MASK_OK_DONE handling to
> irq_do_set_affinity() in the irq core and not to the Arm32 irq code.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
> 
> The hotplug issue on Arm TC2 happens because the vexpress-spc interrupt
> (irq=22) is affine to CPU0. This occurs since it is setup early when the
> cpu_online_mask is still 0.
> But the problem with the missing copy of the affinity mask should occur
> with every interrupt which is forced to migrate.
> 
> With additional debug in irq_setup_affinity():
> 
> [0.000619] irq_setup_affinity(): irq=17 mask=0 cpu_online_mask=0 set=0-4
> [0.007065] irq_setup_affinity(): irq=22 mask=0 cpu_online_mask=0 set=0-4
> [3.372907] irq_setup_affinity(): irq=47 mask=0-4 cpu_online_mask=0-4
> set=0-4
> 
> cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       CPU4
> 22:        316          0          0          0          0     GIC-0 127
> Level     vexpress-spc
> 
> cat /proc/irq/22/smp_affinity_list 
> 0
> 
>  arch/arm/kernel/irq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 9908dacf9229..ddb828b0235b 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -117,6 +117,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
>  	struct irq_chip *c;
>  	bool ret = false;
> +	int ret2;
>  
>  	/*
>  	 * If this is a per-CPU interrupt, or the affinity does not
> @@ -131,9 +132,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	}
>  
>  	c = irq_data_get_irq_chip(d);
> -	if (!c->irq_set_affinity)
> +	if (!c->irq_set_affinity) {
>  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
> -	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
> +		return ret;
> +	}
> +
> +	ret2 = c->irq_set_affinity(d, affinity, false);
> +
> +	if ((ret2 == IRQ_SET_MASK_OK || ret2 == IRQ_SET_MASK_OK_DONE) && ret)
>  		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
>  
>  	return ret;
> 

On the arm64 side, we've solved the exact same issue by getting rid of
this code and using the generic implementation. See 217d453d473c5
("arm64: fix a migrating irq bug when hotplug cpu"), which uses
irq_migrate_all_off_this_cpu instead.

I'm not sure there is much value in not using the core code in this case.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
