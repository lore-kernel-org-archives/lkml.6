Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F0C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0752177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtTyHIRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0752177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeHCTHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:07:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36326 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeHCTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:07:44 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so9378719itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IioGxO/RNsPfTVToAmjK+aiQ0Tjuetj1bIQpmpDnaO8=;
        b=TtTyHIRN/I9tNit/FWsSQVhd4lRPdvd18Jh3caWN3EULVVUsJu9MszmwIEpidMIQ0s
         9+Y3mxAxwKgRb2EK5yzzZWaQbLKs/bNH0/nWesYcADxxk/BlWPiKw0BJwCFDY7BPusSv
         ciGW/rXWLJjjdDAdpACa35uwYnqCsDjxwbqfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IioGxO/RNsPfTVToAmjK+aiQ0Tjuetj1bIQpmpDnaO8=;
        b=CqZt2D9mJjs58Vk6XSHpPjO5qKd0BNcPnkM4BTj+i4Ykd8pBQd6wgg9BwckznKNnZu
         zPGH48XqpTFjJdHH7IkmwTgDPG8eJ/15N6Vrm7GhzNrpiE4VyddCOTLBuJxkKtB9rjD3
         geWJ71F1kGkKDUoyuecYWL4mmlfUSmRLi1wyp+RIOuLIWEKKhFClTCX2MmdkrYei4lVf
         bf1Dxe4Kyoesd2z1Bpex60WGPn8cQtl+rg1UBDVinXnoCJ1Sz641KQIJ0DMAdKXndHk5
         Ds6c5x4JWxIKIlyj341uFfFaUn/jMOkuoYCamW2VCb4kz0rBwmCDCw/PjQbzJ1owAfGy
         umZQ==
X-Gm-Message-State: AOUpUlFZ05w89w0h+bB4oXZpV0z6XEgJxoXbVCvaURjI7N/xo67glj8a
        +tysHziant5z8ymRzdw9Fwyz1zTQGjL0peC5JjfOJg==
X-Google-Smtp-Source: AAOMgpegkKM5gd1OBGDG5K7+aDYT7PjxlHLMhbKl9GUFBdk37JuKifEYx/gpe/8JRCju99J58THJs8WeXjDl1/x6Ks0=
X-Received: by 2002:a02:9d03:: with SMTP id n3-v6mr4020435jak.113.1533316234107;
 Fri, 03 Aug 2018 10:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Aug 2018 19:10:22 +0200
Message-ID: <CACRpkdbSE0ThGpEo2YnVQ7wW85QbAeOwmFpLczHwL3Q2W3ZF6Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl: meson: Add support for TEST_N gpio
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 12:00 PM Neil Armstrong <narmstrong@baylibre.com> wrote:

> The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
> set the TEST_N pin direction.
> This patchset :
> - adds the Secure Monitor call
> - adds support int the pinctrl-meson common code
> - adds support for GXBB, GXL and AGX SoCs

A lot of trouble to access a single GPIO pin (I guess _N means "active low"?)

Is this line used for something especially important? Would be nice to
include in some commit message like patch 1/5 why we invest so much
energy to accessing this pin.

Just curious. If you're just aiming for feature completion, that is a good
reason as well :D

Yours,
Linus Walleij
