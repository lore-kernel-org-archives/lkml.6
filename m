Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031419AbeEZInP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:43:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35890 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031300AbeEZInI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:43:08 -0400
Date: Sat, 26 May 2018 10:42:53 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 03/16] dt-bindings: qcom_nandc: make
 nand-ecc-strength optional
Message-ID: <20180526104253.05489470@xps13>
In-Reply-To: <1527250904-21988-4-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-4-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Fri, 25 May 2018 17:51:31 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> If nand-ecc-strength specified in DT, then controller will use
> this ECC strength otherwise ECC strength will be calculated
> according to chip requirement and available OOB size.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v2:
>   NONE
> 
> * Changes from v1:
>   NEW PATCH
> 
>  Documentation/devicetree/bindings/mtd/qcom_nandc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
> index 73d336be..f246aa0 100644
> --- a/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
> +++ b/Documentation/devicetree/bindings/mtd/qcom_nandc.txt
> @@ -45,11 +45,13 @@ Required properties:
>  			number (e.g., 0, 1, 2, etc.)
>  - #address-cells:	see partition.txt
>  - #size-cells:		see partition.txt
> -- nand-ecc-strength:	see nand.txt
>  - nand-ecc-step-size:	must be 512. see nand.txt for more details.

I think you can squash the two dt-bindings commits as they are tightly
related to each other.

>  
>  Optional properties:
>  - nand-bus-width:	see nand.txt
> +- nand-ecc-strength:	see nand.txt. If not specified, then ECC strength will
> +			be used according to chip requirement and available
> +			OOB size.
>  
>  Each nandcs device node may optionally contain a 'partitions' sub-node, which
>  further contains sub-nodes describing the flash partition mapping. See



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
