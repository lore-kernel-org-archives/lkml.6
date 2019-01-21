Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32867C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1B820663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ii1bXH7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfAUMGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:06:41 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36928 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfAUMGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:06:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so15324301lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 04:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nejV7NVLntZggAVKsrlOYA7PJcD6BNGfK4isgBUG2oA=;
        b=Ii1bXH7RTvhuPc7FX6EO04KW6qge8RObqs/qqI/IYswemt/FdI8Zfc6AXV9UJnK4zT
         pb5MQ7oTb92o55KiDdh0T8OZV2mRHf+mHz9BnWlJyieCG+eYpXZKcberBbaRdmqNyrBA
         vmr9rX7ZgDzk2m+g1hD+R+gnPAC5qtTO1IIbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nejV7NVLntZggAVKsrlOYA7PJcD6BNGfK4isgBUG2oA=;
        b=TuEq0fPkixVZd2SD6Gg1YJRlEKIIz521NrggCJwTugbgSNd9JUMvFZE8PXlanJEvPa
         Sn1Gxh0tFMXRfbySeu0KqLIbG1FG4T1gPvuF8c7qaYeN6nm86FCRc1BQ9aXevdJ94NZz
         Dm7hdKG3oS928yb+RFU22W+MKSpVSId3/c7v9kRtRP59ZYYDWiFvAtgFxJ1J+5whliEb
         xYYB+9vMbUnQMIfRNHpnc+rBSLUGcBiZ4zKnMEnkCmCi1UeUug2dOsYvanICjGOL0BuQ
         SiV3IuvoWkOcZ7ns99gaB3pgKgDy5nrjGboxsnm6Fxy/74mUWKkWhkxv19ClL0dgStux
         uJMA==
X-Gm-Message-State: AJcUukezRupOsZdo1tgWvXYpVhKNotdRl+vRLNPvoqqzDcBFMiLJgEW/
        31JSZtIhCmCuHuuoyAjI3mYLHttcdSGbSIWeWTUwUQ==
X-Google-Smtp-Source: ALg8bN6FOh+kW4rJidXb2D5CHgOD/Umxd+PqomWJdBPXx9NP96gvPnJ6HS5tAas1WnFjrtlXw2iAWpIS3xwQzy8zpz8=
X-Received: by 2002:a19:f813:: with SMTP id a19mr17526537lff.67.1548072399368;
 Mon, 21 Jan 2019 04:06:39 -0800 (PST)
MIME-Version: 1.0
References: <20190115033836.GA150475@dtor-ws>
In-Reply-To: <20190115033836.GA150475@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Jan 2019 13:06:27 +0100
Message-ID: <CACRpkda8yBg=jqn+YJq_M8MTCAH8EkLuFbVi6mkUmxCf5B6m8g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: fix Strago DMI workaround
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 4:38 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Well, hopefully 3rd time is a charm. We tried making that check
> DMI_BIOS_VERSION and DMI_BOARD_VERSION, but the real one is
> DMI_PRODUCT_VERSION.
>
> Fixes: 86c5dd6860a6 ("pinctrl: cherryview: limit Strago DMI workarounds to version 1.0")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1631930
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied for fixes with the ACKs!

Yours,
Linus Walleij
