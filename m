Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE2CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3446120852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8gBMcH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3446120852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbeGWPXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:23:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388104AbeGWPXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:23:50 -0400
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com [209.85.220.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6504620852;
        Mon, 23 Jul 2018 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532355740;
        bh=bwfOakcAkjklthkyep/ukrW8+k6aJhLkQ7oBqeCZiuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h8gBMcH+WonsFfS6TFvYt7DAz+d1PUPeXdxj6SeKNWJbZpallM5k9smDcHRz2Lsk2
         vE5sikNJqq2jot2trNEdOqElR/8mxvXoT6iLJCd63vR0s57NO+nLb/zmx3IK4SNSHE
         Hadurkr8PSXssu6VWg+WMy8vaoSnu60610U56RiM=
Received: by mail-qk0-f180.google.com with SMTP id t79-v6so500519qke.4;
        Mon, 23 Jul 2018 07:22:20 -0700 (PDT)
X-Gm-Message-State: AOUpUlFf2aGd2DCD8wFIf+BH9lok2mWchvMqAVVe5a7CAubzjM/RNhIV
        PuHcxHI0snKoOxfYANomaRjcOvQgMkaEoO5IOw==
X-Google-Smtp-Source: AAOMgpfRhhAdUjrQmCm2Fk9En+RIEbRRwvEVcBHsNN04TBNkC/5sCzr4yEWQcKcgm1NCmxjozTWz+8ji1ogqUtM2nb4=
X-Received: by 2002:ae9:c112:: with SMTP id z18-v6mr8777686qki.96.1532355739593;
 Mon, 23 Jul 2018 07:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180713143840.9721-1-paul@crapouillou.net> <20180720153027.GA11978@rob-hp-laptop>
 <1532113088.2309.0@smtp.crapouillou.net>
In-Reply-To: <1532113088.2309.0@smtp.crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jul 2018 08:22:08 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+=sSHSeCBQPjiEe5UH2RYyNnck-Q+rDq--iphhnYS=Mg@mail.gmail.com>
Message-ID: <CAL_Jsq+=sSHSeCBQPjiEe5UH2RYyNnck-Q+rDq--iphhnYS=Mg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_ingenic: Add support for the JZ4725B SoC
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 12:58 PM Paul Cercueil <paul@crapouillou.net> wrote=
:
>
> Hi Rob,
>
> Le ven. 20 juil. 2018 =C3=A0 17:30, Rob Herring <robh@kernel.org> a =C3=
=A9crit :
> > On Fri, Jul 13, 2018 at 04:38:40PM +0200, Paul Cercueil wrote:
> >>  The UART in the jz4725b works just like in the other JZ SoCs, so
> >> this
> >>  commit simply adds a new compatible string.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>   Documentation/devicetree/bindings/serial/ingenic,uart.txt | 1 +
> >>   drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
> >>   2 files changed, 6 insertions(+)
> >>
> >>  diff --git
> >> a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> >> b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> >>  index c3c6406d5cfe..a0b34fd3b602 100644
> >>  --- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> >>  +++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> >>  @@ -3,6 +3,7 @@
> >>   Required properties:
> >>   - compatible : One of:
> >>     - "ingenic,jz4740-uart",
> >>  +  - "ingenic,jz4725b-uart",
> >>     - "ingenic,jz4760-uart",
> >>     - "ingenic,jz4770-uart",
> >>     - "ingenic,jz4775-uart",
> >>  diff --git a/drivers/tty/serial/8250/8250_ingenic.c
> >> b/drivers/tty/serial/8250/8250_ingenic.c
> >>  index 15a8c8dfa92b..760266559a5a 100644
> >>  --- a/drivers/tty/serial/8250/8250_ingenic.c
> >>  +++ b/drivers/tty/serial/8250/8250_ingenic.c
> >>  @@ -133,6 +133,10 @@ EARLYCON_DECLARE(jz4740_uart,
> >> ingenic_early_console_setup);
> >>   OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
> >>                  ingenic_early_console_setup);
> >>
> >>  +EARLYCON_DECLARE(jz4725b_uart, ingenic_early_console_setup);
> >>  +OF_EARLYCON_DECLARE(jz4725b_uart, "ingenic,jz4725b-uart",
> >>  +               ingenic_early_console_setup);
> >>  +
> >
> > This shouldn't be necessary. Looks like it should be compatible with
> > ingenic,jz4740-uart.
> >
> >>   EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
> >>   OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
> >>                  ingenic_early_console_setup);
> >>  @@ -330,6 +334,7 @@ static const struct ingenic_uart_config
> >> jz4780_uart_config =3D {
> >>
> >>   static const struct of_device_id of_match[] =3D {
> >>      { .compatible =3D "ingenic,jz4740-uart", .data =3D
> >> &jz4740_uart_config },
> >>  +   { .compatible =3D "ingenic,jz4725b-uart", .data =3D
> >> &jz4740_uart_config },
> >
> > And this too.
>
> Well, I'm confused, the driver already uses multiple compatible strings
> for SoCs that
> work the exact same, so that was wrong?

Not wrong, but not necessary. Given that the data was the same was the
clue telling me that they should be compatible.

Rob
