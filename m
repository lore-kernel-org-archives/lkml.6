Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AFFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6586420659
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6586420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeH2RqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:46:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56225 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbeH2RqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:46:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EADC320789; Wed, 29 Aug 2018 15:49:17 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id BAC4B203EC;
        Wed, 29 Aug 2018 15:49:07 +0200 (CEST)
Date:   Wed, 29 Aug 2018 15:49:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: configs: add generic resistive touchscreen
Message-ID: <20180829134907.GF16561@piout.net>
References: <1535525577-21148-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535525577-21148-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Eugen,

On 29/08/2018 09:52:57+0300, Eugen Hristev wrote:
> Add generic resistive touchscreen CONFIG_TOUCHSCREEN_ADC to defconfigs
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  arch/arm/configs/sama5_defconfig    | 1 +

I would make two separate patches because multi_v7 has a high chance of
conflicting while sama5_defconfig will not.

>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index fc33444..a1b2cfa 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -282,6 +282,7 @@ CONFIG_MOUSE_PS2_ELANTECH=y
>  CONFIG_MOUSE_CYAPA=m
>  CONFIG_MOUSE_ELAN_I2C=y
>  CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_TOUCHSCREEN_ADC=m
>  CONFIG_TOUCHSCREEN_ATMEL_MXT=m
>  CONFIG_TOUCHSCREEN_MMS114=m
>  CONFIG_TOUCHSCREEN_WM97XX=m
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 2080025..ead6826 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -116,6 +116,7 @@ CONFIG_KEYBOARD_QT1070=y
>  CONFIG_KEYBOARD_GPIO=y
>  # CONFIG_INPUT_MOUSE is not set
>  CONFIG_INPUT_TOUCHSCREEN=y
> +CONFIG_TOUCHSCREEN_ADC=y
>  CONFIG_TOUCHSCREEN_ATMEL_MXT=y
>  # CONFIG_SERIO is not set
>  CONFIG_LEGACY_PTY_COUNT=4
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
