Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA1C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EFC217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBaln7Ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfAWABF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:01:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54973 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAWABE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:01:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so308471wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R6FPB3o/aTC8JPdd6m/J/PGGkau26BZyjDhEkbbitYA=;
        b=LBaln7Ji24/imqpzZVve+jcR5oInn7yWJn6b+BDrmPuO8Xz3XCWoI4Ennr6/PvCk6n
         N0yLuy0REchkouxa6gswrCBgZrmLsx/1i9T8piD1vsfNULDmGT+yluN53qx1aDGnAp/7
         JLOfgIRYHHcIzCkQO5r0vtK3qSMKbsgVTXBc3ImC69kXxNZYzJqMN/mPYsJDmEKZPrXf
         /c+yqGE8ngMEug/1HYdbPK0s4WdB+FzlMaK1aiXLd9mt92I+VQ6jDgNLmBEoT8pW7Ocb
         HG/n9iuCR6aChKShXYZBWEyaR0RQoweIWT4LDz0aF8fVKlfXRW7nn4EF/bEtXGuzxDcl
         ymYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R6FPB3o/aTC8JPdd6m/J/PGGkau26BZyjDhEkbbitYA=;
        b=pZ1xtW0dnsttSagKJe7j1l8oNCdlyE7/QxGnq+bgCOH71V9Tr+Qfcs2xHrhfKw4N6q
         8cXXdBTqX0ddTJ3a4gbc12jGm861MXICwghY5RTIsxDd68zrt8Gnxh1m9Cws76v00qLA
         Sas8lIOkZIoBjcX/OkgZzOR/yj8BBvRlCReVwsieL88Ve9icaWYMau8IanQqyXXUoXSN
         cEtjD0atRI3AsozwTmjzQ4Y2MqLlAIUp8PSVjAp2ydlrAp66k0qVEaO3BcpIijEG3r0f
         pJ1JNEVTqzC4HL0ZgjxUwzrJ/f65KtDy5q2dkCr7sDlIjd1ziJ8icYX1mqDY+7sY9fqI
         suLQ==
X-Gm-Message-State: AJcUukda9Y6V1hXeqHvTIgzXEOU8PvHXzQLvGwBi5U+SCxETXTdkbj2E
        xSwpvNaI3YsYzmDCRjmKfdZxf+lu
X-Google-Smtp-Source: ALg8bN6kIjDpgtXtrhHbKf8MCNKVeBeEQDf73fJQZLWAMBvtsIViDkAhjyjYwBLE33sYgFFeCGGvzA==
X-Received: by 2002:a1c:180a:: with SMTP id 10mr471616wmy.92.1548201659496;
        Tue, 22 Jan 2019 16:00:59 -0800 (PST)
Received: from oded-ubuntu-desktop.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 125sm97582630wmm.26.2019.01.22.16.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:00:58 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     ogabbay@habana.ai
Subject: [PATCH 00/15] Habana Labs kernel driver
Date:   Wed, 23 Jan 2019 02:00:42 +0200
Message-Id: <20190123000057.31477-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
Habana Labs since its inception two and a half years ago. 

Habana is a leading startup in the emerging AI processor space and we have
already started production of our first Goya inference processor PCIe card
and delivered it to customers. The Goya processor silicon has been tested
since June of 2018 and is production-qualified by now. The Gaudi training
processor solution is slated to sample in the second quarter of 2019.

This patch-set contains the kernel driver for Habana's AI Processors 
(AIP) that are designed to accelerate Deep Learning inference and training
workloads. The current version supports only the Goya processor and
support for Gaudi will be upstreamed after the ASIC will be available to
customers.

The Goya processor has been designed from the ground up for deep learning
inference workloads. It comprises a cluster of eight fully programmable
Tensor Processing Cores (TPC). The TPC core is a VLIW SIMD vector
processor with ISA and hardware that was tailored to serve deep learning
workloads efficiently. 

In addition, Goya contains software-managed, on-die memory along with five
separate DMA channels, a PCIe Gen4 x16 system interface and 4/8/16GB of
DDR4 memory.

Goya has 3 PCI bars (64-bit), which are not exposed to user-space. They
map the on-chip memory and configuration space (bar 0-1), MSI-X table 
(bar 2-3) and DDR4 memory (bar 4-5).

Each TPC engine and DMA channel has a H/W queue attached to it, called
QMAN. The S/W provides command buffers to the H/W queues (through the
kernel driver) and the H/W consumes the command buffers. To prevent
malicious users from stealing data from other users through the Host or
Device memory, Goya has an internal MMU and a security protection scheme.
In addition, The kernel driver parses the command buffer and rejects it if
it contains disallowed commands.

The QMANs are triggered by a write to a PI (producer index) register. The
QMAN H/W logic maintains a CI (consumer index) register. When PI==CI, the
queue is empty. When PI+1==CI, the queue is full (note the queue is
cyclic). Each entry in the H/W queue is 16-bytes, and contains
a pointer and length of a variable-size command buffer, which the user
fills with specific commands that the H/W logic can read and execute.

