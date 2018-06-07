Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VRBgErCCGVv4FwAAmS7hNA
	; Thu, 07 Jun 2018 19:08:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D4EAA608C1; Thu,  7 Jun 2018 19:08:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vL/r6onz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F804608B8;
	Thu,  7 Jun 2018 19:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F804608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753717AbeFGTIa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:08:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753553AbeFGTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=f9tfPDJjCv7K3n/IusVls/rLtRDeNRVrzGe4qPnglfQ=; b=vL/r6onzflk3tB9qxypt0d7r6n
        2caveauToU8kq5dQqgll05l7R3h5Ed+rXt6MoUXjLNvEGlxlFBChJ/nH4z3gt314/+XeqAu+FWHPW
        gCjb07sUpZVB08ULR2Itw0U9gzshMqpEMK1jN5aCYTALwubH2elWhfA5KV3Fzocik7HSrDKJ40EN5
        sFsmxVIbhoPUHtyR+xkJd5pOG1VRa9eS2nMBjTkiIznE8FlxdUx3xgQYcQcLUcy96H6w0WFSpyTFy
        5yGk+WMEBT3wR6bHpQVHy43lqXKsYlwZBut/UoIvLHI1Ryd1HfCSc1367tacQ/jQ/wF7lRf9y3Vym
        swFNy+GQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fR0Gl-0002Un-7s; Thu, 07 Jun 2018 19:08:24 +0000
Subject: Re: [PATCH v5 2/4] power: supply: Add support for the Qualcomm
 Battery Monitoring System
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
 <20180607181306.9766-2-ctatlor97@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e1a78fe3-593d-d39c-05b3-a1cc2b948e90@infradead.org>
Date: Thu, 7 Jun 2018 12:08:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607181306.9766-2-ctatlor97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 11:12 AM, Craig Tatlor wrote:
> This patch adds a driver for the BMS (Battery Monitoring System)
> block of the PM8941 PMIC, it uses a lookup table defined in the
> device tree to generate a capacity from the BMS supplied OCV, it
> then ammends the coulomb counter to that to increase the accuracy

       amends

> of the estimated capacity.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---

> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 428b426842f4..6c354c37bc55 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -82,6 +82,15 @@ config BATTERY_ACT8945A
>  	  Say Y here to enable support for power supply provided by
>  	  Active-semi ActivePath ACT8945A charger.
>  
> +config BATTERY_BMS
> +	tristate "Qualcomm Battery Monitoring System driver"
> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
> +	depends on OF
> +	depends on REGMAP_SPMI

	select REGMAP_SPMI

I'm not a fan of "select", but it does not have a prompt string so it isn't
user settable (not directly; it can be set indirectly).
And all other uses of it in Kconfig files use "select".

> +	help
> +	  Say Y to include support for the Battery Monitoring hardware
> +	  found in some Qualcomm PM series PMICs.
> +
>  config BATTERY_CPCAP
>  	tristate "Motorola CPCAP PMIC battery driver"
>  	depends on MFD_CPCAP && IIO


-- 
~Randy
