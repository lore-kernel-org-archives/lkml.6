Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10082C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46482087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TMaRRHXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46482087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH1WIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:08:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45432 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1WIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EyHsgR73NmCKBiHZBH1dJ+NuGS2b3K6dlqo/0rsOboE=; b=TMaRRHXgCexAnw/+qjON4lNz+2
        PPedB/DerWVSn44cPrc0M2tsOIgWLIXI1KHQ83pdcXYmKqzhDX20+6EZMbMkZ5vn2U46jgsuuXC4N
        24VPRMSiC5+NtuvZYpkkveJVzrBQyLz2tTtpxYRk8IOdtl0wTfOSlzcwUw51KT0tgEyLlmpv7892r
        pnS0w7cdlg9rroP2EuJWFz+v3FfcZQUwM5BdiKG6Ir1eXKvPq9ynhEiwmUIvUegHWtfZSc/bmO3tZ
        Snux3Bpdv5W0Gm3sg6WQzvyTi2ksr8gZ/YS+plj0LVcVXQHBGeJfxOPrxCOq+YOvh4P3oPC0/0rQm
        NgK6j+xw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuiWr-0002Yr-SX; Tue, 28 Aug 2018 18:15:50 +0000
Subject: Re: [PATCH v2 1/2] GPIO: add single-register gpio via creg driver
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <20180828112721.28178-1-Eugeniy.Paltsev@synopsys.com>
 <20180828112721.28178-2-Eugeniy.Paltsev@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <024be088-15ff-89ed-3766-09eb64e47342@infradead.org>
Date:   Tue, 28 Aug 2018 11:15:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828112721.28178-2-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't see any updates/corrections here.  :(

On 08/28/2018 04:27 AM, Eugeniy Paltsev wrote:

> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 71c0ab46f216..0f9cc1582cab 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -430,6 +430,15 @@ config GPIO_REG
>  	  A 32-bit single register GPIO fixed in/out implementation.  This
>  	  can be used to represent any register as a set of GPIO signals.
>  
> +config GPIO_SNPS_CREG
> +	bool "GPIO via CREG (Control REGisers) driver"
> +	select OF_GPIO
> +	help
> +	  This driver supports GPIOs via CREG on various Synopsys SoCs.
> +	  This is is single-register MMIO gpio driver for complex cases
> +	  where only several fields in register belong to GPIO and
> +	  each GPIO owns field with different length and on/off values.
> +
>  config GPIO_SPEAR_SPICS
>  	bool "ST SPEAr13xx SPI Chip Select as GPIO support"
>  	depends on PLAT_SPEAR


-- 
~Randy
