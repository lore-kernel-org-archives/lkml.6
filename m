Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5F722C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140CF204EE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140CF204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbeFLHcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:32:13 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39774 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754132AbeFLHcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:32:11 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so15302071uad.6;
        Tue, 12 Jun 2018 00:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkuAVGXNysuh02rnOn+qkguRzbJWt5KzZCa1KKykFZ4=;
        b=Jb3Ghp6rlzD9Cjttug5bP2xsjEyMb008PhpkXvge8+CLr6tsO03Ox2QNjK91zsApHk
         TKsRkSD/EhYP/p92SFBtirJM9gH3UpeRwCC/5IXmPkwo2cFw/tX459lQj3IsiJwhstpx
         clU4wukuqSTcTDBTU5T2xDVS0JxxkZsBFFxtrQuPK/dv3qkSbFOsX501H5KpIpr9q0F4
         ajtTfewlH9jFIiVGw/y4isNiezH/9+RS14qliibSVTDVrfHlftrUdXkk5zx2IwDUVwAR
         gQD4F7GciEe/9kThQPTKsb5POwVzr6jZM7ddUGNMX9Rvld5s3mULEUWYPDgh/VSWTqqu
         ykqg==
X-Gm-Message-State: APt69E02yGMIA6ChiyqcR/nK8LpQMS7/u64JYXewr/ieB5NLaVVIckg+
        DaLoD8HoH9+Abk3E4W8NHNv7ParLHNn8SF+kjgQ=
X-Google-Smtp-Source: ADUXVKLe61r6hcO+a07acV/jbzNEXLSJxcpl+WQ+pI88Yz1DhD6LVFOQ60wzjr58faeI+dcFjMEKhAQcll345BFfTR8=
X-Received: by 2002:ab0:265:: with SMTP id 92-v6mr1755640uas.26.1528788730321;
 Tue, 12 Jun 2018 00:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-2-git-send-email-geert@linux-m68k.org> <944b08ba-a882-e6cd-42fa-9251bce1d7b1@linux-m68k.org>
In-Reply-To: <944b08ba-a882-e6cd-42fa-9251bce1d7b1@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jun 2018 09:31:59 +0200
Message-ID: <CAMuHMdUyD8d2yoe6v8TEinEH3hhS7Znv99pPxDCkr_uEFS0Fzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] m68k: coldfire: Normalize clk API
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Jun 12, 2018 at 9:27 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 11/06/18 18:44, Geert Uytterhoeven wrote:
> > Coldfire still provides its own variant of the clk API rather than using
> > the generic COMMON_CLK API.  This generally works, but it causes some
> > link errors with drivers using the clk_round_rate(), clk_set_rate(),
> > clk_set_parent(), or clk_get_parent() functions when a platform lacks
> > those interfaces.
> >
> > This adds empty stub implementations for each of them, and I don't even
> > try to do something useful here but instead just print a WARN() message
> > to make it obvious what is going on if they ever end up being called.
> >
> > The drivers that call these won't be used on these platforms (otherwise
> > we'd get a link error today), so the added code is harmless bloat and
> > will warn about accidental use.
> >
> > Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> I am fine with this for ColdFire, so
>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks!

> Are you going to take this/these via your m68k git tree?

I''m fine delagating this to you.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
