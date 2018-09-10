Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD5BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181942086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NFQ/FLY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181942086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeIJNQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:16:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55411 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbeIJNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:16:57 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so28426344itj.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LZsdE3pMK2CgErmhYhxeMl7wRFqp2pzZraX4jaC3V38=;
        b=NFQ/FLY+p/dV9kbB5kmtizYjxFya5hkYTzVnUeRGMacpxIWO5+3d/QQXfYerV9Bl+O
         aHM9o5B10GR0fqtWljy+CTA9lwczePp4yS5G1zNnBG1w1bnt4Ksv10DcTpKcx1+Pze++
         2/3VMwRSv+LsBG0NsCuMY8Q+RxdKmIF+SDmzkGxxVVqO0uRY5ZwOGhLXDCmiF25/Awn2
         HK0x6QyGvR+ErB7mZtivDS6uQIfpJd1zeRGN0hZBVpBudyep+f0AnUv8NcbntM8GX4+t
         VuQUiFtv/c+U/k7eh5AKu/DkKn1iogCIzJB5Cz95yKbEiswFyoK/1nLCYqLp2KmJzvDZ
         ebBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LZsdE3pMK2CgErmhYhxeMl7wRFqp2pzZraX4jaC3V38=;
        b=Af6PnVRu+KwLX5lFG+VO7IGw+Ff5vVRoVBW+ppZOeAnCfEBQoyCPq9sk9Qg3Zj3xTm
         EcpSPC7Oqe/mY0+ba62bm8VT/x2Bu3yH4LFOwk07rErfZQKRdOVsihCfUkt+EVko59Eb
         jyeoHaiWdVT79Gli2uS6BCMpY0FMmT7qOygxqdGU2C9AekGI5uHk/XaXQyrgevLj1Teg
         jsjLmOwufZ5ikGDwEaVZ52PimCO7OxH6Dwu3x+AyljkrXP5t7KlOIiQaKe/YaFEXtCOK
         1H1Mx6cgTQ2GP3S0PasfzHp5fQkwyAm+RrA0ulnCE4eojkbK2cTCwtt+EVwvGjigy8A2
         HyOg==
X-Gm-Message-State: APzg51CWo/Sn4XLh/mqNlEov3b7sgVmGbrHHII2zLiS9NRDXdP1+8v9M
        F+PYommds4DuSSxSH8VfNEQ1/tYlw5IyUc9T6j+3CQ==
X-Google-Smtp-Source: ANB0Vdao5kQjGLxpp2ZzwOtVdhKwUmkjGbV0JpN4NH43yUOu0CJsJHOyYuX1FoTv5UGKSi1dP1QsngJQS5PeSFJaS9o=
X-Received: by 2002:a24:41cd:: with SMTP id b74-v6mr16261634itd.85.1536567845368;
 Mon, 10 Sep 2018 01:24:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 01:24:04
 -0700 (PDT)
In-Reply-To: <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
References: <20180907100750.14564-1-brgl@bgdev.pl> <da9556fd-0022-8e6a-12b4-cc3babbae5b0@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Sep 2018 10:24:04 +0200
Message-ID: <CAMRc=MeT7UP57x+Q-a1ODRCvcGKKj_NSfkBLVQ9O5dhTC1DAYg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] nvmem: rework of the subsystem for non-DT users
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-10 9:54 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 07/09/18 11:07, Bartosz Golaszewski wrote:
>>
>> Next three patches improve the framework by adding a notifier chain
>> for future use and fixing the issue with nvmem device names.
>>
>> Finally we add support for cell definitions, cell lookups and make
>> DT systems resolve the nvmem cells during provider's registration.
>>
>> Last patches just use the SPDX license identifiers and make the
>> naming convention for some arguments more consistent.
>
> Please send separate series for fixes and things that do not depend on this
> new apis or Order/place them at the end of the series.
>

The API changes change so many things, that these series would be
incompatible. I can send the series separately but they would be
co-dependent anyway. Does it sound good?

Bart

> This can help reviewer when there is large number of patches in series with
> unrelated subject.
>
> -s-rini
>
>
