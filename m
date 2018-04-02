Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeDBFXh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:23:37 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:27805 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbeDBFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:23:35 -0400
Subject: Re: [PATCH 1/8] bindings: PCI: designware: Example update
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <33aa86ee667e8b435db080b8c683cb5df1bd6544.1522235224.git.gustavo.pimentel@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fa001440-0dfe-b84a-e5ef-9285043b5ede@ti.com>
Date: Mon, 2 Apr 2018 10:53:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <33aa86ee667e8b435db080b8c683cb5df1bd6544.1522235224.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 28 March 2018 05:08 PM, Gustavo Pimentel wrote:
> Changes the IP registers size to accommodate the ATU unroll space.
> 
> Replaces "ctrlreg" reg-name by "dbi" to be coherent with similar drivers.
> 
> Replaces the pcie base address example by a real pcie base address in use.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 1da7ade..6300762 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -1,7 +1,8 @@
>  * Synopsys DesignWare PCIe interface
>  
>  Required properties:
> -- compatible: should contain "snps,dw-pcie" to identify the core.
> +- compatible:
> +	"snps,dw-pcie" for RC mode;

I think irrespective of RC mode or EP mode, "snps,dw-pcie" can be used to
identify the pcie core?
>  - reg: Should contain the configuration address space.
>  - reg-names: Must be "config" for the PCIe configuration space.
>      (The old way of getting the configuration address space from "ranges"
> @@ -41,11 +42,11 @@ EP mode:
>  
>  Example configuration:
>  
> -	pcie: pcie@dffff000 {
> +	pcie: pcie@dfc00000 {
>  		compatible = "snps,dw-pcie";
> -		reg = <0xdffff000 0x1000>, /* Controller registers */
> -		      <0xd0000000 0x2000>; /* PCI config space */
> -		reg-names = "ctrlreg", "config";
> +		reg = <0xdfc00000 0x302000>, /* IP registers */

which version of synopsys IP is this. I think the ideal thing to do here is to
have a separate register space for iATU.

Thanks
Kishon
