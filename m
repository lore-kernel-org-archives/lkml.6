Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeDPVIz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:08:55 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41761 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeDPVIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:08:53 -0400
X-Google-Smtp-Source: AIpwx4+LZf71v8P8HRNBZrrCbW6hMr9EPzlFkItTzs06znLwlBUpOQ0kaN9xQdMxygTHOM2EHZTpdw==
Date: Mon, 16 Apr 2018 16:08:51 -0500
From: Rob Herring <robh@kernel.org>
To: Alban Bedel <albeu@free.fr>
Cc: linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 2/3] doc: bindings: Add bindings documentation for mtd
 nvmem
Message-ID: <20180416210851.shu73nlincslxlde@rob-hp-laptop>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
 <1521933899-362-3-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521933899-362-3-git-send-email-albeu@free.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:24:58AM +0100, Alban Bedel wrote:
> Config data for drivers, like MAC addresses, is often stored in MTD.
> Add a binding that define how such data storage can be represented in
> device tree.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
> Changelog:
> v2: * Added a "Required properties" section with the nvmem-provider
>       property
> v3: * Fixed my name in From and Signed-off-by
>     * Moved to the new nvmem binding with the nvmem-cells subnode
> ---
>  .../devicetree/bindings/nvmem/mtd-nvmem.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt b/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt
> new file mode 100644
> index 0000000..c819a69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/mtd-nvmem.txt
> @@ -0,0 +1,27 @@
> += NVMEM in MTD =
> +
> +Config data for drivers, like MAC addresses, is often stored in MTD.
> +An MTD device, or one of its partition, can be defined as a NVMEM provider
> +by having an 'nvmem-cells' subnode as defined in nvmem.txt.
> +
> +Example:
> +
> +	flash@0 {
> +		...
> +
> +		partition@2 {

This unit address is not correct...

> +			label = "art";
> +			reg = <0x7F0000 0x010000>;

Lowercase hex.

> +			read-only;
> +
> +			nvmem-cells {
> +				compatible = "nvmem-cells";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				eeprom@1000 {

"eeprom" isn't specific data. The purpose of the nvmem binding is to 
provide specific data fields like MAC addresseses.

Plus "eeprom" is the node name for EEPROM devices.

> +					reg = <0x1000 0x1000>;
> +				};
> +			};
> +		};
> +	};
> -- 
> 2.7.4
> 
