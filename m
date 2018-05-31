Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755664AbeEaQs1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:48:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45934 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755506AbeEaQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:48:23 -0400
X-Google-Smtp-Source: ADUXVKIRrB+SVG3K3l1u8Td8qu0LPSHSG4hDkG2gnEEa4EIYkkaxAQYvGea1x0zsPU9bA6TlAgGXOQ==
Date: Thu, 31 May 2018 11:48:20 -0500
From: Rob Herring <robh@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for SR
 thermal
Message-ID: <20180531164820.GA23074@rob-hp-laptop>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
 <1527486084-4636-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527486084-4636-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:11:22AM +0530, Srinath Mannam wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Add binding document for supported thermal implementation
> in Stingray.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> 
> diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> new file mode 100644
> index 0000000..33f9e11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> @@ -0,0 +1,45 @@
> +* Broadcom Stingray Thermal
> +
> +This binding describes thermal sensors that is part of Stingray SoCs.
> +
> +Required properties:
> +- compatible : Must be "brcm,sr-thermal"
> +- reg : memory where tmon data will be available.

What type of memory is this?

> +
> +Example:
> +	tmons {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		tmon_ihost0: thermal@8f100000 {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0x8f100000 0x4>;
> +		};

Convince me that you need a node per register. This can all be 
accomplished with a single node and either a single reg entry or a 
series of reg entries.

> +
> +		tmon_ihost1: thermal@8f100004 {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0x8f100004 0x4>;
> +		};
> +
> +		tmon_ihost2: thermal@8f100008 {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0x8f100008 0x4>;
> +		};
> +
> +		tmon_ihost3: thermal@8f10000c {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0x8f10000c 0x4>;
> +		};
> +
> +		tmon_crmu: thermal@8f100010 {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0x8f100010 0x4>;
> +		};
> +
> +		tmon_nitro: thermal@8f100014 {
> +			compatible = "brcm,sr-thermal";
> +			reg = <0x8f100014 0x4>;
> +		};
> +	};
> -- 
> 2.7.4
> 
