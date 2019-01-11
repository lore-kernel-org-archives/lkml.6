Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D808C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8C02133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZqWKruDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbfAKRVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:21:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34320 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbfAKRVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:21:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so16082156wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQntVF2/bk1rgld5/bEFikPpbtRSdjHYK/hVaJqDrb4=;
        b=ZqWKruDoW+J+Ip44e2nSxWkwlREHDU8lp0MVmydauHfccYKIokrxgEujmppFHqUAqC
         y2LJbKl38mKTiAEkFP/Ms5hdV5PCjWUFZDIRrLlyCKV4NQ/+EleIClB90nqytxl12t+Y
         cRtDwe2i4carz3HtxdPU2Wb0l/5HjioMelaBi3MKXXAZvYUlHC1aenarip0bx56vvYmm
         jzvLFLh+dROqM2ulLCZ8KhMwG1uG2XxLO8h1KX7JCSOF6XGD3ICahbxU+QkVyha4vHz5
         jLxdSFpK77Aw70dPcV0tpwe1b8OtxaAn/FbNwqaMSBtwGP+k39+vm39fbwe1xmIeFT79
         BhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQntVF2/bk1rgld5/bEFikPpbtRSdjHYK/hVaJqDrb4=;
        b=XC9qbjHzuXPLpeXaskv1+9cZiBBPT7kWtnn9kiG1dvwpRNjSYn8cPcXUc4fPYo3XL3
         XyuWdsxwjPkHMgWExcEw9iyokVVP1fmmQEWxBGMasdK1NHoAnVifsfbNgECytTuEXLAa
         8NgpwEAkQMs7W9eHl6bHyk2/lejs7UxYZFgASC8Oy9K8uTnqb/sAyLZVA31pHld8HSVE
         HBKHps6klgUwtL5JPHI27Kg08Dh0FPs6vV2NGaMoKxaggHyrL6UGYs6jsySxsfkZv1od
         C8TX8TiERCB0GZSr7mXBz47rn9nG60B7n7h0NoxUtwfsvseAmBeZ//dvD24m0gCzO50P
         6Gww==
X-Gm-Message-State: AJcUukf+m9wym/5ejWlwMm9YBjTqg98Rx6xFpl8HJeG7kx7yafgpErxS
        fZohO7EVazOopU0yMJpqRq+9ub36kghL+Q==
X-Google-Smtp-Source: ALg8bN571A1SecWwIB/aXwjhDOUXWCNsWqPrpJk8vt3h4PZNU1y9RN7dvcG7lEyyGdCi0L0K50SRsw==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr14424248wrb.283.1547227309639;
        Fri, 11 Jan 2019 09:21:49 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 09:21:48 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/17] ARM: davinci: modernize the timer support
Date:   Fri, 11 Jan 2019 18:21:17 +0100
Message-Id: <20190111172134.30147-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series removes the legacy timer code from mach-davinci in favor of
a new clocksource driver it introduces.

The first patch fixes a device tree bug that's been around for a while.
Unfortunately any systems shipped with the buggy device will stop booting
once they switch to the new clocksource driver.

Patch 2 adds a new clocksource driver for davinci.

Patch 3 enables the new driver for device-tree based systems.

Patches 4-9 add a WARN() to the machine code of all davinci boards
which is triggered if clk_get() for the timer clock fails. This is needed
as the new driver expects the clock to be functional and doesn't check it.

Patches 10-11 and 13-16 switch the board files to using the new
clocksource driver while patch 12 moves some necessary defines to
a different place since we'll be removing the file that contains them.

Patch 17 removes legacy timer code.

Bartosz Golaszewski (17):
  ARM: dts: da850: fix interrupt numbers for clocksource
  clocksource: davinci-timer: new driver
  ARM: davinci: enable the clocksource driver for DT mode
  ARM: davinci: da850: WARN() if clk_get() fails
  ARM: davinci: da830: WARN() if clk_get() fails
  ARM: davinci: dm355: WARN() if clk_get() fails
  ARM: davinci: dm365: WARN() if clk_get() fails
  ARM: davinci: dm644x: WARN() if clk_get() fails
  ARM: davinci: dm646x: WARN() if clk_get() fails
  ARM: davinci: da850: switch to using the clocksource driver
  ARM: davinci: da830: switch to using the clocksource driver
  ARM: davinci: move timer definitions to davinci.h
  ARM: davinci: dm355: switch to using the clocksource driver
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: dm644x: switch to using the clocksource driver
  ARM: davinci: dm646x: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/Kconfig                            |   1 +
 arch/arm/boot/dts/da850.dtsi                |   2 +-
 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/da830.c               |  57 +--
 arch/arm/mach-davinci/da850.c               |  57 ++-
 arch/arm/mach-davinci/davinci.h             |   3 +
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm355.c               |  37 +-
 arch/arm/mach-davinci/dm365.c               |  31 +-
 arch/arm/mach-davinci/dm644x.c              |  37 +-
 arch/arm/mach-davinci/dm646x.c              |  37 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  35 --
 arch/arm/mach-davinci/time.c                | 414 -------------------
 drivers/clocksource/Kconfig                 |   5 +
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-davinci.c         | 415 ++++++++++++++++++++
 include/clocksource/timer-davinci.h         |  35 ++
 19 files changed, 611 insertions(+), 596 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.19.1

