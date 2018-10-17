Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45625C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE34214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FxpYXC4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE34214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJQMyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:54:50 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33283 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeJQMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:54:49 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181017050057epoutp03395ade2fbe49cd6802c38e1e30d373ab~eTLOv4OLx0597905979epoutp03j;
        Wed, 17 Oct 2018 05:00:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181017050057epoutp03395ade2fbe49cd6802c38e1e30d373ab~eTLOv4OLx0597905979epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539752457;
        bh=r75SDeTjwshj67FCxbgUYKAe96JfabwpctumRH1HoTA=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=FxpYXC4ekGJqoehxiBQetpDHk7Lbpb5sTdcNrgKAYsYCcNIZgsuhyx7HNhzwk6yMi
         /Jr9iiUMNirEtFPwlFHxPIhYp1Y4oU7hMKQCBtk9Do2gqZXVOrfozqlGF2uZjfK3nm
         49+abWRKiRjwWu9WIE09+06yCnemNbE6RHeUlLUc=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181017050052epcas1p48b80c121072b34ba125999b83261228a~eTLKWn98H2827728277epcas1p4k;
        Wed, 17 Oct 2018 05:00:52 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.EE.04015.402C6CB5; Wed, 17 Oct 2018 14:00:52 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181017050052epcas2p4279b5db295bee2a5d39fe970c26fd1b2~eTLJ9FHOi0054300543epcas2p4b;
        Wed, 17 Oct 2018 05:00:52 +0000 (GMT)
X-AuditID: b6c32a45-6a9ff70000000faf-f2-5bc6c20414da
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 30.B1.03633.302C6CB5; Wed, 17 Oct
        2018 14:00:51 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PGQ00I6E8LDVUB0@mmp2.samsung.com>; Wed, 17 Oct 2018 14:00:51 +0900 (KST)
Message-id: <5BC6C201.70508@samsung.com>
Date:   Wed, 17 Oct 2018 14:00:49 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 3/6] clocksource: exynos_mct: Add arch_timer
 cooperation mode for ARM64
In-reply-to: <20181015123112.9379-4-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUwTURDH87rLthCrj+IxYpSyiShVtKUWt8Z6xGsNfCAqYiSmbmAptWe6
        rRG/SDyReKBGRRTRQFARUQoaFEECBolGIBqMMVYTqoLigcGg8S67GPk285/fTN783ygI1Skq
        WmF1enmPk7PTVAR5ozU+KYFsacvQVjwDpqboahjzqeIAYs4OTmWOviwkmc7Oa3LGH3wSxjy+
        dYZiijqbZMyVuwE58+v5b4qp9R8nmLef28klY9iqs1WI9Vfup9jnT25T7MeODjlbW76DPVRX
        idhB/7RU+Ubbwhyey+I9at6Z6cqyOi0mOnmteZnZkKTVJeiMzHxa7eQcvIlenpKasNJqD72T
        Vm/l7L6QlMoJAj130UKPy+fl1TkuwWuieXeW3W10zxE4h+BzWuZkuhwLdFptoiEEbrblNB/q
        J937NduaBi4ReaghtgApFIDnQWNwcQGKUKhwPYLmQBMhJV8RtO8poQpQuAhVHKympMI1BK+/
        XyaGC0ocCd+OvSCHJxE4Bu4+sg3LBI6H6w1X5RIfQBC4WI8kfiZcONksDiXxdCivrxLnUFgD
        d/qeivo4HAvd34IiPwFvgJulQ+Kg8bgYweEPx9BwQuCHMnjR2C12ROHN0Lu3S4zDsQn6v0sQ
        4D8UDB0vJaQdlkPn0MeRfaLg3b06uRRPgTeVNSMN+xB86dsVJiWFCAbu18okSg9vzhfIpO3G
        Qn7rL7lknxLy96okhIX+6vIRk1oR3G58QBaiqcWjfCr+71PxKJ/OIaISTeTdgsPCC4lu3egP
        9CPxLDUr6lFRR0oLwgpEj1HiyW0ZqjBuq5DraEGgIOjxSmtZSFJmcbnbeY/L7PHZeaEFGUI2
        HyGiJ2S6Qkfu9Jp1hkS9Xs8Y5hv1WiM9SdkzpSRDhS2cl7fxvJv3/OuTKcKj89BTtrF8cdea
        U/OCXcGSwd1fBlb35pX5NFtyN52OS0tL6lJX3z9jpR/3NZvTyHh45zrRW1j6foElfQXbk6y7
        GGF6qKprmHxpoCx/XGKCcWdGu2Xs6pcxtvRZ9lfZR+LqZnQvPWmLeja0r2TWevuPn8uydW2u
        O5Gx5OyvgVU9r7PXxSyhSSGH02kIj8D9BZ0ZjoOsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42I5/e+xoC7zoWPRBq86bSw2zljPavF+WQ+j
        xbzPshaT7k9gsTh/fgO7xabH11gtLu+aw2Yx4/w+Jou1R+6yW/y984/NYvOmqcwWLz+eYHHg
        8Vgzbw2jx6ZVnWwed67tYfN4d+4cu8fmJfUefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlXGg
        7zVLQadWxb4PK5kbGHcrdjFyckgImEgs613H1sXIxSEksI5R4tfSBnaQBK+AoMSPyfdYuhg5
        OJgF5CWOXMoGCTMLqEtMmreIGaL+PqPEqt1fWSDqNSSWTz/ABmKzCKhKLNmxhhnEZhPQktj/
        4gZYnF9AUeLqj8eMIDNFBSIkuk9UgswREZjFKPG8dwUbxIKLTBI/7oP1CgskSOzqeQJ13GFG
        if3vF4MlOAVsJV7/msw4gRGoFeHWWQi3zkJy6wJG5lWMkqkFxbnpucVGBUZ5qeV6xYm5xaV5
        6XrJ+bmbGIHxsu2wVv8OxsdL4g8xCnAwKvHw7hA7Fi3EmlhWXJl7iFGCg1lJhDdzMVCINyWx
        siq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QDo9KVjTbvVFYbdF+Q
        0+8O2P5i2anTneG215NtAuOjvW8Lin89wlvme/YUW/QPnUTV78/1rWO/yT5sKA/bOudepUfy
        N5l1kxRX8TILPGj6X78lJm7btNZV5wT3fRMsLTk6c8ukZqnP0ew+ny/MO/epieX/tCNePK3C
        f+amrIgw218YGv73iszXVCWW4oxEQy3mouJEAN90RIGTAgAA
