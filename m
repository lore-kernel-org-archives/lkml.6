Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6CBECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03132086E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKKkqZ9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03132086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeISUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:10:46 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44684 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeISUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:10:46 -0400
Received: by mail-qt0-f196.google.com with SMTP id k38-v6so5238986qtk.11;
        Wed, 19 Sep 2018 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yl7hJQfbHmWVmbXV0889ELnzSrmV99yMhJ8XuDYbwZ8=;
        b=fKKkqZ9gs1Yfkqf+I0VJFevP6G+lkFmxyEFNzWQw154h5mTkR5/FKQrAmxJhduzv5a
         9Rzx7k9Knn6c6xgVnKkXZx8OHLMCJP2v+RebKBdDsQIllp1eWBTTAmU2Q+S0Axznxp03
         AhbG7YxvG5NMBaIWoUHoXLbDQbf4DN5gaCX65Y6pVhPpXx2MGDZcnCH7ffPR8cIYzTUc
         os//rUIXGWZtDRmPNTGbKs+CzSe1ApA20pU2QYITgz7x7wEu8yPsJ2Y6NqoaF2g56D3G
         00bxut+MwECZ8C70GD2g0efGZtPtogXlWgg0JXdCE3d1UlzvvkLH/amg9NswMJ8lYLg4
         4lgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yl7hJQfbHmWVmbXV0889ELnzSrmV99yMhJ8XuDYbwZ8=;
        b=OsNs2pQB/Uyri/f/UDTcN3hCau+cEslq0RwBWQwtQA6LhO2VyZZjkHqf/0mqbXRRic
         7Us0tuYlOIs54IwBTLmJxQ+l3P2tLTe90ziDoaZuwjUU5APLaVvc7xfNWwIg5tlxPPAq
         iRbq/FsA4G/B6COrRkld8pMk99Trg0/t2lyf2GyeNFzt5eBEaqzVukgYOwTSS6XO/e+E
         F4Oh7jgHUdPMzMe/RrYNJ8QA9/UKyJ+bgAB68RdOrT3cw8CqAN0msRBvKFSOm5gtHT29
         BbvlxkDzPbL8TXd2+j2UMH50puOgLna11uYEoesRN6xwU2UUr86+n+/GL8Ihk6xkwgqw
         sk5A==
X-Gm-Message-State: APzg51Cmcw/+9EO1MwLM8+qtBtYSNpfwMAXBOEGRnHg+UuP2+mDRldT0
        r7J7vkUNTGZWRGPQQ5LOHEP3amgl
X-Google-Smtp-Source: ANB0Vdal1QtF3f8M5Ls2AR0mUR7sZl3+pFj3DV/5ABalduVnIWBhsh47/hvP8LnDfbPRDLYod4rpEw==
X-Received: by 2002:a0c:c686:: with SMTP id d6-v6mr24723169qvj.67.1537367553521;
        Wed, 19 Sep 2018 07:32:33 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:32:32 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 00/12] PCI: brcmstb: Add Broadcom Settopbox PCIe support (resend)
Date:   Wed, 19 Sep 2018 10:31:55 -0400
Message-Id: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the Broadcom Settopbox PCIe host
controller.  It is targeted to Broadcom Settopbox chips running on
ARM, ARM64, and MIPS platforms.

V5 Changes:
  - V4 had its own DMA ops structure in the PCIe driver which would
    override/coexist with the default arch DMA ops.  This approach was
    scrapped, and this version instead essentially implements custom
    definitions of the __phys_to_dma and __dma_to_phys operations for the
    three target arches: MIPs, ARM64, ARM.  This was the course suggested
    by one of the V4 reviewers (ChristophH).

    For MIPs and ARM64, the DMA remapping is easily accomplished by having
    custom definitions of __phys_to_dma and __dma_to_phys.  For
    MIPs/BMIPs, ARCH_HAS_PHYS_TO_DMA is already selected and the two
    functions are just modified.  For ARM64, this driver selects
    ARCH_HAS_PHYS_TO_DMA and declares and defines __phys_to_dma() and
    __dma_to_phys().  For ARM, things were not so simple.  The default
    functions like __arch_pfn_to_dma() had to be overridden by custom ones
    defined in arch/arm/mach-bcm/include/mach/memory.h.  For these
    functions to be "seen", we had to declare our own brcmstb_defconfig
    and no longer use multi_v7_defconfig.  This is unfortunate.

  - Commits have been better organized to first implement the main driver,
    then add features (MSI, DMA remap infrastructure), and then add
    the DMA remapping modifications for MIPs, ARM64, and ARM.

V4 Changes:
  - Merged all BrcmSTB PCIe controller files into a single file.
  - All new files now have the SPDX identifier.
  - Removed the list of PCIe controllers.
  - Removed "link-up" race.
  - Removed probe of msi psuedo-device.
  - Multiple comment text changes, as requested.
  - "SSC" => "Spread Spectrum Clocking".
  - Set 'memc' variable.
  - Unnecessary variable initializations removed (eg rc_bar2_size).
  - Added comment on "L23" link state.
  - Removed use of "__refdata".
  - Formatting of structure elements.

