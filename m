Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0490AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBC8217C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="La+xD2IF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBC8217C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeFURT3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:19:29 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37390 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeFURT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:19:27 -0400
Received: by mail-it0-f66.google.com with SMTP id l6-v6so5862120iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XBQRB776uneO4M/h/ZOsKlO0T1XJMm6bUpoFwTPt4E8=;
        b=La+xD2IFGqHKANWpLZfI2S0cui9WnCDAKO+x2SACeRNpg5f7s0CeAatRTXTQESZiqy
         lnW3potEtW/Opa2tPTH7MJALPpZQWQUeytCED98TOwJqmz9JFlsHBU+I2n2ju2GnfHi0
         /d5Jb98pvUspdUYx57lAXMCshqEWuPzB2vZHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XBQRB776uneO4M/h/ZOsKlO0T1XJMm6bUpoFwTPt4E8=;
        b=FhkOaOg/oCDvmwcnT7LGYqsZj+SgkCL8AopfPzfinf5Y8+2fzm/IENkhzeqiCQIklr
         Af+zgX7vEQZTDwJt8VDmeoX7VX8CwJOBZV8mwX2dC45Q+LSMpdDB9i1rTFOF/YpP0bw7
         zuWdrtTHqrkPc+ejmdHlHbfUIAvLDdRzk+qqe8Wx+DT11DArdFgn9jGYao15HtvtUEys
         pN2Evv3KQxZWyMMAyjuTCUX1UPBlDy8on3mArL2erwc00Gb3y0iRPoxKL+GZttqIvCjZ
         g5KJR7AGfPoRlrJKEs3QQNpsFMECZpuQYi7Cz5e9rxClMGzQZj7y8IZuMXiwbIU1pYj5
         3FCA==
X-Gm-Message-State: APt69E2QhdTDx7amHeOHFsyMN1XGKTdoLTr1cfE3gI3AQhnIufaxMK1m
        JN6EddXfJ+2VAnEBN2eJ3OIr+EE9HyQ+e4yVfDE75A==
X-Google-Smtp-Source: ADUXVKJllAHPYOML7LvsyD10S6OFnu4x9XWhWBZu37QAgaEsLr76qsbT3oKcS+MG20xaU4PCgoDkAR5CSyzN9qROL7I=
X-Received: by 2002:a02:1d01:: with SMTP id 1-v6mr20833701jaj.113.1529601567256;
 Thu, 21 Jun 2018 10:19:27 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jun 2018 19:19:15 +0200
Message-ID: <CACRpkdZP_WZ1PHWtW1bjAKa8kP08UWyt6WJ7cUxxYpfQooegEg@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v4.18 take one
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some fallout in the pin control subsystem in the first
week after the merge window, some minor fixes so I'd
like to get it to you ASAP.

Please pull it in och glad midsommar!
Linus Walleij

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.18-2

for you to fetch changes up to 5f591543a937310e48baf0ee23680be09cdedfb8:

  pinctrl: mt7622: fix a kernel panic when pio don't work as EINT
controller (2018-06-18 07:55:57 +0200)

----------------------------------------------------------------
Fixes for v4.18:

- Fix a serious kernel panic on the Mediatek driver with
  the external interrupt controller.

- Fix an uninitialized compiler warning in the owl
  (actions) driver.

- Allocation failure in the pinctrl-single driver.

- Pointer overwrite problem in the i.MX driver.

- Fix a small compiler warning.

----------------------------------------------------------------
Colin Ian King (1):
      pinctrl: single: Add allocation failure checking of saved_vals

Fabio Estevam (1):
      pinctrl: devicetree: Fix pctldev pointer overwrite

Geert Uytterhoeven (1):
      pinctrl: actions: Fix uninitialized error in owl_pin_config_set()

Sean Wang (1):
      pinctrl: mt7622: fix a kernel panic when pio don't work as EINT controller

Wei Yongjun (1):
      pinctrl: mediatek: remove redundant return value check of
platform_get_resource()

 drivers/pinctrl/actions/pinctrl-owl.c         |  2 +-
 drivers/pinctrl/devicetree.c                  |  7 +++++--
 drivers/pinctrl/mediatek/pinctrl-mt7622.c     |  6 +++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  5 -----
 drivers/pinctrl/pinctrl-single.c              | 14 +++++++++++---
 5 files changed, 22 insertions(+), 12 deletions(-)
