Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3404581-1526425494-2-7309446286036895266
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526425494; b=Y7thBUk/JRGdDUS5G+i8kbW9Kltq3JKmSBDZ5avYj1Zglfjnm6
    jFTGH+0idoWVnYR2ja1+ps7tqeHIpTw1FkLca0bMzUaZN7Yi+4Kon0AFLaVO1hmN
    RxGJP7+/edjfnGCD6jxWXNRtxBLuEsGrRNbi7wLilkaaXjg0+quUnuiW6XK7AdpE
    OsmWbZH4dnronyda/P4UAx118YC+UL6LzxofaVR1uGSzylQUY6No1R7yeJr0EWwf
    PDJn5C2cXY0dnMn/P14u6dKKH6sQQtuTJUA3g0xr4/C9R8hcr8IYFwbfF8l8w+BZ
    HT7mOyGDE4K+DFrjhCkkOsSlKjvO4wUSu/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=fm2; t=1526425494;
    bh=/v+uqrbhppM1nurFza+jv1Cznco/8uHeW0tMv9jiGLU=; b=Apkpkr/JRUA3
    KknoPdk/w3+t3rQdDet5ar3AEiS2X/KIdkzp5ntsyQQYp0+hUyl3s7cfychOLtdc
    tsIQIHYbnUxA2lk2wwvo0bjmD6nFoJyMSBOQa+8FAyg37Xdtvf9/FjETFCO0Y4U9
    WmSz//LiAGa6Njf8J1nGyIsnZf3J6Yttv4N211uRph+vIAHtigy8MTO8irynOL6y
    8l302vCcGayWxq+W8+Jg864TLfZcaJGiUlGewRbhh/3eaprDth3YiDq4U7vHM/zQ
    hLWBWzKv5KdsRM2EfIx+jQs6O/qca7tFT1SXGK5OgfxZ8dYY372cACRC2y2a/f1W
    9YMYOlFpeQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=vvHYuM+M x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=vvHYuM+M x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKOhOdi3qA+Hk2Z49cbvJj5sYafVYU8BNnFaJjdm8oE6jlgGGCroew4GTi87Kh/PPVVlJKyyk5+fajUQeEhrz7ll3/AHmiq+oRglUW0I9MJ31km/+MVc
    Kx3FMUoKjFCXK8l3Rl54Zgn+QnNa5NVO+P6/imRM6N20/vrtM0/QNq69x+pU+KksqJgn9+uxTAVnxkSmLzt97Krf2kYWjEaCHWLolGAZ3aHD8LpEVw1lIZ5W
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=71to9axffSFjc_oUPLEA:9
    a=QEXdDO2ut3YA:10 a=zfgeMz1PSwFLVvhDL7gT:22 a=AjGcO6oz07-iQ99wixmX:22
    a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeEOXEw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 19:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752416AbeEOXEv (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 15 May 2018 19:04:51 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Marcin Ziemianowicz <marcin@ziemianowicz.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180509043205.GA57916@hak8or>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180429190111.14247-1-marcin@ziemianowicz.com>
 <20180430075847.29706679@bbrezillon> <20180509043205.GA57916@hak8or>
Message-ID: <152642549058.237094.805373991669238611@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V4] clk: at91: PLL recalc_rate() now using cached MUL and DIV
 values
Date: Tue, 15 May 2018 16:04:50 -0700
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Marcin Ziemianowicz (2018-05-08 21:32:05)
> On Mon, Apr 30, 2018 at 07:58:47AM +0200, Boris Brezillon wrote:
> > On Sun, 29 Apr 2018 15:01:11 -0400
> > Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:
> > =

> > > When a USB device is connected to the USB host port on the SAM9N12 th=
en
> > > you get "-62" error which seems to indicate USB replies from the devi=
ce
> > > are timing out. Based on a logic sniffer, I saw the USB bus was runni=
ng
> > > at half speed.
> > > =

> > > The PLL code uses cached MUL and DIV values which get set in set_rate=
()
> > > and applied in prepare(), but the recalc_rate() function instead
> > > queries the hardware instead of using these cached values. Therefore,
> > > if recalc_rate() is called between a set_rate() and prepare(), the
> > > wrong frequency is calculated and later the USB clock divider for the
> > > SAM9N12 SOC will be configured for an incorrect clock.
> > > =

> > > In my case, the PLL hardware was set to 96 Mhz before the OHCI
> > > driver loads, and therefore the usb clock divider was being set
> > > to /2 even though the OHCI driver set the PLL to 48 Mhz.
> > > =

> > > As an alternative explanation, I noticed this was fixed in the past by
> > > 87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
> > > driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
> > > at91: make use of syscon/regmap internally").
> > > =

> > > Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> > =

> > Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> =

> Apologies for being a bother, but since it's been a bit over a week,
> should I do something with this now that it has been ACK'd? I was thinking
> I would see it somewhere on the git group repo but am not seeing it there
> yet. Googling says that there is a "review cycle" for some maintainers, b=
ut
> I am not clear on if I need to initiate it manually or anything of the so=
rt.
> =


I'll apply it to clk-next. Should appear in linux-next in day or so.
