Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA65C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B522081C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dM2C4Gd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B522081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbeKOVCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:02:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37847 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387880AbeKOVCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:02:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id e5-v6so16899477lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnvV7j/+nTg+LDaNboxyDZ6ldnjoYJ8B97EViposZH4=;
        b=dM2C4Gd8bjmcVA+aNDUQs940Ok0/FDgGKh1YiJAVWY69sXbZbDxIF5mSKLRHSVRGfM
         qS7aV3hF8AXCVf6o1HQZoIhn8vEEDkmzQBB2abQlsx/ndKbinQ54R6oV6xrkABbb3XRG
         8u/BbxhEVfCyN99E+XUUzDJJ/MnPb79xqqVdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnvV7j/+nTg+LDaNboxyDZ6ldnjoYJ8B97EViposZH4=;
        b=AQPH7Tfup+VF+q19KsSVa8IftWYAN5MNB706BFxthRbrvThCdsK6LKhXlel0FNbBkm
         LKQl18jw5seqmSBNOXQjhT162C8SK9CZBDisDDNWNZaA9TwvLcknjCYm+JFdK/Ui0Y3F
         Y2Kkt1prJua2k32DdH0n/xNmJLtZtKbTC24yNVk99oY7ZwUTyHZsJXpQtZ4vNaPOHvWf
         LJYHkRTXr1iiB7Bai0Q1TFeVtaU12pqx6YCX+cQPhldnvXhs3nh6f+shzm8aHNaQW9Rv
         jogrASIGpX/5KyoaLwvYyz+dDkNlUNrtrlAmb9TkKHuzFQLdiLi0AWRTzGrHSxIxPVHS
         ii0w==
X-Gm-Message-State: AGRZ1gJzthCpDZhPhbXiv1wgAFxh7mEHuEC3/ETxWfIK4/yvCJ4b/cLO
        502/8u96fqZ9xN0L43aG84v+B0ihSB9YNYd0Zfntcw==
X-Google-Smtp-Source: AJdET5da+y1SGDuZQ/Zx6RK4UQtEjmIanlPADfQPdNS+Q0/qBMJ4OXTt1lWiGSCf5gUEOqlT8u1lV5MqIS+1YdlSjGQ=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr3346731ljc.97.1542279300290;
 Thu, 15 Nov 2018 02:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20181108101405.14062-1-ckeepax@opensource.cirrus.com> <20181108101405.14062-7-ckeepax@opensource.cirrus.com>
In-Reply-To: <20181108101405.14062-7-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 11:54:48 +0100
Message-ID: <CACRpkdZCUDsSZA3xAH05ZFuNP8dyHFapX7MJTVnD3A-ts1Y7yA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] pinctrl: lochnagar: Add support for the Cirrus
 Logic Lochnagar
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 11:14 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board.
>
> Lochnagar provides many pins which can generally be used for an
> audio function such as an AIF or a PDM interface, but also as
> GPIOs.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

This v4 version looks very good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Nitpicks (fix or not, my review tag stands):

>  drivers/pinctrl/cirrus/pinctrl-lochnagar.c | 1145 ++++++++++++++++++++++++++++
>  drivers/pinctrl/cirrus/pinctrl-lochnagar.h |  112 +++

Why don't you just include that header file in the C file.
112 lines +/- on a 1145 line file doesn't matter.

> +       priv->gpio_chip = template_chip;

I would just skip the template and just assign struct members
directly.

Bonus if you set ->label to something instance-unique as well.

Yours,
Linus Walleij
