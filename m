Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F0DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF7120651
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550846600;
	bh=pyS87RG0MqwtQj7F9fsHkLTEyaPsOowR5xj3/R/QD7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/shXv3M4saK0XJxvrs6eEORnXLpFztFuuPzvytp+aKPyTypeDV9GVJrGfusewFZ9
	 tU1oBe5BNJEX7zwRLkDhHmIg93ZoSgtBJ5c/9oAce45DRIoakoDddJMai+t7575rFR
	 iNgdy91d3nzgBBjTMiarrX8zFeWEuDL1X/T25Nsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfBVOnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:43:19 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46814 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBVOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 09:43:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id j135so1842978oib.13;
        Fri, 22 Feb 2019 06:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8UqyK51WWUMv62f/xSf/NgWglLHOsqA+OVLyel2pKmk=;
        b=fbhBF7jJg5j4OqgtmcW757W5HFKGr2eY+GZgHqIOSsx04R6uugyzjif1Vmt8jfVq5x
         UWjMmJQoWiznTHmJ1zg+dU/+BFkqg+lD576KSjP2sRMz+VxOKbNtqAvLdy1SWsqVbZEG
         04W0bm3x1/B6wSZSKiqiu5HOr5og/qrOJI730+a2FDqNf6QCGzV71HhVBmcp7icaLZ/D
         euqQQ+tSEwdUIx+8+ppkHeEG2qlYOuO//LBOBNHJv5wbFgQujwWFVvyWFWPfxPxsgNOs
         im92I4/+DaoyEvwab7hDu5GFUufVoaa7PcciOgb3RCqaTnlBbkiJ54AJ4jYbVNTAu1U+
         xGKg==
X-Gm-Message-State: AHQUAubOqRaoan1E0w6a9Gns7Z7N4AC9yum299OsXPGVEGtMyzl6vN/u
        0sblmXfvI0ba3yQ3xkkQPQ==
X-Google-Smtp-Source: AHgI3IbiU1/o2lREFx/T/rryMFh7rCjg6zqfdW6sBders53BoAnhdFu0fjZj/gWekkZ2rMhOJUEG9w==
X-Received: by 2002:aca:4c10:: with SMTP id z16mr2650708oia.53.1550846598019;
        Fri, 22 Feb 2019 06:43:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a4sm642157otc.21.2019.02.22.06.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 06:43:17 -0800 (PST)
Date:   Fri, 22 Feb 2019 08:43:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Erin Lo <erin.lo@mediatek.com>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: Add a binding for Mediatek SCP
Message-ID: <20190222144316.GA19284@bogus>
References: <20190221084729.101784-1-pihsun@chromium.org>
 <20190221084729.101784-2-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221084729.101784-2-pihsun@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:47:24PM +0800, Pi-Hsun Shih wrote:
> From: Erin Lo <erin.lo@mediatek.com>
> 
> Add a DT binding documentation of SCP for the
> MT8183 SoC from Mediatek.
> 
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
> Changes from v4:
>  - Add detail of more properties.
>  - Document the usage of mtk,rpmsg-name in subnode from the new design.
> 
> Changes from v3:
>  - No change.
> 
> Changes from v2:
>  - No change. I realized that for this patch series, there's no need to
>    add anything under the mt8183-scp node (neither the mt8183-rpmsg or
>    the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
>    directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
>    created by SCP name service.
> 
> Changes from v1:
>  - No change.
> ---
>  .../bindings/remoteproc/mtk,scp.txt           | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> new file mode 100644
> index 00000000000000..8cf8b0e0d98a4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
> @@ -0,0 +1,37 @@
> +Mediatek SCP Bindings
> +----------------------------------------
> +
> +This binding provides support for ARM Cortex M4 Co-processor found on some
> +Mediatek SoCs.
> +
> +Required properties:
> +- compatible		Should be "mediatek,mt8183-scp"
> +- reg			Should contain the address ranges for the two memory
> +			regions, SRAM and CFG.
> +- reg-names		Contains the corresponding names for the two memory
> +			regions. These should be named "sram" & "cfg".
> +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
> +- clock-names		Contains the corresponding name for the clock. This
> +			should be named "main".
> +
> +Subnodes
> +--------
> +
> +When CONFIG_RPMSG_MTK_SCP is enabled, subnodes of the SCP represent rpmsg

Bindings can't depend on kernel config options.

> +devices. The names of the devices are not important. The properties of these
> +nodes are defined by the individual bindings for the rpmsg devices - but must
> +contain the following property:
> +
> +- mtk,rpmsg-name	Contains the name for the rpmsg device. Used to match
> +			the subnode to rpmsg device announced by SCP.

I don't think this belongs in DT, but without some examples I'm not 
really sure.

> +
> +Example:
> +
> +	scp: scp@10500000 {
> +		compatible = "mediatek,mt8183-scp";
> +		reg = <0 0x10500000 0 0x80000>,
> +		      <0 0x105c0000 0 0x5000>;
> +		reg-names = "sram", "cfg";
> +		clocks = <&infracfg CLK_INFRA_SCPSYS>;
> +		clock-names = "main";
> +	};
> -- 
> 2.21.0.rc0.258.g878e2cd30e-goog
> 
