Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755860AbeEAMsE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:48:04 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44275 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755380AbeEAMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:48:02 -0400
X-Google-Smtp-Source: AB8JxZqSBDAyeK4dHWMAgEQSMLj4PMYsaaU/RvX3IuEdA4fiTRVUTbZbWnh8uXtf3aVSMz/K8t8oaw==
Date: Tue, 1 May 2018 07:48:00 -0500
From: Rob Herring <robh@kernel.org>
To: Liming Sun <lsun@mellanox.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: Add binding for BlueField SoC
Message-ID: <20180501124800.GA6206@rob-hp-laptop>
References: <026fa942828c54fda5bad225981e56abc808b949.1524497286.git.lsun@mellanox.com>
 <1525099868-45094-2-git-send-email-lsun@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525099868-45094-2-git-send-email-lsun@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:51:07AM -0400, Liming Sun wrote:
> This commit adds "mellanox,bluefield-dw-mshc" for dwmmc driver
> extension on Mellanox BlueField SoC platform.
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

Still the same issues.

mmc@...

And the unit-address looks wrong.

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
