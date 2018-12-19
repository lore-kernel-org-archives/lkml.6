Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9170C218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeLSKUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:20:12 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33086 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeLSKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:20:12 -0500
Received: by mail-ua1-f68.google.com with SMTP id t8so6802839uap.0;
        Wed, 19 Dec 2018 02:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzEhDolVp9iHhQoOAdKIoYEOAkSfn+ymluHFXe0syLs=;
        b=ru0XbuuaIIAKNR+TorOfiqDNu8j7O03mJzKClw7X0AXWOpaJG80Sme8FwITVCwXFic
         hgChBCL7VhE2UbqtxVv/Bh2JuuP7QTcrnePjHOTS4Mcb8AHJ5AfbAFzNg2Fi74y56DdP
         uAHPr9o+/SuXgkL3hSRFyXB4nABoNkp/9L9C05DTwTsk8LQsPlYEZ0TCtBqRQduWf43v
         e7Az5q+wiNiFVORy5BrJ3aODn1jX2P8zH4994b5TQoR0wXnGeff/uj+fFpTrVFi1P2SG
         cXg4UHiEVRH1vV4KPOaG+2oTrRnJH7qRqGZA7R04VimHLsICbZ/To90K74hD2P9w5f+W
         K1tg==
X-Gm-Message-State: AA+aEWaymfY9Jbh4HClJWpqkyThPXeJCC5mwYLNfY8LDCZmTBxd/xvLc
        Z45gR32eTL7ZjtnS6JAozH7/MPJq1QeuGFnobyg=
X-Google-Smtp-Source: AFSGD/Wy+7KBP3epsIbVQb3Km5p4vqvsZ2nLZqtYYBQF/oQdGgpbo05rPRqz18gM/Se60VcTbRaBY5C8PdpFx3XBll4=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr9863089ual.20.1545214811236;
 Wed, 19 Dec 2018 02:20:11 -0800 (PST)
MIME-Version: 1.0
References: <1545213985-30341-1-git-send-email-fabrizio.castro@bp.renesas.com> <1545213985-30341-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1545213985-30341-2-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Dec 2018 11:19:58 +0100
Message-ID: <CAMuHMdUmjR7qVmsHtE5OfRer_RNOpoCt6G90UQxAXdTFEUhqbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: sh-sci: Document r8a774a1 bindings
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:06 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings. While at it,
> update the RZ/G1 and RZ/G2 family specific strings description as
> outdated.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
