Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91406C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5479020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ILAPHdJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5479020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbeLEMiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:38:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39021 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeLEMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:38:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so17352858oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=phPfRycTObsJs4Pyer1OXmh5+Pv4MU+ILsITuYlluEU=;
        b=ILAPHdJrbX/troygIsAgLPL/Cbhracu6LLXVT1sxzwQmi1VlVbL/pJcqZxIIDPvK/C
         0RU6LitXqr1idfTc5ihqW+ChO811invc2/pdWW+Sq4XNs+bOBRlRU9qX/NA8g2nl1P+x
         ROzIxEk1jHeEJqxyXVk8ljXgf2V0UhkNAOLx7diVLtJNDIvruZfSvnkWePAGOJIC7gq/
         /OI4ABIrSBTCi/zdKCXrZPerPmB8giVUdCsk8dwbIKxjO/7US0Q0GVW9SmRqkm7PUNll
         b5pnsQVR5EOgZr4h8p7wgL5ychKTonhmKaAZ5jdaQuvNu3sYuWU6ht8IAlAL8r0TIeP7
         rXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=phPfRycTObsJs4Pyer1OXmh5+Pv4MU+ILsITuYlluEU=;
        b=nIkcDYNJL3O/gevY/iV3ZV2NK9vyc4iZFoH25Mgzdi4r8B/UZYuu/dwWC0WrQ9cA2+
         EAlVq3PczoQYvDTNfHEvABFWiF6NoA0YdIRaEOsChuUdJJ0Ycj2BhrH4lVeMydZoRgkQ
         dbNFERXIjk4Stq7rjOb0joH7a11kulUuq0OZdMI5G93T8EfAMBL9BAaOylm2rqqxJZLP
         8Zc3waxz1qRTFE7IXDHHCtZfTbx/ibh6ctkCoKj31uEO1+YgeIvW+r58EszgW3hzzlpR
         AJvzSYkyqydzQVpqnfgshJyQhg9CiXdA0XavsUabSZ1UYtYSzjRetQ3aO/rS/m4vmxC2
         dI4A==
X-Gm-Message-State: AA+aEWbaiWRvL8WoDUEdTf/jCWjtybs4vpMpa84J4lW0y6Y1UFiLLydn
        pqQij8/t5KOKXJQtkbRPrKB9Ba7dxO1y1NHExqvFAg==
X-Google-Smtp-Source: AFSGD/Ud3uWGK5XkqCOzt6gqGxALiZdgfpvLhRSk603SHwmoILeOHC9dCHBHQrG0NlCTP8e/GDV/IYMaZV7oWEZ2Grs=
X-Received: by 2002:aca:3856:: with SMTP id f83mr10068507oia.147.1544013502658;
 Wed, 05 Dec 2018 04:38:22 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MfKf_f+x3Wt5gScA5yb78kbpphL87bi2arxcKKGjg1S7Q@mail.gmail.com>
 <20181121191509.ia2vcklvx4q2rh56@pengutronix.de> <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de> <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
 <20181203110654.53o3prw3qu3u2uyf@pengutronix.de> <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
In-Reply-To: <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 5 Dec 2018 13:38:11 +0100
Message-ID: <CAMpxmJWAZevmCkDDgLVTY5REGPB3HA5JAtNDtxT0NMt964GQCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     u.kleine-koenig@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 5 gru 2018 o 13:20 Linus Walleij <linus.walleij@linaro.org> napis=
a=C5=82(a):
>
> On Mon, Dec 3, 2018 at 12:06 PM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Dec 03, 2018 at 11:57:26AM +0100, Bartosz Golaszewski wrote:
>
> > > It used to live in the gpio-mockup driver and I generalized it
> > > precisely because there was another driver - iio evgen - which was
> > > doing basically the same thing. While I don't know if there'll be mor=
e
> > > users (I'd guess it would be useful for testing purposes of other
> > > subsystems) having the same functionality implemented once is better
> > > than twice.
> >
> > The iio testing driver only needs the trigger and relies on an irq that
> > then calls the registerd handler. The iio driver doesn't need to tune
> > the edge sensitivity though and if your mockup driver just only calls
> > the fire routine if the configured sensitivity justifies that,
> > everything should work as expected.
>
> Simulating edges in the generic IRQ simulator codes seems
> generally useful to me, even if there is just one user now.
>
> Certainly for any kind of IRQ testing, it could be interesting to
> throw several low-to-high and high-to-low transitions
> on a driver and see how it reacts.
>
> But it is up to the irqchip maintainers to state whether they
> agree.
>

All that would be great, but at this point I just want to fix broken
tests in user-space. After that we can think about how to
improve/approach simulating interrupts all we want.

Marc: is my explanation for using an int instead of bool for
irq_sim_fire_edge() fine? Can Linus pick this up for fixes?

Bart
