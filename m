Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B444DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7910D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NGi8FisZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBKM0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:26:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52466 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfBKM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so17484502wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EVwT7SLU6xuo+x02xQzRORljWNqsvQZgcE+ZJadFdw=;
        b=NGi8FisZuhbNx0YSYsDeDRrkCS2o5RN9g3v/+I/ToT/+9XNI8ArWf+RGceKETHBHPb
         DZ4C2o1gjASYpwsYWnZyeonl3c2aFEvWZ0LHyh00vkp6Wm4XVI0pvL0LNOX7EpXf1jBc
         o41r6OzsR6P2VYBbT1z1vDhkRCjh1U3gAifT7GTHzYnWRl5LqVdyTWNnoNcAUCLV17LP
         n1hw/MICL11ARtvASWiWbtbkDqaKxeR7P4XfYnMnSE3ODUvt9cqfjFom4Hy3RS82n6Of
         UeU1162PZVK+7BiMuJwePimwXvyULzEfFTnRPAckBMa9opk6WGf5xToNVxwbRXLk3JNo
         1gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EVwT7SLU6xuo+x02xQzRORljWNqsvQZgcE+ZJadFdw=;
        b=m7ByuZ7KA9JfbQHVtFrfFHPGRBX1FZ0RfLmJIEjdcHdLLemZW8niu3UMSvEAdtB8Qf
         o6oc/FP8gOgDvVZaNAa62u4Vbv6e4M8OJGNiDGXhPHO0EeNkoKIq/z+i+EJf+scMLWar
         6WU0/WyyYCK9tq5hGJpKd/J36g8u2cNYP5hEKoSEejZer5D9zQfdjVudip/YapM6s8lF
         jZGZRjf866F6nzzbT5QGuJm3Wtmfz/st1aPAy336yaTbYjGe3DGj4scj8FELchI4+nlS
         UE05Ae/acFNqPa6NevzaUKSM79UYuKdKHxRCW+dNwMKWoi03s8YjaoBOQAhCY8ZhVfzO
         B9Zw==
X-Gm-Message-State: AHQUAubjM+Ngn5SUbggWsroDheAC766QkEf2MvgiLEInjbvNMr2rmUv3
        q77sIr3kDuwOktjtJCgJhQ52Sw==
X-Google-Smtp-Source: AHgI3IbrArNOZvricsw/9LYpVNP4SvXubagJeRfx7KFAMnmA5+trmnGZaRTqEYh3yQdYW2IcqwKQaw==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr8897153wmb.33.1549887973619;
        Mon, 11 Feb 2019 04:26:13 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:12 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 00/33] ARM: davinci: modernize the irq support
Date:   Mon, 11 Feb 2019 13:25:33 +0100
Message-Id: <20190211122606.8662-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

NOTE: resending due to missing irqchip maintainers in Cc

This series ports the davinci platform to using SPARSE_IRQ, cleans up
the irqchip drivers and moves them over to drivers/irqchip.

The series can be logically split into four parts. The first (1-8) aims
at introducing support for SPARSE_IRQ. It contains a couple changes
required for that functionality and the final patch actually selecting
it.

Second part (9-19) makes the aintc driver suitable for drivers/irqchip
and eventually moves it over there.

Part 3 (20-32) does the same for the cp-intc driver.

Last patch removes unnecessary code.

The series has been tested on da850-lcdk (for cp-intc) and
dm365-evm (for aintc).

v1 -> v2:
- made commit messages readable without reading the subject line first
- collected David's Reviewed-by tags for patches that haven been
  significantly modified since v1
- added handling of spurious interrupts in cp-intc
- added comments explaining the irq handlers (C versions translated from
  assembly)
- dropped the patches removing the hardware interrupt numbers from
  the priority tables
- don't remove irqs.h, make it a local header instead
- rearranged the patches in order not to remove the code added
  by earlier ones
- renamed d*_init_irqs to d*_init_irq to fit the name of the relevant
  callback in machine info struct
- fixed license identifiers where needed
- added comments to config structures for irqchip drivers
- fixed all off-by-one errors in resource sizes
- clarified the comments on the weird handling of IRQ_TINT1_TINT34 as level
  irq and added missing calls to irq_set_handler() to dm3* SoCs
- fixed one function that was missing a correct prefix in cp_intc
- return value variables should be called ret not rv
- added a patch converting calls to _raw_readl/writel() to their _relaxed
  counterparts
- fixed the commit message prefix in patches that belong to the irqchip
  subsystem
- other minor tweaks

