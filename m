Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FCBC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FC625230
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 09:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GploU6wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FC625230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeGAJeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 05:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751533AbeGAJeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 05:34:15 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A630924FEC;
        Sun,  1 Jul 2018 09:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530437654;
        bh=ZQCapGK63rgUclcKXmpYYtkZua1JqOyfYIMjocNZGP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GploU6wXcHuLZWecYkOm+w8KH0j9XpCE3ry8qG/VOklvSX4JqXKQ+24JMJ7TKLRF4
         +xI8oLKHXLifSo2TMa++4c36JoiEYs5NPZmIrFgBvF6Nq9FUtZF9jEp4tdJkPkyL0u
         GX13Dz9ToiJzhQqB/oTiSj97rACqdFmgWeZoCl74=
Date:   Sun, 1 Jul 2018 17:34:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, anson.huang@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
Message-ID: <20180701093402.GN4348@dragon>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:34:11PM +0800, Robin Gong wrote:
> SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should
> be kept always on. But it's disabled after switch disabled
> interface implemented in pfuze driver
> 'commit 5fe156f1cab4
> ("regulator: pfuze100: add enable/disable for switch")'.Thus,
> it breaks kernel bootup. Add 'regulator-always-on' for SW4.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Does that mean boards with existing DTB installed will stop working with
new kernel?  That's bad, and the kernel commit should probably be
reverted.

Shawn

> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index 37e792f..798df66 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -199,6 +199,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt = <800000>;
>  				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
>  			};
>  
>  			swbst_reg: swbst {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
