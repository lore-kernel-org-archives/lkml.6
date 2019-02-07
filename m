Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA69CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D907218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfBGKlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:41:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45193 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfBGKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:41:43 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1grh7g-00089V-6p; Thu, 07 Feb 2019 11:41:36 +0100
Message-ID: <1549536094.4557.8.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add HI3670 reset controller
 binding
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org
Date:   Thu, 07 Feb 2019 11:41:34 +0100
In-Reply-To: <20190201153841.21903-2-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
         <20190201153841.21903-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

On Fri, 2019-02-01 at 21:08 +0530, Manivannan Sadhasivam wrote:
> HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
> driver is reused for HI3670 SoC and the binding is documented here.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt     | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> index 2bf3344b2a02..5d60ec541331 100644
> --- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> @@ -5,11 +5,12 @@ Please also refer to reset.txt in this directory for common reset
>  controller binding usage.
>  
>  The reset controller registers are part of the system-ctl block on
> -hi3660 SoC.
> +hi3660 and hi3670 SoCs.
>  
>  Required properties:
> -- compatible: should be
> +- compatible: should be one of the following:
>  		 "hisilicon,hi3660-reset"
> +		 "hisilicon,hi3670-reset"

If the HI3670 reset controller is compatible to the HI3660 reset
controller, this could be:

- compatible: should be one of the following:
              "hisilicon,hi3660-reset" for HI3660
              "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670

That way there would be no need to change the driver and it would be
documented that the two reset controllers are compatible.

regards
Philipp
