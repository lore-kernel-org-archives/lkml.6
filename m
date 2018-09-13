Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F049C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55620866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CjocuqAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeINB2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:28:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:33947 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeINB2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=X3rwluGpLmvRicTSFccI7sfupTtaP0otslkDBx9p20I=;
        b=CjocuqAaRhw2W87pxVHMEHI1hfymjuiI90elzoBYA+4m4VAsfnhOu2D96SiKstut5U0s5m3F7vCpt92/1hJ2bffaN/ufBQvOTRyoKnrS9wXuvK5+sWS+G1cH8clFx5Ettu/eDAnO2kP8pAliJwapNNnwJreFPbwVioODCQ9nLgc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g0Y3X-0000TD-DZ; Thu, 13 Sep 2018 22:17:39 +0200
Date:   Thu, 13 Sep 2018 22:17:39 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, afaerber@suse.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH] ARM: dts: aspeed: Adding Facebook TioagaPass BMC
Message-ID: <20180913201739.GG23892@lunn.ch>
References: <20180913195751.1833227-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913195751.1833227-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/arch/arm/boot/dts/Makefile
> @@ -1206,4 +1206,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-opp-witherspoon.dtb \
>  	aspeed-bmc-opp-zaius.dtb \
>  	aspeed-bmc-portwell-neptune.dtb \
> +	aspeed-bmc-facebook-tiogapass.dtb \

Hi Vijay

These entries are normally kept in alphabetic order.

> +	leds {
> +		compatible = "gpio-leds";
> +		postcode0 {
> +			label="BMC_UP";

Documentation/leds/leds-class.txt

LED Device Naming
=================

Is currently of the form:

"devicename:colour:function"

	Andrew
