Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC621C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9152199B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="igfesLgB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kw6/i/7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C9152199B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeHLVNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 17:13:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbeHLVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 17:13:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1E8A260B22; Sun, 12 Aug 2018 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534098848;
        bh=5isK8/ltU8TN5bZPNBaYZ4bjBuVp3uGlBSEFCEldRkI=;
        h=From:To:Cc:Subject:Date:From;
        b=igfesLgB3HAFJPMkKyvlHJmW3G8JvnmwbkZqnBKf2X1LcaVzLAL+uDDx8ZLPLd+YY
         otzU+Eu5slVZaeyBffSRvHywgRYQsQ5PE6mIxRC6VPqxGQ4QFjP4J8/deZq/EjovjK
         JBBtJ9qjolmA7AkWGd/6ZdbhyqGEyIKaI987Y+2Q=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E273560710;
        Sun, 12 Aug 2018 18:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534098847;
        bh=5isK8/ltU8TN5bZPNBaYZ4bjBuVp3uGlBSEFCEldRkI=;
        h=From:To:Cc:Subject:Date:From;
        b=Kw6/i/7vetE/DuyAm+2qgjxoB6lIqJd6BbfvwIsxeJhoRska647pnNyjtsvOoyYjO
         G4UtQNWhsZHD51mpp740Rn5NIgCC7yMPYSiqVpiKkG77ZhltqD5FtmKhpldCSWeEE+
         RSOqcK10b9tkDn8D1umjzA3Q2We2auqwlY9njr5E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E273560710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: pull-request: wireless-drivers-next 2018-08-12
Date:   Sun, 12 Aug 2018 21:34:03 +0300
Message-ID: <87wosvxwmc.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

one more request to net-next for 4.19. I hope I'm not too late with
this. These have been in linux-next since Friday so I'm hoping there are
no surprises. Please let me know if you have any problems.

Kalle

