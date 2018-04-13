Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeDMVeb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:34:31 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40835 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeDMVe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:34:29 -0400
X-Google-Smtp-Source: AIpwx49ROHxKFRU0rxiH2gIfCEOvMybUAAiBhMr/Ki7eu+C0PZ68quRABfc5M2/8VzEzzUesnzYoVQ==
Date: Fri, 13 Apr 2018 16:34:27 -0500
From: Rob Herring <robh@kernel.org>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/10] bindings: PCI: designware: Example update
Message-ID: <20180413213427.3ny7ids3q7yxf35g@rob-hp-laptop>
References: <cover.1523360166.git.gustavo.pimentel@synopsys.com>
 <a3eebc66b17172b92e91d95c12a9d0289b9417c2.1523360166.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3eebc66b17172b92e91d95c12a9d0289b9417c2.1523360166.git.gustavo.pimentel@synopsys.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 01:58:33PM +0100, Gustavo Pimentel wrote:
> Replaces "ctrlreg" reg-name by "dbi" to be coherent with similar drivers,
> however it still be compatible with any previous DT that uses the old
> reg-name.
> 
> Replaces the PCIe base address example by a real PCIe base address in use.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes v1->v2:
>  - Removed any iATU reference or changes to avoid confusion.
>  - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
> Changes v2->v3:
> - Nothing changed, just to follow the patch set version.
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 1da7ade..f02cd20 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -1,7 +1,8 @@
>  * Synopsys DesignWare PCIe interface
>  
>  Required properties:
> -- compatible: should contain "snps,dw-pcie" to identify the core.
> +- compatible:
> +	"snps,dw-pcie-rc", "snps,dw-pcie" for RC mode;

I think adding this compatible is pointless. "snps,dw-pcie" meant RC and 
should continue to mean that. We also have compatibles with the IP 
version number as well as the SoC specific compatible strings. We don't 
need 4 compatible strings here.

Rob
