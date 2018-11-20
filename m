Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA83CC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D8B208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D8B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeKTSrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:47:41 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38799 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKTSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:47:41 -0500
Received: by mail-vs1-f68.google.com with SMTP id x64so574485vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fkxGg1C/u4vutBnfJiIUueBzMKtzQB+fauhesjUMis=;
        b=SrZTalxouJC7ahRStNpKmWYkZ2e/YQxhVUR7yapFOL5aFQiFlp10h2DlzNpX4VujfW
         mryWwNj89mydq/oP4G0CFtdWQPERcRz3GrQv5dCKvmyvStCJ/2wvvDiLA325C98xNz6X
         CMgBpNtZYV1fEj5XC2Cb5zNweQ0njkjasYfRK8Qwyw4lOZgVuLHSFKo0VlBuCNaiZh8p
         nbTZNuBCL4RDmyZfLtKyezByxe5JEr2mOEau+6o5/okMJ7yp07TLI17aEI3OnlUsWnlk
         U5zNaRxfIIxkk4VWpFFbRxY9GkKiuwT/1LjIIkAtfPA+AULyyxoZCHx9CxC/rrRSZQkB
         pATg==
X-Gm-Message-State: AGRZ1gKX/up6fI/Akya1ep+4dBxonh6WdSLhZUKEVYErigpGQ0HbGaIi
        elGasfbR5nDpzDcKs74H29PZobHrMncQ8mQx24A=
X-Google-Smtp-Source: AJdET5fc1oQJBKMS5yhYdVsaT1GJCTqFYlmWjXbIO9x0lx3/jLkPpE4m6MSeX/PW+ecMEy1CSvZPOKhbDUb+Vm5A4pk=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr449096vsm.152.1542701988958;
 Tue, 20 Nov 2018 00:19:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
 <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
In-Reply-To: <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Nov 2018 09:19:36 +0100
Message-ID: <CAMuHMdWPeLeVQNnkE_V-Vb1qkf7tcCEEYzd3XwRKxJMwfV-OWw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Nov 20, 2018 at 9:10 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> As with the Amiga, this chip also has an RTC clock that should
> go to the RTC subsystem, naturally.

Please note the Amiga CIA is an 8520, not 6526, hence it has a 24-bit TOD
instead of a BCD TOD, so it's not suitable for use as an RTC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
