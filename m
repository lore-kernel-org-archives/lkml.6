Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932707AbeBVOx2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:53:28 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:36596 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbeBVOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:53:26 -0500
X-Google-Smtp-Source: AG47ELtpnLnAcesdEQbIBgEDsk6A3cjiuQc3dT295qap4TPSGFrq3CTnDJVMM6H5h1w5+hE8GCMQafvajTS8Ki18MkE=
MIME-Version: 1.0
In-Reply-To: <20180216191243.129130-1-djkurtz@chromium.org>
References: <20180216191243.129130-1-djkurtz@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:53:25 +0100
Message-ID: <CACRpkdaNcFnwh=77-gYC=NW_boi6h007ViL_cTB2W4nCWr-gTw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl/amd: add get_direction handler
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 8:12 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:

> On boot, gpiochip_add_data() initializes the FLAG_IS_OUT bit in
> desc->flags iff its gpio_chip does not have ->direction_input() handler,
> else it is initialized to 0, which implies the GPIO is an "input".
>
> Later, the sysfs "direction" handler will use gpiod_get_direction() to
> get the current direction, but if no ->get_direction() handler is
> installed, the result will just be the current (initial) value of flags,
> which will always be OUT irregardless of the initial register value.
>
> Add a get_direction() handler to pinctrl-amd to fix this and always
> provide the correct value for direction.
>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Hm, please don't use the sysfs... use the chardev!

Anyways, patch is fine and applied.

Yours,
Linus Walleij
