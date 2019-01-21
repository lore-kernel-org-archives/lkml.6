Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13533C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B8020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfAURLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:11:06 -0500
Received: from muru.com ([72.249.23.125]:34448 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfAURLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:11:05 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 92DCF812F;
        Mon, 21 Jan 2019 17:11:11 +0000 (UTC)
Date:   Mon, 21 Jan 2019 09:11:01 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Arthur Demchenkov <spinal.by@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
Message-ID: <20190121171101.GD5544@atomide.com>
References: <20190121032109.10220-1-spinal.by@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121032109.10220-1-spinal.by@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Arthur Demchenkov <spinal.by@gmail.com> [190121 03:22]:
> Wrong polarity of card detect GPIO pin leads to the system not
> booting from external mmc, if the back cover of N900 is closed.
> When the cover is open the system boots fine.
> 
> This wasn't noticed before, because of a bug, which was fixed
> by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
> CD and WP).

Aaro, does this work for your test case too?

> Kernels up to 4.19 ignored the card detect GPIO from DT.

Hmm so should this have a Fixes tag or not?

Regards,

Tony

>  arch/arm/boot/dts/omap3-n900.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 182a53991c90..826920e6b878 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -814,7 +814,7 @@
>  	/* For debugging, it is often good idea to remove this GPIO.
>  	   It means you can remove back cover (to reboot by removing
>  	   battery) and still use the MMC card. */
> -	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
> +	cd-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>; /* 160 */
>  };
>  
>  /* most boards use vaux3, only some old versions use vmmc2 instead */
> -- 
> 2.11.0
> 
