Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeCPQbM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:31:12 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45116 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeCPQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:31:09 -0400
X-Google-Smtp-Source: AG47ELtpjffRXNJCEFGjmpgS+ywnUu3WMzxprPmcquAfS+nLINByoFMa03Yz1JrOPKkLw0m4xCrSCw==
Date: Fri, 16 Mar 2018 09:31:07 -0700
From: Moritz Fischer <mdf@kernel.org>
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: fpga: add lattice machxo2 slave spi
 binding description
Message-ID: <20180316163107.67gaxcjksn76ztmn@us-sjc-wireless-10-16-34-48.amer.corp.natinst.com>
References: <1521215669-23874-1-git-send-email-p.pisati@gmail.com>
 <1521215669-23874-2-git-send-email-p.pisati@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521215669-23874-2-git-send-email-p.pisati@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 04:54:28PM +0100, Paolo Pisati wrote:
> Add dt binding documentation details for Lattice MachXO2 FPGA configuration
> over Slave SPI interface.
> 
> Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
>  .../bindings/fpga/lattice-machxo2-spi.txt          | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
> new file mode 100644
> index 0000000..a8c362e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
> @@ -0,0 +1,29 @@
> +Lattice MachXO2 Slave SPI FPGA Manager
> +
> +Lattice MachXO2 FPGAs support a method of loading the bitstream over
> +'slave SPI' interface.
Nit: a 'slave SPI'
> +
> +See 'MachXO2ProgrammingandConfigurationUsageGuide.pdf' on www.latticesemi.com
> +
> +Required properties:
> +- compatible: should contain "lattice,machxo2-slave-spi"
> +- reg: spi chip select of the FPGA
> +
> +Example for full FPGA configuration:
> +
> +	fpga-region0 {
> +		compatible = "fpga-region";
> +		fpga-mgr = <&fpga_mgr_spi>;
> +		#address-cells = <0x1>;
> +		#size-cells = <0x1>;
> +	};
> +
> +	spi1: spi@2000 {
> +        ...
> +
> +		fpga_mgr_spi: fpga-mgr@0 {
> +			compatible = "lattice,machxo2-slave-spi";
> +			spi-max-frequency = <8000000>;
> +			reg = <0>;
> +		};
> +	};
> -- 
> 2.7.4
> 

Thanks,

Moritz
