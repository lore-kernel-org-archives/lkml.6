Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B958C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74F02410F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 08:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGGLKjSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74F02410F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeGEIFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 04:05:02 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:43572 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753287AbeGEIFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 04:05:00 -0400
Received: by mail-qk0-f169.google.com with SMTP id z74-v6so4015271qkb.10;
        Thu, 05 Jul 2018 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJ/UjRLHd6x/m/6+IjIZMl0x82RXtbtWLukJVMSv9xY=;
        b=IGGLKjSnGp1uMmgKMGRA6CxLEfNVnx98TcMKOQKF7N8r57YfQE265UZ4rzAUuwhCpX
         DpnCsolmKxrHH3NBqsyt0vp5/VSpfcnAt9A3vx1Wwq1ExQfgYvIVprBbiWYGmKKVaLnZ
         1kNnATaiVkqOq1nhsWN7uRHozML/3DxeLFkqTLk0J+KgG3CAo9SGN2Q4KeRzVE1eiiP0
         fduXdNV+0iZQcpU7I8AMZTLLBLC16eSUrzERdXEf8XU99jX4G9NdGIYWB38pSVMvN/Dw
         DvgzEDinQBikJcDRomQe+kzezJgKWNLpYfbDx0+NKCCtveldWE4q4fM8wnBcaQU5iufA
         BhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJ/UjRLHd6x/m/6+IjIZMl0x82RXtbtWLukJVMSv9xY=;
        b=aOWF76zFkvvuESgLqLTHHiikVvVxfoUr8qUbblOcniAVa8WWgbH43aRYeMzVLUSf1/
         0RCagrEr/c8kDHH3puHZRurozNruFod1JpB1tw38suqSqXFsrTmAydVluOGCd4vnHc90
         iQz99xDyJuvVJbOVIfyKaaX74GtQYd3D1TQQO4oa6PQx2qwB7mztleysp1db/J2CRajy
         UBKZsxDT0MpvvRV33wKqAjZmpoWs7WQotLAP8tC1bT/HWFETcphyVxDkIhDTHRR2rfdy
         eGsDFDVCTmJjkgvnW4M/FDejP5ahXjZKiFTxzt7d/HqVyqI2auaiuNn3Hh5tl720FEco
         uaMA==
X-Gm-Message-State: APt69E1KE10vJxVHkrjUC8kpecAE9bLNVv6KQeKfYGRDvDvg7PwqcjtL
        Nl0Ku9G4XMFAW2JjNUJAHy9ngCy3L71OOs6ATgs=
X-Google-Smtp-Source: AAOMgpcmSTSGa14QADGefGG9qEPhGjZPojSnULfdbTyQphMA/yZim6ykkwO5ZAVe75mngl1RD2lGrDzUH/3rOSB0kCA=
X-Received: by 2002:a37:4cd5:: with SMTP id z204-v6mr4229561qka.302.1530777899113;
 Thu, 05 Jul 2018 01:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com> <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 5 Jul 2018 10:04:48 +0200
Message-ID: <CAFqH_531ob=uY7x-SK1tXyRZXdd1qFT+O5pUVnnnJcucC7_fig@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
To:     matti.vaittinen@fi.rohmeurope.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,
Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
dia dj., 5 de jul. 2018 a les 9:46:
>
> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/Kconfig         |  13 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/bd71837.c       | 215 ++++++++++++++++++++++++
>  include/linux/mfd/bd71837.h | 391 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 620 insertions(+)
>  create mode 100644 drivers/mfd/bd71837.c
>  create mode 100644 include/linux/mfd/bd71837.h
>

(snip)

Looks good to me.
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Best Regards,
 Enric
