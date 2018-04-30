Return-Path: <lee.jones@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525084232; cv=none;
        d=google.com; s=arc-20160816;
        b=WiQHBxC0s1WtVANwKXn0XMJFVyNobFVcPUebU1lE8RtQWmmcug8+7a4YX4O7Xw1wH6
         uAqv8fofgqWnb9GcSiUtaVLs7NgpA/zltt5aSyfZrP4ZXRbQ772Ie+V0iyyQ7zwbM8rB
         NO3ZSZQh+ZTeuNqvzNCudStqVIjBncJCXv7/+XwFOe67w60o/UyjuCFdJhPo8I91wTXG
         vLDQBdoZrEi6N/B5s0YGOpcbmCSkDbH3UcphNpCRk3pSbAJtHTmmF911AVS9enzhZX58
         xK/tnCAKA0VMiuyl2wWS64Iswc8lFW3gGE3dJyZxhrTHK4+yCe/xiQ4DQeHLugLmne4S
         bzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=pNhCL5NHo42HQ/3bdFvBUUZIWwn5z2onYFUV1tH6uu4=;
        b=KeuV88dXFr0sUNVxeVMFRSceF7g/N6WQqx10dIHKbTUgPAwNxeL3VABF/M8pE6Wv7N
         /aVrE/e/JAmEhPnVahT4I0CVDnbeMEIm9hpvG1NHNL4q28yI/++4MwRpQ6KTTJITqyVu
         6XGumK1Q0QLn5pPsTi2gMfZgmWCITG8Lj0jn+Ti+ZBQegTkh1MKh2OH8I2zoaat1mLYe
         6NnELYd04wtaOfxaqdQmkTp27SsLXl4/dv8sosllv+Jej+KRUbjdEPfhMT/tuzd5gXsy
         CpYDc7sQysQICNsZeXvzEve79ikPRLtyeiWD9UegQ4JXL1WEil7cJGxeGwyWcq7hW0cu
         gjBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FaMjiFz+;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=FaMjiFz+;
       spf=pass (google.com: domain of lee.jones@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=lee.jones@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoU3xNm+8nZFJ6PX+QFx1wbvFEpemn1JJqv3DAPFbUYQTGuGjIVHTaa5tlvCg14oyheUQvw7Q==
Date: Mon, 30 Apr 2018 11:30:29 +0100
From: Lee Jones <lee.jones@linaro.org>
To: matthias.bgg@kernel.org
Cc: ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
	robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
	sboyd@codeaurora.org, davem@davemloft.net,
	gregkh@linuxfoundation.org, mchehab@kernel.org,
	rdunlap@infradead.org, sean.wang@mediatek.com,
	linux-clk@vger.kernel.org, linux@armlinux.org.uk,
	matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: Re: [v3 01/10] dt-bindings: mediatek: mmsys: Add support for mfd
Message-ID: <20180430103029.GD5147@dell>
References: <cover.1524820923.git.mbrugger@suse.com>
 <64ca273429d92f581568a48f3efe6035af65f579.1524820923.git.mbrugger@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64ca273429d92f581568a48f3efe6035af65f579.1524820923.git.mbrugger@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598890774192452836?=
X-GMAIL-MSGID: =?utf-8?q?1599166723776672088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018, matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> Add binding description for the mmsys mfd for some Mediatek
> devices. mmsys has some registers to control clock gates (which is
> used in the clk driver) and some registers to set the routing and enable
> the differnet blocks of the display subsystem.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.txt       |  2 --
>  .../bindings/display/mediatek/mediatek,disp.txt    |  2 +-
>  .../devicetree/bindings/mfd/mediatek,mmsys.txt     | 27 ++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index 4eb8bbe15c01..4468345f8b1a 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -6,10 +6,8 @@ The Mediatek mmsys controller provides various clocks to the system.
>  Required Properties:
>  
>  - compatible: Should be one of:
> -	- "mediatek,mt2701-mmsys", "syscon"
>  	- "mediatek,mt2712-mmsys", "syscon"
>  	- "mediatek,mt6797-mmsys", "syscon"
> -	- "mediatek,mt8173-mmsys", "syscon"
>  - #clock-cells: Must be 1
>  
>  The mmsys controller uses the common clk binding from
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 383183a89164..85a3b4ec06cd 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -9,7 +9,7 @@ function block.
>  
>  All DISP device tree nodes must be siblings to the central MMSYS_CONFIG node.
>  For a description of the MMSYS_CONFIG binding, see
> -Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt.
> +Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
>  
>  DISP function blocks
>  ====================
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> new file mode 100644
> index 000000000000..2331ae16917e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mmsys.txt
> @@ -0,0 +1,27 @@
> +MediaTek MMSYS Multifunction Device Driver

What is "MMSYS"?

"Multi-Function Driver"s are specific to Linux.

What actually is the device?

> +MMSYS is a multifunction device with the following sub modules:
> +- clocks for the multi-media subsystem
> +- central node for the DRM subsystem.
> +
> +This document describes the binding for MFD device. The MFD takes care to initailize
> +the clock driver and the DRM driver. More info see
> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +
> +Required properties:
> +- compatible: Should be one of:
> +	- "mediatek,mt2701-mmsys", "syscon"
> +	- "mediatek,mt8173-mmsys", "syscon"
> +- #clock-cells: Must be 1
> +
> +Optional properties:
> +- power-domains: list of powerdomains needed for the subsystem to work
> +
> +Example:
> +
> +mmsys: clock-controller@14000000 {
> +	compatible = "mediatek,mt8173-mmsys", "syscon";
> +	reg = <0 0x14000000 0 0x1000>;
> +	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
> +	#clock-cells = <1>;
> +};

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
