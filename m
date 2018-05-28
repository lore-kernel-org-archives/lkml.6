Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeE1HrS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:47:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45065 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753668AbeE1HrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:47:16 -0400
X-Google-Smtp-Source: ADUXVKJP+UAIelJDV6aNCGYK+AZj861hzwbWYJIQb45tYWxT2JNfp4/CR0L8gfevVRzxm1edC+oMm127upoj2wLgcKc=
MIME-Version: 1.0
In-Reply-To: <20180525155030.3667352-7-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de> <20180525155030.3667352-7-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 May 2018 09:47:15 +0200
Message-ID: <CACRpkda0bmr-0wyEhgVRjMC_PUNYGQUU993LcBCyj1YfrWxwRw@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/bridge: fix dependency for lvds-encoder
To: Arnd Bergmann <arnd@arndb.de>
Cc: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maciej Purski <m.purski@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 5:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The DRM panel bridge code is built into the kms helpers module, so we
> get a link error when trying to use it from a built-in driver while the
> kms helper is a loadable module:
>
> drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
> lvds-encoder.c:(.text+0x124): undefined reference to `devm_drm_panel_bridge_add'
>
> This adds a the same dependency in the lvds-encoder that we use for all
> the other users of the panel bridge. I did not bisect the problem, but
> from inspection it seems to date back to the patch that separated out
> the panel bridge from lvds encoder.
>
> Fixes: 13dfc0540a57 ("drm/bridge: Refactor out the panel wrapper from the lvds-encoder bridge.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
