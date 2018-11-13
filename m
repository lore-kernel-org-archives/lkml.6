Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBB8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B52C2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B52C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbeKNBLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:11:00 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46299 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbeKNBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:11:00 -0500
Received: by mail-ua1-f65.google.com with SMTP id v24so4427040uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Law5y0HPc/82gzCCJ2AeBdV9GKeaU1WmOhyh9ijWi6s=;
        b=mQgymFVOkqBuBvJCspSh06oGTFh0IuGBbTi3ko8JJXAMlaEMhorKv9Lb8Ajx305jaZ
         VxuDa9W8wLE3Fo0T71Pp7kjyYHaXC4DfP8HMFwpqZREn+WopPtBua0NB/Z1e57W81Lk4
         8gcCjTvwNbiJPd/F2sPLlzhHvU3wjsSpP+6+YSMOVD/ZjfYHI8/I+ckGlbur+iU7Vro3
         b0NgIjj1wV4C4R6131sI4ssmbTz3ZPoyXZ7hWNDThKW1DqzZlG0O+wpi2COKECOkJaZN
         ygmeJCs7sjT6LmxnOE/djllWBi0wcta8I2wrqwIsbY0HYqfnB0Ltdhje2aLVDwFVfFl8
         peEw==
X-Gm-Message-State: AGRZ1gK0J9KtMAz2TW6P3TAxUj4hoNKcPM/OYpb1ng29xLeGZvUqR92F
        JQido4jfH2mIFVK72HJ+BfgNkF0gPjYBUTyZyw0=
X-Google-Smtp-Source: AJdET5e2Nf7uWh5D7FG9dM0BNt98/i62ZFiDCoWPkA99N0bfPfSqNRCayZ5bHUcQnPciX4OIdowTbszzH2/rtUyBNrs=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr2383031uad.78.1542121945745;
 Tue, 13 Nov 2018 07:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20181008111543.26128-1-geert+renesas@glider.be> <1539003340.11512.18.camel@pengutronix.de>
In-Reply-To: <1539003340.11512.18.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Nov 2018 16:12:13 +0100
Message-ID: <CAMuHMdVQSsVwaCNy9UCDQErymhHEFBycs2mcps2p-0CLmc7AYA@mail.gmail.com>
Subject: Re: [PATCH trivial] reset: Improve reset controller kernel docs
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Kosina <trivial@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, Oct 8, 2018 at 2:55 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Mon, 2018-10-08 at 13:15 +0200, Geert Uytterhoeven wrote:
> > Grammar and indentation fixes.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  include/linux/reset.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/reset.h b/include/linux/reset.h
> > index 29af6d6b2f4b8103..d01ea059e2beee6e 100644
> > --- a/include/linux/reset.h
> > +++ b/include/linux/reset.h
> > @@ -138,7 +138,7 @@ __must_check reset_control_get_exclusive(struct device *dev, const char *id)
> >   *
> >   * Returns a struct reset_control or IS_ERR() condition containing errno.
> >   * This function is intended for use with reset-controls which are shared
> > - * between hardware-blocks.
> > + * among hardware blocks.
>
> To my ears "between" sounds better, because it evokes the idea that each
> hardware block individually must take care not to disturb any of the
> others (like sharing a bike between a few riders, instead of among
> them). Also, in many cases the sharing occurs between just two hardware
> blocks, which makes "among" sound weird.
> Of course I'm not a native speaker, so maybe I'm completely wrong.

I'm not a native speaker.
But I was taught "between" is used for exactly 2 items, and "among" for more
than 2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