V3 Changes:
  - Fold pcie-brcmstb-msi.c into pcie-brcmstb.c
  - Use PCI_XXX constants for PCIe capability registers
  - Removal of any unused constants
  - Change s/pci/pcie/ for filenames, comment text
  - Config space access now uses 8/16/32 read/writes
  - Use proper multi-line comment style
  - Use function names, structure that are common in other host drivers
  - DT binding 'brcm,ssc' is now 'brcm,enable-ssc'
  - Dropped DT binding 'xyz-supply'
  - Not setting CRS support as Linux does it if it is advertised.
  - Removed code that was considered "debug code".
  - Use of_get_pcie_domain_nr()
  - Variable 'bridge_setup_done' removed.

V2 Changes:
* Patch brcmstb-add-memory-API:
  - fix DT_PROP_DATA_TO_U32 macro.
  - dropped one EXPORT_SYMBOL, changed the other to GPL.
* Patch DT-docs-for-Brcmstb-PCIe:
  - change 'brcm,gen' prop to standard 'max-link-speed'.
  - rewrite bindings commit to omit standard prop defs.
  - change props "supplies", "supply-names" to "xyz-supply"
* Patch removed: export-symbol-arch_setup_dma_ops [4/9]
* Patch brcmstb-add-dma-ranges:
  - use get_dma_ops(); also use a const dma_map_ops structure.
  - rewrite map_sg(), unmap_sg(), other calls like syng_sg_*()
  - omit brcm_mapping_error(), but added code in brcm_dma_supported()
  - put all of the notifier code in one compilation unit.



Florian Fainelli (1):
  soc: bcm: brcmstb: add memory API

Jim Quinlan (11):
  dt-bindings: pci: add DT docs for Brcmstb PCIe device
  PCI: brcmstb: add Broadcom STB PCIe host controller driver
  PCI: brcmstb: add dma-range mapping for inbound traffic
  PCI: brcmstb: add MSI capability
  MIPS: BMIPS: add dma remap for BrcmSTB PCIe
  PCI/MSI: enable PCI_MSI_IRQ_DOMAIN support for MIPS
  MIPS: BMIPS: add PCI bindings for 7425, 7435
  MIPS: BMIPS: enable PCI
  ARM64: declare __phys_to_dma on ARCH_HAS_PHYS_TO_DMA
  ARM64: add dma remap for BrcmSTB PCIe
  ARM: add dma remap for BrcmSTB PCIe

 .../devicetree/bindings/pci/brcmstb-pcie.txt       |   59 +
 arch/arm/Kconfig                                   |   33 +
 arch/arm/configs/brcmstb_defconfig                 |  204 +++
 arch/arm/configs/multi_v7_defconfig                |    3 -
 arch/arm/mach-bcm/Kconfig                          |   21 +-
 arch/arm/mach-bcm/Makefile.boot                    |    0
 arch/arm/mach-bcm/include/mach/irqs.h              |    3 +
 arch/arm/mach-bcm/include/mach/memory.h            |   47 +
 arch/arm/mach-bcm/include/mach/uncompress.h        |    8 +
 arch/arm64/include/asm/dma-direct.h                |   16 +
 arch/mips/Kconfig                                  |    3 +
 arch/mips/bmips/dma.c                              |    9 +
 arch/mips/boot/dts/brcm/bcm7425.dtsi               |   28 +
 arch/mips/boot/dts/brcm/bcm7435.dtsi               |   28 +
 arch/mips/boot/dts/brcm/bcm97425svmb.dts           |    4 +
 arch/mips/boot/dts/brcm/bcm97435svmb.dts           |    4 +
 drivers/pci/Kconfig                                |    2 +-
 drivers/pci/controller/Kconfig                     |   13 +
 drivers/pci/controller/Makefile                    |    1 +
 drivers/pci/controller/pcie-brcmstb.c              | 1554 ++++++++++++++++++++
 drivers/soc/bcm/brcmstb/Makefile                   |    2 +-
 drivers/soc/bcm/brcmstb/memory.c                   |  158 ++
 include/soc/brcmstb/common.h                       |   16 +
 include/soc/brcmstb/memory_api.h                   |   26 +
 24 files changed, 2217 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/brcmstb-pcie.txt
 create mode 100644 arch/arm/configs/brcmstb_defconfig
 create mode 100644 arch/arm/mach-bcm/Makefile.boot
 create mode 100644 arch/arm/mach-bcm/include/mach/irqs.h
 create mode 100644 arch/arm/mach-bcm/include/mach/memory.h
 create mode 100644 arch/arm/mach-bcm/include/mach/uncompress.h
 create mode 100644 arch/arm64/include/asm/dma-direct.h
 create mode 100644 drivers/pci/controller/pcie-brcmstb.c
 create mode 100644 drivers/soc/bcm/brcmstb/memory.c
 create mode 100644 include/soc/brcmstb/memory_api.h

-- 
1.9.0.138.g2de3478

