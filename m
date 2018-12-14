Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C5BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167822080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167822080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeLNKOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:14:45 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34990 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeLNKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:14:44 -0500
Received: by mail-vs1-f67.google.com with SMTP id e7so3054954vsc.2;
        Fri, 14 Dec 2018 02:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Kxxzl240bHwfHlkHEvEpqlLBZyTLpnPYvupEh+6LRw=;
        b=sDoxBEtST4XgDZ7TFC9DxKvCOW6NonsKnLpeJMKfP3IbkdCeWrksV4nEMPUajFUQnT
         VfBJuc5cey+zeSaGlWdkamR/ao8GCswq5REBOwftP7dapW4fhyevIrU4GhrGN5wCruzt
         LaRMt0KMq8a4Xx3dsn02FT7qhUifE/htts/10sTOqrqM0/C1o3eOyBU/0H3PGH6HIrIN
         nTKgTzefqOT+QJm/oh7+vgsiPz5hJ49xCD5zQSSm1Sf9uI1MRRtLE0Ora9arIfo3EFrD
         /zex6FujHLUxpu4yDYrMQcgKcyqWlmoa+pxcH1bHBnGnAjXqqZuQs6EEl8iME03+Chi7
         wWhQ==
X-Gm-Message-State: AA+aEWYDLnJjVgohQeSNdTN3+dWl12EgNzbkZqc4eOwjB/4mB4MT2zoC
        jJRQi1hzknT3GNs1hkQX570Z1MK6MJYczUdcE5o=
X-Google-Smtp-Source: AFSGD/VRQZmHmLPgA/CMW9YPI1p28fphnHHWe4f1N1RRGCwgyaP2hknRFOT1XA/dPKZnefMbuX65cSd4r4BTxSBBQZo=
X-Received: by 2002:a67:f43:: with SMTP id 64mr1013565vsp.166.1544782483370;
 Fri, 14 Dec 2018 02:14:43 -0800 (PST)
MIME-Version: 1.0
References: <1544732397-6361-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732397-6361-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:14:31 +0100
Message-ID: <CAMuHMdVxQmwptcM_xKAJ0mPQ+yKSOO2Vf3i2YrYzvSDwA5Ko6g@mail.gmail.com>
Subject: Re: [PATCH] spi: sh-msiof: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
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

On Thu, Dec 13, 2018 at 9:20 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
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
