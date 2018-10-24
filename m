Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D852ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77C420831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77C420831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeJYCJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:09:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38525 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeJYCJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:09:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id l1so5882157otj.5;
        Wed, 24 Oct 2018 10:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WBCwW9brnhcDkuSWyHAUGAX4fOkdacpnsoYAQDqjNT0=;
        b=NxOtuTtWgmNeS2Dh6fy/qOg88ff5Sxo20LY7p87RPyUEFOFhYRLLvdO6Xh6WmVAb7X
         QP5rO7DcD1Z4KKN1eHno+x8pH6ShiIeURaXPMY0iWcbWwWSEsF72zozx3QdO40xqdnkF
         HVPjgiObACNoHaiOptW4yFh0JPSRLM4/X9yfdJaTTXVl9Mf1/bgN4v0I1P5hCRzixrMo
         YQj/VgQ3KqbwEYlTYKltRm6vVWlPsdLUXpxCTUHiwUstC7+TNJd5QpTvEDbRrPCHN0JE
         EdypvR7cszIgaA4XWEQlr4fdsqbJJDuNr07l0DkEZG0LR4CcQulVJE2jEgpr4rBv6uul
         F0Mw==
X-Gm-Message-State: AGRZ1gL6Qisl5mkSy3D5a4zIK/JBZdq3zsDsDfb4f0vY/VZdJogMB/kK
        RndTC1XhoSDFvN/3R7S/WQ==
X-Google-Smtp-Source: AJdET5dh2XzL8Gpg1tvBe4sKGqmyqhCR+ZdJAF/VE5xGkL1Oe5d/r0RfbHhoIrNg4L2JumSPmCfp7Q==
X-Received: by 2002:a9d:42e1:: with SMTP id c30mr2382773otj.307.1540402809775;
        Wed, 24 Oct 2018 10:40:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z9sm1778779ota.44.2018.10.24.10.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 10:40:08 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:40:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luis Oliveira <luis.oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        joao.pinto@synopsys.com, festevam@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [V3, 3/4] Documentation: dt-bindings: media: Document bindings
 for DW MIPI CSI-2 Host
Message-ID: <20181024174007.GA2902@bogus>
References: <1539953556-35762-1-git-send-email-lolivei@synopsys.com>
 <1539953556-35762-4-git-send-email-lolivei@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539953556-35762-4-git-send-email-lolivei@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:52:25PM +0200, Luis Oliveira wrote:
> Add bindings for Synopsys DesignWare MIPI CSI-2 host.
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changelog
> v2-V3
> - removed IPI settings
> 
>  .../devicetree/bindings/media/snps,dw-csi-plat.txt | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
> new file mode 100644
> index 0000000..be3da05
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/snps,dw-csi-plat.txt
> @@ -0,0 +1,52 @@
> +Synopsys DesignWare CSI-2 Host controller
> +
> +Description
> +-----------
> +
> +This HW block is used to receive image coming from an MIPI CSI-2 compatible
> +camera.
> +
> +Required properties:
> +- compatible: shall be "snps,dw-csi-plat"

'plat' is really part of the name of the h/w block?

> +- reg			: physical base address and size of the device memory mapped
> +  registers;
> +- interrupts		: CSI-2 Host interrupt
> +- snps,output-type	: Core output to be used (IPI-> 0 or IDI->1 or BOTH->2)
> +			  These  values choose which of the Core outputs will be used,
> +			  it can be Image Data Interface or Image Pixel Interface.
> +- phys			: List of one PHY specifier (as defined in
> +			  Documentation/devicetree/bindings/phy/phy-bindings.txt).
> +			  This PHY is a MIPI DPHY working in RX mode.
> +- resets		: Reference to a reset controller (optional)
> +
> +The per-board settings:
> + - port sub-node describing a single endpoint connected to the camera as
> +   described in video-interfaces.txt[1].

Need to say 2 ports and what is each port? Why no port #0?

> +
> +Example:
> +
> +	csi2_1: csi2@3000 {
> +		compatible = "snps,dw-csi-plat";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = < 0x03000 0x7FF>;
> +		interrupts = <2>;
> +		output-type = <2>;
> +		resets = <&dw_rst 1>;
> +		phys = <&mipi_dphy_rx1 0>;
> +		phy-names = "csi2-dphy";

Not documented. Not really needed for a single entry, so I'd just drop 
it.

> +
> +		/* CSI-2 per-board settings */
> +		port@1 {
> +			reg = <1>;
> +			csi1_ep1: endpoint {
> +				remote-endpoint = <&camera_1>;
> +				data-lanes = <1 2>;
> +			};
> +		};
> +		port@2 {
> +			csi1_ep2: endpoint {
> +				remote-endpoint = <&vif1_ep>;
> +			};
> +		};
> +	};
> --
> 2.7.4
> 
