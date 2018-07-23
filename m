Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282C5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FD020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FD020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbeGWMIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:08:23 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35416 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbeGWMIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:08:22 -0400
Received: by mail-vk0-f65.google.com with SMTP id p12-v6so104760vkf.2;
        Mon, 23 Jul 2018 04:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q97NnOnP+Ejq6/o336JvRW4gTqCkHzba7TQY8+wB2Sw=;
        b=mfUSlcJnv5ymfO5oWQL6Cwy94NrwuiIFaxLob4J076jyUuiEBD260mGabrlBSqE0Cx
         1GGNTLDmswEnRcTIleS5Ova6w6FBWD+ntou156WIV7KE1UHZuAIoeKCT+04TUBtStBUV
         Pto8pMQ+z3xv9CZ/eXQpExCY5wlpalMbjDrmGX59wP0bXZuaI3Q8BIT3M8fVUx17mtkz
         VzhbO2wCzgt26o5KgZ/snHO3ObHqAujpqB4MSBRB5unvZg2SuKALaIc5GixzAXUThlpd
         2msZbRDNnjsCQKDVl5F91/Xmhsho4XbyGjsKkHF1CCMraz26MuO9i3dRx+RUMhRSIVGq
         3iEw==
X-Gm-Message-State: AOUpUlGrGFKIolpOdAG5HfBGnGXTaCKXl9eDw9PvSELyp6r1EJUq0Q0G
        VtjkUwNDbygFYtdrGVv9uz4Zxm9a1nYk5JnVxNQ=
X-Google-Smtp-Source: AAOMgpe6nOQ/Gwp2OCNRxhVlpkSLZJOLxvWroSsRfVO/MhgdbRf3CBrGuui+QJJ5hVJEAFIuAjJiD9hHWsGoHkRScho=
X-Received: by 2002:a1f:9cc4:: with SMTP id f187-v6mr7236447vke.87.1532344060127;
 Mon, 23 Jul 2018 04:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl> <20180721074319.GA30454@kroah.com>
 <20180721213843.wkculy5cdrrbmuij@angband.pl> <CAMuHMdWvZnU_p-c98sag8t1BCaBLSqZmiH88sgD2kACbvax0pA@mail.gmail.com>
 <20180723104151.z3lasjmdd3ubh2sc@angband.pl>
In-Reply-To: <20180723104151.z3lasjmdd3ubh2sc@angband.pl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jul 2018 13:07:27 +0200
Message-ID: <CAMuHMdVPx40SL2kqv+nRUDoX0GL4uKoZd7gYmab94T2RyrpkMw@mail.gmail.com>
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
        linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Mon, Jul 23, 2018 at 12:42 PM Adam Borowski <kilobyte@angband.pl> wrote:
> On Mon, Jul 23, 2018 at 10:53:29AM +0200, Geert Uytterhoeven wrote:
> > On Sat, Jul 21, 2018 at 11:39 PM Adam Borowski <kilobyte@angband.pl> wrote:
> > > Technically, every console can be made to blink by drawing/clearing affected
> > > characters a few times per second, but that'd be quite a waste of coding
> > > time and kernel size.  There's a reason browsers dropped support for <blink>
> > > and text-decoration:blink.
> >
> > It's very simple and fast to implement in fbcon for FB_TYPE_PLANES or
> > FB_TYPE_INTERLEAVED_PLANES and FB_VISUAL_PSEUDOCOLOR ;-)
>
> Interesting...  I'm still not going to do the effort to implement that
> (which would require learning fbdev internals first), though.  But while I
> dislike this feature, someone else might want it.
>
> The main problem here is that there are only 8 or 7 bits available for
> attributes, thus it's better to use them for something more useful.  And
> here, fbcon already interprets this bit as bright background, thus this
> patchset makes vt use it instead of non-existant blink.

Even better that they are mutually exclusive ;-)  So it can work fine with
only 4 bitplanes.

That means bitplane 3 means either bright background (palette[8..15] are
the extra-bright versions of palette[0..7]) or blinking (palette[8..15]
alternate between palette[0..7] and all zeroes).

> There'll be more bits available once attributes get migrated into uniscr --
> either 11 or 32 bits depending on chosen implementation.  But I still
> wouldn't go too wild with them: the console is meant for recovery tasks as
> on any properly working system you can have an X terminal configured for
> pixel-to-pixel identical behaviour as anything console can do.  Thus, only
> cheap improvements to attributes make sense.  This patchset is currently at
> +3 net lines, this certainly counts as cheap.

Assumed all those systems are sufficiently powerful to still run X
(said the guy who once ran X with mem=2M on his Amiga, just to prove it could
 work ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
