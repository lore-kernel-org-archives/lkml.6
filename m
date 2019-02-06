Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E118EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93FA2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXuZpr2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfBFIJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:09:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42066 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFIJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:09:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so5187113lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 00:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gOX1SsouACCPf08YjbmYPW5UOhkdAMvK3qlQKiv1d90=;
        b=PXuZpr2NmwOfv77mOyOxxwUFls8tIM9qlDFd33QHru6dsHhKGLDahUyJQ8X1N5fq40
         RoK9TTamwmReup4UWa8JjXQO1PKNEisiWbxklTxWoxlNxF3zmXV0WWYgstMedpJpJ8Ce
         K2utHPc15FwEaXNCSFWkbg/t/CJmlumVyMsbGnTPs6qdw7gMZcFtZqF73aT+mtlpqq6C
         NTyhXTixxRJv7RdEWS0vH2dp8TYxoRH6+dmJaipmBQholV8IRflC/gEonAfHBmiyEB7Z
         DfCqvjNNqZYitHjuzc8TaicP7YOKdqZzMuoXZYmAIFbBAZosKNqui/B5vLtJxCU1o57K
         UIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gOX1SsouACCPf08YjbmYPW5UOhkdAMvK3qlQKiv1d90=;
        b=Y16YtPWaFuHMC35IlvF6GeRNai/zKA0ZgistU5yQoNm09Jz4v1IbSFYlcAvwJdV6fv
         99mT1uN2qBFEK/bgDXkzeh2slE8mmun3l/zwcxmvfzJ4lK7Ltky6ti+DBPbbGEXjAfIS
         ScgzmYrs0m+MPiQEM9Hu1E26YD0Yk/f74YsaKafufnkopRNfrF7p0weojotHHQtzucVZ
         mLKCQk4VAtbmkxYUGUUl33noIlrZmM5/tK4istn9K+mZgp5ZTk5+lvIONIj4R60KFHbW
         d85nqeZmIfRkqMkIAZa9XdDDrpwI6bZFN2E0fvkjhStH10ZG+cVVYqB/+byb5b7Nd29w
         L49Q==
X-Gm-Message-State: AHQUAuZS8MJ5XwdSAgKwXFZWQprQwzGgc8lb8IllsC5sWrj+qXvMvSBe
        4zPFO8GjBLu1YOT5woHKpowHi8WTL/NrvQv5GUvtTw==
X-Google-Smtp-Source: AHgI3IbCEkzbE7L0yrWtheCdQ4b0VGN5aeom4hRfjJXymqlyIgCDas/3KlJ2Rh0fwM9+2iVIkOEX3zA9sLqWHP1aFGk=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr5576392ljh.135.1549440590149;
 Wed, 06 Feb 2019 00:09:50 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 Feb 2019 09:09:39 +0100
Message-ID: <CACRpkdYfCT9eBfrKZBA_Do3PcCwvTCX9odD1uHDyZQKdJ4KsNg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v5.0-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jason Kridner <jdk@ti.com>, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are some overdue pin control fixes for the v5.0
series. Was too busy to send them until now.

Please pull them in!

Yours,
Linus Walleij

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v5.0-2

for you to fetch changes up to 10098709b4ee6f6f19f25ba81d9c6f83518c584c:

  pinctrl: sunxi: Correct number of IRQ banks on H6 main pin
controller (2019-01-22 10:52:39 +0100)

----------------------------------------------------------------
Pin control fixes for the v5.0 series:
- Mediatek Kconfig fix
- Sunxi regulator, IRQ banks and pin base fixup
- Intel Cherryview Strago DMI workaround
- Potential regmap problem on mcp23s08

----------------------------------------------------------------
Chen-Yu Tsai (3):
      pinctrl: sunxi: Fix and simplify pin bank regulator handling
      pinctrl: sunxi: Consider pin_base when calculating regulator array index
      pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller

Dmitry Torokhov (1):
      pinctrl: cherryview: fix Strago DMI workaround

Jason Kridner (1):
      pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18

Ryder Lee (1):
      pinctrl: mediatek: fix Kconfig build errors for moore core

 drivers/pinctrl/intel/pinctrl-cherryview.c |  8 +++---
 drivers/pinctrl/mediatek/Kconfig           |  3 ++
 drivers/pinctrl/pinctrl-mcp23s08.c         |  7 ++++-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c  |  2 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c      | 44 +++++++++++++++---------------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h      |  2 +-
 6 files changed, 37 insertions(+), 29 deletions(-)
