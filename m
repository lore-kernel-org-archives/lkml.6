Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E196C218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfBFWi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:38:59 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:34025 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBFWi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:38:58 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5BBB7100002;
        Wed,  6 Feb 2019 22:38:55 +0000 (UTC)
Date:   Wed, 6 Feb 2019 23:38:55 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ben.dooks@codethink.co.uk,
        ccaione@baylibre.com
Subject: Re: [PATCH v6 2/2] rtc: support for the Amlogic Meson RTC
Message-ID: <20190206223855.GC4719@piout.net>
References: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
 <20190119144332.11984-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119144332.11984-3-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/01/2019 15:43:32+0100, Martin Blumenstingl wrote:
> +static int meson_rtc_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config meson_rtc_nvmem_config = {
> +		.name = "meson-rtc-regmem",
> +		.word_size = 4,
> +		.stride = 4,
> +		.size = 4 * 4,
> +		.reg_read = meson_rtc_regmem_read,
> +		.reg_write = meson_rtc_regmem_write,

Not much to add but if those registers are battery backed, you could add
.type = NVMEM_TYPE_BATTERY_BACKED,


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
