Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0DDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0210C218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 22:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9y9Pd4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfA3W4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 17:56:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfA3W4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 17:56:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so579551wmt.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 14:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eulrGW+gMWztMD6EeoDBaFH7E3goMW4Kl6Q0GzxUfMs=;
        b=L9y9Pd4ZSvJqXaNdcUlFgLpiJR2ujV4YBWJdrVNhWcKXxtJAmpuzxvK3mejmyR4Rgw
         FO0VQLBoXqECCrBNtxpusiQG/3+KvwhbGJ+wQnIJi5XXaCM0vXIHSsIYsoD49vThyUxj
         827x6fdMwGMM4FLsnDfPxyaqwdTvwX2K0DmZAdaTbtwa119fWWWi40xucZmBC5LQV6qx
         iV4io13ixc3OlULiP6EusmthHY2+Qv00eHNdlMRqX2mJXJ8VNm6N+KZ/jrnN3joqlYfc
         XJSO+AKYn5ytbYPagDvEd9xvSrMenqI9UTO7A+6AtyE3M9vRtaRhJa4ULpGi4oWGBuA0
         VjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eulrGW+gMWztMD6EeoDBaFH7E3goMW4Kl6Q0GzxUfMs=;
        b=GwtrPuFgRoXNqtFhHajRYd/6maRQzEnHkl8lAnZw3d5D/ZoaA0myc3Pf1lhqwksR9Z
         CJWRjY71mVWhQ13pPkIcLEH64DkC/Z5FH6HVEZroKYxCr6HweB6icSnYV6MEt/qfUxSZ
         h+COgtKCJH1wpU1j3aJkNVipE3e4jE2cGW7XODIq11RFK6sBWrMO52LJNc1j6rgMX6V/
         tzdCXsB6k988BYMvyUKV2aZVVPXCMg1Mszn1/dG5EB1KLg7PxahooDo5zBbCq/d0+rww
         fmRX/vrvw1fLDyDQpD+upGz9+xPkyQVeFZDe8QSEWUJyDa+RTPVUBjGx2fzN0CmlFiUv
         4ktg==
X-Gm-Message-State: AJcUukeWnWIBr57ZvxMSDCOpb2zFmR04NTGouploWTj+/HrWwIUVvTGe
        XOElM9o4nRJuE7ObvUkedJGZcvaU
X-Google-Smtp-Source: ALg8bN4/rNiJo3JMwYv6bBlyAcJ9jX+l1dOIfdvQjPsUN0xOEBhvwfyTi/q4jUHDQ5mIYwKuPPFbdA==
X-Received: by 2002:a1c:5dce:: with SMTP id r197mr25123335wmb.130.1548885981611;
        Wed, 30 Jan 2019 14:06:21 -0800 (PST)
Received: from oded-ubuntu-des.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id b13sm2341349wrn.28.2019.01.30.14.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 14:06:20 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, rppt@linux.ibm.com
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v2 00/15] Habana Labs kernel driver
Date:   Thu, 31 Jan 2019 00:06:02 +0200
Message-Id: <20190130220617.4862-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This is v2 of the Habana Labs kernel driver patch-set. It contains fixes
for almost everything that was brought up in the review of v1.

In addition to local changes in each patch that are detailed in each
patch's commit message, the global/major changes are:

- Rebased on v5.0-rc4
- Removed all bitfields from interface files to H/W and F/W
- Use __le16/32/64 instead of __u16/32/64 in F/W or H/W structures

Link to v1 cover letter: https://lwn.net/Articles/777342/

I would appricate any feedback, question and/or review.

Thanks,
Oded

p.s. for those who prefer to clone the tree instead of looking at the
emails, you can grab a copy from our company's page in GitHub:

https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v2_20190130

Oded Gabbay (14):
  habanalabs: add skeleton driver
  habanalabs: add Goya registers header files
  habanalabs: add basic Goya support
  habanalabs: add context and ASID modules
  habanalabs: add command buffer module
  habanalabs: add basic Goya h/w initialization
  habanalabs: add h/w queues module
  habanalabs: add event queue and interrupts
  habanalabs: add sysfs and hwmon support
  habanalabs: add device reset support
  habanalabs: add command submission module
  habanalabs: implement INFO IOCTL
  habanalabs: add debugfs support
  Update MAINTAINERS and CREDITS with habanalabs info

