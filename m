Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB19920656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZ/2VbWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfANMta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:49:30 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33947 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfANMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:49:29 -0500
Received: by mail-yw1-f68.google.com with SMTP id g75so8548484ywb.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoU2MB9V748XAdgv8g50kB8PjZCqixoPjUfuVZcI3/M=;
        b=jZ/2VbWo5p9+//eQLBwcjubuXDZmmRc/4idHyhx6McQQh2YuV6TTsDEhrYn1n5CGHh
         IUgm+2xWKbY8Ck6biGXWrWOd3R3jrPuajPupz5wS0C0Ey2CcS5oy4/VlQmGyZzv1wxLA
         uGXifypWr4L55+PDfVRCqUXgVchUjP+D6dMX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoU2MB9V748XAdgv8g50kB8PjZCqixoPjUfuVZcI3/M=;
        b=hHAxeaw8TBA/PCAVHpJrp/qIQC4HnL80yJnparvRteZyR8rGL92Q6z56Kgf0pAsKm2
         HRw22ko5Zv7KOCR7GXMA8HQy+ObIk/hinv0VOKaTV0Jr/gXtmpZJZdpgHgNyroC8jVdR
         TtA/4mH/aq+TVG/SEA6jFOEZAq2RjWZaJLtjx+POr0X5PUQOY614YCj8JGMhycBK3yMy
         enX8e94BJCvI2Kse44aefG3uuwkUK2GIJwd/g1RNSwRmp2ADapa4lNes22CMJ7qEKYoS
         SwOuT3GCUYL+Tkj4/ptN4Y/db5d8jVRqPBiMsZie7EfmnU3L5tuZ6+ZZbVOKS9tEs000
         RYeg==
X-Gm-Message-State: AJcUukcEWd95MmFHqHx5nZXMkVTZ7nT0MRBAdkU2D0xCMzgUddUaUGjz
        BEWXddvjpFkJEuIim+joqTTIlae+NX+g1AjStZroAw==
X-Google-Smtp-Source: ALg8bN6xsjHg/OVq7TDrNKQtOOcUNTgQ8J2aOdvYMoJYvd9rVa9czlDbaR8C32wgxTvm+YycyieWKoHdMny2xghsck0=
X-Received: by 2002:a81:2bc2:: with SMTP id r185mr22871377ywr.425.1547470168720;
 Mon, 14 Jan 2019 04:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20190114095540.22956-1-anders.roxell@linaro.org> <20190114112443.GA11073@sirena.org.uk>
In-Reply-To: <20190114112443.GA11073@sirena.org.uk>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 14 Jan 2019 13:49:17 +0100
Message-ID: <CADYN=9LU2fngmUZrM_E7qS7rGB7y4b45H12yZOW=X7JfaS1qqQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: cs4341: fix waring unused-function
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, brian.austin@cirrus.com,
        Paul.Handrigan@cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 at 12:24, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 14, 2019 at 10:55:40AM +0100, Anders Roxell wrote:
> > The driver cs4341 can be built with SPI and/or I2C, but it has to be one
> > of them at least. When I2C is set as a module we see the warning below:
>
> I'm missing patches 2 and 3 of this series and there's no cover letter.
> What's the story with dependencies?

oh, I made a mistake. It Should not be any dependencies, just this patch.

Do you want me to resend it without " 1/3]... " in the subject?

Cheers,
Anders
