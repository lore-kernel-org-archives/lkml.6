Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB74C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7DD2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7DD2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJHO6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:58:06 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39539 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:58:06 -0400
Received: by mail-vk1-f193.google.com with SMTP id x140-v6so4343102vkd.6;
        Mon, 08 Oct 2018 00:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIElAWjEC4+qiV3Uf4xf+PuGd22N3jcTDz6lLt7BuWM=;
        b=r9msCXA0PS/QHUyfyq0PXohyulRW4GtFwqdjh8MW9seRKzmwvaJpL2USatO/0y8Ocf
         yDfiC5oBPgihbR0S/mNQEZWlFrVoIE5veddImDhwU9pCK59pVFnJZQRcc6twcQq+k3PU
         8A7cTRJLbQgm0baPFpLOu9P/nWklTOmstOLqiwwZkTjkwE3cLiR8qXsqcO7pL2O9bAba
         xAKGZygajC5w0yFgWy2XEyOqdSMFSeOk4OqHA2XHcvaHidol7vKLmGKJZQOcXPgXnc/c
         ctsk2UIksjyrYxxuh0jSO496YkifxklExqOXyzQtvZQRYJwq1YpwDFZD1Sn6bEIbJlyN
         LvxQ==
X-Gm-Message-State: ABuFfoiI7H7GOx50+O8Ai8FXM8UC8QVKOjnB+mZnBUE18FFXGWMvt7uG
        +wm2QxgVPihY6VFnqkYlLnlTFYYBS3HvZE1kBkw=
X-Google-Smtp-Source: ACcGV61roA6wLlkVv7sk2NfIm6I4d3sLLnkmtKvKU8cMqiPVN27rjs7bnm1Jeo2z1DhH+O5Fbv/H492gE7znuBqzBIk=
X-Received: by 2002:a1f:d507:: with SMTP id m7-v6mr8394416vkg.40.1538984861844;
 Mon, 08 Oct 2018 00:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-30-robh@kernel.org>
In-Reply-To: <20181005165848.3474-30-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 09:47:29 +0200
Message-ID: <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> Convert Renesas SoC bindings to DT schema format using json-schema.
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

Note that this will need a rebase, as more SoCs/boards have been added
in -next.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> @@ -0,0 +1,205 @@
> +# SPDX-License-Identifier: None

The old file didn't have an SPDX header, so it was GPL-2.0, implicitly?

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/shmobile.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH-Mobile, R-Mobile, and R-Car Platform Device Tree Bindings
> +
> +maintainers:
> +  - Geert Uytterhoeven <geert+renesas@glider.be>

Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)
Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM ARCHITECTURE)

You had it right in the CC list, though...

> +      - description: RZ/G1M (R8A77430)
> +        items:
> +          - enum:
> +              # iWave Systems RZ/G1M Qseven Development Platform (iW-RainboW-G20D-Qseven)
> +              - iwave,g20d
> +          - const: iwave,g20m
> +          - const: renesas,r8a7743
> +
> +      - items:
> +          - enum:
> +              # iWave Systems RZ/G1M Qseven System On Module (iW-RainboW-G20M-Qseven)
> +              - iwave,g20m
> +          - const: renesas,r8a7743
> +
> +      - description: RZ/G1N (R8A77440)
> +        items:
> +          - enum:
> +              - renesas,sk-rzg1m # SK-RZG1M (YR8A77430S000BE)

This board belongs under the RZ/G1M section above
(see also the 7743 in the part number).

> +          - const: renesas,r8a7744

> +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> +        items:
> +          - const: shimafuji,kingfisher
> +          - enum:
> +              - renesas,h3ulcb
> +              - renesas,m3ulcb
> +          - enum:
> +              - renesas,r8a7795
> +              - renesas,r8a7796

This looks a bit funny: all other entries have the "const" last, and
use it for the
SoC number. May be correct, though.
To clarify, this is an extension board that can fit both the [HM]3ULCB
boards (actually also the new M3NULCB, I think).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
