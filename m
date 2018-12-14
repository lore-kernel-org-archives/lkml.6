Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0309C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E32B21104
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E32B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbeLNKj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:39:59 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36387 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:39:59 -0500
Received: by mail-vs1-f67.google.com with SMTP id v205so3088867vsc.3;
        Fri, 14 Dec 2018 02:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kpU0gVyGtk5/K+vbVE8yJLvmw3b1y46qun8kSXBVyk=;
        b=ZNJqAeDVNB7x8HgUzKppO6raTbjA+dWTe0u7FUHTQ7DyX+TwpRNZzkx2JF3u+7DK8d
         k7KP/lwzOEJGQoigcZK7lGTg5f8CGkS9+Xrm3jlBtg88NuiO9mIlu17KqdfzlieJ+pqE
         rOEuzZw07GK3U5syUF00/ZsTD35fyM94Nt55V9Ay7Mh2tVbHABO4yTbDz2ttJEGwwY33
         3WEqS7kpC8QeFUGkptveB+WTQ5hvn/r302yDreaSZedCIgQ3CwR1Ar889ZxW40tUtG5C
         4FeARu2y/1gjSkqQBk4QgMDPV8Qd3sJD++Lste/jQ6bKTiQXSl7CPpaE0KrJ+DYxOFBk
         i+ow==
X-Gm-Message-State: AA+aEWZdTp8INq7JfsvPscQCOQiSaFGamKa5AjL+49B9+zEUqeK2IV3W
        7bpKisSJei81P3JLofamHYZjFLy5ytEPhDVP/Vj8VscS
X-Google-Smtp-Source: AFSGD/Uu+ZLozFkDXMaWjZFJ+QWiFVvKd1VvAlPb0DbgpCDwIEUHTjfh9bgnHyPLKsEPROoLxZ/6nwQxBUId8r5eKQ8=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr1066820vsm.152.1544783997910;
 Fri, 14 Dec 2018 02:39:57 -0800 (PST)
MIME-Version: 1.0
References: <1544776907-17845-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544776907-17845-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:39:46 +0100
Message-ID: <CAMuHMdVjccV=xpJ4f25YerR2Y8CxsKfn6CD7Es3P+x3yzGLuYg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: i2c: sh_mobile: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 9:41 AM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>
> ---
> v1->v2:
> * Improved the style according to Peter's comment

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
