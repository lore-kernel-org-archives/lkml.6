Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D142C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84C925D44
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HFDYj4Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84C925D44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeFYPvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:51:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55750 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeFYPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id v16-v6so90630wmv.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9fzHNjiGATqEOUXqqqbwuHzguTrEkvz1GEPFdZZGcwY=;
        b=HFDYj4Zu1sxFJyDrEAbwObqijXKb6F1r8Xn3gvOtyJC1sVldSrWC3rPfHYlAabW92v
         gL305DEAOsIqd4UpNX2qE7hCT9NFt+x0i33x6Wc3JNGhvVOw8BVGyMMx3+XTzWUcw2iU
         r6VzpPPqw6bZQLkRuLTPI5E3izYN6ggwkNjxFApX8w+d8+RNq/Dj6fmsZ+KdF1oBS8Pu
         IRlgjyM9MIWBia2Kw7lm8Wd0ji6jKRbC/Y5vNG4CPXmjIC8bZlROWdi/LmVJoMH3p6F9
         14OHqOVzvDJlyppS1YIa1XEj6aaHsY2QX2YLA6lIGo7Qk2nwwXcrEMq/LXKBrBsz96uY
         ufJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9fzHNjiGATqEOUXqqqbwuHzguTrEkvz1GEPFdZZGcwY=;
        b=iywUN3cNgLXyW0wB1KqhZztBYOxYMS7SxtQkwc6fhP82tq9hhGNV3Qmik5lFEt+9Gk
         jiv7u4OaS0Cs0psMw4dIhXda9sdPE7jrzm1znRTAMSgx6BT8HW7E/s7SO/sJNO1xJVbk
         3NksdPZ3hMo1RveH2zDPXj5KeH68DQaAk5nCV+/XfJYgy8T86nO4HB77DqwKmBT4+gIZ
         uiRkhEa9bGIflQaWo8muaRB2Y0mYJNBN2iof55zAQ1MBtLGTdG5qD4mVPu9NueqHhD0e
         p7v6ZUGzFHYvzb7QA8HjWkIuqQbv2nDB2q+f6gUM8TR/d6ZEFZPxzlRIHCMb4LPZirgj
         1FyQ==
X-Gm-Message-State: APt69E0pTvM8Af53qa5VP97tGWuancqZP0IQPye05p09PuaBC1oztTWo
        vIM9SNrx0fFu9OWa/FzWnV52kA==
X-Google-Smtp-Source: ADUXVKJpJBQYiYTnDw3SabalOm4erQW9ZL13hAFxLDhYiZ3HgPs7/rZ0eusibTj4qSqPUWEN8nrJDA==
X-Received: by 2002:a1c:3610:: with SMTP id d16-v6mr1517092wma.126.1529941877916;
        Mon, 25 Jun 2018 08:51:17 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/14] ARM: davinci: step towards removing at24_platform_data
Date:   Mon, 25 Jun 2018 17:50:11 +0200
Message-Id: <20180625155025.12567-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since I took over maintainership of the at24 driver I've been working
towards removing at24_platform_data in favor for device properties.

DaVinci is the only platform that's still using it - all other users
have already been converted.

One of the obstacles in case of DaVinci is removing the setup() callback
from the pdata struct, the only user of which are some davinci boards.

Most boards use the EEPROM to store the MAC address. This series adds
support for cell lookups to the nvmem framework, registers relevant
cells for all users, converts the davinci_emac driver to using them
and replaces at24_platform_data with device properties.

The only board that's still using this callback is now mityomapl138.
Unfortunately it stores more info in EEPROM than just the MAC address
and will require some more work. Unfortunately I don't have access
to this board so I can't test any actual solutions on a live hardware.

Tested on a dm365-evm board.

Bartosz Golaszewski (14):
  nvmem: add support for cell lookups
  ARM: davinci: dm365-evm: use nvmem lookup for mac address
  ARM: davinci: dm644-evm: use nvmem lookup for mac address
  ARM: davinci: dm646x-evm: use nvmem lookup for mac address
  ARM: davinci: da830-evm: use nvmem lookup for mac address
  ARM: davinci: mityomapl138: add nvmem cells lookup entries
  net: davinci_emac: use nvmem to retrieve the mac address
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom

 arch/arm/mach-davinci/board-da830-evm.c    | 25 +++++++---
 arch/arm/mach-davinci/board-dm365-evm.c    | 25 +++++++---
 arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++++---
 arch/arm/mach-davinci/board-dm646x-evm.c   | 25 +++++++---
 arch/arm/mach-davinci/board-mityomapl138.c | 30 +++++++++---
 arch/arm/mach-davinci/board-sffsdr.c       | 13 +++--
 drivers/net/ethernet/ti/davinci_emac.c     | 29 +++++++----
 drivers/nvmem/core.c                       | 57 +++++++++++++++++++++-
 include/linux/nvmem-consumer.h             |  6 +++
 include/linux/nvmem-provider.h             |  6 +++
 10 files changed, 182 insertions(+), 58 deletions(-)

-- 
2.17.1

