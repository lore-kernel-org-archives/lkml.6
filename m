Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pM88MGo8HltKRwAAmS7hNA
	; Mon, 11 Jun 2018 09:10:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B475F607A4; Mon, 11 Jun 2018 09:10:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 779F360791;
	Mon, 11 Jun 2018 09:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 779F360791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbeFKJKA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 05:10:00 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:32845 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754083AbeFKJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:09:58 -0400
Received: by mail-ua0-f195.google.com with SMTP id m21-v6so13057702uan.0;
        Mon, 11 Jun 2018 02:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yUwOeTLsw6vLCJAdkNMLBMN5py7rxS7EW1wp2CAtkHU=;
        b=J16k1ob2rCGYy4QnYIHXnPZ3543Iy3OYwnE/m+kec3g9vZFrqNx95ghu/mNRzzvNOp
         3mBHiKJvNhhPwLnOLGKcO5ay12HmghNQ+Z3C/a4Ism9YCFwve+yfjNw0a9sw+3o+SpyR
         jsEGglsx3Ahwp7n9bEDV/yEFUbMNXPwhA/In9qBuv8eDwZg9nFbDfWPROJporcDEQTjE
         lVxOcWSQLX2Wlg4Eg6ssAlNwRi910WMdD2EMBF8jTfNBTOxgE8RnoaE33M3eMeW6zIp1
         fJR9WJN17In8/iZW25KRggbGEssSb0yyhJsp6z2sowPG4mLQ6XoEPCOudoszZZ61hBso
         Fb+g==
X-Gm-Message-State: APt69E087s8vMD/yKGvjjul3ddgA4FbIzCcivV1vZSdw6FZ5GOgqdpOd
        aguwfo/LP9BPgDgIA9KfBWEnSZgfnwTDPwmwFKc=
X-Google-Smtp-Source: ADUXVKLAQ0vWoPew7P3UiCQzTLb2p0B3mTbXsWn5HTrxG4zgtvjXQ9JM76mCF4rp5gHW3sIIH0PqLRarGVjP9ODQ7Zw=
X-Received: by 2002:ab0:96:: with SMTP id 22-v6mr10647389uaj.4.1528708197541;
 Mon, 11 Jun 2018 02:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org> <CAK8P3a0CJmpf0L-OXDmqP=kRLGCokR=v6jUPaCSpnFuCwHa7WA@mail.gmail.com>
In-Reply-To: <CAK8P3a0CJmpf0L-OXDmqP=kRLGCokR=v6jUPaCSpnFuCwHa7WA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Jun 2018 11:09:46 +0200
Message-ID: <CAMuHMdWozfKt87Gmy0yuZ+tUOv2ohTybkrb88evgWoyG8xfdgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Legacy clock drivers: Normalize clk API
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

On Mon, Jun 11, 2018 at 11:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jun 11, 2018 at 10:44 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > When seeing commit bde4975310eb1982 ("net: stmmac: fix build failure due
> > to missing COMMON_CLK dependency"), I wondered why this dependency is
> > needed, as all implementations of the clock API should implement all
> > required functionality, or provide dummies.
> >
> > It turns out there were still two implementations that lacked the
> > clk_set_rate() function: Coldfire and AR7.
> >
> > This series contains three patches:
> >   - The first two patches add dummies for clk_set_rate(),
> >     clk_set_rate(), clk_set_parent(), and clk_get_parent() to the
> >     Coldfire and AR7, like Arnd has done for other legacy clock
> >     implementations a while ago.
> >   - The second patch removes the COMMON_CLK dependency from the stmmac
> >     network drivers again, as it is no longer needed.
> >     Obviously this patch has a hard dependency on the first two patches.
>
> Yes, good idea.
>
> Acked-by: Arnd Bergmann <arnd@arnd.de>

Thanks!

> One question: what happens on machines that don't support any CLK
> interface, i.e.
> that don't have any of COMMON_CLK/HAVE_CLK/CLKDEV_LOOKUP?
>
> I guess those are already hopelessly broken for many drivers, right?

Nope, they (e.g. m68k allmodconfig) build fine, as they don't define
CONFIG_HAVE_CLK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
