Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC1FC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7FA2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 00:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GapDKGtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeLPAQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 19:16:15 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33520 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeLPAQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 19:16:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so8007374ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xowB4fO2ulejTfd/hVWncQjFixfhCvws4woiTLenw2I=;
        b=GapDKGtDAKjLVGvkcLYvNGvI10+PZ3hawP/uMtdBfHRpd2qW0VMZ6M/kwRxSZ/TmuT
         zYVXBbc4CZ0HuXdVoFhPuW9ZS/TyYB9IhaPUohKPY4xObr+kgCPPT3gBujECY+7y3R/5
         6affQfw4XpaksxwxrtMTAZi4GC1a2aBhH3nyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xowB4fO2ulejTfd/hVWncQjFixfhCvws4woiTLenw2I=;
        b=dATSaGAed7kWAVdJLzn+u3b3ArTOgFzIvcZBapnXnAFaLyVT5Dyg9JgjbJm7/+FeM1
         nVfP2Q168IjemxiFL7QyGxyIYRBNSS+uULAq4XpCtkp0hJ5ofRv2sAIjnkozXTlwxgpQ
         TnvoyRf2vTBeXRV3ZRS+9XzgkEQ6IvezXv29QoJhXJWZQw6KPtxqR4RL6gpi7jEVj7Vs
         FwTTlHO1JxCm+Z9AsIYLx+cEB4BhzVhIsgtZd9tgB3N1W0M9/G4yN0btmCktmIolEgbS
         XHnvRTih0XuzQK1KUhjUC/lBnFMj91yYT4njMtBwsBjMRHKZjNX0wVoTU7LnQ6N6COhG
         xuAg==
X-Gm-Message-State: AA+aEWapZVCf/LU5lVxEUjvDvoixwdUX+aJiwKcGd9XbWfoxHMkGZ5n7
        sD8HmymZkRiw0SrZoQP/SmIiFWrpoWVoWyQFhiPfoA==
X-Google-Smtp-Source: AFSGD/VFpcwYveA7OjmMz4CuZc0i9nUUNnXap7UWXfaqvi0aI8bOfQLB4ucPAFVTaop5KKqiv+r/Bj72Q/kw5s/8xYE=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr4618278ljc.97.1544919372414;
 Sat, 15 Dec 2018 16:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com> <20181120141631.18949-4-ckeepax@opensource.cirrus.com>
In-Reply-To: <20181120141631.18949-4-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 16 Dec 2018 01:16:00 +0100
Message-ID: <CACRpkda2cmCurkAeTH0dwaHGOaDZRFC_XDV_qkgRz5M1kdr=tA@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] pinctrl: lochnagar: Add initial binding documentation
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

On Tue, Nov 20, 2018 at 3:16 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
