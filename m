Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B27C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA492086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA492086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeLNKkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:40:33 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36412 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLNKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:40:32 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so3089649vsc.3;
        Fri, 14 Dec 2018 02:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oO4YJ2Lj0D6NZLqn4UXXqeED2hjYyadVSzGvtlBbnRQ=;
        b=jBHlsyUgIxtmgxPOL6LHbm+xUIsOXg11Kll/93IEPqxZ2cnmpAxN/pSsdDwpy94XKU
         /3hAO6Hv4WlMGyRh1z+idLRKKMB0GR3+DsfOxGZFEeCrx7MsbqlypNq7Nmiwanpq7Fjs
         cQs3tUKNPQR3eT205Kx+on2+q1ube3YOv/QHVtXN3GUctwPJTlgGrCjIoGRjlaoVV7Hx
         CZI9ubCq+WISJ3i7wXoXiymkO0v3IhVOGresizxeSgT5Q2KZ2UHeMyNHZ5Ctvg/eCrBY
         aQ+617CxRHRIRZ6PdYn8bsiribZ7c8UWt5oNW1/WQKN8CS8u39GKPVcsWtXZImO9XIjH
         1DZQ==
X-Gm-Message-State: AA+aEWanGdKQgeMcuv5RxjAwsjcOge4Oj9txexjPJbE7mo2lrR7mSFz4
        jr8b+Kga93WAY3LpNrwoyl1Ed80eQ5mhCszXl8E=
X-Google-Smtp-Source: AFSGD/VWHVFKb2wMmGMDHMuxqyIcp4XO9NgG7Cf6+G+u6Mk3Anc3o2B7oq71m2A5MgJQltmzYsCcwYpkcstSHzFfyrM=
X-Received: by 2002:a67:3885:: with SMTP id n5mr885049vsi.96.1544784031503;
 Fri, 14 Dec 2018 02:40:31 -0800 (PST)
MIME-Version: 1.0
References: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:40:20 +0100
Message-ID: <CAMuHMdWzXW15qX5AHxbDObp-9EJbLVv0J1myN1g9nPA1fUGFaQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
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

On Thu, Dec 13, 2018 at 9:22 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Similarly to R-Car E3, RZ/G2E doesn't come with automatic
> transmission registers, as such it is not considered compatible
> with the existing fallback bindings.
>
> Add SoC specific binding compatibility to allow for later
> support for automatic transmission.
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
