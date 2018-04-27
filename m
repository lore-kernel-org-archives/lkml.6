Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759054AbeD0Tux (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:50:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45388 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758725AbeD0Tuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:50:51 -0400
X-Google-Smtp-Source: AB8JxZrKKgJy8TzK5kU+OWUyeEMRXMrHxu0zJX9AOoBjDrkj7Qs6A8wsJxQY3TUOvRHkXLhee+qBAg==
Date: Fri, 27 Apr 2018 14:50:49 -0500
From: Rob Herring <robh@kernel.org>
To: Liming Sun <lsun@mellanox.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: bluefield-dw-mshc: add DT
 description
Message-ID: <20180427195049.ycjmhes4qj4n3myq@rob-hp-laptop>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <7505274f8d82642fd08e874160acd45be2418673.1524497286.git.lsun@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7505274f8d82642fd08e874160acd45be2418673.1524497286.git.lsun@mellanox.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:32:21AM -0400, Liming Sun wrote:
> This commit adds "mellanox,bluefield-dw-mshc" for dwmmc driver
> extension on Mellanox BlueField SoC platform.

"dt-bindings: mmc: " is preferred subject prefix.

> 
> Signed-off-by: Liming Sun <lsun@mellanox.com>
> ---
>  .../devicetree/bindings/mmc/bluefield-dw-mshc.txt  | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> new file mode 100644
> index 0000000..ee0dd61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/bluefield-dw-mshc.txt
> @@ -0,0 +1,29 @@
> +* Mellanox Bluefield SoC specific extensions to the Synopsys Designware
> +  Mobile Storage Host Controller
> +
> +Read synopsys-dw-mshc.txt for more details
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the Mellanox Bluefield SoC
> +specific extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be one of the following.
> +  - "mellanox,bluefield-dw-mshc": for controllers with Mellanox Bluefield SoC
> +    specific extensions.
> +
> +Example:
> +
> +	/* Mellanox Bluefield SoC MMC */
> +	dwmmc0@4,0 {

mmc@...

Doesn't look like a correct unit-address either.

> +		compatible = "mellanox,bluefield-dw-mshc";
> +		reg = <4 0x8000 0x400>;
> +		interrupts = <32>;
> +		fifo-depth = <0x100>;
> +		clock-frequency = <24000000>;
> +		bus-width = <8>;
> +		cap-mmc-highspeed;
> +	};
> -- 
> 1.8.3.1
> 
