Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F8AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFE121852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cowrJJsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfBZMHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:07:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfBZMHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so13683017wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEQVTIPbAqJ0YmXHUFQn+jdXrnAfnHEV14C7AUBnqIA=;
        b=cowrJJsDDelXsLlhBRPmUPbMwENlxN2SrTo6msvTYZMdt2A5GTW/T2/EhoEbO7Y1GX
         3T5iNhkSS1Bo3vqaAVJ73mcCMDK4YPt7ba+I+2noatexMKnRmAyS6P0gWyieo2op+Q40
         x4BE8270IXpCnI628gPwnG2iB7CETE0VZ3Nbma82N6Ih+QT2TieffAe8eph10tIOYFUk
         c8bCJOHQIwlJmqYSwtHT6qm4NeJHfjn1mFEhkJnooZgpp39QqvAGJamvnRSpmMpy2JjU
         Xr3F8l0vUKoJ8UNA6r34t9RuKPbastbQwuCkLYN3VMPE3+SB+GGL1qtHrKJqfrUx39dY
         IWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FEQVTIPbAqJ0YmXHUFQn+jdXrnAfnHEV14C7AUBnqIA=;
        b=W1JxZJ07EubSS/c8juxJGmm4r2lS1mw4kCz+pvU7dFeV7VO5yhsPyNHqAK+ViI06tO
         WPrj7uO+JORQhvmqs4W0oxLrmaFOEs+EepsLaZ5L/1is/DzT6z6y07EsH9Y0ruz7w4ZG
         JI+MiJV7wHALaPP9fotL5x1xKYWdru0ad6K/7N3NAmhfzveoCuM+RwTDe5LXlzE2gonQ
         wE+Bi751aJqfSfCn5Db/8lRvrkoCfglcg12OhjxGrRXUKCW7ISH28l0HmpL39hUaQagS
         Ol+J9ptbPkrZvjpBFuwxNIRfE3bvTuXyMyap7WdJEgmqIZTE3qokhU0WkVt6Lpy439Cu
         XHRg==
X-Gm-Message-State: AHQUAuZx3KHy2HcsZvUTan8lfz6Fs+lI32TeOaPAZRc8FYMIAbZ7a4+u
        khIohQJL+PCgqeFvWzBxduUnhg==
X-Google-Smtp-Source: AHgI3IZkCTUnZEIwziSVgR3suW5bULLS6bx2xgnMdqCeQCcg6N+qE+U3frPFzHg6fZMxb0duZRVuhQ==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr15822591wrw.84.1551182849727;
        Tue, 26 Feb 2019 04:07:29 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:28 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 00/11] ARM: davinci: modernize the timer support
Date:   Tue, 26 Feb 2019 13:06:22 +0100
Message-Id: <20190226120633.18200-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

merge window will be later than expected so I'm sending this now rebased
on top of your v5.1/soc branch - that way you'll be able to pick it up
early in the next release cycle.

---

This series removes the legacy timer code from mach-davinci in favor of
a new clocksource driver it introduces.

Patch 1 adds a new clocksource driver for davinci.

Patch 2 enables the new driver for device-tree based systems.

Patch 3 adds a WARN_ON() to the machine code of all davinci boards
which is triggered if clk_get() for the timer clock fails. This is needed
as the new driver expects the clock to be functional and doesn't check it.

Patches 4-5 and 7-10 switch the board files to using the new
clocksource driver while patch 6 moves some necessary defines to
a different place since we'll be removing the file that contains them.

Patch 11 removes legacy timer code.

v1 -> v2:

- changed the license to GPL-only
- dropped regmap usage due to the additional code paths making the
  code too slow
- minor code rearrangement
- fixed the da830 timer configuration
- correctly assign the timer halfs to clocksource and clockevent
- sqashed the commits adding WARN() when clk_get() fails
- used WARN_ON() and added a return when clk_get() fails to avoid
  entering the timer driver without a valid clock
- request the register range before iomapping it
- simplified the configuration structure (dropped the additional cmp struct)

v2 -> v3:

- use readl/writel_relaxed() instead of __raw variants in the clocksource
  driver
- request the memory region before remapping it
- add explanatory comments
- fixed licensing
- used pr_fmt macro
- correctly assign the clocksource name
- use DEFINE_RES_x macros when defining resources to avoid off-by-one
  bugs in resource's size
- tweak the commit messages
- don't delete the comments describing the timer usage
- other minor improvements
- rebased on top of Sekhar's soc branch
- dropped patch fixing the clocksource interrupts in device tree (already
  upstream)

Bartosz Golaszewski (11):
  clocksource: davinci-timer: new driver
  ARM: davinci: enable the clocksource driver for DT mode
  ARM: davinci: WARN_ON() if clk_get() fails
  ARM: davinci: da850: switch to using the clocksource driver
  ARM: davinci: da830: switch to using the clocksource driver
  ARM: davinci: move timer definitions to davinci.h
  ARM: davinci: dm355: switch to using the clocksource driver
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: dm644x: switch to using the clocksource driver
  ARM: davinci: dm646x: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/Kconfig                            |   1 +
 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/da830.c               |  40 +-
 arch/arm/mach-davinci/da850.c               |  45 +-
 arch/arm/mach-davinci/davinci.h             |   3 +
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm355.c               |  22 +-
 arch/arm/mach-davinci/dm365.c               |  22 +-
 arch/arm/mach-davinci/dm644x.c              |  28 +-
 arch/arm/mach-davinci/dm646x.c              |  28 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  35 --
 arch/arm/mach-davinci/time.c                | 414 ------------------
 drivers/clocksource/Kconfig                 |   5 +
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-davinci.c         | 438 ++++++++++++++++++++
 include/clocksource/timer-davinci.h         |  44 ++
 18 files changed, 584 insertions(+), 582 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.20.1

