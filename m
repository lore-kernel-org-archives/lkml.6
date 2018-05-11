Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeEKIo3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:44:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39084 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeEKIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:44:27 -0400
X-Google-Smtp-Source: AB8JxZr2ojkI7E1Ls8bfnXUK8M8U0ylT1rVBZqXzNkc9hAkAsd6r3NpP9v1YhAesJb0ij1XPiiZ0Jw==
Subject: Re: [RFC 1/2] documentation: Add nvmem bindings documentation
To: chinnikishore369@gmail.com, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Nava kishore Manne <navam@xilinx.com>
References: <20180324174638.12621-1-chinnikishore369@gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4c6115db-2272-6d35-e220-be0f61b37cb0@linaro.org>
Date: Fri, 11 May 2018 09:44:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180324174638.12621-1-chinnikishore369@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 24/03/18 17:46, chinnikishore369@gmail.com wrote:
> From: Nava kishore Manne <navam@xilinx.com>
> 
> This patch add the bindings document of zynqmp silicon id driver.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>

I see that you have not included DT maintainers in to/cc list, I can not 
accept new drivers whose bindings are not Acked/Reviewed by DT maintainers.

Overall the driver looks fine for me.


thanks,
srini


> ---
>   .../devicetree/bindings/nvmem/zynqmp_nvmem.txt     | 32 ++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
> new file mode 100644
> index 000000000000..94332f160a92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/zynqmp_nvmem.txt
> @@ -0,0 +1,32 @@
> +=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
> +
> +Required properties:
> +- compatible: should be "xlnx,zynqmp-nvmem-fw"
> +
> += Data cells =
> +Are child nodes of silicon id, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +	nvmem_firmware {
> +		compatible = "xlnx,zynqmp-nvmem-fw";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		 /* Data cells */
> +		soc_revision: soc_revision@0 {
> +			reg = <0x0 0x4>;
> +		};
> +	};
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	pcap {
> +		...
> +		nvmem-cells = <&soc_revision>;
> +		nvmem-cell-names = "soc_revision";
> +	};
> 
