Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD92C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6334B20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkPV/r43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6334B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIJMij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:38:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55373 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeIJMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:38:39 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so28315198itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9z1w/2We5BKHXPP6XvPuv7S64WGiACWduVZM9rnpiJw=;
        b=dkPV/r43UKAOLTnZeJib1gJLpcnskdyoVO77YmBiIOewRGeN6oC+h8a8KtW65WG8bN
         YAejaLazn5rWMsXJ3u+sY31iGqwm16BcBUWLgu8WNVHK9EPMdsILc3AIniHg0DIDsqRw
         v2tDIx8EUhfh2WHl9LRyLG+iXAsB0KPxaKT6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9z1w/2We5BKHXPP6XvPuv7S64WGiACWduVZM9rnpiJw=;
        b=eHZ0x6D37vtNw7nRKdDOQWldUAIc+4ioM5xnACzc3MRR1qNgijXx+nVn3ovi0yTI/w
         WGkWsLlyvOkZeCG0VhJ150CxhQOnAoozsWOJYqei1o3LOgG1bNY9t1WTfat11m6TvE5u
         86GDQ8zqwe1EZ5nwCvJHQY5iloHr0cYiBorA9FPTs5oZnBjPp2NdsIkjeyRyiitTTvnR
         lXR/mkDjXFtHtoDjMuaJjGT3zA0fthBiZnAbOLA9lk39JYHuBCHujg9QC/07ZyWQufKB
         8vswzc4MvGOXGWRA+dC9i+lhqxcuI+aEjrPjdC7Bx7lD9jfEnH3d6TxTuSU1bBMZN/UW
         q8yQ==
X-Gm-Message-State: APzg51AEWQyTdPSuCzMLwVxGG1smek6hHABZwZDDOliDRRGsV3TSRCuy
        Ox1VLwPLLJRzmG4iGN85D+wCR1U6dtpGsSXqy984eg==
X-Google-Smtp-Source: ANB0VdZb0k1xMvAFcFiZJeLwZYwavSyl92iucoLOq6RZ9YRZTVsk3jiazoBcSK5y539adzpshGT0tYpFRlkm16SqFMY=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr18004093itc.16.1536565556036;
 Mon, 10 Sep 2018 00:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540> <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20180903112517.GE20333@w540>
In-Reply-To: <20180903112517.GE20333@w540>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 09:45:44 +0200
Message-ID: <CACRpkdaVXiE70Ux_-idKz6ovgGz1KEZ7qau-i_3FpN_q=w5npQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
To:     jacopo <jacopo@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 1:25 PM jacopo mondi <jacopo@jmondi.org> wrote:
> On Mon, Sep 03, 2018 at 11:03:18AM +0000, Phil Edworthy wrote:
> > On 03 September 2018 11:34, jacopo mondi wrote:
> > > On Thu, Aug 30, 2018 at 02:12:52PM +0100, Phil Edworthy wrote:
> > > > This implements the pinctrl driver for the RZ/N1 family of devices,=
 including
> > > > the R9A06G032 (RZ/N1D) device.
(...)
> > > Using standard pinctroller bindings pin configuration properties:
> > >
> > >          &pinctrl {
> > >                  pinsuart0: uart0  {
> > >                         pinsuart_tx0 {
> > >                                 pinmux =3D <103, UART0_I>;  /* UART0_=
TXD */
> > >                         };
> > >
> > >                         pinsuart_rx0 {
> > >                                  pinmux =3D <104, UART0_I>; /* UART0_=
RXD */
> > >                                  bias-pull-up;
> > >                         };
> > >                  };
> > >          };
> > >
> > > Is there anything I am missing? Maybe from the interaction with
> > > "another OS/core running concurrently" you mentioned? In this case if
> > > you only have to perform pin configuration (because muxing is handled
> > > already) things are even simpler, just use the pin configuration
> > > bindings, without involving muxing at all:
> > >
> > >         &pinctrl {
> > >                 pinsuart_conf: uart0 {
> > >                         pins =3D <103, 104>;
> > >                         bias-pull-up;
> > >                  };
> > >          };
> >
> > Sorry I didn=E2=80=99t address your point.
> > The only reason we want to use new properties is so the driver can proc=
ess
> > dts files that have been generated from an existing PinMux App. That ou=
tput
> > is used by VxWorks as well as our out-of-tree Linux port. If that is no=
t a
> > good enough reason to add new properties, then I can't see any technica=
l
> > reason not to use the existing bindings.
>
> I see. I step back then and let this to be handled by the pinctrl
> subsystem people and maintainer :)

I rely on Geert Uytterhoeven and Laurent Pinchart to tell me
what is best for Renesas.

A good hint is that Geert will merge this driver when finished and
send it to me, so if he's not happy it is unlikely to get merged.
So make sure Geert is happy and I will be happy too.

Geert, as I, likely rely on the DT maintainers to tell me what is
best for DT. But with pinctrl they often pass it back to us.

Yours,
Linus Walleij
