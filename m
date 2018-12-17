Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08488C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB064206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeLQQF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:05:59 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34934 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbeLQQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:05:58 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so8026442vsc.2;
        Mon, 17 Dec 2018 08:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLk+ODEh+YX19xbTxwTZeBqbrmECH0wG3ea+UOaK1pQ=;
        b=pdTjT77T8bRlxN8SQhiZXmGteY/EIX53NoDB0oZmniNsDwOMju3UiK08JbUck1EY5m
         68Rws6WCOvF1OL/ADE8RcCu08S5pY3vd7WvtOizG/GV8ZqdaFCEizneAVnSeQejM+Z6f
         Z5KzQcz8gn9/xrYNetwsrSamasFx+EXxEVKHeCk9Wz2tE46zbSutJ0F+b+E1At2FfSLP
         dH222cY/lkSjxQWZ8xLeCnq+MOoHppA6fq5YoYb6HGwKOHcb2CDI75xSFACrEOQgXEw5
         pmlTbmKJ7JxkglbNlqgSq7cc86LUaWN2dUeqxIRp3qpvUW25XW7KpJ9aTM9BcTGZt95F
         iPzw==
X-Gm-Message-State: AA+aEWa75DR1JHVoIcqQ8Q66uiRYpUepZh/Ud07MEkbRe8Ua1FiFN1EU
        EsWMGc1hNbEmFYRQxebslu+vdRoTyCmxj1W47j4=
X-Google-Smtp-Source: AFSGD/VIGIQj1947yxRhEiwhh8LN5jUMNQ3qaxsxovc6VXsWCi57T0OE1PtENIt+QDTwq1suCE+7a0l8hKc914UgBSg=
X-Received: by 2002:a67:3885:: with SMTP id n5mr5776992vsi.96.1545062757371;
 Mon, 17 Dec 2018 08:05:57 -0800 (PST)
MIME-Version: 1.0
References: <1544778613-24279-1-git-send-email-fabrizio.castro@bp.renesas.com> <1544778613-24279-4-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544778613-24279-4-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Dec 2018 17:05:45 +0100
Message-ID: <CAMuHMdXp3AD+t3yuF4RXKN2dX7wHc7de-B=k4T8KAmDdng1ZCQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: renesas: r8a774c0: Add SCIF and HSCIF nodes
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Fri, Dec 14, 2018 at 10:10 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Add the device nodes for all RZ/G2E SCIF and HSCIF serial ports,
> including clocks, power domains and DMAs.
> According to the HW user manual, SCIF[015] and HSCIF[012] are
> connected to both SYS-DMAC1 and SYS-DMAC2, while SCIF[34] and
> HSCIF[34] are connected to SYS-DMAC0.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Let's hope SCIF2 DMA will be documented soon, too ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
