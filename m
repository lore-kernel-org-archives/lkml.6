Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D4FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C438721581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C438721581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeHON0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:26:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57390 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbeHON0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:26:14 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fpt8M-0003eu-Mn; Wed, 15 Aug 2018 12:34:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, amstan@chromium.org,
        groeck@google.com, kieran.bingham@ideasonboard.com,
        kernel@collabora.com, bleung@chromium.org,
        devicetree@vger.kernel.org, Frank Wang <frank.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: phy-rockchip-inno-usb2: add new rockchip,force-bvalid property.
Date:   Wed, 15 Aug 2018 12:34:34 +0200
Message-ID: <6944969.kWmPjI4VuS@phil>
In-Reply-To: <20180815095934.11205-5-enric.balletbo@collabora.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com> <20180815095934.11205-5-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. August 2018, 11:59:34 CEST schrieb Enric Balletbo i Serra:
> This property is used when the otg-id pin is not connected. When this
> property is set it forces to set the B-Device Session Valid bit when the
> port works as device and clears that bit when the port works as host.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  .../devicetree/bindings/phy/phy-rockchip-inno-usb2.txt       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index 2d4808d3920b..55761f466c41 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -48,6 +48,11 @@ Optional properties:
>  		See ./phy-bindings.txt for details.
>   - rockchip,utmi-avalid : boolean, use the avalid register to get vbus status.
>  			  Otherwise, use the bvalid register.
> + - rockchip,force-bvalid : boolean, set this to force the B-Device Session
> +			  Valid bit when the usb port is in device mode. This
> +			  is used when the otg-id pin is not connected.
> +			  Only supported in case of compatible being:
> +			  * "rockchip,rk3399-usb2phy"

I guess you could drop that rk3399 mention instead make the
driver complain? Trying to keep that list up to date will get hard
and I guess the other socs may very well hide that setting somewhere
in their undocumented phy registers as well.

I guess a bit of alphabetical ordering might also be nice,
rockchip,force-bvalid above rockchip,utmi-avalid
Makes it easier to read ;-)

Heiko



