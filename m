Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162DBC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3DF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfAUJks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:40:48 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37779 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfAUJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:40:47 -0500
Received: by mail-vs1-f68.google.com with SMTP id n13so12250124vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1v9X5itBPerT+/BcgahBj3Yz//WH8Xc1/qMC7ThRjxs=;
        b=S7xZDSyBZVQujETIw/4/qcDHaA0YoBLEsxcepmcv/+JYuVvM+D6FucgYTktpgawcVN
         2N/1NrZ/XKtgDQ5FAL9lltSR4EvTDzLLK+BRyoJ82koyv+bgcRUm+91y9oTuLCwFUarG
         qFG6VZoAloeh6CAff/OTw9ygPn8L909SdcBE7zkzjDAHydf2sIPesNIzkqAXlxyXhHPz
         cNmy7MqVBWM2YGCvS6oah2h+hZ0QcDErU7Uo42DoF+5zx5QSIYxWeW+f4wwQmW6tM4hW
         hckVZ5X/mnYMBkc94NHp29OLKCptAa+l351HxPleDn9YOF00QIV9TIAfLJHKAPINkqE/
         3k3A==
X-Gm-Message-State: AJcUukeGFb/mlHlkIK0tRuuLJ2K734C2aFnA/5taUBC0LvCFkVTVvjvW
        7f3tTZYA40lNG6FIOMC8lHApqVpIp/jH8mRiiQk=
X-Google-Smtp-Source: ALg8bN7NU4LQd1XARB4uj+W+Sqg/vaYLTZAnlGtbjEXkVivWlnhxWLQdncVdOJi26KKCV/OG/oEgnU5n985NdKT3jlw=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10403261vsi.96.1548063646998;
 Mon, 21 Jan 2019 01:40:46 -0800 (PST)
MIME-Version: 1.0
References: <ed9f2567365292fd4f6ca081beb31a9aa8eae0df.1545445081.git.fthain@telegraphics.com.au>
In-Reply-To: <ed9f2567365292fd4f6ca081beb31a9aa8eae0df.1545445081.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Jan 2019 10:40:35 +0100
Message-ID: <CAMuHMdWh+fS-e7U3mU3tDNJhFL+3x-vbpTWRYqeokBP7P+0ifA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Skip VIA port setup unless RTC is connected
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 4:07 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Those Mac models which don't connect their RTC to VIA1 port B probably
> have something else connected to those pins. Just leave them the way we
> found them. Make the port B setup conditional on via_type, to match the
> RTC accessors in arch/m68k/mac/misc.c.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Thanks, applied and queued for v5.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
