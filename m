Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbeEQMAq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:00:46 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40504 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeEQMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:00:44 -0400
X-Google-Smtp-Source: AB8JxZo50pL9YlnNtwU4zvYYTBm7LV8U7uRs93ftcwwaynhBLkAWUep7sBxVT+qrvsbnavOrDYp+7w==
From: dmeyer@gigaio.com
To: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>
Subject: [PATCH 0/2] PCI Quirk Patchset for Microsemi Switchtec NTB
Date: Thu, 17 May 2018 05:00:11 -0700
Message-Id: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Meyer <dmeyer@gigaio.com>

This patch series addresses the need to be able to run Microsemi
Switchtec NTB configurations with the IOMMU in the hosts turned on.
Because of the nature PCI Quirk implementation, it was preferable
to migrate the Microsemi PCI vendor and device definitions to the
Linux canonical location. Logan Gunthorpe requested that this
migration be done as a separate patch in a set, and so this patch
series was created as shown here.

The first patch encapsulates the movement of constants from
switchtec.h to pci_ids.h, with commensurate changes to the source
files. This patch is not dependent on any other work.

The second patch is the PCI quirk implementation itself, and is
completely dependent upon the first patch in this series.

Testing of the quirk was done on with a 2-host x86-64 system
with all combinations of IOMMU off/on. The ntb_perf module was
used as test stimulus. 

Doug Meyer (2):
  NTB: Migrate PCI Constants to Cannonical PCI Header
  NTB: PCI Quirk to Enable Switchtec NT Functionality with IOMMU On

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |   3 +-
 drivers/pci/quirks.c                   | 196 +++++++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c         |  15 ++-
 include/linux/pci_ids.h                |  32 ++++++
 include/linux/switchtec.h              |   4 -
 5 files changed, 237 insertions(+), 13 deletions(-)

-- 
1.8.3.1
