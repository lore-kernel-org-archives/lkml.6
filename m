Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677A220883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677A220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeKJAmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:42:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36083 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKJAmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:42:11 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gL8HU-0007yu-Fl; Fri, 09 Nov 2018 16:01:08 +0100
Message-ID: <1541775663.4112.48.camel@pengutronix.de>
Subject: Re: [PATCH 3/4] dt-bindings: reset: uniphier: Add AHCI core reset
 description
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Date:   Fri, 09 Nov 2018 16:01:03 +0100
In-Reply-To: <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1541727727-10821-1-git-send-email-hayashi.kunihiko@socionext.com>
         <1541727727-10821-4-git-send-email-hayashi.kunihiko@socionext.com>
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

Hi Kunihiko,

On Fri, 2018-11-09 at 10:42 +0900, Kunihiko Hayashi wrote:
> Add compatible strings for reset control of AHCI core implemented in
> UniPhier SoCs. The reset control belongs to AHCI glue layer.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/reset/uniphier-reset.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> index f63c511..ea00517 100644
> --- a/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
> @@ -133,6 +133,9 @@ Required properties:
>      "socionext,uniphier-pxs2-usb3-reset" - for PXs2 SoC USB3
>      "socionext,uniphier-ld20-usb3-reset" - for LD20 SoC USB3
>      "socionext,uniphier-pxs3-usb3-reset" - for PXs3 SoC USB3
> +    "socionext,uniphier-pro4-ahci-reset" - for Pro4 SoC AHCI
> +    "socionext,uniphier-pxs2-ahci-reset" - for PXs2 SoC AHCI
> +    "socionext,uniphier-pxs3-ahci-reset" - for PXs3 SoC AHCI

Since the driver behaves identically for "socionext,uniphier-pro4-usb3-
reset" and "socionext,uniphier-pro4-ahci-reset", would it make sense to
add a common compatible?
Something like:
"socionext,uniphier-pro4-usb3-reset", "socionext,uniphier-pro4-glue-reset" - for USB3 SoC AHCI
"socionext,uniphier-pro4-ahci-reset", "socionext,uniphier-pro4-glue-reset" - for Pro4 SoC AHCI

That way if more places turn up where the glue layer reset is used,
you can add them without patching the driver every time.

regards
Philipp
