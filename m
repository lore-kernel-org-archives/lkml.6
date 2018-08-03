Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A7C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6C3216F3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 03:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6C3216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeHCE5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:57:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:28329 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbeHCE5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:57:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="59343604"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2018 20:03:22 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        James Hogan <jhogan@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 00/18] MIPS: intel: add initial support for Intel MIPS SoCs
Date:   Fri,  3 Aug 2018 11:02:19 +0800
Message-Id: <20180803030237.3366-1-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is for adding the support for Intel MIPS
interAptiv SoC GRX500 family. It includes CCF support, serial
driver optimization and DTS modification.

This patch series is applied on top of linux v4.18-rc7.
Basic verification is performed on GRX500 board.

We propose merging this patch series into MIPS Linux tree.

Changes in v2:
- Remove unused _END macros
- Remove the redundant check and not accurate comments
- Replace the get_counter_resolution function with fixed value 2
- Use obj-y and split into per line per .o
- Add EVA mapping description in code comments
- Remove unused include header file
- Do a clean-up for grx500_defconfig
- Rewrite clock driver, add platform clock description details in
  clock driver.
- Rewrite clock driver's dt-binding document according to Rob Herring's
  comments.
- Simplify device tree docoment, remove some clock description.
- New patch split from previous patch
- The memory address is changed to @20000000
- Update to obj-$(CONFIG_BUILTIN_DTB) as per commit fca3aa166422
- New patch split from previous patch
- Add the board and chip compatible in dt document
- New patch to reorder the head files according to the coding style.

Hua Ma (3):
  MIPS: intel: Add initial support for Intel MIPS SoCs
  MIPS: dts: Add initial support for Intel MIPS SoCs
  dt-binding: MIPS: Add documentation of Intel MIPS SoCs

Songjun Wu (13):
  MIPS: dts: Change upper case to lower case
  MIPS: dts: Add aliases node for lantiq danube serial
  serial: intel: Get serial id from dts
  serial: intel: Change ltq_w32_mask to asc_update_bits
  MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
  serial: intel: Use readl/writel instead of ltq_r32/ltq_w32
  serial: intel: Rename fpiclk to freqclk
  serial: intel: Replace clk_enable/clk_disable with clk generic API
  serial: intel: Add CCF support
  serial: intel: Support more platform
  serial: intel: Reorder the head files
  serial: intel: Change init_lqasc to static declaration
  dt-bindings: serial: lantiq: Add optional properties for CCF

Yixin Zhu (2):
  clk: intel: Add clock driver for Intel MIPS SoCs
  dt-bindings: clk: Add documentation of grx500 clock controller

 .../devicetree/bindings/clock/intel,grx500-clk.txt |  39 ++
 Documentation/devicetree/bindings/mips/intel.txt   |  17 +
 .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  |  30 +-
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/intel-mips/Makefile             |   4 +
 arch/mips/boot/dts/intel-mips/easy350_anywan.dts   |  26 ++
 arch/mips/boot/dts/intel-mips/xrx500.dtsi          |  66 +++
 arch/mips/boot/dts/lantiq/danube.dtsi              |  42 +-
 arch/mips/boot/dts/lantiq/easy50712.dts            |  18 +-
 arch/mips/configs/grx500_defconfig                 | 138 ++++++
 .../asm/mach-intel-mips/cpu-feature-overrides.h    |  61 +++
 arch/mips/include/asm/mach-intel-mips/ioremap.h    |  39 ++
 arch/mips/include/asm/mach-intel-mips/irq.h        |  17 +
 .../asm/mach-intel-mips/kernel-entry-init.h        | 104 +++++
 arch/mips/include/asm/mach-intel-mips/spaces.h     |  27 ++
 arch/mips/include/asm/mach-intel-mips/war.h        |  18 +
 arch/mips/intel-mips/Kconfig                       |  22 +
 arch/mips/intel-mips/Makefile                      |   5 +
 arch/mips/intel-mips/Platform                      |  12 +
 arch/mips/intel-mips/irq.c                         |  35 ++
 arch/mips/intel-mips/prom.c                        | 172 ++++++++
 arch/mips/intel-mips/time.c                        |  42 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   3 +
 drivers/clk/intel/Kconfig                          |  20 +
 drivers/clk/intel/Makefile                         |   7 +
 drivers/clk/intel/clk-cgu-pll.c                    | 166 ++++++++
 drivers/clk/intel/clk-cgu-pll.h                    |  34 ++
 drivers/clk/intel/clk-cgu.c                        | 470 +++++++++++++++++++++
 drivers/clk/intel/clk-cgu.h                        | 259 ++++++++++++
 drivers/clk/intel/clk-grx500.c                     | 168 ++++++++
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/lantiq.c                        | 143 ++++---
 include/dt-bindings/clock/intel,grx500-clk.h       |  69 +++
 36 files changed, 2206 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,grx500-clk.txt
 create mode 100644 Documentation/devicetree/bindings/mips/intel.txt
 create mode 100644 arch/mips/boot/dts/intel-mips/Makefile
 create mode 100644 arch/mips/boot/dts/intel-mips/easy350_anywan.dts
 create mode 100644 arch/mips/boot/dts/intel-mips/xrx500.dtsi
 create mode 100644 arch/mips/configs/grx500_defconfig
 create mode 100644 arch/mips/include/asm/mach-intel-mips/cpu-feature-overrides.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/ioremap.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/irq.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/kernel-entry-init.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/spaces.h
 create mode 100644 arch/mips/include/asm/mach-intel-mips/war.h
 create mode 100644 arch/mips/intel-mips/Kconfig
 create mode 100644 arch/mips/intel-mips/Makefile
 create mode 100644 arch/mips/intel-mips/Platform
 create mode 100644 arch/mips/intel-mips/irq.c
 create mode 100644 arch/mips/intel-mips/prom.c
 create mode 100644 arch/mips/intel-mips/time.c
 create mode 100644 drivers/clk/intel/Kconfig
 create mode 100644 drivers/clk/intel/Makefile
 create mode 100644 drivers/clk/intel/clk-cgu-pll.c
 create mode 100644 drivers/clk/intel/clk-cgu-pll.h
 create mode 100644 drivers/clk/intel/clk-cgu.c
 create mode 100644 drivers/clk/intel/clk-cgu.h
 create mode 100644 drivers/clk/intel/clk-grx500.c
 create mode 100644 include/dt-bindings/clock/intel,grx500-clk.h

-- 
2.11.0

