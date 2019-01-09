Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A7C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF8A20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfAIHwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:52:07 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34149 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfAIHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:52:06 -0500
Received: by mail-vs1-f67.google.com with SMTP id y27so4211148vsi.1;
        Tue, 08 Jan 2019 23:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/00JG/LKDGXbS/7oDQfRERssheEGJxE8WucQTaYTm5w=;
        b=dJzQerfpMHZPhEVFWFmJnXfpkjQdqhJuqkc0GQzNSWc4I0pxHPeR6oc9JOmehqbt46
         SmNgfaboHuuCsXeryu6kr31z/xLQjhUi4mFxdIGCt2SShAG0NQzUCTSmvo3b2XxfwXu9
         rz3YC1HalefVg0PkgIvTSJdwPgJ2lPzbRwvwnWqiytkCSZSRqtEuIwChqAuUB+6L7cBd
         0rHGUaOE4WLlaBw7fooVxR561UNu3JqDjnuML4V7wJLvjwIFoC5nUIcqhB38Dq6mlDly
         8BBk4KvBKK2GN3PBTPVecvmR1l7WV6J26+A2GEHYeOxsu0mCkLLhNnqicAo1baPS74bs
         EWNw==
X-Gm-Message-State: AJcUukd0YsJQ2jT/E9aiUsRBEVsbyaAFFD7xS3EnzlMZDStpts05S1DY
        Dos6ikFn27VBTbheZSGao/Empo9hRgEMKmB1eUk=
X-Google-Smtp-Source: ALg8bN4AJr240Okvh9pFg8QSuW3fNgqKIpk8Pm8sArvLNdvqCRasPIvjyRB0QT1yrGNGafwUjD6j9OFTJGcmDrZxdHg=
X-Received: by 2002:a67:c202:: with SMTP id i2mr1878528vsj.11.1547020325550;
 Tue, 08 Jan 2019 23:52:05 -0800 (PST)
MIME-Version: 1.0
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw> <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1546921020-20436-3-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Jan 2019 08:51:53 +0100
Message-ID: <CAMuHMdW0vBrQm1_moRyTSa+1j5Nob83UNPu3phmrhZNECk7t2w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: spi: Document Renesas R-Car RPC-IF
 controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Tue, Jan 8, 2019 at 5:17 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +----------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,r8a77995-rpc"

Would it make sense to have a family-specific fallback "renesas,rcar-gen3-rpc",
bseides the SoC-specific compatible value?
</masonccyang@mxic.com.tw></masonccyang@mxic.com.tw>

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "regs" and "dirmap"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock

Doesn't the driver have a need to access the RPCD2 clock?
At least on R-Car V3M, it needs to program the Divider Clock Register
(DIVREG).

> +- renesas,rpc-mode: should contain "spi" for rpc spi mode or
> +                                  "hyperflash" for rpc hyperflash mode.

Can't this be derived from the flash subnode?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