Bartosz Golaszewski (33):
  ARM: davinci: remove intc_host_map from davinci_soc_info struct
  ARM: davinci: aintc: use irq domain
  ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
  ARM: davinci: remove davinci_intc_type
  ARM: davinci: pull davinci_intc_base into the respective intc drivers
  ARM: davinci: wrap HW interrupt numbers with a macro
  ARM: davinci: select SPARSE_IRQ
  ARM: davinci: make irqs.h a local header
  ARM: davinci: aintc: drop GPL license boilerplate
  ARM: davinci: aintc: wrap davinci_irq_init() with a helper
  ARM: davinci: aintc: use a common prefix for symbols in the driver
  ARM: davinci: aintc: drop the 00 prefix from register offsets
  ARM: davinci: aintc: use readl/writel_relaxed()
  irqchip: davinci-aintc: add a new config structure
  ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
  ARM: davinci: aintc: use the new config structure
  ARM: davinci: aintc: move timer-specific irq_set_handler() out of
    irq.c
  ARM: davinci: aintc: remove unnecessary includes
  irqchip: davinci-aintc: move the driver to drivers/irqchip
  ARM: davinci: cp-intc: remove cp_intc.h
  ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
  irqchip: davinci-cp-intc: add a new config structure
  ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
  ARM: davinci: cp-intc: use a common prefix for all symbols
  ARM: davinci: cp-intc: convert all hex numbers to lowercase
  ARM: davinci: cp-intc: use the new-style config structure
  ARM: davinci: cp-intc: improve coding style
  ARM: davinci: cp-intc: unify error handling
  ARM: davinci: cp-intc: use readl/writel_relaxed()
  ARM: davinci: cp-intc: drop GPL license boilerplate
  ARM: davinci: cp-intc: remove redundant comments
  irqchip: davinci-cp-intc: move the driver to drivers/irqchip
  ARM: davinci: remove intc related fields from davinci_soc_info

 arch/arm/Kconfig                              |   2 +
 arch/arm/mach-davinci/Kconfig                 |  19 +-
 arch/arm/mach-davinci/Makefile                |   3 -
 arch/arm/mach-davinci/asp.h                   |   8 +-
 arch/arm/mach-davinci/board-da830-evm.c       |   5 +-
 arch/arm/mach-davinci/board-da850-evm.c       |   5 +-
 arch/arm/mach-davinci/board-dm355-evm.c       |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c   |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c       |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c      |   8 +-
 arch/arm/mach-davinci/board-dm646x-evm.c      |   7 +-
 arch/arm/mach-davinci/board-mityomapl138.c    |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c     |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c   |   3 +-
 arch/arm/mach-davinci/board-sffsdr.c          |   2 +-
 arch/arm/mach-davinci/common.c                |   3 -
 arch/arm/mach-davinci/cp_intc.c               | 215 ----------------
 arch/arm/mach-davinci/cp_intc.h               |  57 -----
 arch/arm/mach-davinci/da830.c                 | 128 ++--------
 arch/arm/mach-davinci/da850.c                 | 154 +++---------
 arch/arm/mach-davinci/davinci.h               |   4 +
 arch/arm/mach-davinci/devices-da8xx.c         | 147 +++++------
 arch/arm/mach-davinci/devices.c               |  40 +--
 arch/arm/mach-davinci/dm355.c                 |  86 ++++---
 arch/arm/mach-davinci/dm365.c                 | 110 ++++----
 arch/arm/mach-davinci/dm644x.c                |  76 +++---
 arch/arm/mach-davinci/dm646x.c                |  90 ++++---
 arch/arm/mach-davinci/include/mach/common.h   |  14 +-
 arch/arm/mach-davinci/include/mach/da8xx.h    |   2 +
 .../mach-davinci/include/mach/entry-macro.S   |  39 ---
 arch/arm/mach-davinci/irq.c                   | 117 ---------
 .../mach-davinci/{include/mach => }/irqs.h    |   4 -
 arch/arm/mach-davinci/usb-da8xx.c             |   9 +-
 arch/arm/mach-davinci/usb.c                   |  14 +-
 drivers/irqchip/Kconfig                       |  10 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-davinci-aintc.c           | 144 +++++++++++
 drivers/irqchip/irq-davinci-cp-intc.c         | 238 ++++++++++++++++++
 include/linux/irqchip/irq-davinci-aintc.h     |  27 ++
 include/linux/irqchip/irq-davinci-cp-intc.h   |  25 ++
 40 files changed, 872 insertions(+), 956 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/cp_intc.c
 delete mode 100644 arch/arm/mach-davinci/cp_intc.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-davinci/irq.c
 rename arch/arm/mach-davinci/{include/mach => }/irqs.h (98%)
 create mode 100644 drivers/irqchip/irq-davinci-aintc.c
 create mode 100644 drivers/irqchip/irq-davinci-cp-intc.c
 create mode 100644 include/linux/irqchip/irq-davinci-aintc.h
 create mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

-- 
2.20.1

