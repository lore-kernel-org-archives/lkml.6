Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeDITMh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:12:37 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39864 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeDITMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:12:35 -0400
X-Google-Smtp-Source: AIpwx48+edazKEc0Md3Bt3eXQyZQRxx8qUdUPGt6Du78CCUqmLXEnUlsMBA/1h+1/aWdVIUCaXzjXQ==
Date: Mon, 9 Apr 2018 14:12:33 -0500
From: Rob Herring <robh@kernel.org>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/8] bindings: PCI: designware: Add support for the EP in
 designware driver
Message-ID: <20180409191233.l2s5hnrq7gejrmq6@rob-hp-laptop>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <dd582bfc2780679b7a092d23547c316234a84c34.1522235224.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd582bfc2780679b7a092d23547c316234a84c34.1522235224.git.gustavo.pimentel@synopsys.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 12:38:33PM +0100, Gustavo Pimentel wrote:
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 6300762..4bb2e08 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>  - compatible:
>  	"snps,dw-pcie" for RC mode;
> +	"snps,dw-pcie-ep" for EP mode;
>  - reg: Should contain the configuration address space.
>  - reg-names: Must be "config" for the PCIe configuration space.
>      (The old way of getting the configuration address space from "ranges"
> @@ -56,3 +57,15 @@ Example configuration:
>  		#interrupt-cells = <1>;
>  		num-lanes = <1>;
>  	};
> +or
> +	pcie_ep: pcie_ep@dfc00000 {

pcie-ep@...

Or what others have used. We should define a standard name in the DT 
spec for this.

> +		compatible = "snps,dw-pcie-ep";
> +		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
> +		      <0xdfc01000 0x0001000>, /* IP registers 2 */
> +		      <0xd0000000 0x2000000>; /* Configuration space */
> +		reg-names = "dbi", "dbi2", "addr_space";
> +		device_type = "pci";
> +		num-ib-windows = <6>;
> +		num-ob-windows = <2>;
> +		num-lanes = <1>;
> +	};
> -- 
> 2.7.4
> 
> 
