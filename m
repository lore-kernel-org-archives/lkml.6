Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6125C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A626219DA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A626219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeGFHW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:22:59 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46195 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbeGFHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:22:57 -0400
Received: by mail-vk0-f68.google.com with SMTP id b14-v6so6280656vke.13;
        Fri, 06 Jul 2018 00:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IofupPeDuLY+4c4ywpltXrKJjanU0Le1lix4ff1LQH8=;
        b=C1a/nwJWaE1gsaw6pDRdTnwyj39DA7OS7edYZwr10lKTdRMZegezLBCtZZsXuXn2Mz
         GFmEq7E5AjtWSKoYvUuLqhUyb61tghpm2j8UmIH+nVsub80MG4vBTOFmkLNAhIEVnYLx
         iDboKKCG1ifBXcaDzTD6rTsM0JjCdRFbtcfXMmu835qOqHz+xeD0b4XtqdM99t4OQ+za
         TX1e9hL6G7gS117NRYTJSQZNC38vOlPPfdu4bAWgEqiBVOQvi89drSF8qOKTFhcXSXi+
         FrfL5acxE0Wpjxz0ebxsxHUForS9Bow79QelxXgqEWCxLOwjnwCpS5D3zWdScTFUIdWr
         b4zg==
X-Gm-Message-State: APt69E31J+6x9wASuqrDzSjYalLFK76lD1dbmNchUYiocg/H96UoEePL
        UWEaAFJ8FPDqPOvapbVWCApI3GRdZIwxGy/mjQA=
X-Google-Smtp-Source: AAOMgpd2HRcgEgNRLAGe02Byv302Vw9dS6R/LOwJ5daQJhmVnE9xBWF801aspsLqHsBt38mbbBcb6SA1riPOZ6+bJWs=
X-Received: by 2002:a1f:8307:: with SMTP id f7-v6mr5060542vkd.3.1530861776877;
 Fri, 06 Jul 2018 00:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180703155328.GA18299@arbeit> <CAHp75VcQmUPCqzteHs=EaA5h-ABAQ=GWuLVRGWL3meMKZBJ-iQ@mail.gmail.com>
 <20180704024112.GB9015@1wt.eu>
In-Reply-To: <20180704024112.GB9015@1wt.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jul 2018 09:22:46 +0200
Message-ID: <CAMuHMdXE3MdCQRq6Y5sEu+B8668b5mEEfNT=5qva4AzxWFyijA@mail.gmail.com>
Subject: Re: [PATCH v2] leds: ledtrig-morse: send out morse code
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ben Whitten <ben.whitten@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Wed, Jul 4, 2018 at 4:41 AM Willy Tarreau <w@1wt.eu> wrote:
> On Tue, Jul 03, 2018 at 09:43:06PM +0300, Andy Shevchenko wrote:
> Well, in this case it's even possible to go further and avoid storing
> 36 strings. Indeed, no representation is longer than 5 symbols, so you
> can use 5 bits for the encoding (0=".", 1="-") and 3 bits for the
> length, it gives you a single byte per character instead of a pointer
> to a string plus 6 chars. Then in order to make it readable, 5 macros
> can be provided to emit the code :

And using the scheme from
https://plus.google.com/u/0/117536210417097546339/posts/hvctn17WUZu
you can store up to 7 symbols in a single byte, which you need when going
beyond plain alphanumeric:

-0111111
--011111
---01111
----0111
-----011
------01
-------0

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