X-CMS-MailID: 20181017050052epcas2p4279b5db295bee2a5d39fe970c26fd1b2
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d
References: <20181015123112.9379-1-m.szyprowski@samsung.com>
        <CGME20181015123135eucas1p16a10ed68040141a714ab2977e2ad5e2d@eucas1p1.samsung.com>
        <20181015123112.9379-4-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

I tested it about kernel booting and CPU hotplug through sysfs path 
on ARM64 Exynos5433-based TM2 board. It is well working.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

But,
I have a minor comment for code clean-up.
On exynos4_mct_starting_cpu() function, the initialization of 'evt' instance
are not mandatory because 'evt' instance is not registered
by clockevents_config_and_register(). 


On 2018년 10월 15일 21:31, Marek Szyprowski wrote:
> To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
> first configure and enable Exynos Multi-Core Timer, because they both
> share some common hardware blocks. This patch adds a mode of cooperation
> with arch_timer driver, so kernel can use CP15 based timer interface via
> arch_timer driver, which is mandatory on ARM64. In such mode driver only
> configures MCT registers and starts the timer but don't register any
> clocksource or events in the system. Those are left to be handled by
> arch_timer driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clocksource/exynos_mct.c | 52 +++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index a379f11fad2d..06cd30a6d59a 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -57,6 +57,7 @@
>  #define TICK_BASE_CNT	1
>  
>  enum {
> +	MCT_INT_NONE = 0,
>  	MCT_INT_SPI,
>  	MCT_INT_PPI
>  };
> @@ -238,6 +239,9 @@ static int __init exynos4_clocksource_init(void)
>  {
>  	exynos4_mct_frc_start();
>  
> +	if (!mct_int_type)
> +		return 0;
> +
>  #if defined(CONFIG_ARM)
>  	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
>  	exynos4_delay_timer.freq = clk_rate;
> @@ -343,6 +347,9 @@ static struct irqaction mct_comp_event_irq = {
>  
>  static int exynos4_clockevent_init(void)
>  {
> +	if (!mct_int_type)
> +		return 0;
> +
>  	mct_comp_device.cpumask = cpumask_of(0);
>  	clockevents_config_and_register(&mct_comp_device, clk_rate,
>  					0xf, 0xffffffff);
> @@ -476,12 +483,12 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>  
>  		irq_force_affinity(evt->irq, cpumask_of(cpu));
>  		enable_irq(evt->irq);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_PPI) {
>  		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>  	}
> -	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
> -					0xf, 0x7fffffff);
> -
> +	if (mct_int_type)
> +		clockevents_config_and_register(evt,
> +			       clk_rate / (TICK_BASE_CNT + 1), 0xf, 0x7fffffff);
>  	return 0;
>  }
>  
> @@ -496,7 +503,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>  		if (evt->irq != -1)
>  			disable_irq_nosync(evt->irq);
>  		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_PPI) {
>  		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
>  	}
>  	return 0;
> @@ -529,7 +536,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  					 &percpu_mct_tick);
>  		WARN(err, "MCT: can't request IRQ %d (%d)\n",
>  		     mct_irqs[MCT_L0_IRQ], err);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_SPI) {
>  		for_each_possible_cpu(cpu) {
>  			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
>  			struct mct_clock_event_device *pcpu_mevt =
> @@ -564,7 +571,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  out_irq:
>  	if (mct_int_type == MCT_INT_PPI) {
>  		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> -	} else {
> +	} else if (mct_int_type == MCT_INT_SPI) {
>  		for_each_possible_cpu(cpu) {
>  			struct mct_clock_event_device *pcpu_mevt =
>  				per_cpu_ptr(&percpu_mct_tick, cpu);
> @@ -585,17 +592,28 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  
>  	mct_int_type = int_type;
>  
> -	/* This driver uses only one global timer interrupt */
> -	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
> +		struct device_node *np = of_find_compatible_node(NULL, NULL,
> +							     "arm,armv8-timer");
> +		if (np) {
> +			mct_int_type = MCT_INT_NONE;
> +			of_node_put(np);
> +		}
> +	}
>  
> -	/*
> -	 * Find out the number of local irqs specified. The local
> -	 * timer irqs are specified after the four global timer
> -	 * irqs are specified.
> -	 */
> -	nr_irqs = of_irq_count(np);
> -	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> -		mct_irqs[i] = irq_of_parse_and_map(np, i);
> +	if (mct_int_type) {
> +		/* This driver uses only one global timer interrupt */
> +		mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
> +
> +		/*
> +		 * Find out the number of local irqs specified. The local
> +		 * timer irqs are specified after the four global timer
> +		 * irqs are specified.
> +		 */
> +		nr_irqs = of_irq_count(np);
> +		for (i = MCT_L0_IRQ; i < nr_irqs; i++)
> +			mct_irqs[i] = irq_of_parse_and_map(np, i);
> +	}
>  
>  	ret = exynos4_timer_resources(np, of_iomap(np, 0));
>  	if (ret)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
