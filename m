Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982AEC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4AA2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4AA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbeLNKIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:08:16 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41634 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:08:16 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so3017896vsc.8;
        Fri, 14 Dec 2018 02:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zErPQXLOrnGpuIgc9UhSUCQT+CttusR6/OmltVr9z7g=;
        b=l+LUJxjTJcH4CX16JJ6BkcUPPmRfAiqBSAQCzbTlpTIZW0E+WilghRt5WXEOP4D9TO
         SNzQ2r1Erze5h3+A+6f1+VnyTUs1Fc3Phl9zM+2LL9/oBsqN4pgRH4Ah6sKjllX6/bbX
         PA8WwtN7XkW2HwGdI56rk1qOBbR3nCUAlwDCvf++PRBmnOobRl2wlZeAKZqPVXaz7jtP
         7XUg/vFY2qvXTMUnu3bvoMhaB6mPFLrwYDP3ISih4xt4IFKy3gmpL6pxsEkHBFsy/xAO
         jh4KUFn8LQ9DAGIn/rAwXd0XjHrFfZwY6885U21G+hUcjIpWOoKGmyP1YVi6QBQZexRq
         PBAQ==
X-Gm-Message-State: AA+aEWZjP9YsC39I1T/gO9IndTNYc5vrlgmzKoP/OTbArOcc18fFCg7B
        GcUtlukDvfV6Pgrhw2dB6Hnw3JugbzYOFls7DcU=
X-Google-Smtp-Source: AFSGD/Uo6XIvpukkSDVKREoGCxhdSxZk6YsRg+oqZ7AlJ9WxJlhpBQZ3fzl/alOVxx4k5ajmlBZ1NieEUCnJYvqQRjI=
X-Received: by 2002:a67:d119:: with SMTP id u25mr914548vsi.63.1544782095187;
 Fri, 14 Dec 2018 02:08:15 -0800 (PST)
MIME-Version: 1.0
References: <1544732368-6223-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732368-6223-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:08:03 +0100
Message-ID: <CAMuHMdVwM4wd7JUmx=3XoYxvRkfB=ApPXewQL8ae3w9A=PV8vA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iommu: ipmmu-vmsa: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
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

On Thu, Dec 13, 2018 at 9:19 PM Fabrizio Castro
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
