Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3210CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC52221852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="COKa9nGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbeLSXCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:02:01 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43533 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbeLSXCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:02:01 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so13299544vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcyvRp2CQ5DbPDRjTktuIANDFz5LiuYFyHF2SMFgEDw=;
        b=COKa9nGAgf4JWC5gTPJ5DNPXJc7D8ZF8FCjTQQ6+bt5Zgz9OG5Vh3Qnt7jEx/1gSTk
         C1fuvGVTKw/yYUXPUwTE3l4+7/H4aSV+WYZMUO2mPOtFnBjrkOt/vEsRP4zpKxcv51gS
         SelE4dG0avLvr4as0crBmXRkO+hqlIjjFz1T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcyvRp2CQ5DbPDRjTktuIANDFz5LiuYFyHF2SMFgEDw=;
        b=EsXfpWJC/4jWpIOqqpBtaBRuJ3wj8AgHUcnzR7rySuUDoNdOcnLibJGGFV2f5/WsHJ
         zHSfytieOEYiD8+ITELmFwTiYvDhAcEhsm3j2taaGG1eD0awgohZv8PTWbI+PF9P5RK9
         WwC9QPPh8BEc4eyp1M6oHBPr5J7NKPXVIGiKdRdzQgu4zQkBlErrMMY0G8wn4so7YbZw
         wivQ1k2p9vw5n555X9XSYlXaPHC0Vs+SpC3PEXuO2nwbFaMkJPz6JQTr3OaamadMhFhF
         /P5L1BbO2AnlrU037dWBju2nPF/CDb4ABMk3BHWUJfMUEI7sX82QOHv3fz1ReBIA1S4Y
         GM3A==
X-Gm-Message-State: AA+aEWZmlYHHVkD151hJKkKmJu6u3kHZXJja2OSNWtVPjsSCya4HEwEk
        NFJEdcuik4Y3IzbhtuP8ZyUW87CT2qg=
X-Google-Smtp-Source: AFSGD/X5kAUuWQpjw1Ei7S/0u+xg2iDEeXbpWKHyUMwGP1tO5788yzRBZH2b65B6Myrc7L/ILg+gHg==
X-Received: by 2002:a67:de97:: with SMTP id r23mr10937347vsk.127.1545260519474;
        Wed, 19 Dec 2018 15:01:59 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id j133sm7947164vkc.24.2018.12.19.15.01.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:01:58 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id e7so13329147vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:01:58 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr4154249vsk.111.1545260518185;
 Wed, 19 Dec 2018 15:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20181219203353.172335-1-ryandcase@chromium.org> <CAE=gft4=gK5Ge_BOMN4dov=b978dXbTBZ2KPDuGxCP=CvgLd2A@mail.gmail.com>
In-Reply-To: <CAE=gft4=gK5Ge_BOMN4dov=b978dXbTBZ2KPDuGxCP=CvgLd2A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Dec 2018 15:01:47 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XiMEUjyZ7E1pHLCfhpe5wzfq8e0EHL5DXpr2dKk6wsJA@mail.gmail.com>
Message-ID: <CAD=FV=XiMEUjyZ7E1pHLCfhpe5wzfq8e0EHL5DXpr2dKk6wsJA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix UART hang
To:     Evan Green <evgreen@chromium.org>
Cc:     Ryan Case <ryandcase@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 19, 2018 at 2:12 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Wed, Dec 19, 2018 at 12:34 PM Ryan Case <ryandcase@chromium.org> wrote:
> >
> > If a serial console write occured while a UART transmit command was
> > waiting for a done signal then no further data would be sent until
> > something new kicked the system into gear. If there is already data
> > waiting in the circular buffer we must re-enable the tx watermark so we
> > receive the expected interrupts.
> >
> > Signed-off-by: Ryan Case <ryandcase@chromium.org>
> > ---
> >
> >  drivers/tty/serial/qcom_geni_serial.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 0c93beb69e73..a694a47747c7 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -442,6 +442,7 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >         bool locked = true;
> >         unsigned long flags;
> >         u32 geni_status;
> > +       u32 irq_en;
> >
> >         WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
> >
> > @@ -476,6 +477,13 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
> >                  * has been sent, in which case we need to look for done first.
> >                  */
> >                 qcom_geni_serial_poll_tx_done(uport);
> > +
> > +               if (uart_circ_chars_pending(&uport->state->xmit)) {
> > +                       irq_en = readl_relaxed(uport->membase +
> > +                                       SE_GENI_M_IRQ_EN);
> > +                       writel_relaxed(irq_en | M_TX_FIFO_WATERMARK_EN,
> > +                                       uport->membase + SE_GENI_M_IRQ_EN);
>
> The _relaxed part of it has always been weird to me, but I guess we
> fought that battle awhile ago with this driver and lost.
>
> I suppose the only real danger with relaxed would be if you could get
> yourself into some sort of tight loop or idle where the CPU's write
> queue never flushes, but you needed it to in order to proceed. This
> probably could never happen, especially with locks around consoles and
> uart ports that act as barriers.

Yeah.  IMO we should go through and remove all the "_relaxed" from
this driver until someone can prove that it's important for
performance.  ...but I think that's for a future patch to do.

-Doug
