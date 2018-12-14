Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C7FC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78E42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78E42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeLNKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:06:35 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46254 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:06:34 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so3009645vso.13;
        Fri, 14 Dec 2018 02:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0sD6C/f5j60o6YVaQU7FwP7ODkT/Pxt45sE4f3QoNLE=;
        b=nj5eKFWsozCdOWVTQhQpI7XLSxZP7Q/PUTYGKj9LZsMXkRMtB412kPtw+G+tJvTP2C
         YVFKs+29tPbUhQW26RRArOfVgXKC4QagXDZ0dzg4U0VVBEdEoE71Oi+82i17FDs7GvqL
         EDm7Vng4DutgSpAaX0Hnd3jNMRwE/MjuvmpI7OxKCDwDvZcwKRe4AbA4SUV8OeYkaFK4
         apU4ABMx3F3gzv9U1+6kdjJPQV9T2QWYU2liJqLa7lWwidBh9wtFad5HBiQfkMd8AGhb
         ZrtU4atVe1hT3oFkRvo2qa/iGOdiLxe7StRDMfolz/naWdqwrQSVK+HnZQ0JdASzuyus
         +V4g==
X-Gm-Message-State: AA+aEWaR/O03SWVJLDmRr+vh+EoV8JO3vqcsfP3wKt7xDAcWZM9U3qZt
        aSbz+Wnthq30X6yPPh/kr+eigubala+0Vt+jUyc=
X-Google-Smtp-Source: AFSGD/Uc4OGan38/GHcDrAfqa2OdBltw6rRuoLb9+dE59xaubsYBF/ZWag9ZluqcJ98ouAdhADlRyqpJfshR+QdaPnQ=
X-Received: by 2002:a67:f43:: with SMTP id 64mr1003454vsp.166.1544781993620;
 Fri, 14 Dec 2018 02:06:33 -0800 (PST)
MIME-Version: 1.0
References: <1544732294-5996-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732294-5996-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:06:21 +0100
Message-ID: <CAMuHMdUiSXfkHOzNzNCZdaOg4O4FYs6JZT-EH_ZuwbAfr6P_xA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: rcar: Add r8a774c0 (RZ/G2E) support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:18 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document Renesas' RZ/G2E (R8A774C0) GPIO blocks compatibility within the
> relevant dt-bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
