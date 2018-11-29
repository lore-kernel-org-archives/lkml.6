Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DAAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC90D20663
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qgZTqvqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC90D20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeK3Fow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 00:44:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45771 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeK3Fov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 00:44:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id b141so2481887oii.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3o/XV/7Qgfz2I/5HYzE6SUWlIujyWkkEJZU7j4BGDX8=;
        b=qgZTqvqKHID23mlYFPSrATE3lAjZ8t9ENyxnn8QFjaeLLjbYQoINA6aboERYwaYPng
         E8SmP+rOPkumPOVtA3KRouVCAni9kFsz7ezP/EPB/A7rgZOa1udAFkvxp4AE4FTLWcQB
         fD1aNSHlPJ2h2h8miuzSL84jdE7A/B02c1OqTyQ2a6vEguzGJJB3U63Dy6auqqVBS5oI
         H1ZDjzUmv9F8h++6g/C/E4DOZB+65aWrMFjrBKgU7o1QMTkxBXRL+zfpCYCVTXFMKMm8
         GpT/x/VocALpYGElUcLpmmirpO0yMozolQvKNbh04SkZ74F5NE5caTgJk53avdl36PqY
         64Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3o/XV/7Qgfz2I/5HYzE6SUWlIujyWkkEJZU7j4BGDX8=;
        b=JJg48cECF9915OvGnVXSr1itSseEKlYNyxh0MVF0IpcrN5XAcsUA1uqYGcHDuUpEOr
         EREn/eHttNBPIUtvIz1cb/K/kghOUQuFJpiz17CpCUNqxTLwom2LD48kkpXNRW7Aj3bd
         FBSBrMgcAw9C/eqiCDOUyxd/F8dCebnzNxwvkIu8SUB2NPBd0Z3J97CA8+aBO4m1ixwc
         CfT7Q/0qZ/WfR/2JUcJBa+ux81iiTiiqRwUvat711S5W8H6wgONx/8XpEYkQk//+VVjg
         96JFfwgpc/tsoRTB8JCPQokZcMBX2aYSg+9MTgIUA2f6iS8q2eQsno2gXMmHDKICEYmG
         Qt1g==
X-Gm-Message-State: AA+aEWb7lJli26p8N+yKPmmZtFTvLJwbIV8lYJYwk74imKBW09QozGMi
        fsusTqV39EdDT7OACQqW+Q/l6b0kA2CONZb7y0kT5A==
X-Google-Smtp-Source: AFSGD/UcMnIMoNHVTlocwZGKTkTJok0FjEBUKGn1/LlZTpf4du+Ku08i/jl0hhXUvjNRIGygWUwggcepnbGCPr8dr2o=
X-Received: by 2002:aca:3785:: with SMTP id e127-v6mr1563478oia.147.1543516712174;
 Thu, 29 Nov 2018 10:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20181128104350.31902-1-linus.walleij@linaro.org>
In-Reply-To: <20181128104350.31902-1-linus.walleij@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 29 Nov 2018 19:38:20 +0100
Message-ID: <CAMpxmJUsAccSKELNxn6DEWO6_3aCbzM=hZyaXUCr30S0-Eh0mA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Regulator ena_gpiod fixups
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ckeepax@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 28 lis 2018 o 11:43 Linus Walleij <linus.walleij@linaro.org> napi=
sa=C5=82(a):
>
> We noticed a refcounting fight between the kernel device
> core devm_* and the regulator core refcounting, pertaining
> to enable GPIOd:s that may be shared between multiple
> regulators.
>
> Fix this with a series that hand it all over to the
> regulator core and remove any devm_* stuff pertaining
> to these GPIOs.
>
> This includes a patch to gpiolib to make gpiod_get_from_node()
> available. Just go ahead and apply this to the regulator
> tree.
>
> If these need to go for fixes or not is up to the
> regulator maintainer, but all commits have a proper
> Fixes: tag in case they would. I have noted in the
> four last commits that the gpiolib patch is a
> prerequisite.
>
> Linus Walleij (10):
>   regulator: fixed: Let core handle GPIO descriptor
>   regulator: lm363x: Let core handle GPIO descriptor
>   regulator: lp8788-ldo: Let core handle GPIO descriptor
>   regulator: max8952: Let core handle GPIO descriptor
>   regulator: max8973: Let core handle GPIO descriptor
>   gpio: Export gpiod_get_from_of_node()
>   regulator: da9211: Let core handle GPIO descriptors
>   regulator: max77686: Let core handle GPIO descriptor
>   regulator: s5m8767: Let core handle GPIO descriptors
>   regulator: tps65090: Let core handle GPIO descriptors
>
>  drivers/gpio/gpiolib.h                 |  6 -----
>  drivers/regulator/da9211-regulator.c   |  4 +--
>  drivers/regulator/fixed.c              |  4 ++-
>  drivers/regulator/lm363x-regulator.c   |  8 ++++--
>  drivers/regulator/lp8788-ldo.c         |  4 ++-
>  drivers/regulator/max77686-regulator.c |  3 +--
>  drivers/regulator/max8952.c            |  8 +++---
>  drivers/regulator/max8973-regulator.c  | 12 ++++++---
>  drivers/regulator/s5m8767.c            | 37 ++++++++++++++++++--------
>  drivers/regulator/tps65090-regulator.c | 10 +++----
>  include/linux/gpio/consumer.h          | 13 +++++++++
>  11 files changed, 72 insertions(+), 37 deletions(-)
>
> --
> 2.19.1
>

I'm wondering if instead of using the non-devm variants of
gpiod_get_*() routines, we shouldn't provide helpers in the regulator
framework that would be named accordingly, for example:
regulator_gpiod_get_optional() etc. even if all they do is call the
relevant gpiolib function. Those helpers could then be documented as
passing the control over GPIO lines over to the regulator subsystem.

The reason for that is that most driver developers will automatically
use devm functions whenever available and having a single non-devm
function without any comment used in a driver normally using devres
looks like a bug. Expect people sending "fixes" in a couple months.

Bart
