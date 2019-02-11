Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC30C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1BC222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8Uwuxsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbfBKPR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:17:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39518 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403862AbfBKPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:17:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so5127408wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eO16Cit8ifKoEE/5l4W1TpaGAuNqq8ybK4D8zjEXkNA=;
        b=s8UwuxswbPnnuXUtE0fYvkxlCkTDVIHFFQnPXd422wlHnRYQbvKA5hDw8V5NMe+9/O
         /QIeRTw04ER/npgW+srLu1XVBfIAcHsquAx4I6YEMKXSUgvuQQ9C4Vju5BExz0tn1SJR
         erpxTG/BKCWZ9yKp6MfeAhIVOfFN0VV9lhV8zGtNM0JA/9S0wPf1fhIoalA4+JvgItpn
         5nVUVt1naRET3SLMCP/dlvYM5cS1zz2pDtUtW6GbiaREqkEI31DMA1morRbiEjKuamNZ
         BiPd5eTwo7DKkn79T6r1uGvUQkR4DY+7gHTdzVZ1UXx1PPmbK3bSzoDHg6Ih8JGVHlf0
         sVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eO16Cit8ifKoEE/5l4W1TpaGAuNqq8ybK4D8zjEXkNA=;
        b=lne+XW6UOd/Yk2rs6DVq8zs/LoMswIBmyI5Qbio0ioh/ZKtCxT0ze/LMM50vGpFYll
         r75Z972vIiv4U9ljAbnQcvx4sscOMiVUipbtb+sydMcGfYdPPho/VhADg47LsQXahriN
         SvM+RMhyVkzy58h91czcEgx5gTRhicI8+kN72G9fuGIZmOzVAsXhGNpyS2J2Y5UO+9Yc
         h+lQtLQyUfuSUk5DuJuR9BBRzD9Wp3CYgI/MyORCxl0/8VE1SQftgWUVEjoYBIfB2G1F
         hVOs9TApW8IDkiqTU+vWSTz7uoK9vTjcgei4uwpWuSs2nxjZrcvfvFLVI3yTMQoRLaTS
         9o6A==
X-Gm-Message-State: AHQUAuZRSinJYAaQVCq+nYsaREo2xhn1Ek69s1hxApLL1MAHpzLBltCs
        YJu+TnR7m+xQuihZPV4XrcY=
X-Google-Smtp-Source: AHgI3Iap8qw1kOYnrkTromAkI5Zs5lhjq8o34spAC2e5JMkGXAK2znfR6t4ckTeenQ72LBlvrlit0w==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr14517772wro.255.1549898274140;
        Mon, 11 Feb 2019 07:17:54 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c186sm12531380wmf.34.2019.02.11.07.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:17:53 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v4 00/15] Habana Labs kernel driver
Date:   Mon, 11 Feb 2019 17:17:36 +0200
Message-Id: <20190211151751.12336-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
according to reviews done on v3, mainly for the command buffer, sysfs and MMU
patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.

The patch-set is rebased on v5.0-rc6.

Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033

Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003

Link to v1 cover letter: https://lwn.net/Articles/777342/

I would appricate any feedback, question and/or review.

Thanks,
Oded

p.s. for those who prefer to clone the tree instead of looking at the
emails, you can grab a copy from our company's page in GitHub:

