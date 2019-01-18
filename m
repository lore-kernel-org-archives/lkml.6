Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4EBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124AA20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfARIEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:04:02 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33313 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfARIEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:04:02 -0500
Received: by mail-vk1-f194.google.com with SMTP id d201so2896419vka.0;
        Fri, 18 Jan 2019 00:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccUkt6LqB58uFT+Lx+JRMzBjE5OeTm+9Ao7mTHrVgFk=;
        b=c6aaHbtkKrzDppComCQCChyNVOYM6fZAVtJOPwY+b2GUaay6cG1WELSVuuIuLaDQS1
         RR5IijFMk9DoaU6rRbaMEY2xFtL9A0NxLW9u8+9GX5xowbokyiJ0/BoQkmuAN3F1BYX2
         rYQq2jcs77qdpQ3bZ8HBy3pW+7ulbxs28aZpjr1iXXEqnmYDAl/90+Lomq6UGLodXqob
         N3Ljo2l9z2KUAbNIEl9muun361EbEgF43jtmPwvKhrSu0ZovH6NaQ8pNq4cPbiPIWjPM
         pNy+smz2gcPU8Q0L3Gq5flubSQOcuMhptfb9K4Qto6eJGKDnbE2mzj39/0v5UNJE2vbg
         9cWg==
X-Gm-Message-State: AJcUukfx6SmRuN0L6iRXAiFPwN/Aa8C5ZTFjOf67B4yV79VLHfP9NhIM
        cDKKP+uol8KHXO5yorDfG7ySramRLudQs+VSFHM=
X-Google-Smtp-Source: ALg8bN6wpmm4GpWH0VByLffjMnnQ4bEQnolNyKS2frBicfnKBqD4XD93hMrq9HIKxZiW0iNA140j3pGF9ICH2cY/lQc=
X-Received: by 2002:a1f:a414:: with SMTP id n20mr6991022vke.83.1547798640676;
 Fri, 18 Jan 2019 00:04:00 -0800 (PST)
MIME-Version: 1.0
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw> <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 18 Jan 2019 09:03:49 +0100
Message-ID: <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
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

On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,37 @@
> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> +----------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be

    compatible: should be an SoC-specific compatible value, followed by
    "renesas,rcar-gen3-rpc" as a fallback.

    Examples of the latter are:
      - "renesas,r8a7795-rpc" (R-Car H3).

This makes it future-proof, in case the RPC on a specific SoC version needs
to be handled specially. We already know that is the case for R-Car V3M.

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain three register areas:
> +       first for the base address of rpc-if registers,
> +       second for the direct mapping read mode and
> +       third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clock-names: should contain "rpc"
> +- clocks: should contain 1 entries for the module's clock
> +
> +Example:
> +
> +       rpc: rpc@ee200000 {
> +               compatible = "renesas,rcar-gen3-rpc";

compatible = "renesas,r8a7795-rpc," renesas,rcar-gen3-rpc";

> +               reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,
> +                     <0 0xee208000 0 0x100>;
> +               reg-names = "regs", "dirmap", "<wbuf>;
> +               clocks = <&cpg CPG_MOD 917>;
> +               power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +               resets = <&cpg 917>;
> +               clock-names = "rpc";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               flash@0 {
> +                       compatible = "jedec,spi-nor";
> +                       reg = <0>;
> +                       spi-max-frequency = <40000000>;
> +                       spi-tx-bus-width = <1>;
> +                       spi-rx-bus-width = <1>;
> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
