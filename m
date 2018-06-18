Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AFDC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D798208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D798208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967751AbeFRI5d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:57:33 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37988 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967699AbeFRI5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:57:30 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so10204985uas.5;
        Mon, 18 Jun 2018 01:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaEh0sYT5va1hWQr05QQ7KHhPEs4HDtHWNGL8rX7y3Q=;
        b=McbKNNyhqhuIFmG6jkLzWdEDO6UDwWj3cEuekSmcLkysB/5ctbBik0r+ikLZH2gJDU
         PST0M+R28+LgKsfhVS0tSJh5128hMweI0eLu38KLLrL07pVrLroZI7ztKHsEJMEWBN/C
         VUK8elyECsSSILS4AItEFECrJ/ZX56jJsrpanuMyeVxsdZdjiYNHksZzRDSFyZt7Fk17
         CMlEFk+QvtP8tk8WL1FjeJwQDoo9q2U2UPJQm2du4RHKEscpylgwWIXGM1gYv2QIu/r0
         xmvHtvNZqzA7raG0jibe6nHSP26RdAXTphyg0XJOqarIfsglgEABXx9VTe33tmK6eerL
         w9Ow==
X-Gm-Message-State: APt69E3FK2XxB49bPWmdqaGjgKQo2EEmvN/n6LhatmGW23Ab1vEv/Jm8
        nMUISYwc1rCEQJ7muPLkB8LiODaMs/6L5AqZka4=
X-Google-Smtp-Source: ADUXVKJBDI5+dQHujQEPx9UgVICG0FxVeNgiKtb2bwP0tUR0fL0d+EYj7I2Gy44KSOR6YBzufsmgSb/fx8aCyvM6Vbw=
X-Received: by 2002:ab0:5b18:: with SMTP id u24-v6mr7240782uae.72.1529312249528;
 Mon, 18 Jun 2018 01:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com> <CACRpkdbX0R+ipasLfZi80yf2OBU0TuDT-0KoUJBvrQz3Zj6eFQ@mail.gmail.com>
In-Reply-To: <CACRpkdbX0R+ipasLfZi80yf2OBU0TuDT-0KoUJBvrQz3Zj6eFQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Jun 2018 10:57:18 +0200
Message-ID: <CAMuHMdVL-00gb7ZfgNGr8-VawFUpg+iY5mpPF6UZPfjFqM1_jg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Renesas R9A06G032 PINCTRL Driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michel Pollet <michel.pollet@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Magnus Damm <damm+renesas@opensource.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jun 18, 2018 at 10:46 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 14, 2018 at 1:00 PM, Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
>
> > *WARNING* -- this requires:
> > + R9A06G032 base patch v9
> > + R9A06G032 SMP patch v5
>
> Is that required for the pin controller itself (compile-time dependence)
> or is it required to boot the system (run-time dependence)?

Obviously the last 3 patches in the series touch the DTS, so they depend
on the base patch adding the DTS files.

> We can merge support for pin control ahead, that's fine.

The actual pinctrl driver can indeed be merged separately.

> > This implements the pinctrl driver for the R9A06G032.
>
> Geert Uytterhoeven and Laurent Pinchart maintains the Renesas pin
> controllers, and this one is for some reason a totally new one in
> drivers/pinctrl/pinctrl-r9a06g032.c
>
> Is it totally different from the other "great old ones" in the SuperH-PFC
> series or is there some other reason why it was done like this?

Yes it is, cfr. drivers/pinctrl/pinctrl-rza1.c, which lives outside sh-pfc, too.

Of course I can take it through my sh-pfc tree, once the rough edges have been
removed.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
