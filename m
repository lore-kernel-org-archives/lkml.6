Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeEGIkQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:40:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45960 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752423AbeEGIkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:40:13 -0400
Date: Mon, 7 May 2018 10:40:10 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 03/14] dt-bindings: qcom_nandc: make
 nand-ecc-strength optional
Message-ID: <20180507104010.620a4b43@bbrezillon>
In-Reply-To: <1525350041-22995-4-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
        <1525350041-22995-4-git-send-email-absahu@codeaurora.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 May 2018 17:50:30 +0530
Abhishek Sahu <absahu@codeaurora.org> wrote:

> Now, nand-ecc-strength is optional. If specified in DT, then
> controller will use this ECC strength otherwise ECC strength will
> be calculated according to chip requirement and available OOB size.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v1:
> 
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

As mentioned in my other review, no need to specify nand-ecc-step-size
if you don't have a choice. You can remove the property and say that
nand-ecc-strength encodes the ECC strength for 512 bytes chunks.

>  
>  Optional properties:
>  - nand-bus-width:	see nand.txt
> +- nand-ecc-strength:	see nand.txt. If not specified, then ECC strength will
> +			be used according to chip requirement and available
> +			OOB size.
>  
>  Each nandcs device node may optionally contain a 'partitions' sub-node, which
>  further contains sub-nodes describing the flash partition mapping. See
