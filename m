Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B357DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7286A256AF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7286A256AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754904AbeFYJZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:25:02 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:38573 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754576AbeFYJZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:25:00 -0400
Received: by mail-ua0-f195.google.com with SMTP id 59-v6so8157471uas.5;
        Mon, 25 Jun 2018 02:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPgYy9oa7ysThMpJJ+VCjMSuiQRgLr69yd/9qFCW9IM=;
        b=MI/UKtOfNzUk6nM7wYBScVdpb2u0x9QeB9zH/O/1Z0hGomCAuQxDZLZhHL03YdUXG4
         186kfTf+2cywnzQhaHQd2xJ/qJCueDQz9Oo2o/u26Ir3bJNTCmEWT0BCLXc9Gm2i5kkp
         HEXqZZ389XIOX5Q/5v/D5Ej0ANAP7ociFGSrjm1owqv5DB6TDkqJljB7w6SGT751hc/B
         oQHS7/PdLmz6TCf93DsUsZ758s+9pe45pH/QSJZMNUUWrNIaFC8PvcnMQGdr9To3U2dM
         vXMAyPyWaFyA41HrnsL2iFe2sWlwPKGvtNWrZi5WmrfMsAuLuXiOytZtXdDM9JLje1TA
         Q6/Q==
X-Gm-Message-State: APt69E0ZjP8IS0Ara+qYnrlGm4O/TFmzWJkbvNLjbYSwWk3X4XB/YCeM
        9cwREv1dhWKTo9XswXijA20zVYwY/2lH4WLAUPs=
X-Google-Smtp-Source: AAOMgpe1lxUSgBEOHHfAao5NZBWzkq55um0YLoJGmz6umuN5egQ8eve7OijjQo5n7ZE8FZ00uN7VEmjv4kGKo2tAR1M=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr7451453uae.12.1529918699404;
 Mon, 25 Jun 2018 02:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com> <1529915110-5867-3-git-send-email-michel.pollet@bp.renesas.com>
In-Reply-To: <1529915110-5867-3-git-send-email-michel.pollet@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Jun 2018 11:24:48 +0200
Message-ID: <CAMuHMdVarwq26Jr=YN+zBDrHjQf-Q+u3L6oRNiSKh-hxuwOsrA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Carlo Caione <carlo@endlessm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Mon, Jun 25, 2018 at 10:31 AM Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
> requires a special enable method to get it started.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-shmobile/Makefile        |  1 +
>  arch/arm/mach-shmobile/smp-r9a06g032.c | 96 ++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

Given this doesn't depend on anything under arch/arm/mach-shmobile/,
perhaps this should be moved to drivers/soc/renesas/ (and renamed to
r9a06g032-smp.c for consistency) instead?

Simon: what do you think?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
