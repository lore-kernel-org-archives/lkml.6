Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1F1C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1783E20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="X3tVoli+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1783E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbeKTAoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:44:05 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42456 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbeKTAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:44:04 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so342472ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=newS4ul37ytGF9gG5STvIGtY/FOy/vjor97NqlDBHZ0=;
        b=X3tVoli+a2TKuOiLQzVwfja06SKl9U3W4nIiqVjDOeF+cE/aR7vQ/g5Zp8WntLMXok
         i4HXrA45AF0ikO+scIL5QV77UqhZ0TkAdPkSxOVoWvGirriKEiyABuqnW0UZNCVaH49B
         wNemU8EZ4LcaUD6qa1iGT6Wmm0XBd62ZRFiwh2XETgJdfcpBIqMStW0vUy2cNCjSBopa
         qYcY+d48p3Bm1YEsKOa6MWuIyN7Q2yzMehi0O1ItyjJ74CtJ04lvBoCId8Tnw8pJM3ng
         BrKHionoFhVoWYjHJZRyviR5JyVUIJR4aRSu4LIB2MIY6oJGp1UUiGQY/gqoKaVy53k4
         bE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=newS4ul37ytGF9gG5STvIGtY/FOy/vjor97NqlDBHZ0=;
        b=ssa1BOIP5ftNnUtLt0hAoP0zevbyRcWVo1BCkhKUMt1EiLhfB+OFJkWuVTToyZ1kA/
         NynYH1A48UbIBr3sY4nyPkKoS+YR7/3hdghMvosEw15IjNcnGEl/ZxNEII0E8UCTHYW/
         eBgJvTRAANWK4ZcP25yuES2Fq0tTv+RYje9wWb6FE+e7fJ9n9G+v2s744AezzBKuIVCB
         l55+/L38TPOXfxXVzwQlPOqdvaSi1WTSexN5uO1e0hcTRFLJMTLnl3qq3tM3CH7DGvia
         wjTqth1nvMTA8cCUsoF6tutpXgRIxHmuEWbRrzVICxtwE+eegmWE8HqrewjhAvONxOlu
         wdgw==
X-Gm-Message-State: AA+aEWaIuaXAk1NKQUNN8n0T7kMfpJhIvFOs7485OJjL22kHlt4iw0KX
        B4E/evrT9VRJF1qywRdkwrHHwnlwxa8ApGl03uS5sw==
X-Google-Smtp-Source: AFSGD/X4zNlLNaD+9Lf0IlmnWj1Vn6CC1UWKg4NcbraT3jG+oQcSdRF7nFy7+79nu661m1fBEByqQolGVJRJPRmRCaQ=
X-Received: by 2002:a5e:9e0a:: with SMTP id i10-v6mr18770520ioq.111.1542637218198;
 Mon, 19 Nov 2018 06:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20181113135051.15308-1-brgl@bgdev.pl> <20181113135051.15308-3-brgl@bgdev.pl>
 <CACRpkdZkZeVSi3O1AR-uZFcBEwp6BN95UxkgKHZz3FJbOHS3mw@mail.gmail.com>
In-Reply-To: <CACRpkdZkZeVSi3O1AR-uZFcBEwp6BN95UxkgKHZz3FJbOHS3mw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Nov 2018 15:20:07 +0100
Message-ID: <CAMRc=MfxjhRB5mYcqB82aJfP0+qXNGqBsa8bzV6eCKfGggcpZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: davinci: restore a way to manually specify the
 GPIO base
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 19 lis 2018 o 14:19 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Tue, Nov 13, 2018 at 2:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
> > automatic base selection") broke the network support in legacy boot
> > mode for da850-evm since we can no longer request the MDIO clock GPIO.
> >
> > Other boards may be broken too, which I haven't tested.
> >
> > The problem is in the fact that most board files still use the legacy
> > GPIO API where lines are requested by numbers rather than descriptors.
> >
> > While this should be fixed eventually, in order to unbreak the board
> > for now - provide a way to manually specify the GPIO base in platform
> > data.
> >
> > Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automat=
ic base selection")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I guess this will be merged throug ARM SoC?
>

Yes, if Sekhar's fine with that.

Bart