https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v4_20190211

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
 .../ABI/testing/debugfs-driver-habanalabs     |  126 +
 .../ABI/testing/sysfs-driver-habanalabs       |  190 +
 MAINTAINERS                                   |    9 +
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/habanalabs/Kconfig               |   22 +
 drivers/misc/habanalabs/Makefile              |   14 +
 drivers/misc/habanalabs/asid.c                |   58 +
 drivers/misc/habanalabs/command_buffer.c      |  440 ++
 drivers/misc/habanalabs/command_submission.c  |  782 +++
 drivers/misc/habanalabs/context.c             |  216 +
 drivers/misc/habanalabs/debugfs.c             | 1064 ++++
 drivers/misc/habanalabs/device.c              | 1117 ++++
 drivers/misc/habanalabs/goya/Makefile         |    3 +
 drivers/misc/habanalabs/goya/goya.c           | 5359 +++++++++++++++++
 drivers/misc/habanalabs/goya/goyaP.h          |  193 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c     |  254 +
 drivers/misc/habanalabs/goya/goya_security.c  | 2999 +++++++++
 drivers/misc/habanalabs/habanalabs.h          | 1453 +++++
 drivers/misc/habanalabs/habanalabs_drv.c      |  465 ++
 drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
 drivers/misc/habanalabs/hw_queue.c            |  636 ++
 drivers/misc/habanalabs/hwmon.c               |  449 ++
 drivers/misc/habanalabs/include/armcp_if.h    |  335 ++
 .../goya/asic_reg/cpu_ca53_cfg_masks.h        |  191 +
 .../include/goya/asic_reg/cpu_ca53_cfg_regs.h |   61 +
 .../include/goya/asic_reg/cpu_if_regs.h       |   49 +
 .../include/goya/asic_reg/cpu_pll_regs.h      |  105 +
 .../include/goya/asic_reg/dma_ch_0_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_1_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_2_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_3_regs.h     |  209 +
 .../include/goya/asic_reg/dma_ch_4_regs.h     |  209 +
 .../include/goya/asic_reg/dma_macro_masks.h   |  105 +
 .../include/goya/asic_reg/dma_macro_regs.h    |  181 +
 .../include/goya/asic_reg/dma_nrtr_masks.h    |  209 +
 .../include/goya/asic_reg/dma_nrtr_regs.h     |  227 +
 .../include/goya/asic_reg/dma_qm_0_masks.h    |  465 ++
 .../include/goya/asic_reg/dma_qm_0_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_1_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_2_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_3_regs.h     |  179 +
 .../include/goya/asic_reg/dma_qm_4_regs.h     |  179 +
 .../include/goya/asic_reg/goya_blocks.h       | 1372 +++++
 .../include/goya/asic_reg/goya_masks.h        |  275 +
 .../include/goya/asic_reg/goya_regs.h         |  117 +
 .../include/goya/asic_reg/ic_pll_regs.h       |  105 +
 .../include/goya/asic_reg/mc_pll_regs.h       |  105 +
 .../include/goya/asic_reg/mme1_rtr_masks.h    |  653 ++
 .../include/goya/asic_reg/mme1_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme2_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme3_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme4_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme5_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme6_rtr_regs.h     |  331 +
 .../include/goya/asic_reg/mme_cmdq_masks.h    |  373 ++
 .../include/goya/asic_reg/mme_cmdq_regs.h     |  139 +
 .../include/goya/asic_reg/mme_masks.h         | 1537 +++++
 .../include/goya/asic_reg/mme_qm_masks.h      |  465 ++
 .../include/goya/asic_reg/mme_qm_regs.h       |  179 +
 .../include/goya/asic_reg/mme_regs.h          | 1153 ++++
 .../include/goya/asic_reg/mmu_masks.h         |  143 +
 .../include/goya/asic_reg/mmu_regs.h          |   53 +
 .../include/goya/asic_reg/pci_nrtr_masks.h    |  209 +
 .../include/goya/asic_reg/pci_nrtr_regs.h     |  227 +
 .../include/goya/asic_reg/pcie_aux_regs.h     |  243 +
 .../goya/asic_reg/psoc_emmc_pll_regs.h        |  105 +
 .../goya/asic_reg/psoc_global_conf_masks.h    |  447 ++
 .../goya/asic_reg/psoc_global_conf_regs.h     |  745 +++
 .../include/goya/asic_reg/psoc_mme_pll_regs.h |  105 +
 .../include/goya/asic_reg/psoc_pci_pll_regs.h |  105 +
 .../include/goya/asic_reg/psoc_spi_regs.h     |  143 +
 .../goya/asic_reg/sram_y0_x0_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x1_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x2_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x3_rtr_regs.h       |   83 +
 .../goya/asic_reg/sram_y0_x4_rtr_regs.h       |   83 +
 .../include/goya/asic_reg/stlb_masks.h        |  117 +
 .../include/goya/asic_reg/stlb_regs.h         |   55 +
 .../include/goya/asic_reg/tpc0_cfg_masks.h    | 1607 +++++
 .../include/goya/asic_reg/tpc0_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc0_cmdq_masks.h   |  373 ++
 .../include/goya/asic_reg/tpc0_cmdq_regs.h    |  139 +
 .../goya/asic_reg/tpc0_eml_cfg_masks.h        |  347 ++
 .../include/goya/asic_reg/tpc0_eml_cfg_regs.h |  313 +
 .../include/goya/asic_reg/tpc0_nrtr_masks.h   |  209 +
 .../include/goya/asic_reg/tpc0_nrtr_regs.h    |  227 +
 .../include/goya/asic_reg/tpc0_qm_masks.h     |  465 ++
 .../include/goya/asic_reg/tpc0_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc1_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc1_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc1_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc1_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc2_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc2_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc2_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc2_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc3_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc3_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc3_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc3_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc4_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc4_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc4_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc4_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc5_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc5_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc5_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc5_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc6_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc6_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc6_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc6_rtr_regs.h     |  323 +
 .../include/goya/asic_reg/tpc7_cfg_regs.h     |  887 +++
 .../include/goya/asic_reg/tpc7_cmdq_regs.h    |  139 +
 .../include/goya/asic_reg/tpc7_nrtr_regs.h    |  227 +
 .../include/goya/asic_reg/tpc7_qm_regs.h      |  179 +
 .../include/goya/asic_reg/tpc_pll_regs.h      |  105 +
 drivers/misc/habanalabs/include/goya/goya.h   |   41 +
 .../include/goya/goya_async_events.h          |  186 +
 .../misc/habanalabs/include/goya/goya_fw_if.h |   28 +
 .../habanalabs/include/goya/goya_packets.h    |  129 +
 drivers/misc/habanalabs/include/hl_boot_if.h  |   30 +
 .../include/hw_ip/mmu/mmu_general.h           |   45 +
 .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
 drivers/misc/habanalabs/include/qman_if.h     |   56 +
 drivers/misc/habanalabs/irq.c                 |  325 +
 drivers/misc/habanalabs/memory.c              | 1722 ++++++
 drivers/misc/habanalabs/mmu.c                 |  690 +++
 drivers/misc/habanalabs/sysfs.c               |  537 ++
 include/uapi/misc/habanalabs.h                |  444 ++
 132 files changed, 51224 insertions(+), 1 deletion(-)
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
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_ca53_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/cpu_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_ch_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_macro_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/dma_qm_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_blocks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/goya_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/ic_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme5_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme6_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mme_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/mmu_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pci_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/pcie_aux_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_emmc_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_mme_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_pci_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_spi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x0_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x1_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x2_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x3_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/sram_y0_x4_rtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_cmdq_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_eml_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_masks.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_nrtr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/tpc0_qm_masks.h
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
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
 create mode 100644 drivers/misc/habanalabs/include/hl_boot_if.h
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

