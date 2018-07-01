Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81264C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A3925041
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 13:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxyWKspx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3925041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeGANc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 09:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752109AbeGANc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 09:32:56 -0400
Received: from dragon (unknown [45.56.152.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CDA2500A;
        Sun,  1 Jul 2018 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530451975;
        bh=+Wo12E95UAeicV9YTpoYCOhBEwrIrrIzU/RYikB7vGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxyWKspxbhQl1CNQzORvFGja6H9YcQyIbnkLch1279Pl232RFU1O2O8KCwin6R6ia
         Y8gZwH/qtwHA8pi4bvxoTU6rnJWkhJHIpZNb8AFOWS4+YeFNkd19CTcYV40H5nGdFa
         OIH+HY2jTYCmuUrc+DnhGN1obE5HB6/fbSHv4gUg=
Date:   Sun, 1 Jul 2018 21:32:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] ARM: dts: imx6sll-evk: make pfuze100 sw4 always on
Message-ID: <20180701133243.GU4348@dragon>
References: <1530062725-25779-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530062725-25779-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 09:25:25AM +0800, Anson Huang wrote:
> On i.MX6SLL EVK board, PFuze100's SW4 is supplying
> LPDDR3, it needs to be always on. This patch fixes
> Linux kernel boot up hang caused by commit 5fe156f1cab4
> ("regulator: pfuze100: add enable/disable for switch"),
> because SW4 is turned off unexpectedly:
> 
> [    1.693613] cfg80211: failed to load regulatory.db
> [    1.700063] SW4: disabling
> [    1.703973] SWBST: disabling
> 
> Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Just want to understand if we agree to break the existing DTB with v4.18
kernel?

Shawn

> ---
> changes since V2:
> 	improve the way of referencing commit, and add fix tag.
>  arch/arm/boot/dts/imx6sll-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
> index 4684ac4..2217c40 100644
> --- a/arch/arm/boot/dts/imx6sll-evk.dts
> +++ b/arch/arm/boot/dts/imx6sll-evk.dts
> @@ -142,6 +142,7 @@
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
