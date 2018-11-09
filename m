Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF6F20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QniO/dW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF6F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeKITwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:52:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41493 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKITwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:52:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so909327lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pEDAAVD8Zif85a2dkw2aoDDIusre2/X3TyFpFT5Vg1c=;
        b=QniO/dW7Ri982d9KXTSTfqgOwbC7q+tZ9SYvtIEgT+VPScjh+MHgSUSblVY9prDy8c
         S/nxyhwwKWNzlxXcQLu6I07Ef5pZ+aghJ3qRNJ+B7eNS4n0w0Tr4r9rrZdnN8RQ2zpOK
         gvRMM+NiDrmYNYjxXtLMAmE6S1SoQ05tQzJMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pEDAAVD8Zif85a2dkw2aoDDIusre2/X3TyFpFT5Vg1c=;
        b=IBv0uVnrvBp8BKC6Qn6ylLHodpfeSLCcaFuBBWHyHttv6j5Ji3aHqvBQ8h6pNCj7fX
         pyrTbcd+Yaj3oOKIBZOWo2mlhNo7P5f+KGWVsto8frYSD8DVq9rh70jgmKetOJpg6lEp
         pWc1WzhGn9N6o6d59pYOWUSfaPt6Oeg85ZAoj5hPM5kjj4aEGvDl5afDuYVWAkyv7Uqf
         I1OPj1K1KPnJ3i1NfOV+G8doExLZVBg0qP0AgdIjRssi5fBdN6N+x7M/k9R4xD7RuFP0
         6c8PB02zK2ynD46q/ACv71OH2GR0HtRPp/TtO0o+EQiMabj/a0rT5MXoBR8vBFcmnADS
         tlug==
X-Gm-Message-State: AGRZ1gJHBmCoDfbKs7Mo7UxXT9qrF62/eYWyyQVwQ+xJVWvgsbEe3Ikh
        33kkOzbQZICsRs/ggGnmht900DRf6IA2EQqKzRJZ+NCeKSE=
X-Google-Smtp-Source: AJdET5fnVJ3oVn6cL+NRKHJoCIVgYnM2RTbuIiaFyqSTpvvaO3lff/SSbvCZgHt1yfdy7YubZzdTRjpYqM40A6og3WE=
X-Received: by 2002:a19:5154:: with SMTP id f81mr5125813lfb.96.1541758379274;
 Fri, 09 Nov 2018 02:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20181102103539.6077-1-marek.behun@nic.cz> <20181102103539.6077-3-marek.behun@nic.cz>
In-Reply-To: <20181102103539.6077-3-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 11:12:47 +0100
Message-ID: <CACRpkdbLQX3ZcuJE_CMxtnJ37f2f=BWHuf0wa1PG6if3-4DSow@mail.gmail.com>
Subject: Re: [PATCH v2 bus+gpio 3/4] drivers: gpio: Add support for GPIOs over
 Moxtet bus
To:     marek.behun@nic.cz
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:35 AM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote=
:

> This adds support for interpreting the input and output bits of one
> device on Moxtet bus as GPIOs.
> This is needed for example by the SFP cage module of Turris Mox.
>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

Overall looks fine, it's OK like this just adding some nitpicking:

> +static const struct moxtet_gpio_desc descs[] =3D {
> +       [TURRIS_MOX_MODULE_SFP] =3D {
> +               .in_mask =3D 0x7,
> +               .out_mask =3D 0x30,
> +       },
> +};

You can actually use things like:

.in_mask =3D GENMASK(3,0);

ton indicate exactly which bits you hit, but maybe it is overkill.
(No big deal.)

> +       return (ret & BIT(offset)) ? 1 : 0;

I would usually just clamp like this:

return !!(red & BIT(offset));

> +static int moxtet_gpio_get_direction(struct gpio_chip *gc, unsigned int =
offset)
> +{
> +       struct moxtet_gpio_chip *chip =3D gpiochip_get_data(gc);
> +
> +       if (chip->desc->in_mask & BIT(offset))
> +               return 1;
> +       else if (chip->desc->out_mask & BIT(offset))
> +               return 0;
> +       else
> +               return -EINVAL;

Maybe insert a comment here that a line is hard wired
as either input or output.

Anyways:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
