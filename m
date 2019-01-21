Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFFCC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8F520861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ci2JZzI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfAUOac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:30:32 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:43982 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfAUOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:30:32 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 713CC5C0DDF;
        Mon, 21 Jan 2019 15:30:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548081030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8TpjwAbO652mHYXiF9FJrLILmgvaCiBjhUMapdS/NQ=;
        b=ci2JZzI4ukuzyQd3PmMDSntR5gn1pN6+5Jbt3PfFSCojzLv1gLNp1BxjlndwodsqVfDw0a
        XJrAmWNeZDdadiRAi2Kg2s3A7FeUPR6JLilFAPJ9DrDah6AKsTjpXplA6MhmFMBgRBqlhb
        nEpI10T4X2h+GXgqZsf04uzvcSbOusg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Jan 2019 15:30:30 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        dev@pschenker.ch, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-apalis: add phy-supply
In-Reply-To: <20190118133218.19917-1-stefan@agner.ch>
References: <20190118133218.19917-1-stefan@agner.ch>
Message-ID: <54c6b91cf908bd7553027d77244414f8@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.2019 14:32, Stefan Agner wrote:
> Use the VDD I/O rail as phy-supply regulator. Technically, the
> regulator has multiple rails, but currently the driver only
> supports a single phy-supply. The VDD I/O rail has the highest
> power consumption when software power down is used and hence
> the highest saving potential.

Please don't merge this patch. The vgen5_reg is also used as a pull-up
for USB ID pin, it would not be safe for the FEC driver to disable this
rail.

--
Stefan


> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
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