Omer Shpigelman (1):
  habanalabs: add virtual memory and MMU modules

 CREDITS                                       |    2 +-
 .../ABI/testing/debugfs-driver-habanalabs     |  127 +
 .../ABI/testing/sysfs-driver-habanalabs       |  190 +
 MAINTAINERS                                   |    9 +
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/habanalabs/Kconfig               |   22 +
 drivers/misc/habanalabs/Makefile              |   15 +
 drivers/misc/habanalabs/asid.c                |   58 +
 drivers/misc/habanalabs/command_buffer.c      |  432 +
 drivers/misc/habanalabs/command_submission.c  |  787 ++
 drivers/misc/habanalabs/context.c             |  216 +
 drivers/misc/habanalabs/debugfs.c             | 1071 ++
 drivers/misc/habanalabs/device.c              | 1110 ++
 drivers/misc/habanalabs/goya/Makefile         |    4 +
 drivers/misc/habanalabs/goya/goya.c           | 5338 ++++++++++
 drivers/misc/habanalabs/goya/goyaP.h          |  193 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
 drivers/misc/habanalabs/goya/goya_security.c  | 2999 ++++++
 drivers/misc/habanalabs/habanalabs.h          | 1448 +++
 drivers/misc/habanalabs/habanalabs_drv.c      |  469 +
 drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
 drivers/misc/habanalabs/hw_queue.c            |  654 ++
 drivers/misc/habanalabs/hwmon.c               |  449 +
 drivers/misc/habanalabs/include/armcp_if.h    |  335 +
 .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |  213 +
 .../include/goya/asic_reg/cpu_if_regs.h       |  110 +
 .../include/goya/asic_reg/cpu_pll_regs.h      |  186 +
 .../include/goya/asic_reg/ddr_mc_ch0_regs.h   | 1158 +++
 .../include/goya/asic_reg/ddr_mc_ch1_regs.h   | 1158 +++
 .../include/goya/asic_reg/ddr_misc_ch0_regs.h |  156 +
 .../include/goya/asic_reg/ddr_misc_ch1_regs.h |  156 +
 .../include/goya/asic_reg/dma_ch_0_regs.h     |  512 +
 .../include/goya/asic_reg/dma_ch_1_regs.h     |  512 +
 .../include/goya/asic_reg/dma_ch_2_regs.h     |  512 +
 .../include/goya/asic_reg/dma_ch_3_regs.h     |  512 +
 .../include/goya/asic_reg/dma_ch_4_regs.h     |  512 +
 .../include/goya/asic_reg/dma_macro_regs.h    |  242 +
 .../include/goya/asic_reg/dma_nrtr_regs.h     |  380 +
 .../include/goya/asic_reg/dma_qm_0_regs.h     |  543 +
 .../include/goya/asic_reg/dma_qm_1_regs.h     |  543 +
 .../include/goya/asic_reg/dma_qm_2_regs.h     |  543 +
 .../include/goya/asic_reg/dma_qm_3_regs.h     |  543 +
 .../include/goya/asic_reg/dma_qm_4_regs.h     |  543 +
 .../include/goya/asic_reg/gic_regs.h          | 9079 +++++++++++++++++
 .../include/goya/asic_reg/goya_blocks.h       | 1372 +++
 .../include/goya/asic_reg/goya_masks.h        |  262 +
 .../include/goya/asic_reg/goya_regs.h         |  119 +
 .../include/goya/asic_reg/ic_pll_regs.h       |  186 +
 .../include/goya/asic_reg/mc_pll_regs.h       |  186 +
 .../include/goya/asic_reg/mme1_rtr_regs.h     |  876 ++
 .../include/goya/asic_reg/mme2_rtr_regs.h     |  876 ++
 .../include/goya/asic_reg/mme3_rtr_regs.h     |  876 ++
 .../include/goya/asic_reg/mme4_rtr_regs.h     |  876 ++
 .../include/goya/asic_reg/mme5_rtr_regs.h     |  876 ++
 .../include/goya/asic_reg/mme6_rtr_regs.h     |  876 ++
 .../include/goya/asic_reg/mme_cmdq_regs.h     |  431 +
 .../include/goya/asic_reg/mme_qm_regs.h       |  543 +
 .../include/goya/asic_reg/mme_regs.h          | 2422 +++++
 .../include/goya/asic_reg/mmu_regs.h          |  158 +
 .../include/goya/asic_reg/pci_nrtr_regs.h     |  380 +
 .../include/goya/asic_reg/pcie_aux_regs.h     |  476 +
 .../include/goya/asic_reg/pcie_dbi_regs.h     | 2909 ++++++
 .../goya/asic_reg/psoc_emmc_pll_regs.h        |  186 +
 .../goya/asic_reg/psoc_global_conf_regs.h     | 1119 ++
 .../include/goya/asic_reg/psoc_mme_pll_regs.h |  186 +
 .../include/goya/asic_reg/psoc_pci_pll_regs.h |  186 +
 .../include/goya/asic_reg/psoc_spi_regs.h     |  427 +
 .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y1_x0_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y1_x1_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y1_x2_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y1_x3_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y1_x4_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y2_x0_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y2_x1_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y2_x2_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y2_x3_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y2_x4_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y3_x0_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y3_x1_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y3_x2_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y3_x3_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y3_x4_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y4_x0_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y4_x1_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y4_x2_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y4_x3_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y4_x4_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y5_x0_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y5_x1_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y5_x2_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y5_x3_rtr_regs.h       |  215 +
 .../goya/asic_reg/sram_y5_x4_rtr_regs.h       |  215 +
 .../include/goya/asic_reg/stlb_regs.h         |  133 +
 .../include/goya/asic_reg/sync_mngr_regs.h    | 4930 +++++++++
 .../include/goya/asic_reg/tpc0_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  580 ++
 .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  380 +
 .../include/goya/asic_reg/tpc0_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc1_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc1_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc1_rtr_regs.h     |  848 ++
 .../include/goya/asic_reg/tpc2_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc2_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc2_rtr_regs.h     |  848 ++
 .../include/goya/asic_reg/tpc3_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc3_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc3_rtr_regs.h     |  848 ++
 .../include/goya/asic_reg/tpc4_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc4_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc4_rtr_regs.h     |  848 ++
 .../include/goya/asic_reg/tpc5_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc5_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc5_rtr_regs.h     |  848 ++
 .../include/goya/asic_reg/tpc6_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc6_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc6_rtr_regs.h     |  848 ++
 .../include/goya/asic_reg/tpc7_cfg_regs.h     | 2110 ++++
 .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  431 +
 .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  380 +
 .../include/goya/asic_reg/tpc7_qm_regs.h      |  543 +
 .../include/goya/asic_reg/tpc_pll_regs.h      |  186 +
 drivers/misc/habanalabs/include/goya/goya.h   |   41 +
 .../include/goya/goya_async_events.h          |  186 +
 .../habanalabs/include/goya/goya_boot_if.h    |   30 +
 .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
 .../habanalabs/include/goya/goya_packets.h    |  129 +
 .../include/hw_ip/mmu/mmu_general.h           |   45 +
 .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
 drivers/misc/habanalabs/include/qman_if.h     |   56 +
 drivers/misc/habanalabs/irq.c                 |  325 +
 drivers/misc/habanalabs/memory.c              | 1713 ++++
 drivers/misc/habanalabs/mmu.c                 |  604 ++
 drivers/misc/habanalabs/sysfs.c               |  691 ++
 include/uapi/misc/habanalabs.h                |  444 +
 147 files changed, 98492 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-habanalabs
 create mode 100644 Documentation/ABI/testing/sysfs-driver-habanalabs
 create mode 100644 drivers/misc/habanalabs/Kconfig
 create mode 100644 drivers/misc/habanalabs/Makefile
 create mode 100644 drivers/misc/habanalabs/asid.c
 create mode 100644 drivers/misc/habanalabs/command_buffer.c
 create mode 100644 drivers/misc/habanalabs/command_submission.c
 create mode 100644 drivers/misc/habanalabs/context.c
 create mode 100644 drivers/misc/habanalabs/debugfs.c
 create mode 100644 drivers/misc/habanalabs/device.c
 create mode 100644 drivers/misc/habanalabs/goya/Makefile
 create mode 100644 drivers/misc/habanalabs/goya/goya.c
 create mode 100644 drivers/misc/habanalabs/goya/goyaP.h
 create mode 100644 drivers/misc/habanalabs/goya/goya_hwmgr.c
 create mode 100644 drivers/misc/habanalabs/goya/goya_security.c
 create mode 100644 drivers/misc/habanalabs/habanalabs.h
 create mode 100644 drivers/misc/habanalabs/habanalabs_drv.c
 create mode 100644 drivers/misc/habanalabs/habanalabs_ioctl.c
 create mode 100644 drivers/misc/habanalabs/hw_queue.c
 create mode 100644 drivers/misc/habanalabs/hwmon.c
 create mode 100644 drivers/misc/habanalabs/include/armcp_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_mc_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ddr_misc_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/gic_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_blocks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_dbi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y1_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y2_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y3_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y4_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y5_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sync_mngr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc5_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc6_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc7_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_boot_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
 create mode 100644 drivers/misc/habanalabs/include/qman_if.h
 create mode 100644 drivers/misc/habanalabs/irq.c
 create mode 100644 drivers/misc/habanalabs/memory.c
 create mode 100644 drivers/misc/habanalabs/mmu.c
 create mode 100644 drivers/misc/habanalabs/sysfs.c
 create mode 100644 include/uapi/misc/habanalabs.h

-- 
2.17.1

