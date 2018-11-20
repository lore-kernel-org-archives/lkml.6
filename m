Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CD1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B692206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4j2428o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B692206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeKTUVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:21:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43250 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeKTUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:21:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so1055994ljf.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlWXp8fpvUtCTFs5QE06so0nwIH2qnlZg4EYF3K3jdI=;
        b=H4j2428o1P42IH/iAU1Ta6GIq2NJnTYlpnND4+gQoj5ZgmlzATrmcDBcWROnj70ETv
         1DxRgjQw8nYyX80RcwtvFMpTZzymf4wBvEFZH93Kpze24KYyVfh/t4cD4nBDbV3iZOYm
         WcZbdUjkV5j1SnTnZmUAla+NLKwb5oks0EqOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlWXp8fpvUtCTFs5QE06so0nwIH2qnlZg4EYF3K3jdI=;
        b=COPV65E8mVOqqKfehTNIG41A50NrODxRlgJT6kyWBZy0BVbCJULsATWCPPrmwlDqsg
         lBCtY5ZQAXBqYda2OZPy6KBqNqHc3Hh0s9zvu0pGybOgbJN4jVrjbt43/F01yHwGPLad
         GklQQlJ6P8Ie+epabsvJ3VfvKvbKkxD6GUsChs7Jqnv6RUoIcF5agcbe0uIs+YbVEzPl
         grH75Ur2XN9N4VwUwnn8+CFyhF/e/vt2Nbh5CDjZbELQQONEr/bq/Dii63hD+BLZ1JrL
         xjH7SO6Cw6e/mb+C9bazrUDCYglY4VQs2yVciXxbdj1iRAOrkmFb3rSA0R48TtjNF22r
         W83g==
X-Gm-Message-State: AA+aEWZAJSMsf+C8oAhOhoIdQv9TnIlaNtr097bj/+3ekLFRbpA0R4uR
        qKCxcefG31+eQj8lVuov3iY0K8V54AWBYiOLClLUCg==
X-Google-Smtp-Source: AFSGD/UBPfJUKWPKIQEIWbO/KwybYEjoFJDBM613pqKIJRGii7bJV2gxQ9qM0PSohsedI0UGTBwRF+dhd9h0HbZNWjY=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr695818ljj.120.1542707601794;
 Tue, 20 Nov 2018 01:53:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
 <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com> <alpine.LNX.2.21.1811202001390.258@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1811202001390.258@nippy.intranet>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 10:53:10 +0100
Message-ID: <CACRpkdZCFFAmArh20Sn7Z-FTYfreWw9cXfVN6iJNR1wAQD7gpg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
To:     fthain@telegraphics.com.au
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, schwab@linux-m68k.org,
        Arnd Bergmann <arnd@arndb.de>, schivers@csc.com.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:30 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 20 Nov 2018, Linus Walleij wrote:

> > As with the Amiga, this chip also has an RTC clock that should go to the
> > RTC subsystem, naturally.
>
> I think some Atari's have an MC146818, which is drivers/rtc/rtc-cmos.c,
> arch/alpha/kernel/rtc.c etc.

Indeed, some systems have more than one RTC, often one in their
SoC silicon and one battery backed elsewhere (like a dedicated
chip on I2C or inside a PMIC).

We usually just register more of them. The RTC subsystem can
handle any amount. It's up to userspace to figure out which RTC
to actually use, which is not so good, we should probably
have some heuristic like a quality indicator on them.

Yours,
Linus Walleij
