Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1A2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60C72064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud6bkiKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60C72064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeJARHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:07:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50545 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeJARHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so8221046wmc.0;
        Mon, 01 Oct 2018 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epkCxOPGd+I5y5TmMc3oCEPLcQpgTkwG6saQ9rBl764=;
        b=Ud6bkiKT4YoIFa+LxYQaGqEyEa7lXW2OKhijxKnUuN5yBzFb9UVlabLX69MO0xrxFa
         1CapypZug6xPT8PTTCZMjXHBJpQ5qIoOlgaQ2PEc0rJV+iTcqFSPHSr23zPyun6RbhdH
         3/Z++AR8sB99ex8JCNDV0BnYokuOZqto0x/NDu3/7c3l6ocq4iqRyKi/pmvbjwoCpTRO
         TPWIW2tzFZhlp8r9I4F607U+8hjeQRJQuxdc3PRKSuw7gVbW1LODed40ZDqhJlDrWWZj
         uBvNvX81erWQpX+SZg8UsJvAj8dsVW6X7Wm78czs1bvSl/gbIz8D56dEvM2DjtMNq/Ir
         EqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epkCxOPGd+I5y5TmMc3oCEPLcQpgTkwG6saQ9rBl764=;
        b=n/avunK/bLfTkR4tqSFyBomOVDkyHYcGec24QsFGUATKvfrVl9qyKxzJOdDOLAWMcC
         Ipdn+4SkVWqNC2O1aaE8a1K7+PfFWppDRqWMiRMX7w+QfHMfYWBV6fvuOD3KXOulkfLJ
         /C+Mv1wSMVBOSkMQ58K52S281qZWb9k2EUMH5hLRnYL8cmZ/oMpaHgdNozWT28kZ1vXd
         N9MSVv76d189MAbVSW5Q3HtUSBl4VN8mmYsp+O5G9AXwh710Rq1k9hDikAqRNDqO9o4i
         VVMHqX6WcclegryIxyXwxsjaw9KvUUP8EfTYZezsVDPPy0uIIpriYiSbPD9Zdc/W+n6F
         vVzQ==
X-Gm-Message-State: ABuFfojqI1Hre5LObk0l6c1QTi6qMm5wRNQs7XfRi9g2euR9m4NNpggG
        4ibahXNuX2N7/6Tkhqqu9xY=
X-Google-Smtp-Source: ACcGV60QDBH5ZiVCtU1FrEcZHHyBMu2vRfPxxl9msexOIMWmmm2PdUfNlvmw3HH4tpkp4vfP+WluZg==
X-Received: by 2002:a1c:1c4e:: with SMTP id c75-v6mr5814006wmc.4.1538389813569;
        Mon, 01 Oct 2018 03:30:13 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:12 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 0/7] MIPS: Lexra LX5280 CPU + Realtek RTL8186 SoC support
Date:   Mon,  1 Oct 2018 13:29:45 +0300
Message-Id: <20181001102952.7913-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changelog:

v2:
- Patch 5 in v1 added irqchip, timer and arch code for the SoC all in one patch.
  Split this patch into 3 patches:
    - Patch 3 for irqchip (depends on MACH_RTL8186 in Kconfig)
    - Patch 5 for timer (depends on MACH_RTL8186 in Kconfig)
    - Patch 7 for SoC code in arch/mips (adds MACH_RTL8186 in mips and selects irqchip+timer drivers)
  Also, reorder the patches in a way that each DT binding patch comes before
  the respective driver patch.

- No code changes from v1

------

This RFC patch series adds all the necessary code
to successfully boot Linux on the Realtek RTL8186 SoC.

Boot log with the v1 series applied (+one DT patch that adds partitions) is available here:
https://gist.github.com/yashac3/483decfa8db014edfb055ba5a1f9996e

Network drivers and other misc drivers are not included
in this patch set, but are being worked on.


This patch series includes:
- Patch 1: Lexra LX5280 CPU support (MIPS)

- Patch 2: Device tree bindings for the RTL8186 interrupt controller
- Patch 3: RTL8186 interrupt controller driver

- Patch 4: Device tree bindings for the RTL8186 timer
- Patch 5: RTL8186 timer driver

- Patch 6: Device tree bindings for Realtek MIPS SoCs
- Patch 7: RTL8186 SoC support (MIPS, device tree)


What's still missing:
1) Upstream toolchain support for the Lexra LX5280 CPU.
   (Still WIP) GCC and binutils patches are available at [1][2].
   Buildroot with these patches applied is available at [3].

   The toolchain work is still WIP and I'm planning to send it
   for review when it will be ready.

   Still, feel free to comment on this work too.

