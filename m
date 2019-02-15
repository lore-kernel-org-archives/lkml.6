Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74783C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458EC21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393823AbfBOKZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:25:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34015 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392402AbfBOKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:25:40 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1guagV-00078g-Jj; Fri, 15 Feb 2019 11:25:31 +0100
Message-ID: <1550226330.4531.10.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add HI3670 reset controller
 binding
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, guodong.xu@linaro.org,
        john.stultz@linaro.org
Date:   Fri, 15 Feb 2019 11:25:30 +0100
In-Reply-To: <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
References: <20190215054955.788-1-manivannan.sadhasivam@linaro.org>
         <20190215054955.788-2-manivannan.sadhasivam@linaro.org>
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

On Fri, 2019-02-15 at 11:19 +0530, Manivannan Sadhasivam wrote:
> HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
> driver is reused for HI3670 SoC and the binding is documented here which
> uses the fallback approach.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/reset/hisilicon,hi3660-reset.txt   | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
> index 2bf3344b2a02..2df4bddeb688 100644
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
> -		 "hisilicon,hi3660-reset"
> +- compatible: should be one of the following:
> +		 "hisilicon,hi3660-reset" for HI3660
> +		 "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
>  - hisi,rst-syscon: phandle of the reset's syscon.
>  - #reset-cells : Specifies the number of cells needed to encode a
>    reset source.  The type shall be a <u32> and the value shall be 2.

Thank you, I think it makes sense for this to be merged together with
the other patch via the linux-hisi tree.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
