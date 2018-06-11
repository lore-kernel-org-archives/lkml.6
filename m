Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ou8UCR49Hlt1SwAAmS7hNA
	; Mon, 11 Jun 2018 09:13:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DA984607A4; Mon, 11 Jun 2018 09:13:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6530F6074D;
	Mon, 11 Jun 2018 09:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6530F6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbeFKJNo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:13:44 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45103 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeFKJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:13:42 -0400
Received: by mail-vk0-f67.google.com with SMTP id l64-v6so4267233vkl.12;
        Mon, 11 Jun 2018 02:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAG1HlFNZLry04O83k28CkbuTEXx4nWXBwWX6+/dvaU=;
        b=Md4KPpJUttsTl56JqYkKuge/qWYvoqbDsQnGrltcPVzJIveA1khqr9O6Yzf4DDDCtJ
         El/DkqLQiRlFXvBkk6RaW7dWBBNRMw8HGYgfFa1uQl4bLeiyB6d/m+zqEFCzllau9B3o
         VF+IMEZLUnuVN+a/lLbWqALbmGjirZZShrFE2pPkwzzHsSdLm22FIdMVQDOnkzoW6TS5
         blVskuuNP4k/FRg1xh/mu2ZmlVWSrc0YRaG/bC6mZltFCzQ5/E3K0ZTTrMkJNfNfnjPP
         Up8fIpfkLFYfuxxU2i3AS5pKT4tMZ4/hZjK5w0S4y7TMeMv0sspwR8V2BO0zQkhvLucR
         nESQ==
X-Gm-Message-State: APt69E0NZqq+eG3zMLkSVDNCSocIrzYWfXu4kGZT95khpEXwS6d9+VPM
        XJaJm/svfY7ez1gi1wyh/7ymaEe1A6WpSmQwdPQ=
X-Google-Smtp-Source: ADUXVKIRcj3u8XYQFZt4KkKSi+mvq8ZA5h5GlH6xNyRraN+xpG9NGnF0TY/N3mUilBwITKVp5CkCy6blRrOMUIS01YI=
X-Received: by 2002:a1f:9e8c:: with SMTP id h134-v6mr9505301vke.125.1528708421922;
 Mon, 11 Jun 2018 02:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-4-git-send-email-geert@linux-m68k.org> <CAK8P3a1mhVJYuQGZM+ypQ1mKbB=+5gA6L=_D7-jjPmShLarwUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mhVJYuQGZM+ypQ1mKbB=+5gA6L=_D7-jjPmShLarwUQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Jun 2018 11:13:30 +0200
Message-ID: <CAMuHMdWQ_wm29Y7-qELcd4OdSc8bxEWUqcF_rfTX8JuQFDH16w@mail.gmail.com>
Subject: Re: [PATCH 3/3 RFC] Revert "net: stmmac: fix build failure due to
 missing COMMON_CLK dependency"
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jun 11, 2018 at 10:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 11, 2018 at 10:44 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > This reverts commit bde4975310eb1982bd0bbff673989052d92fd481.
> >
> > All legacy clock implementations now implement clk_set_rate() (Some
> > implementations may be dummies, though).
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Marked "RFC", as this depends on "m68k: coldfire: Normalize clk API" and
> > "MIPS: AR7: Normalize clk API".
>
> This seems reasonable. It's possible that it will cause regressions because the
> COMMON_CLK dependency hides another dependency on something else
> that not everything implements, but we should fix that properly if that happens.

Compile-testing was enabled 2 years ago, in commit 2e280c188f06b190
("stmmac: make platform drivers depend on their associated SoC"), but the
dependency on COMMON_CLK was added only recently.
That's what triggered me: the drivers were suddenly disabled in m68k
allmodconfig,
while they built fine for years before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
