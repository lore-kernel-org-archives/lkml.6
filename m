Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35357C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E1F20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E1F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbeKFCkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:40:16 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40090 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387458AbeKFCkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:40:15 -0500
Received: by mail-vs1-f67.google.com with SMTP id s9so5563152vsk.7;
        Mon, 05 Nov 2018 09:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeqCh/RL/DBT9DzwrUpxA2QCznWJ3GvMbgliS2owqF0=;
        b=PRvK0lsKEiGYbNKCxvYnuyvd4kC4q2nzMN4pGxmQiW6YJVIcHkgigR5n68BJVqcJwg
         3KlDWpwEYHnP6mbELn4wnF3CCA/GPqnWmOPHFm9cGH5vhOo/fb9Nz+ng0WpP9gCmj5Tt
         yvGABwS9orTS7O+hvg2OYvB2VUYh2yzI5vQs91zKsDZcHLG6fQF8ZK8/DbRUjKo9cU+i
         rL4ITYw27tzAzC73WTss/T7KXi6lJ+DpJOF5u6AJ5k68NIGQX/JJpN823+IxhpfBOUp0
         hpEAG4xnu8hxhrOdoIm6qaDLDN/RXMxydw+2t7o5Kp+G1q8+svrt8vtYHBQmlLrt0ut6
         +eLA==
X-Gm-Message-State: AGRZ1gIamGs2/Xt0pc1G1Xlod+rsh04pawDDs4lM8rZaT+mYLltISsa/
        bbuWVJllQ8FEyUTTtYZfH7CIamT6xjnYQG1b+cHLmWsZ
X-Google-Smtp-Source: AJdET5cfNTxubsDU8szvQ6PiZtMQiz4bxfXzAKYiDCCG6LW7J1Du6RhYLV9YZHEBkNlevz7b+1mSu4D8Oa+ps9HyITA=
X-Received: by 2002:a67:3885:: with SMTP id n5mr6499579vsi.96.1541438374474;
 Mon, 05 Nov 2018 09:19:34 -0800 (PST)
MIME-Version: 1.0
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Nov 2018 18:19:22 +0100
Message-ID: <CAMuHMdUWP=zBfn8ff1PZ-f7WegQiYU7omGkAM-Fh1uNUxF2XNQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: r8a77965: Add VIN4 and VIN5
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Mon, Oct 29, 2018 at 7:14 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>    this two patches add supports for VIN4 and VIN5 interfaces to R-Car M3-N.
>
> On this SoC (and in the forthcoming support for E3 R8A77990) the VIN groups
> could appear on different sets of pins, usually the 'a' and 'b' one.
>
> With the existing VIN_DATA_PIN_GROUP macro we have to specify group names as:
>
> VIN_DATA_PIN_GROUP(vin4_data_a, 8)
>
> which results in the group being named as "vin4_data_a_8" which is
> un-consistent with the canonical group names (eg. "vin4_data8_a").
>
> This series adds a macro that allows to specify the group 'version' along with
> the pin and mux numbers in patch [1/1]. I haven't been able to find a better
> term than 'version' as 'group' was already taken. Suggestions welcome.

Yeah, the datasheet also calls these groups :-(
A possible alternative is to use "variant"?

Or, what about avoiding the name issue by making the VIN_DATA_PIN_GROUP()
macro varargs, and passing the "variant" as the (optional) third parameter?
That way existing users work as a before, while you can also write e.g.

    VIN_DATA_PIN_GROUP_VER(vin4_data, 8, _a),

> As I cannot test VIN4 nor VIN5 on Salvator-XS as the parallel pins are not
> wired, I made sure the macro creates correct names and fields not only by
> compile testing it, but with a small C program [1] that replicates the VIN data
> layout defined in the PFC module and access fields (and has helped me testing
> more easily the preprocessor stringification/concatenation process).
>
> Final note: Simon, you took the E3 patches in your tree, and I expect them to
> land on v4.20-rc1. They use the old macros, are follow up patches ok?)

Which patches are using these macro names, and are in v4.20-rc1?

BTW, "grep vin._data_[a-z][0-9] drivers/pinctrl/sh-pfc/*o" tells me we already
have broken groups names on r8a7792, r8a7795, and r8a7796.
Fortunately we have no known users of them, so they can be fixed.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
