Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932649AbeBVNrn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:47:43 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36382 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932579AbeBVNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:47:40 -0500
X-Google-Smtp-Source: AG47ELsiktiefI9NXB3AQbAzs2jXmtV0wG1nNhm95f2aBrRci/KEKIJAQsGoyG6DyEaATpmblARXUZMlzjGAebcm9tc=
MIME-Version: 1.0
In-Reply-To: <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com> <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 14:47:39 +0100
Message-ID: <CACRpkdaeFXuB1Qv-vqNpf4pHsAysiYh03_gfNoRdHBh1pN_Amw@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: Add GPIO support for the ST Multi-Function eXpander
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> ST Multi-Function eXpander (MFX) can be used as GPIO expander.
> It has 16 fast GPIOs and can have 8 extra alternate GPIOs
> when other MFX features are not enabled.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

As mentioned I think this driver needs to:

- Move to drivers/pinctrl/pinctrl-stmfx.c similar to the sx150x controller.
- Pass a regmap around instead of the custom accessor functions.
- Maybe refactor and reuse STMPE infrastructure

Yours,
Linus Walleij
