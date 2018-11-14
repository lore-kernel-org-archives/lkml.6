Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C724C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F99F2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pojC46g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F99F2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeKOGND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:13:03 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:41214 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeKOGNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:13:02 -0500
Received: from avalon.localnet (unknown [64.114.255.97])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AEC10BB8;
        Wed, 14 Nov 2018 21:08:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1542226101;
        bh=4iuu6mDK3ogN82CH0uQrM5FsJtqaEwzGzvBNPuopzKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pojC46g19VUEABWyHMPdIqRPWU2jdyDDEoH2C6MLvbQVhjGuzwiRyHS7JsWjvnw2I
         L0NylM1pkCegZwa5Kv5Wkl9/PG74ljb3obajNXDWR42+piqCRMQkPwvvs/GoBp+gs+
         mI5o5C1NHS5Yb3zu/iNQigKxa9w00O3JhBI0xuv8=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Luis Oliveira <luis.oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.pinto@synopsys.com, festevam@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [V3, 1/4] Documentation: dt-bindings: phy: Document the Synopsys MIPI DPHY Rx bindings
Date:   Wed, 14 Nov 2018 22:08:33 +0200
Message-ID: <9022447.phA1NjbWu1@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1539953556-35762-2-git-send-email-lolivei@synopsys.com>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com> <1539953556-35762-2-git-send-email-lolivei@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Thank you for the patch.

On Friday, 19 October 2018 15:52:23 EET Luis Oliveira wrote:
> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
> RX mode.
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changelog
> v2-V3
> - removed gpios reference - it was for a separated driver
> - changed address to show complete address
> 
>  .../devicetree/bindings/phy/snps,dphy-rx.txt       | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt new file mode
> 100644
> index 0000000..03d17ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/snps,dphy-rx.txt
> @@ -0,0 +1,28 @@
> +Synopsys DesignWare MIPI Rx D-PHY block details
> +
> +Description
> +-----------
> +
> +The Synopsys MIPI D-PHY controller supports MIPI-DPHY in receiver mode.
> +Please refer to phy-bindings.txt for more information.
> +
> +Required properties:
> +- compatible		: Shall be "snps,dphy-rx".
> +- #phy-cells		: Must be 1.
> +- snps,dphy-frequency	: Output frequency of the D-PHY.

You replied to my review of v2 that you would remove this property. Is this an 
oversight ?

> +- snps,dphy-te-len	: Size of the communication interface (8 bits->8 or
> 12bits->12).
> +- reg			: Physical base address and size of the device memory mapped
> +		 	  registers;

Please document the ranges.

> +Example:
> +
> +	mipi_dphy_rx1: dphy@d00003040 {
> +		compatible = "snps,dphy-rx";
> +		#phy-cells = <1>;
> +		snps,dphy-frequency = <300000>;
> +		snps,dphy-te-len = <12>;
> +		reg = < 0xd0003040 0x20
> +			0xd0008000 0x100
> +			0xd0009000 0x100>;
> +	};
> +

-- 
Regards,

Laurent Pinchart



