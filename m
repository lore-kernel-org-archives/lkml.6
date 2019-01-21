Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E9C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A8C20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfAUIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:35:47 -0500
Received: from mxout013.mail.hostpoint.ch ([217.26.49.173]:55684 "EHLO
        mxout013.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729185AbfAUIfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:35:47 -0500
Received: from [10.0.2.45] (helo=asmtp012.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1glV3S-000Lzx-I8; Mon, 21 Jan 2019 09:35:38 +0100
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp012.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1glV3S-000K6H-Du; Mon, 21 Jan 2019 09:35:38 +0100
X-Authenticated-Sender-Id: dev@pschenker.ch
Message-ID: <a5af06ec3d694263ba85a030640b5611de40c5cb.camel@pschenker.ch>
Subject: Re: [PATCH] ARM: dts: imx6qdl-apalis: add phy-supply
From:   Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To:     Stefan Agner <stefan@agner.ch>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Jan 2019 09:35:37 +0100
In-Reply-To: <20190118133218.19917-1-stefan@agner.ch>
References: <20190118133218.19917-1-stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 14:32 +0100, Stefan Agner wrote:
> Use the VDD I/O rail as phy-supply regulator. Technically, the
> regulator has multiple rails, but currently the driver only
> supports a single phy-supply. The VDD I/O rail has the highest
> power consumption when software power down is used and hence
> the highest saving potential.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>

> ---
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 0b47aecf336a..cf66f9ececbd 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -241,6 +241,7 @@
>  	phy-handle = <&ethphy>;
>  	phy-reset-duration = <10>;
>  	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
> +	phy-supply = <&vgen5_reg>;
>  	status = "okay";
>  
>  	mdio {

