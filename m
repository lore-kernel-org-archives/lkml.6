Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbeBVOq6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:46:58 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35028 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeBVOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:46:56 -0500
X-Google-Smtp-Source: AH8x227L9s2OxuLjeETvbyV+CrFsl/VzvTiSC4a6rLid/EMtETe9V1AcHdoHCWD55sP1pom/IIycfjvp9y7kRmVjceM=
MIME-Version: 1.0
In-Reply-To: <20180214155512.17218-1-ckeepax@opensource.cirrus.com>
References: <20180214155512.17218-1-ckeepax@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:46:55 +0100
Message-ID: <CACRpkda3Tc0U_UJAyu-Jhja3E8xg2FRcswcxe2hMofrrXLTAEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: arizona: Update reset pin to use GPIOD
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 4:55 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Now GPIOD has support for both pdata systems and for non-standard DT
> bindings the Arizona reset GPIO can be converted to use it.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
(...)
> +       pdata->reset = devm_gpiod_get_from_of_node(arizona->dev,
> +                                                  arizona->dev->of_node,
> +                                                  "wlf,reset", 0,
> +                                                  GPIOD_OUT_LOW,
> +                                                  "arizona /RESET");

It seems this call is really useful.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Also thanks for testing this API, I had nothing to test it on...

Yours,
Linus Walleij
