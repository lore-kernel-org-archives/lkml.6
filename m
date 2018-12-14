Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18DFC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95F92080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95F92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbeLNKVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:21:11 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41979 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbeLNKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:21:10 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so1801148ual.8;
        Fri, 14 Dec 2018 02:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1e6kXam3KptWtzmlio9mMxA4gXF9mTaKfv67aKFEqJo=;
        b=MDCt+VH/FvaGGZoUvJuYC0O6g7csy/heb16CDobqi5B0HnEFo4IW+MljvxaG/hJOQ3
         O/OPAjAfQDjxobS8pz2FTecADDWoa0xbow4Ke3H8FFGLLGJe+f/t//f4wA8EqVz7GGKp
         FmmFPQa76jc8isprZGzkTgemZt6g2db7LFwaSK1GjGj8rBRfDv6xGicDLQ8eSStf0sO2
         PfBP4i/oJZ3QE5/neMLURlwLhI5mdmJyWRd0udY7r0NVxiYlvdPFbEm1Ytt3vbaJQfjp
         DJLKbyRBwPtry0Jf64irXcufSY+05mtUGcTvEjUU+N1kbdU3OVTGEu80oY+3+dIJOa/w
         NhDw==
X-Gm-Message-State: AA+aEWYzWqvcxIDL4SCjPk42+TWLnkgQ2YSBzxhEYYYaNdVOrd2aSgjc
        EQikMFbHIIwMCaqObdNLziFeBvMHLNRuE87gMjA=
X-Google-Smtp-Source: AFSGD/XN0MOYm1ORrKxGQ4LKF8f4WWgRBhg+orQXaOalvMqoTtJXzHbBu7pGmfoRCsyb4SAj56RP73Ucj8rddj0KgrI=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1052396ual.20.1544782869454;
 Fri, 14 Dec 2018 02:21:09 -0800 (PST)
MIME-Version: 1.0
References: <1544732491-6821-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732491-6821-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:20:57 +0100
Message-ID: <CAMuHMdUXVL01HC+PYCQc+Gkr6XVFCTV1=gf4apyjnpzTiPFCoQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: dmaengine: usb-dmac: Add binding for r8a774c0
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
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

On Thu, Dec 13, 2018 at 9:21 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This patch adds bindings for the r8a774c0 (RZ/G2E).
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
