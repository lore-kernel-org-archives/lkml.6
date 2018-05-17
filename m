Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeEQGgr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:36:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46373 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeEQGgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:36:44 -0400
X-Google-Smtp-Source: AB8JxZpKXmDyZ06VoM0rdyx33II7pNG7IytcIWdI00jSqy0dNlKUOSnKzzaUeJy6ckQo8wAex7BNLw==
Date: Thu, 17 May 2018 07:36:40 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Amelie DELAUNAY <amelie.delaunay@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/5] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
Message-ID: <20180517063640.GK5130@dell>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-2-git-send-email-amelie.delaunay@st.com>
 <20180416181940.4b5z4svbde3ompij@rob-hp-laptop>
 <CACRpkdYOMjjYyWQz7PK34jqUK7z5-CmH1HY6un4k8nBn7Cq8ag@mail.gmail.com>
 <55392fe7-20d2-9447-60f9-4bd226b60195@st.com>
 <CACRpkda2VGo0FOdR09tKiTpg66NgoWjubaHp_J3372y=a772Zg@mail.gmail.com>
 <b9005dd8-8214-ceab-0f88-ff1a51b44e34@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9005dd8-8214-ceab-0f88-ff1a51b44e34@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, Amelie DELAUNAY wrote:

> 
> 
> On 05/16/2018 04:20 PM, Linus Walleij wrote:
> > On Wed, May 9, 2018 at 9:56 AM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
> > 
> >> Indeed, stmfx has other functions than GPIO. But, after comments done
> >> here: [1] and there: [2], it has been decided to move MFD parent/GPIO
> >> child drivers into a single PINCTRL/GPIO driver because of the following
> >> reasons:
> >> - Other stmfx functions (IDD measurement and TouchScreen controller) are
> >> not used on any of the boards using an stmfx and supported by Linux, so
> >> no way to test these functions, and no need to maintain them while they
> >> are not being used.
> >> - But, in the case a new board will use more than GPIO function on
> >> stmfx, the actual implementation allow to easily extract common init
> >> part of stmfx and put it in an MFD driver.
> >>
> >> So I could remove gpio sub-node and put its contents in stmfx node and
> >> keep single PINCTRL/GPIO driver for the time being.
> >> Please advise,
> > 
> > I would normally advice to use the right modeling from the start, create
> > the MFD driver and spawn the devices from there. It is confusing
> > if the layout of the driver(s) doesn't really match the layout of the
> > hardware.
> > 
> > I understand that it is a pain to write new MFD drivers to get your
> > things going and it would be "nice to get this working really quick
> > now" but in my experience it is better to do it right from the start.
> > 
> 
> Hi Linus,
> 
> Thanks for your advice. I understand the point.
> So, the right modeling would be to:
> - create an MFD driver with the common init part of stmfx
> - remove all common init part of stmfx-pinctrl driver and keep only all 
> gpio/pinctrl functions.
> 
> I will not develop the other stmfx functions (IDD measurement driver and 
> TouchScreen controller driver) because, as explained ealier, they are 
> not used on any of the boards using an stmfx and supported by Linux, so 
> no way to test these functions, and no need to maintain them while they 
> are not being used.
> 
> Lee, are you OK with that ?

I missed a lot of this conversation I think, but from what I've read,
it sounds fine.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
