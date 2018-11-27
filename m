Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BCDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0EA2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0EA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbeK0VFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:05:40 -0500
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:35886 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730348AbeK0VFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:05:40 -0500
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 11433634C87;
        Tue, 27 Nov 2018 12:08:15 +0200 (EET)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1gRaHu-0001ed-SY; Tue, 27 Nov 2018 12:08:14 +0200
Date:   Tue, 27 Nov 2018 12:08:14 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Subject: Re: [PATCH v3 05/14] media: dt-bindings: marvell,mmp2-ccic: Add
 Marvell MMP2 camera
Message-ID: <20181127100814.7sovl2c6jedq7ruw@valkosipuli.retiisi.org.uk>
References: <20181120100318.367987-1-lkundrak@v3.sk>
 <20181120100318.367987-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120100318.367987-6-lkundrak@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On Tue, Nov 20, 2018 at 11:03:10AM +0100, Lubomir Rintel wrote:
> Add Marvell MMP2 camera host interface.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v2:
> - Added #clock-cells, clock-names, port
> 
>  .../bindings/media/marvell,mmp2-ccic.txt      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
> new file mode 100644
> index 000000000000..e5e8ca90e7f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
> @@ -0,0 +1,37 @@
> +Marvell MMP2 camera host interface
> +
> +Required properties:
> + - compatible: Should be "marvell,mmp2-ccic"
> + - reg: register base and size
> + - interrupts: the interrupt number
> + - #clock-cells: must be 0
> + - any required generic properties defined in video-interfaces.txt

Could you document what is relevant for the hardware? There are quite a few
properties documented there...

> +
> +Optional properties:
> + - clocks: input clock (see clock-bindings.txt)
> + - clock-names: names of the clocks used, may include "axi", "func" and
> +                "phy"
> + - clock-output-names: should contain the name of the clock driving the
> +                       sensor master clock MCLK
> +
> +Required subnodes:
> + - port: the parallel bus interface port with a single endpoint linked to
> +         the sensor's endpoint as described in video-interfaces.txt

Please use the full path to video-interfaces.txt. Same above, as well as
for clock-bindings.txt.

Are there endpoint properties that are applicable for the hardware?

> +
> +Example:
> +
> +	camera0: camera@d420a000 {
> +		compatible = "marvell,mmp2-ccic";
> +		reg = <0xd420a000 0x800>;
> +		interrupts = <42>;
> +		clocks = <&soc_clocks MMP2_CLK_CCIC0>;
> +		clock-names = "axi";
> +		#clock-cells = <0>;
> +		clock-output-names = "mclk";
> +
> +		port {
> +			camera0_0: endpoint {
> +				remote-endpoint = <&ov7670_0>;
> +			};
> +		};
> +	};

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
