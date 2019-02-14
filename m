Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79688222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC5gCEOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393948AbfBNQBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:01:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40349 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfBNQBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:01:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id q1so7043770wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3wVVFnzkegf18NEw394caGSDKJp4oN+9JjqCN487ujI=;
        b=lC5gCEOc7sx4mMFNNOQssV/qUFStEEcSU2SUnYdpZ16LxFG91svNwkljRCJFg12wfE
         LSgYIEamFcKj9Lqw5cSIQihZfT0F4zXHSftaktq9Q7QB0P/QvQdWFz0aMpEgSMzfp1VI
         4LVM/OawaJG+GgWi0MDJMKzJVVDjgrLvHsPkAi7eozArM62MhDA06cNT+c6V5S/3XdIj
         U+AQMweH4ghmfe4ppxsQ4aaD0AunmQ5felMCSpT8BxfL+72I2AXJtTl5F5jP7gRmTuhM
         DMRtu2MrY5bbg8b/rM9ao37ZZKV4Ns7iAUzfURZk8AT+0cCt5HytUi7sbT7yY42Q5GCq
         9SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3wVVFnzkegf18NEw394caGSDKJp4oN+9JjqCN487ujI=;
        b=gWOWZkBjiaGNmviXV1u399f4+VdKq3vuyYOqZ5EFdvHNIPuydpVvCFmQfIHx+Bb69T
         CEqNFCHEOxfTG7ssQFVu8VRiyo+QbBZvv3FZeX7l2G2hkfWkVvI89L6PyaQ4+uNyP7qx
         yJdHmhMV8IiZt2s4lWgnNxVTknR/zYdIS2qgVXRafupC1DXHyOLMfZByiarVkTnD8Yb2
         8VCXFMxz5QHk4N7XBzttdAaJBvdX5xEtvxnDDJq7cpEmeFNE6pZWjlEfzEaUwDK9XTPw
         aAqxMfrkQ1lAxU0ul7iEOamLbFuRAz+W9B0vOqSVfD+sCFeLUa3hdQMvRep/tPe1pqK9
         JVkA==
X-Gm-Message-State: AHQUAuaFMja8FpHh7W0vzyhgd3FbBFNZtRe9cJVKBfPAAKTGxgtd31l/
        Emm3odCOmV5cioncjZbQ3QQ=
X-Google-Smtp-Source: AHgI3IbtzEu2VoSOVABFKSaVxcqlsH0XnpUn52tvLBt+OiQ3vNQhVrp+/xhLsINDd2EN8lw4sSNNAw==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr3485906wrn.298.1550160076662;
        Thu, 14 Feb 2019 08:01:16 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u15sm5092855wmu.17.2019.02.14.08.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:01:15 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, olof@lixom.net
Cc:     ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: [PATCH v5 00/15] Habana Labs kernel driver
Date:   Thu, 14 Feb 2019 18:00:59 +0200
Message-Id: <20190214160114.26314-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is v5 of the Habana Labs kernel driver patch-set. The changes in this
version are mainly fixes to warnings that appear when compiling to i386
architecture.

Link to v4 cover letter: https://lkml.org/lkml/2019/2/11/993

Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033

Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003

Link to v1 cover letter: https://lwn.net/Articles/777342/

I would appricate any feedback, question and/or review.

Thanks,
Oded

p.s. for those who prefer to clone the tree instead of looking at the
emails, you can grab a copy from our company's page in GitHub:

https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v5_20190214

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
 drivers/misc/habanalabs/command_buffer.c      |  441 ++
 drivers/misc/habanalabs/command_submission.c  |  782 +++
 drivers/misc/habanalabs/context.c             |  216 +
 drivers/misc/habanalabs/debugfs.c             | 1071 ++++
 drivers/misc/habanalabs/device.c              | 1122 ++++
 drivers/misc/habanalabs/goya/Makefile         |    3 +
 drivers/misc/habanalabs/goya/goya.c           | 5372 +++++++++++++++++
 drivers/misc/habanalabs/goya/goyaP.h          |  190 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c     |  254 +
 drivers/misc/habanalabs/goya/goya_security.c  | 2999 +++++++++
 drivers/misc/habanalabs/habanalabs.h          | 1453 +++++
 drivers/misc/habanalabs/habanalabs_drv.c      |  465 ++
 drivers/misc/habanalabs/habanalabs_ioctl.c    |  234 +
 drivers/misc/habanalabs/hw_queue.c            |  635 ++
 drivers/misc/habanalabs/hwmon.c               |  449 ++
 drivers/misc/habanalabs/include/armcp_if.h    |  335 +
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
 drivers/misc/habanalabs/include/goya/goya.h   |   45 +
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
 132 files changed, 51250 insertions(+), 1 deletion(-)
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

