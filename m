Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SCUSBSk4HlsZMQAAmS7hNA
	; Mon, 11 Jun 2018 08:52:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 10C26607A4; Mon, 11 Jun 2018 08:52:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 84BE56074D;
	Mon, 11 Jun 2018 08:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84BE56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932479AbeFKIwT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:52:19 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46062 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbeFKIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:52:17 -0400
Received: by mail-vk0-f67.google.com with SMTP id l64-v6so4234277vkl.12;
        Mon, 11 Jun 2018 01:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2ydmYOZUp/q+iE67tK2+OR/lD+qeULVg3FE0AzMPqU=;
        b=sRFQ+AfuwlBHZg0GMimzYHoW9Jpf5oXBEvACjZ3FO2T3ut0LfykRb/8eFlCWPcCOuW
         WRLgx5mkNaV892h0XJCl/28MThW+1dsjFnflfohqkYwrhJ5+FSTuTUFHKODEl6VyrE74
         EQNHRMag5GJuzW+lSRBJ42FItsTf6UWmF7OpBkBE4+QmoouO23UIBCfcmYkOHlDe0fQ4
         G5mXIsfR44nfBCDOMnmBeX5l2b8gxqgWFjaR9QJLlliqu306uZiNjAnPOrPKmVGZ+TzZ
         EOKsfplyZwQ9Vxt/ixWIPhVoOzUykmBJY5B/RStFXigcsEZ5IZyKqklu7OcXcCKZOTtk
         rRZQ==
X-Gm-Message-State: APt69E0hvAQ8hNzOZzoCALG/wKkb1LPXtMee84snRimsQV+NOzFE3hjJ
        VtXzxA3hlPDtavl6we0d2EPzj1V8TUyY/v471O0=
X-Google-Smtp-Source: ADUXVKK+KGjUr3c3cHk7ZjkcntroeWv00381TeqBko8VZaPL2i+z7w3pzPvbghy1IH+hHVzG508c5OC19D+QAgXPqJo=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr6625712vke.176.1528707136645;
 Mon, 11 Jun 2018 01:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <84075652e978661247d71f84de46efd827869948.1528697370.git.michal.simek@xilinx.com>
 <CACRpkdb=Vfs6R+576+Wjh1cOh8ti-8jkGhj7Pw8zXdOxvHKOCg@mail.gmail.com>
In-Reply-To: <CACRpkdb=Vfs6R+576+Wjh1cOh8ti-8jkGhj7Pw8zXdOxvHKOCg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Jun 2018 10:52:04 +0200
Message-ID: <CAMuHMdVfYWrhvhDDgHanMq6LpnruBiRZYRdAbMj5WiJJKvJ+Tw@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Remove architecture heart beat code
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Jun 11, 2018 at 10:47 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 11, 2018 at 8:09 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> > There is no reason to keep this gpio based code in architecture. Use
> > ledtrig-heartbeat.c instead which is much more flexible then this
> > ancient code.
> >
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Maybe the arch maintainers will complain that the corresponding
> new heartbeat code is not put in place in the same patch, but I
> think the change is so much overdue that I don't see why they
> can't do that themselves if they have interest in it.
>
> BTW: m68k has the same kind of luggage, in the middle of it
> timekeeping code:
> arch/m68k/kernel/time.c

Fixing that means converting m68k to GPIO first, which would take lots of
heartbeats ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
