Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613DBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D695217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SPJOlELh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfBHMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:35:04 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59054 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHMfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:35:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18CYm1e013731;
        Fri, 8 Feb 2019 06:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549629288;
        bh=8bS8zls/dE8hfPZP4eU0IjuclttOYbruvQkIboObp7c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SPJOlELht4ONyKX390yrEZKdFO1SHaoBdlO0IrFg8To0MyZeSlDRkfBPFCXlzJkyU
         chcM7wSATw4GWbVN91CHIOw7gYwJol3vfedJyl5YjFoGbazVd865p/TWXqdwcgJQYj
         wzVUVuzkax1A6A0sj8wzLAXYd9PKpn9VCO+dp4Dg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18CYmjh050960
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 06:34:48 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 06:34:47 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 06:34:47 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18CYiiS016929;
        Fri, 8 Feb 2019 06:34:44 -0600
Subject: Re: [PATCH v2 08/12] ARM: davinci: dm355: switch to using the
 clocksource driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-9-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <bb0bc61a-8c2b-affa-c58a-1e7c14f9390d@ti.com>
Date:   Fri, 8 Feb 2019 18:04:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-9-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:
> -/*
> - * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
> - * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
> - * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
> - * T1_TOP: Timer 1, top   :  <unused>

Documenting this timer division is important because DSP usage and
unused timers are not immediately clear from kernel code alone. Can you
retain these comments in all patches of this series (I guess T0_BOT etc.
terminology is changed, so feel free to adjust the comment text).

> - */
> -static struct davinci_timer_info dm355_timer_info = {
> -	.timers		= davinci_timer_instance,
> -	.clockevent_id	= T0_BOT,
> -	.clocksource_id	= T0_TOP,
> +static const struct davinci_timer_cfg dm355_timer_cfg = {
> +	.reg = {
> +		.start		= DAVINCI_TIMER0_BASE,
> +		.end		= DAVINCI_TIMER0_BASE + SZ_4K,

Here and other places too, SZ_4K - 1

Thanks,
Sekhar
