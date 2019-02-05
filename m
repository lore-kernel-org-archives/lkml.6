Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD9CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169F72175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfBENoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:44:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40549 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:44:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so2864641edr.7;
        Tue, 05 Feb 2019 05:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzQZRFs25qWZAsAYEW0SYoGEoO/nV18H65SPSBaC+Lg=;
        b=q2cUU42wTjBBeS52mlIKNdJR3Mm2RGo82LtvqgV14Ne2YeocLbnA6zDuxs1efqTN5u
         XorcPodWmWETLqqZmBlnBsKLMag39BHJIznSKfQXFDYTirX//P/Olq3RY5d1G3Gw+5HK
         onZjScV78O75fNZyHUTEUj/ibo60YuMSkHcMLo1hen+t5i9m/8cgczjHACiI20nnGAAf
         zR+Dx0WtQZRr1K0qU+jeOaINiL67hNZg5M9DZLIGz3bwDD+9J+mPd2PN8NpGR96HOxAM
         c/O4eNdrSNX2DKdJXqHD3rNadVN3gy91Ng3HPJKHrqNE7ZluupgDXztHvKTesUnijMHC
         BKDg==
X-Gm-Message-State: AHQUAuaqOqi0kjL9LKEDDs7e3h+R6dNsxvoICVBslgfy01Zz7PgE8p3L
        m+dbQQATc5jKCTfu7nPaKwSAjiattWA=
X-Google-Smtp-Source: AHgI3IbwDZ3aKY2morlIV/L1jPIeigRod/kM4BpuT69HQ76KJ1BcfiW9wCuz2ryTEKjDLMXkybS5sg==
X-Received: by 2002:a50:9665:: with SMTP id y92mr3918195eda.282.1549374257270;
        Tue, 05 Feb 2019 05:44:17 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id x47sm5195179eda.91.2019.02.05.05.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 05:44:16 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id p4so3657838wrt.7;
        Tue, 05 Feb 2019 05:44:16 -0800 (PST)
X-Received: by 2002:adf:891a:: with SMTP id s26mr3732163wrs.44.1549374256271;
 Tue, 05 Feb 2019 05:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20190202155209.31617-1-plaes@plaes.org> <20190205094529.t7je4ozzu2b4ornc@flea>
In-Reply-To: <20190205094529.t7je4ozzu2b4ornc@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 5 Feb 2019 21:44:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
Message-ID: <CAGb2v673ntXn7MTRhU1uecO9q8_i79e+Ovio=tucd6qFf5L84Q@mail.gmail.com>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Priit Laes <plaes@plaes.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 5:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Feb 02, 2019 at 05:52:09PM +0200, Priit Laes wrote:
> > Recent patch of improving MP clock rate calculations by taking
> > into account whether adjusting parent rate is allowed, have
> > unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
> > boards which fail with following error:
> >
> > [snip]
> > EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> > EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> > sunxi-mmc 1c11000.mmc: data error, sending stop command
> > sunxi-mmc 1c11000.mmc: send stop command failed
> > [/snip]
> >
> > Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
> > clock rate with following parents:

You mean 52 and 51.2 MHz.

> > [snip]
> > pll-ddr-base        2  2        0   768000000 0     0  50000
> >    pll-ddr-other    1  1        0   768000000 0     0  50000
> >       mmc2          0  0        0    51200000 0     0  50000
> > [/snip]
> >
> > Now, after the improvements, requested and settled rate are both
> > 520MHz, but as mmc2 clock cannot adjust parent rate, the situation
> > ends up like this:
> > [snip]
> > pll-periph-base     3  3        0  1200000000 0     0  50000
> >    pll-periph       6  6        0   600000000 0     0  50000
> >       mmc2          3  3        0    50000000 0     0  50000
> > [/snip]
> >
> > With this patch (allowing mmc2 to set parent rate), we end up with
> > working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
> > [snip]
> > pll-periph-base     3  3        0   312000000 0     0  50000
> >    mbus             1  1        0    78000000 0     0  50000
> >    pll-periph-sata  1  1        0    26000000 0     0  50000
> >       sata          1  1        0    26000000 0     0  50000
> >    pll-periph       5  5        0   156000000 0     0  50000
> >       mmc2          0  0        0    52000000 0     0  50000
> >       mmc0          0  0        0    39000000 0     0  50000
> > [/snip]
> >
> > Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when allowed")
> > Signed-off-by: Priit Laes <plaes@plaes.org>
>
> Applied, thanks!
> Maxime

I'm concerned for other users of the PLL-PERIPH clock. AFAIK
all of them, except the HRTIMER, expect the clock rate to stay
the same and not change underneath them. And SATA expects it to
be at 600 MHz, as the datasheet says. And while it may not directly
apply to the LIME2, eMMC on newer SoCs / boards run at the slightly
reduced rate of 50 MHz just fine.

In the commit in question, clocks without CLK_SET_RATE_PARENT
should be using the old code (now in the if conditional block),
i.e. the behavior should not have changed.

I don't think this actually "fixes" whatever bug was introduced,
but only papers over the issue, and possible introduces further
issues for other users.

Regards
ChenYu
