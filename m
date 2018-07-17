Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF862ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6832720C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q50NDZZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6832720C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeGQHt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbeGQHt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:49:28 -0400
Received: from dragon (unknown [104.237.91.210])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A8E2086D;
        Tue, 17 Jul 2018 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531811898;
        bh=0oNFgwlWIyEZrA/4XguwkVZHxXcPkReiIlhld6BkbWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q50NDZZWj7ysIRogOn6iF2HTmDmTaOfAy7baNhNXoCZDEpUQz8DE6IA6Dlh09mqYM
         riJoHHet0xYetRb4ZjH2267x0vlC47GnFwjGUz+vKfYrXCBPNb++dfS3jMcl5KnlgJ
         5514ngHp4DoP47XnwkVjhdQzAUx90jyGdL4XNno4=
Date:   Tue, 17 Jul 2018 15:18:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yibin.gong@nxp.com, Linux-imx@nxp.com
Subject: Re: [PATCH 4/4] ARM: dts: imx6sl-evk: make pfuze100 sw4 always on
Message-ID: <20180717071807.GM4576@dragon>
References: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
 <1531804325-3476-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531804325-3476-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:12:05PM +0800, Anson Huang wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> On i.MX6SL EVK board, pfuze100 sw4 supplies
> LPDDR2 which is critical for system, must be
> always on.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Robin's SoB is missing, since it's authorized by him.  I fixed it up and
applied all patches.

Shawn

> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index 046cfab..679b448 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -201,6 +201,7 @@
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