The following changes since commit 981467033a37d916649647fa3afe1fe99bba1817:

  tc-testing: remove duplicate spaces in skbedit match patterns (2018-08-05 17:39:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git tags/wireless-drivers-next-for-davem-2018-08-12

for you to fetch changes up to 209b43759d65b2cc99ce7757249aacc82b03c4e2:

  ssb: Remove SSB_WARN_ON, SSB_BUG_ON and SSB_DEBUG (2018-08-09 18:47:47 +0300)

----------------------------------------------------------------
wireless-drivers-next patches for 4.19

Last set of new features for 4.19. Most notable is simplifying SSB
debugging code with two Kconfig option removals and fixing mt76 USB
build problems.

Major changes:

ath10k

* add debugfs file warm_hw_reset

wil6210

* add debugfs files tx_latency, link_stats and link_stats_global

* add 3-MSI support

* allow scan on AP interface

* support max aggregation window size 64

ssb

* remove CONFIG_SSB_SILENT and CONFIG_SSB_DEBUG Kconfig options

mt76

* fix build problems with recently added USB support

----------------------------------------------------------------
Ahmad Masri (3):
      wil6210: allow scan on AP interface
      wil6210: align to latest auto generated wmi.h
      wil6210: off channel transmit management frames in AP mode

Alexei Avshalom Lazar (3):
      wil6210: add 3-MSI support
      wil6210: fix min() compilation errors
      wil6210: set default 3-MSI

Colin Ian King (5):
      ath10k: remove redundant pointers 'dev' and 'noa'
      ath5k: remove redundant pointer rf
      ath6kl: remove redundant variables netlen, orig_buf, orig_len, dropped and stats
      rsi: remove redundant variables bss, wh and temp_flash_content
      iwlegacy: fix spelling mistake "acumulative" -> "accumulative"

Dedy Lansky (6):
      wil6210: Rx multicast packets duplicate detection
      wil6210: drop Rx packets with L2 error indication from HW
      wil6210: add TX latency statistics
      wil6210: fix temperature debugfs
      wil6210: align to latest auto generated wmi.h
      wil6210: add support for link statistics

Felix Fietkau (8):
      ath9k_hw: set spectral scan enable bit on trigger for AR9003+
      ath9k: don't run periodic and nf calibation at the same time
      ath9k: fix moredata bit in PS buffered frame release
      ath9k: clear potentially stale EOSP status bit in intermediate queues
      ath9k: report tx status on EOSP
      ath9k: fix block-ack window tracking issues
      ath9k_hw: fix channel maximum power level test
      ath9k: fix more-data flag for buffered multicast packets

Gustavo A. R. Silva (1):
      ssb: driver_gige: use true and false for boolean values

Hamad Kadmany (1):
      wil6210: increase firmware ready timeout

Jia-Ju Bai (1):
      ath6kl: replace GFP_ATOMIC with GFP_KERNEL in ath6kl_bmi_init()

Kalle Valo (3):
      ath10k: fix open brace location in ath10k_wmi_tlv_op_gen_dbglog_cfg()
      ath10k: fix parenthesis alignment
      Merge ath-next from git://git.kernel.org/.../kvalo/ath.git

Kees Cook (1):
      mt76x0: Remove VLA usage

Maharaja Kennadyrajan (1):
      ath10k: add debugfs file warm_hw_reset

Maya Erez (6):
      wil6210: fix RX checksum report to network stack
      wil6210: support Talyn specific FW file
      wil6210: support max aggregation window size 64
      wil6210: support Talyn specific board file
      wil6210: prevent FW download if HW is configured for secured boot
      wil6210: fix eDMA RX chaining

Michael Buesch (4):
      b43/leds: Ensure NUL-termination of LED name string
      b43legacy/leds: Ensure NUL-termination of LED name string
      ssb: Remove home-grown printk wrappers
      ssb: Remove SSB_WARN_ON, SSB_BUG_ON and SSB_DEBUG

Nicholas Mc Guire (1):
      ath10k: htt_tx: move lock into id_get function

Pradeep Kumar Chitrapu (1):
      ath10k: support for multicast rate control

Rakesh Pillai (1):
      ath10k: handle mgmt tx completion event

Stanislaw Gruszka (2):
      mt76x0: correct type for eeprom gain value
      mt76x0: perform mt76x0_mac_set_ampdu_factor

Surabhi Vishnoi (1):
      ath10k: disable bundle mgmt tx completion event support

Sven Eckelmann (1):
      ath10k: prevent active scans on potential unusable channels

Valdis Kletnieks (1):
      mt76: fix build for MediaTek MT7610U USB wireless dongle

Winnie Chang (1):
      brcmfmac: fix brcmf_wiphy_wowl_params() NULL pointer dereference

YueHaibing (1):
      rtlwifi: btcoex: Fix if == else warnings in halbtc8723b2ant.c

 arch/mips/configs/bcm47xx_defconfig                |   1 -
 arch/powerpc/configs/wii_defconfig                 |   1 -
 drivers/net/wireless/ath/ath10k/ahb.c              |   5 -
 drivers/net/wireless/ath/ath10k/core.c             |   1 +
 drivers/net/wireless/ath/ath10k/core.h             |   5 +
 drivers/net/wireless/ath/ath10k/debug.c            |  49 ++
 drivers/net/wireless/ath/ath10k/htt_tx.c           |  10 +-
 drivers/net/wireless/ath/ath10k/hw.h               |   1 +
 drivers/net/wireless/ath/ath10k/mac.c              |  67 +-
 drivers/net/wireless/ath/ath10k/wmi-ops.h          |  12 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |  75 ++-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |  17 +
 drivers/net/wireless/ath/ath10k/wmi.c              |  87 ++-
 drivers/net/wireless/ath/ath10k/wmi.h              |  23 +-
 drivers/net/wireless/ath/ath5k/phy.c               |   5 -
 drivers/net/wireless/ath/ath6kl/bmi.c              |   2 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |  10 +-
 drivers/net/wireless/ath/ath6kl/main.c             |   3 +-
 drivers/net/wireless/ath/ath6kl/txrx.c             |   2 -
 drivers/net/wireless/ath/ath9k/ar9002_calib.c      |   6 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.c        |   2 +
 drivers/net/wireless/ath/ath9k/hw.c                |   7 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |  67 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  50 +-
 drivers/net/wireless/ath/wil6210/debugfs.c         | 371 ++++++++++-
 drivers/net/wireless/ath/wil6210/fw.c              |   3 +
 drivers/net/wireless/ath/wil6210/fw_inc.c          |   2 +-
 drivers/net/wireless/ath/wil6210/interrupt.c       |  64 +-
 drivers/net/wireless/ath/wil6210/main.c            |  65 +-
 drivers/net/wireless/ath/wil6210/pcie_bus.c        |  70 ++-
 drivers/net/wireless/ath/wil6210/rx_reorder.c      |  31 +-
 drivers/net/wireless/ath/wil6210/txrx.c            |  71 ++-
 drivers/net/wireless/ath/wil6210/txrx.h            |   7 +
 drivers/net/wireless/ath/wil6210/txrx_edma.c       |  48 +-
 drivers/net/wireless/ath/wil6210/txrx_edma.h       |   6 +
 drivers/net/wireless/ath/wil6210/wil6210.h         |  96 ++-
 drivers/net/wireless/ath/wil6210/wil_platform.h    |   1 +
 drivers/net/wireless/ath/wil6210/wmi.c             | 221 +++++++
 drivers/net/wireless/ath/wil6210/wmi.h             | 685 ++++++++++++++++++++-
 drivers/net/wireless/broadcom/b43/leds.c           |   2 +-
 drivers/net/wireless/broadcom/b43legacy/leds.c     |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   8 +-
 drivers/net/wireless/intel/iwlegacy/3945-debug.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/Kconfig         |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mac.c    |   2 -
 .../realtek/rtlwifi/btcoexist/halbtc8723b2ant.c    | 180 ++----
 drivers/net/wireless/rsi/rsi_91x_hal.c             |  10 +-
 drivers/ssb/Kconfig                                |  21 -
 drivers/ssb/b43_pci_bridge.c                       |   4 +-
 drivers/ssb/bridge_pcmcia_80211.c                  |   6 +-
 drivers/ssb/driver_chipcommon.c                    |  14 +-
 drivers/ssb/driver_chipcommon_pmu.c                |  40 +-
 drivers/ssb/driver_chipcommon_sflash.c             |   6 +-
 drivers/ssb/driver_extif.c                         |   4 +-
 drivers/ssb/driver_gige.c                          |   2 +-
 drivers/ssb/driver_gpio.c                          |   8 +-
 drivers/ssb/driver_mipscore.c                      |  17 +-
 drivers/ssb/driver_pcicore.c                       |  23 +-
 drivers/ssb/embedded.c                             |  18 +-
 drivers/ssb/host_soc.c                             |  16 +-
 drivers/ssb/main.c                                 |  83 +--
 drivers/ssb/pci.c                                  |  75 +--
 drivers/ssb/pcmcia.c                               |  62 +-
 drivers/ssb/scan.c                                 |  38 +-
 drivers/ssb/sdio.c                                 |  16 +-
 drivers/ssb/sprom.c                                |   4 +-
 drivers/ssb/ssb_private.h                          |  39 +-
 include/linux/ssb/ssb.h                            |   2 -
 69 files changed, 2308 insertions(+), 654 deletions(-)
