Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbeEPOUj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:20:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56319 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeEPOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:20:36 -0400
X-Google-Smtp-Source: AB8JxZo4IUSj+xQb4NuEP5Zv5OrmK6jKoYBBtd7ebjXw/axyLg3yv7te+BCiL4jySofsqD9fiDcKhJ2f22EMoSUocQY=
MIME-Version: 1.0
In-Reply-To: <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop> <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
 <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 16:20:35 +0200
Message-ID: <CACRpkda2VGo0FOdR09tKiTpg66NgoWjubaHp_J3372y=a772Zg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl bindings
To: Amelie DELAUNAY <amelie.delaunay@st.com>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 9:56 AM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:

> Indeed, stmfx has other functions than GPIO. But, after comments done
> here: [1] and there: [2], it has been decided to move MFD parent/GPIO
> child drivers into a single PINCTRL/GPIO driver because of the following
> reasons:
> - Other stmfx functions (IDD measurement and TouchScreen controller) are
> not used on any of the boards using an stmfx and supported by Linux, so
> no way to test these functions, and no need to maintain them while they
> are not being used.
> - But, in the case a new board will use more than GPIO function on
> stmfx, the actual implementation allow to easily extract common init
> part of stmfx and put it in an MFD driver.
>
> So I could remove gpio sub-node and put its contents in stmfx node and
> keep single PINCTRL/GPIO driver for the time being.
> Please advise,

I would normally advice to use the right modeling from the start, create
the MFD driver and spawn the devices from there. It is confusing
if the layout of the driver(s) doesn't really match the layout of the
hardware.

I understand that it is a pain to write new MFD drivers to get your
things going and it would be "nice to get this working really quick
now" but in my experience it is better to do it right from the start.

Yours,
Linus Walleij
