Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F32CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4D020671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4D020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeJWTze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:55:34 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42807 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeJWTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:55:34 -0400
Received: by mail-vs1-f68.google.com with SMTP id e126so594131vsc.9;
        Tue, 23 Oct 2018 04:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXVhf0lG9o3NhHPLIKa4H6OPjQeJZ0Fcb6lOBwVfBWA=;
        b=nAInbpRCBsnzebd3vlTYCnayHADQyzRLp0G8gluAeEFZ2XiJXJdKmJqJ0NX9Sayyvu
         ChnsqKolO9WKzsUlTy0NZmxjsK2a3rCPqC3vRiPjMXXKIG1FIZMN1hlQ5dBQIQEgzaYZ
         fmrEQkXnY0+xQnRIsPewxNvFSMPz+29LZl2zz1bsuo3P7fJ7z4yZ57pxyGrVnw7j80f8
         xePt3cbbUauF+6Jeq1dwk+o8cirDMXEnZKIlX6XPFqxSTjOYwcTge2Zz07KdqrQGXwnC
         /ctew5h60CYfhxpYWjcaGfBOwuanPOmjZFTvcxuomdskMLjhSj8wpp9nNgOVrigMQv28
         zSTA==
X-Gm-Message-State: ABuFfoiyeKXqTL9dx04jwVraD+1H7Nd03f+ihcyHx2FhweqU7lXk5jUp
        c33lqQU9pYJ2T+ym5Vwx6t71fsSIw2WHBFT0A8g=
X-Google-Smtp-Source: ACcGV63I9oy2YH/THrZtGepjpDfl0q3P5lAga0UphRT2i8O/tni7XXg5s+PBiIN/ClOAw2I/eZZe8G5SQRHcYGiOTvE=
X-Received: by 2002:a67:e015:: with SMTP id c21mr19382318vsl.63.1540294348180;
 Tue, 23 Oct 2018 04:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180827090651.25062-1-brgl@bgdev.pl> <20180827090651.25062-4-brgl@bgdev.pl>
 <8636swude1.wl-marc.zyngier@arm.com>
In-Reply-To: <8636swude1.wl-marc.zyngier@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Oct 2018 13:32:16 +0200
Message-ID: <CAMuHMdWPPr56j3z4-eamtavt7cZ2jkKyE3W5_XiK1HNim8qXBg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 3/3] sh: add the sh_ prefix to early platform symbols
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Oct 23, 2018 at 1:11 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Mon, 27 Aug 2018 10:06:51 +0100,
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> As for the whole "early device" debate, my take is that we'd be much
> better off making the device model available early, rather than trying
> to architect something that is simply papering over the issue.

The device model itself can be made available earlier, but the big blocker
is mainly the use of everything related to the scheduler (threads, msleep()),
which depends on the "early" timer.

I think it can be made to work if msleep() and all thread-related functions
would return -EPROBE_DEFER, but that should be handled in every
single driver, which may be already the case for thread-related functions,
but not for e.g. msleep(), which currently returns void.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
