Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A2CC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6239220B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6GtVnF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeLNOHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:07:53 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46123 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbeLNOHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:07:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id f23so4315022lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5M6Pv0iTBeLAUiVLw36pC8WZ2QZ8He/+Zt26NeLbuVU=;
        b=U6GtVnF7eAJVv7khtdSwGSPwtfeOFGb3AmwHeAZRNpUxNAiTA+CPoV+4MkTy96OZCg
         llfuemrRXTEV9Uilr8+6aeA/v0YryAz/orceT9M9jcuCq79trqIpdPXhAK9W2akbY3md
         9FpwYznvqCBPg7o+tBXtYA2vC/yvYZKQMMhaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5M6Pv0iTBeLAUiVLw36pC8WZ2QZ8He/+Zt26NeLbuVU=;
        b=Et4agyVa2n0kkS5418RbgJ3EOiaMdl4IGtgCtQ6HvfDcVhq8ksl9xSnJ/5aKhJXeKW
         POYRfk3NdevfUHsOcEsCdLoh8CIEkm7K/ET5F021s8VlpearAa0u6xcXwui6WIOHol92
         uErdyCmCnbouhLR+MySaaP925WjzzkDVP6NV7Yn+qpHKimAASzJQOPauB0CjuapC7TKd
         jaoofSiNRdrHpaYmpMlA8RZT3OT9CDxO7eYgwl2Ztjs2L7o32wKVzLti+w/baOLwkTbo
         rXN8wRznnW4RZ/i1s4Dgc6LC+lpPLGj9xvbetipzpv20nKPxZSRKkUkM3rgZGAJUMtMW
         OtDg==
X-Gm-Message-State: AA+aEWam/i1n8W4w7KEC3MLBEJrYVAVy8YytzdxEtEX0b0inZx5PwrtU
        Y+iFVpjrnYwH2KVSOp6/Nu+7P1P7cnYYpqR8BCxqnA==
X-Google-Smtp-Source: AFSGD/UZlHYoNN3mCLFfdSpGiUke2v/bIjJuaRlBuqBEpUmm76qC0EW70qcN3YGROjLD6SdV9p1lvdw2tRoG2V0kY6c=
X-Received: by 2002:a19:5154:: with SMTP id f81mr2025291lfb.96.1544796471115;
 Fri, 14 Dec 2018 06:07:51 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=Mef_O9ANUekZaz7vP7M2PpQFjZxJBoG8EPbXt6enRPL7g@mail.gmail.com>
 <20181125211854.idnqxz4pco3r7ydr@pengutronix.de> <CAMRc=Mfu=e3BsjMN=_H9CbUvumdmT1pvNjsyivTo1WN+LC1+2A@mail.gmail.com>
 <20181202215613.jcfrxwl4taiqgsql@pengutronix.de> <CAMRc=Me=FP537vMVx-jkuff2GqO66T+i3XUBza2Xb4oWzGNcLw@mail.gmail.com>
 <CAMRc=MeD-O5-7sBfrFn2rt27VHXwcOQ5cX2ybLHXU8kFyA_dLQ@mail.gmail.com>
 <20181203104923.gcb2bcsaoczjcjhk@pengutronix.de> <CAMRc=Me3srKHXLvdAVLAaVOyW79D378EGVh=dTXbCxo7FiyAsA@mail.gmail.com>
 <20181203110654.53o3prw3qu3u2uyf@pengutronix.de> <CACRpkdahWTts9Vz_vdC8dfd_HxCb3NmiFcwK=x-tVvFRcRm3tg@mail.gmail.com>
 <20181205132000.f7n2stv2pxldzcxu@pengutronix.de>
In-Reply-To: <20181205132000.f7n2stv2pxldzcxu@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 15:07:37 +0100
Message-ID: <CACRpkdaTNFFevE-hauMn17cXbsoddkw_Bp3WyBHbzG1+dohxew@mail.gmail.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 2:20 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Dec 05, 2018 at 01:19:54PM +0100, Linus Walleij wrote:

> > > The iio testing driver only needs the trigger and relies on an irq th=
at
> > > then calls the registerd handler. The iio driver doesn't need to tune
> > > the edge sensitivity though and if your mockup driver just only calls
> > > the fire routine if the configured sensitivity justifies that,
> > > everything should work as expected.
> >
> > Simulating edges in the generic IRQ simulator codes seems
> > generally useful to me, even if there is just one user now.
>
> I cannot imagine another potential user. Which kind of driver could use
> that that is not a gpio simulator?

I suppose anything that can generate an IRQ and wants to generate
some test IRQs where edge matters, drivers/irqchips/?

Regmap IRQ drivers/base/regmap/regmap-irq.c does support
edges, and regmap already expose all registers it handles in
debugfs, so it'd be really neat of you can also use debugfs
to insert IRQs from a device using regmap.

Yours,
Linus Walleij