2) Reading the TLB size from device tree:
   (The reason there's no DT bindings for the LX5280 in this series)

   As there's no way to get the TLB size from the hardware,
   is must be passed in the DT.

   Currently in arch/mips, the FDT is not available in the cpu_probe()
   stage, where the 'tlbsize' field of the cpu data is set.

   Any ideas/suggestions on how to solve that?


This patch series is on top of v4.18 + 5 prerequisite patches that
are in mips-next for 4.20. [4][5].

This patch series is also available at:
https://github.com/yashac3/linux-rtl8186/commits/rtl8186-porting-for-upstream-4.18-v2


Please review.

Thanks,
Yasha


[1] https://github.com/yashac3/gcc/commits/lx5280-gcc-8_2_0
[2] https://github.com/yashac3/binutils-gdb/commits/lx5280-porting-master
[3] https://github.com/yashac3/buildroot/commits/lx5280_master
[4] https://www.linux-mips.org/archives/linux-mips/2018-09/msg00769.html
[5] https://www.linux-mips.org/archives/linux-mips/2018-09/msg00775.html


Cc: linux-kernel@vger.kernel.org


Yasha Cherikovsky (7):
  MIPS: Add support for the Lexra LX5280 CPU
  dt-binding: interrupt-controller: Document RTL8186 SoC DT bindings
  irqchip/rtl8186: Add RTL8186 interrupt controller driver
  dt-binding: timer: Document RTL8186 SoC DT bindings
  clocksource/drivers/rtl8186: Add RTL8186 timer driver
  dt-binding: mips: Document Realtek SoC DT bindings
  MIPS: Add Realtek RTL8186 SoC support

 .../interrupt-controller/realtek,rtl8186-intc |  18 ++
 .../devicetree/bindings/mips/realtek.txt      |   9 +
 .../bindings/timer/realtek,rtl8186-timer.txt  |  17 ++
 arch/mips/Kbuild.platforms                    |   1 +
 arch/mips/Kconfig                             |  47 +++-
 arch/mips/Makefile                            |   1 +
 arch/mips/boot/compressed/uart-16550.c        |   5 +
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/realtek/Makefile           |   4 +
 arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 ++++++
 .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
 arch/mips/configs/rtl8186_defconfig           | 112 ++++++++
 arch/mips/include/asm/cpu-features.h          |   3 +
 arch/mips/include/asm/cpu-type.h              |   4 +
 arch/mips/include/asm/cpu.h                   |   9 +
 arch/mips/include/asm/isadep.h                |   3 +-
 arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
 arch/mips/include/asm/mipsregs.h              |  10 +
 arch/mips/include/asm/module.h                |   2 +
 arch/mips/include/asm/pgtable-32.h            |   7 +-
 arch/mips/include/asm/pgtable-bits.h          |   9 +-
 arch/mips/include/asm/pgtable.h               |   6 +-
 arch/mips/include/asm/stackframe.h            |   9 +-
 arch/mips/include/asm/traps.h                 |   2 +
 arch/mips/kernel/Makefile                     |   2 +
 arch/mips/kernel/cpu-probe.c                  |   6 +
 arch/mips/kernel/entry.S                      |   3 +-
 arch/mips/kernel/genex.S                      |   6 +-
 arch/mips/kernel/idle.c                       |  10 +
 arch/mips/kernel/process.c                    |   3 +-
 arch/mips/kernel/traps.c                      |  42 +++
 arch/mips/lib/Makefile                        |   1 +
 arch/mips/mm/Makefile                         |   1 +
 arch/mips/mm/c-lx5280.c                       | 251 ++++++++++++++++++
 arch/mips/mm/cache.c                          |   6 +
 arch/mips/mm/fault.c                          |   4 +
 arch/mips/mm/tlbex.c                          |   1 +
 arch/mips/rtl8186/Makefile                    |   2 +
 arch/mips/rtl8186/Platform                    |   7 +
 arch/mips/rtl8186/irq.c                       |   8 +
 arch/mips/rtl8186/prom.c                      |  15 ++
 arch/mips/rtl8186/setup.c                     |  80 ++++++
 arch/mips/rtl8186/time.c                      |  10 +
 drivers/clocksource/Kconfig                   |   9 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-rtl8186.c           | 220 +++++++++++++++
 drivers/irqchip/Kconfig                       |   5 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-rtl8186.c                 | 107 ++++++++
 49 files changed, 1225 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtl8186-intc
 create mode 100644 Documentation/devicetree/bindings/mips/realtek.txt
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
 create mode 100644 arch/mips/boot/dts/realtek/Makefile
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186.dtsi
 create mode 100644 arch/mips/boot/dts/realtek/rtl8186_edimax_br_6204wg.dts
 create mode 100644 arch/mips/configs/rtl8186_defconfig
 create mode 100644 arch/mips/include/asm/mach-rtl8186/rtl8186.h
 create mode 100644 arch/mips/mm/c-lx5280.c
 create mode 100644 arch/mips/rtl8186/Makefile
 create mode 100644 arch/mips/rtl8186/Platform
 create mode 100644 arch/mips/rtl8186/irq.c
 create mode 100644 arch/mips/rtl8186/prom.c
 create mode 100644 arch/mips/rtl8186/setup.c
 create mode 100644 arch/mips/rtl8186/time.c
 create mode 100644 drivers/clocksource/timer-rtl8186.c
 create mode 100644 drivers/irqchip/irq-rtl8186.c

-- 
2.19.0

