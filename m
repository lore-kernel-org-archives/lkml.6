Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeCMW0Z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbeCMW0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:26:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA2020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Subject: [PATCH v1 0/4] PCI/VPD: Encapsulate VPD stuff in vpd.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:26:14 -0500
Message-ID: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is strictly cleanup, not intended to change or fix anything.

Move all the VPD-related code and structures to drivers/pci/vpd.c.

---

Bjorn Helgaas (4):
      PCI/VPD: Move VPD access code to vpd.c
      PCI/VPD: Move VPD sysfs code to vpd.c
      PCI/VPD: Move VPD quirks to vpd.c
      PCI/VPD: Move VPD structures to vpd.c


 drivers/pci/access.c    |  368 ------------------------------
 drivers/pci/pci-sysfs.c |   67 -----
 drivers/pci/pci.h       |   19 --
 drivers/pci/quirks.c    |  121 ----------
 drivers/pci/vpd.c       |  573 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 578 insertions(+), 570 deletions(-)
