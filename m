Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2803C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A0E26FD6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrqcP7aR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A0E26FD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbeF1GyP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:54:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54279 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeF1GyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:54:14 -0400
Received: by mail-it0-f65.google.com with SMTP id 76-v6so11126809itx.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDlYdBIsuBIr4wjM0p3rvetmOP4Tg5xtX478Tipws+Q=;
        b=KrqcP7aReYMSnSEOjcbnPztJmlGiMBllmLIIk+uWnV0QaQ9kxpmFRtkr/Fp8q/5xJd
         FiqtjmwIXCZLmxcvNYLSnsQ+9SlDH40O3Wscap/t+1cDv7RRGwNnRZwiMKewCcgWqZeH
         RsBqTbDoGK2wwvbLKIStExi6qaFh7syEiMgRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDlYdBIsuBIr4wjM0p3rvetmOP4Tg5xtX478Tipws+Q=;
        b=JW5Kyqi5Evd2bTqJxz2pa2wmSZNd4tDT+lspzdQ8iuMm0S4kfJuYv6e6W3CNlnzpzp
         e6KdHwTZP5MbB+85gERHoyq8vIPtO/VWZ8ZTAcYZQbRXLtMlPvVW8cMsFQbeW2K4Y4F6
         +ELE20/nr3etYXF5lgjk2+Nw+p0n02OTO++4aUHOc3C+/528pbr/4rizhtb6zo1Dczcr
         UkQRNVMByYHkEH3y+b0YYogMmX1XzLvENbnftXmZU3tZ4YKKk35scJmwAiAmA79J7zYe
         /vK4dRdLLxnprjmhmERmm82bgzmOBr+FHKNerDpOztgHb+Pqq207svSVYqOBRenikYPB
         o5jg==
X-Gm-Message-State: APt69E3dUjZx7yJCP9+JWpTpuJ2PiTKbN6DcDuCZvH0ztgvbzMT6LoG5
        Fw/SciEdJG9Xzvta3p4zy//Ny9WdhfPlLULs+gQD2A==
X-Google-Smtp-Source: AAOMgpfWfFQDDWocUjzS/FKn0cbN5f8TMNjJLym/g6etUQFsHPR+IwXhbbmai++5bcnpaYYqSFoHsDSaEkl/tuBmbsU=
X-Received: by 2002:a02:c006:: with SMTP id y6-v6mr7738041jai.87.1530168854118;
 Wed, 27 Jun 2018 23:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1529563351-2241-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 08:54:02 +0200
Message-ID: <CACRpkdaX8KrZ=3GwFUje05kYV61bRfTSJQ9fCQwVk5ot3cxvpQ@mail.gmail.com>
Subject: Re: [[LINUX PATCH v10] 1/4] Devicetree: Add pl353 smc controller
 devicetree binding information
To:     naga.sureshkumar.relli@xilinx.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>, ada@thorsis.com,
        honghui.zhang@mediatek.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 8:43 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

Thanks for your patch!

> Add pl353 static memory controller devicetree binding information.
>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> +Device tree bindings for ARM PL353 static memory controller
> +
> +PL353 static memory controller supports two kinds of memory
> +interfaces.i.e NAND and SRAM/NOR interfaces.
> +The actual devices are instantiated from the child nodes of pl353 smc node.

See and reference the special PrimeCell DT bindings:
Documentation/devicetree/bindings/arm/primecell.txt

> +Required properties:
> +- compatible           : Must be "arm,pl353-smc-r2p1"

Should be:

"arm,pl353-smc-r2p1", "arm,primecell";

It will be possible for the Linux AMBA core to probe the device
from just reading out the primecell ID registers, so the first
compatible string will not even be used by many OS:es.

> +- reg                  : Controller registers map and length.
> +- clock-names          : List of input clock names - "ref_clk", "aper_clk"
> +                         (See clock bindings for details).

The AMBA primecell peripheral clock (clocking the silicon)
must be named "apb_pclk".

> +- clocks               : Clock phandles (see clock bindings for details).
> +- address-cells                : Must be 1.
> +- size-cells           : Must be 1.
> +
> +Child nodes:
> + For NAND the "arm,pl353-nand-r2p1" and for NOR the "cfi-flash" drivers are
> +supported as child nodes.
> +
> +for NAND partition information please refer the below file
> +Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example:
> +       smcc: memory-controller@e000e000
> +                       compatible = "arm,pl353-smc-r2p1"

Add , "arm,primecell";

> +                       clock-names = "memclk", "aclk";

This doesn't even have the same name as in the bindings
above, I think the latter should be named "apb_pclk".

Otherwise it looks good!

Yours,
Linus Walleij