For each DMA QMAN, there is a completion queue that the QMAN writes to
when it finishes the execution of the command buffer. The QMAN also
sends an MSI-X interrupt after writing the completion entry.

Inference workloads running on Goya are associated with an address space
through the ASID (address-space ID) property. Goya supports up to 1024
ASIDs. The ASID value is updated by the kernel driver in the relevant
registers before scheduling a workload.

During its initialization, the driver registers itself to the PCI
subsystem. For each Habana PCI device found, a char device node (/dev/hlX)
is created.

The driver currently exposes a total of five IOCTLs. One IOCTL allows
the application to submit workloads to the device, and another to wait on
completion of submitted workloads. The other three IOCTLs are used for
memory management, command buffer creation and information/status
retrieval.

In addition, the driver exposes several sensors through the hwmon
subsystem and provides various system-level information in sysfs for
system administrators.

The first step for an application process is to open the correct hlX
device it wants to work with. Calls to open create a new "context" for
that application in the driver's internal structures and a unique ASID
is assigned to that context. The context object lives until the process
releases the file descriptor AND its command submissions have finished
executing on the device.

Next step is for the application to request information about the
device, such as amount of DDR4 memory. The application then can go on to
create command buffers for its command submissions and allocate and map
device or host memory (host memory can only be mapped) to the internal
device's MMU subsystem.

At this point the application can load various deep learning
topologies to the device DDR memory. After that, it can start to submit
inference workloads using those topologies. For each workload, the
the application receives a sequence number that represents the workload.
The application can then query the driver regarding the status of the
workload using that sequence number.

In case a workload didn't finish execution after 5 seconds (configurable
using a kernel module parameter) from the time it was scheduled to run, a
TDR (timeout detection & recovery) event occurs in the driver. The driver
will then mark that workload as "timed out", perform a minimal reset of
the device (DMA and compute units only) and abort all other workloads of
that context that were already submitted to the H/W queues.

I would appricate any feedback, question and/or review.

p.s. for those who prefer to clone the tree instead of looking at the
emails, you can grab a copy from our company's page in GitHub:

https://github.com/HabanaAI/linux/releases/tag/hl_patchset_v1

Thanks,
Oded

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
 drivers/misc/habanalabs/Makefile              |   14 +
 drivers/misc/habanalabs/asid.c                |   58 +
 drivers/misc/habanalabs/command_buffer.c      |  425 +
 drivers/misc/habanalabs/command_submission.c  |  799 ++
 drivers/misc/habanalabs/context.c             |  216 +
 drivers/misc/habanalabs/debugfs.c             | 1069 ++
 drivers/misc/habanalabs/device.c              | 1097 ++
 drivers/misc/habanalabs/goya/Makefile         |    3 +
 drivers/misc/habanalabs/goya/goya.c           | 6347 ++++++++++++
 drivers/misc/habanalabs/goya/goyaP.h          |  161 +
 drivers/misc/habanalabs/goya/goya_hwmgr.c     |  306 +
 drivers/misc/habanalabs/goya/goya_security.c  | 2999 ++++++
 drivers/misc/habanalabs/habanalabs.h          | 1464 +++
 drivers/misc/habanalabs/habanalabs_drv.c      |  474 +
 drivers/misc/habanalabs/habanalabs_ioctl.c    |  237 +
 drivers/misc/habanalabs/hw_queue.c            |  654 ++
 drivers/misc/habanalabs/hwmon.c               |  449 +
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
 drivers/misc/habanalabs/include/goya/goya.h   |  117 +
 .../include/goya/goya_async_events.h          |  186 +
 .../habanalabs/include/goya/goya_boot_if.h    |   32 +
 .../habanalabs/include/goya/goya_packets.h    |  234 +
 .../habanalabs/include/habanalabs_device_if.h |  397 +
 .../include/hw_ip/mmu/mmu_general.h           |   45 +
 .../habanalabs/include/hw_ip/mmu/mmu_v1_0.h   |   15 +
 drivers/misc/habanalabs/irq.c                 |  325 +
 drivers/misc/habanalabs/memory.c              | 1714 ++++
 drivers/misc/habanalabs/mmu.c                 |  604 ++
 drivers/misc/habanalabs/sysfs.c               |  690 ++
 include/uapi/misc/habanalabs.h                |  412 +
 145 files changed, 99610 insertions(+), 1 deletion(-)
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
 create mode 100644 drivers/misc/habanalabs/include/goya/goya_packets.h
 create mode 100644 drivers/misc/habanalabs/include/habanalabs_device_if.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_0.h
 create mode 100644 drivers/misc/habanalabs/irq.c
 create mode 100644 drivers/misc/habanalabs/memory.c
 create mode 100644 drivers/misc/habanalabs/mmu.c
 create mode 100644 drivers/misc/habanalabs/sysfs.c
 create mode 100644 include/uapi/misc/habanalabs.h

-- 
2.17.1

