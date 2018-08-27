Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2348C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5EA208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vep4fpyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5EA208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeH0Mws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:52:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45382 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Mwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:52:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so12867160wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FO7FMbrtfMqdHJ6Aa/FlTJik4rEECSu2f9rT43E7Y5c=;
        b=Vep4fpyd/Fo7boOazGFtj1g7dpct81cooFUQZ1Etq2JzjUJaqodqAvqsAnYfBZoY18
         qHavj12qPpmt4JKa27hVpU1oqPHyHWKt/HKA4RwP47z/E2NOpy63zIuv8F4sagYIEN+e
         oOmYVvJgfybG0ThOjCfR1ofttTO5KozBx+JV1y5vsSDJoGllUsEyQEyWgKZkYKCo3YGP
         fvy9mBBJO4UYTFlD5z46I2Les5wcq9PAHxFg+G2ocCcpOZb1Oz6vIbRyq0XvyXPnTY/y
         dNBDre+LGCuDfCJEORtxDgtf7kKc5PEqH1+UpvVdWF/lUfPr3imHLAdi53/e1+ILSmtO
         Ptjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FO7FMbrtfMqdHJ6Aa/FlTJik4rEECSu2f9rT43E7Y5c=;
        b=HORKwey2rhHFRaWx0bdu0+/c991yQYancV8OWtetidoYQYzZwx6cQeXgQ1YSwlZHxT
         22GE0bL9aArebwjjyxFfuYrnSNxN/MupvCyRaMZChrQxN3eHiugfn7YjAfOP0By1/UcH
         ZumlojQx8HbcnziUHhGDMUmNFizXUKyChA2QYj6nnVUxQU5DJ2F2WtpXMyKUXX8BBWuj
         hcicJtt83fHo7y+9tJLdWjFv5rnqmvUwlUPg7Bk3h3KRck22a3+yNK21+rwgV63yAFlb
         CH3OTtX6/H71B72FyiZ608wINTdLYQFexyfEqSrNATAqmnSP2uEpWix74g/yj8wz0Hx3
         c2Gg==
X-Gm-Message-State: APzg51AQ0M8yrNDJbp2UKyO1T3DYCdEeycqxtjssHscGhxSJsONjgKS3
        b4dq2F/IiM1u+nwfM+Qh72KG9g==
X-Google-Smtp-Source: ANB0VdZ2aZZrisRiOVV1eP3Ec5SunyM06Wa2wsJEGdA0NCTlXqnfIGFjJyiIZbkMkmq5X/VxAE0YvA==
X-Received: by 2002:adf:f7c4:: with SMTP id a4-v6mr8473324wrq.86.1535360818623;
        Mon, 27 Aug 2018 02:06:58 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-34-229.w90-86.abo.wanadoo.fr. [90.86.153.229])
        by smtp.gmail.com with ESMTPSA id j6-v6sm11470979wru.64.2018.08.27.02.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 02:06:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v3 0/3] sh: make early_platform code SuperH-specific
Date:   Mon, 27 Aug 2018 11:06:48 +0200
Message-Id: <20180827090651.25062-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently started a discussion about the need for a proper early device
probing mechanism[1]. One that would be based on real platform drivers
and support both platform data and device tree.

While we're far from reaching any consensus on the implementation, Arnd
suggested that I start off by moving the SuperH-specific early platform
drivers implementation to arch/sh[2].

This series is the first attempt at making way for a new, less hacky
implementation.

The first patch removes the last instance of a non-sh driver using the
early_platform API. It can be removed since ARM no longer probes early
drivers.

The second patch moves all the early_platform code to arch/sh.

The last patch prefixes all early_platform symbols with 'sh_'.

[1] https://lkml.org/lkml/2018/4/26/657
[2] https://lkml.org/lkml/2018/4/27/239

v1 -> v2:
- certain drivers are compiled for arm/mach-shmobile too - we need to
  add ifdefs for CONFIG_SUPERH around early_platform calls

v2 -> v3:
- added a stub for is_early_platform_device() which always returns false
  on non-SuperH architectures

RESEND: rebased on top of v4.18-rc1 and verified that there are no build
failures.

RESEND AGAIN: rebased on top of v4.19-rc1 and verified builds again.

Bartosz Golaszewski (3):
  clocksource: timer-ti-dm: remove the early platform driver
    registration
  platform: move the early platform device support to arch/sh
  sh: add the sh_ prefix to early platform symbols

 arch/sh/drivers/Makefile               |   2 +-
 arch/sh/drivers/platform_early.c       | 347 +++++++++++++++++++++++++
 arch/sh/include/asm/platform_early.h   |  61 +++++
 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c |   3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh3.c     |   1 +
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |   3 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   3 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   9 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   3 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   3 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |   3 +-
 arch/sh/kernel/setup.c                 |   3 +-
 arch/sh/kernel/time.c                  |   5 +-
 drivers/base/platform.c                | 288 --------------------
 drivers/clocksource/sh_cmt.c           |  13 +-
 drivers/clocksource/sh_mtu2.c          |  13 +-
 drivers/clocksource/sh_tmu.c           |  14 +-
 drivers/clocksource/timer-ti-dm.c      |   1 -
 drivers/tty/serial/sh-sci.c            |  11 +-
 include/linux/platform_device.h        |  64 +----
 41 files changed, 525 insertions(+), 388 deletions(-)
 create mode 100644 arch/sh/drivers/platform_early.c
 create mode 100644 arch/sh/include/asm/platform_early.h

-- 
2.18.0

