Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967411AbeE2V7D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:59:03 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46501 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966679AbeE2V7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:59:01 -0400
X-Google-Smtp-Source: ADUXVKIQMflu1SfGIiVBqbr0rxf/AH20AH+b3byPBLMG/gie7nk1t4Khi2BaXDYY5ZQlz1pLTxc5lg==
From: Ray Jui <ray.jui@broadcom.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/6] PAXB INTx support with proper model
Date: Tue, 29 May 2018 14:58:44 -0700
Message-Id: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds PCIe legacy interrupt (INTx) support to the iProc
PCIe driver by modeling it with its own IRQ domain. All 4 interrupts INTA,
INTB, INTC, INTD share the same interrupt line connected to the GIC
in the system. This is now modeled by using its own IRQ domain.

Also update all relevant devicetree files to adapt to the new model

This patch series is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: pcie-intx-v1

Ray Jui (6):
  PCI: iproc: Update iProc PCI binding for INTx support
  PCI: iproc: Add INTx support with better modeling
  arm: dts: Change PCIe INTx mapping for Cygnus
  arm: dts: Change PCIe INTx mapping for NSP
  arm: dts: Change PCIe INTx mapping for HR2
  arm64: dts: Change PCIe INTx mapping for NS2

 .../devicetree/bindings/pci/brcm,iproc-pcie.txt    | 31 +++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 18 +++-
 arch/arm/boot/dts/bcm-hr2.dtsi                     | 18 +++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     | 27 ++++--
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   | 19 +++--
 drivers/pci/host/pcie-iproc-platform.c             |  2 +
 drivers/pci/host/pcie-iproc.c                      | 95 +++++++++++++++++++++-
 drivers/pci/host/pcie-iproc.h                      |  6 ++
 8 files changed, 188 insertions(+), 28 deletions(-)

-- 
2.1.4
