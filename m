Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518515806-2-9701110653907158404
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518515805; b=dndcAsKOFWw/a7LwirgaSWzvG/EW67CkhHJES5KXvBlx0kR
    AVH08u8CjtHQPV49bZolRk59DRDyswt2v2hRe2s3yYenOHFjQcY8TqTPD9ELAlIK
    /dpazYZfuQhyEolIi0dA3M0WQpJPwe2fpLfg1Mg8PR6vccSqCeO8PVnak1lkngag
    2BnOKDVtw6U5p5ulffrqfjy8ud5IwAf1NEJ3feaOfUwKI8EzZcHL0p1lul7ApmR4
    QplnOHLHRLtTBwzjf0gOO+g3PgitgqV/4sJmwpZYsYK0A6u8ShuHngAymy8+T5XP
    sFXXZqnaNDNrP8YLC/cOkGgoDHDu5rfPOu50Oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518515805; bh=4usZ/qYSuRu1EJb6FjGvCQ/ezp
    uERTVbj7ZAl8QM7T0=; b=jBV9ux899VuISG9YrPcyznp8gOovYYpUL/LBEa1OHB
    puellb+mXTO+Zv2ec/Lf0VpKp08H443WVYpQzajKTdtyqm1wTgsbYhi7BI0IIYnF
    ArktUiNd/TPB9iAbLXKot80+8TbLXgf8P7YKmxRT8ABU0/uHdMAkKNW7QdZZLTV6
    HRuAY4DIt8WQIUc65CGhjLT6Ns8mUlFog+XZRWqMbg8Lm7ey4mQwlJ/IgdQLBNKi
    u53m67EtybZZSOeVJzHI5npfcEcpOnw5J8QIvcutdQm1uxaMsSjyIwEmpqPNFYIL
    /ny8G9aKfBJ57biawJDAaIUiZJGooJqXYkmeuUbDSZzA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbeBMJ4L (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:56:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:27114 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933834AbeBMJfP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889469"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v4 00/24] FPGA Device Feature List (DFL) Device Drivers
Date: Tue, 13 Feb 2018 17:24:29 +0800
Message-Id: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is v4 patch-series adding drivers for FPGA DFL devices.
(This is the new version of [PATCH v3 00/21] Intel FPGA Device Drivers[1])

This patch series provides a common framework to support FPGA Device Feature
List (DFL), and also feature dev drivers under this DFL framework to provide
interfaces for userspace applications to configure, enumerate, open, and
access FPGA accelerators on DFL based FPGA device and enables system level
management functions such as FPGA partial reconfiguration, power management
and virtualization.

This patch series only adds the basic functions for FPGA accelerators and
partial reconfiguration. Patches for more functions, e.g power management
and virtualization, will be submitted after this series gets reviewed.

Note this patch series is only verified on DFL based Intel(R) FPGA PCIe
devices (e.g Intel Server Platform with In-package FPGA and Intel FPGA PCIe
Acceleration Cards).

Patch 1: add a document for FPGA DFL framework driver overview, including
Device Feature List (DFL) introduction, the HW architecture, driver
organization, device enumeration, virtualization and opens.

Patch 2: add region_id for fpga_image_info data structure, which allows
driver to pass region id information to fpga-mgr for FPGA reconfiguration
function. (Used by Patch 14)

Patch 3: add a 'status' sysfs interface to fpga-mgr class, it reflects
the status of the fpga-mgr including reconfiguration errors. (Used by
Patch 16)

Patch 4-7: add FPGA device feature list support, it provides common
enumeration interfaces which creates container device (FPGA base region)
and all feature devices by walking through all the 'Device Feature Lists'
provided low level drivers.

Patch 8-9: implement FPGA PCIe device driver. It locates all 'Device
Feature Lists' in PCIe device memory and invokes common interfaces from
above device feature list framework to finish the enumeration.

Patch 10-15: implement FPGA Management Engine (FME) driver. It's a
platform driver matching with the FME platform device created by above
device feature list framework during enumeration. Sysfs and device file
ioctls are exposed as user interfaces to allow partial reconfiguration
to Accelerated Function Units (AFUs) from user space applications.

Patch 16-19: implement FPGA manager/bridge/region platform drivers for
Intel FPGA Management Engine (FME). These platform drivers match with
platform devices created by above FME driver, they use the generic
fpga-mgr/bridge/region class infrastructure to implement FPGA partial
reconfiguration function.

Patch 20-24: implement FPGA Accelerated Function Unit (AFU) driver.
It's a platform driver matching with AFU platform device created by above
device feature list framework during enumeration. It provides user
interfaces to expose the AFU MMIO region, map/unmap dma buffer, and
control the port which AFU connects to.

Changes from v3:
- Fix SPDX license issue.
- Rename documentation to dfl.txt, add introduction for Device Feature List
  (DFL) and re-organize the content.
- Rename to FPGA Device Feature List (DFL) drivers from Intel FPGA device
  drivers for better reuse purposes. Unified driver and files to dfl-*.*
- Remove static feature_info table from common enumeration code, and switch
  to use feature id for sub feature driver matching.
- Remove next_afu register checking for AFU from common enumeration code.
- Remove interface_id sysfs for dfl-fme-mgr and use per fpga-region
  compat_id instead. (new patch 13, 15, 19).
- Add more comments for driver data structures and functions.
- Fix typos, issues in debug message/commit message and other places.

Changes from v2:
- Split common enumeration code from pcie driver to a separated module
  which for device feature list support.
- Drop fpga-dev class and switch to use fpga base region as container.
- Update the intel-fpga.txt documentation for new driver organization.
- Rename feature device drivers for future code reuse.
- Rebase code due to fpga APIs changes
- replace bitfields with marco and shift.
- fix typos, checkpatch issue and other comments.

Changes from v1:
- Use GPLv2 license instead of Dual BSD/GPL.
- Move the code to drivers/fpga folder.
- Update the intel-fpga.txt documentation for new driver organization.
- Add documentation for new sysfs interfaces.
- Switch to use common fpga-region interface for partial reconfiguration
  (PR) function in FME. It creates fpga-region/fpga-mgr/fpga-bridge
  platform devices and leave the implementation to their platform drivers.
- Add platform drivers for FME fpga-mgr/bridge/region platform devices.
- Fix kbuild warnings, typos and other comments.

This patch series depends on the below patchset from Alan Tull.
[PATCH v3 0/5] fpga: don't use drvdata in common fpga code[2]

[1] https://marc.info/?l=linux-api&m=151176589114857&w=2
[2] https://marc.info/?l=linux-fpga&m=151803761521039&w=2

Kang Luwei (3):
  fpga: dfl: add FPGA Management Engine driver basic framework
  fpga: dfl: fme: add header sub feature support
  fpga: dfl: fme: add partial reconfiguration sub feature support

Wu Hao (18):
  docs: fpga: add a document for FPGA Device Feature List (DFL)
    Framework Overview
  fpga: mgr: add region_id to fpga_image_info
  fpga: mgr: add status for fpga-manager
  fpga: add device feature list support
  fpga: dfl: add chardev support for feature devices
  fpga: dfl: adds fpga_cdev_find_port
  fpga: dfl-pci: add enumeration for feature devices
  fpga: dfl: fme: add FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls
    support
  fpga: region: add compat_id support
  fpga: dfl-fme-pr: add compat_id support for dfl-fme-region platform
    device.
  fpga: dfl: add fpga manager platform driver for FME
  fpga: dfl: add fpga bridge platform driver for FME
  fpga: dfl: add fpga region platform driver for FME
  fpga: dfl-fme-region: add compat_id support
  fpga: dfl: add FPGA Accelerated Function Unit driver basic framework
  fpga: dfl: afu: add header sub feature support
  fpga: dfl: afu: add FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls
    support
  fpga: dfl: afu: add FPGA_PORT_DMA_MAP/UNMAP ioctls support

Xiao Guangrong (2):
  fpga: dfl: add feature device infrastructure
  fpga: dfl: afu: add user afu sub feature support

Zhang Yi (1):
  fpga: add FPGA DFL PCIe device driver

 Documentation/ABI/testing/sysfs-class-fpga-manager |  24 +
 Documentation/ABI/testing/sysfs-class-fpga-region  |   5 +
 Documentation/ABI/testing/sysfs-platform-dfl-fme   |  23 +
 Documentation/ABI/testing/sysfs-platform-dfl-port  |  16 +
 Documentation/fpga/dfl.txt                         | 382 ++++++++
 Documentation/ioctl/ioctl-number.txt               |   1 +
 drivers/fpga/Kconfig                               |  68 ++
 drivers/fpga/Makefile                              |  14 +
 drivers/fpga/dfl-afu-dma-region.c                  | 463 ++++++++++
 drivers/fpga/dfl-afu-main.c                        | 476 ++++++++++
 drivers/fpga/dfl-afu-region.c                      | 165 ++++
 drivers/fpga/dfl-afu.h                             | 100 +++
 drivers/fpga/dfl-fme-br.c                          |  85 ++
 drivers/fpga/dfl-fme-main.c                        | 281 ++++++
 drivers/fpga/dfl-fme-mgr.c                         | 290 ++++++
 drivers/fpga/dfl-fme-pr.c                          | 517 +++++++++++
 drivers/fpga/dfl-fme-pr.h                          | 115 +++
 drivers/fpga/dfl-fme-region.c                      |  90 ++
 drivers/fpga/dfl-fme.h                             |  38 +
 drivers/fpga/dfl-pci.c                             | 322 +++++++
 drivers/fpga/dfl.c                                 | 982 +++++++++++++++++++++
 drivers/fpga/dfl.h                                 | 462 ++++++++++
 drivers/fpga/fpga-mgr.c                            |  28 +
 drivers/fpga/fpga-region.c                         |  19 +
 include/linux/fpga/fpga-mgr.h                      |  11 +
 include/linux/fpga/fpga-region.h                   |  13 +
 include/uapi/linux/fpga-dfl.h                      | 176 ++++
 27 files changed, 5166 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-fme
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-port
 create mode 100644 Documentation/fpga/dfl.txt
 create mode 100644 drivers/fpga/dfl-afu-dma-region.c
 create mode 100644 drivers/fpga/dfl-afu-main.c
 create mode 100644 drivers/fpga/dfl-afu-region.c
 create mode 100644 drivers/fpga/dfl-afu.h
 create mode 100644 drivers/fpga/dfl-fme-br.c
 create mode 100644 drivers/fpga/dfl-fme-main.c
 create mode 100644 drivers/fpga/dfl-fme-mgr.c
 create mode 100644 drivers/fpga/dfl-fme-pr.c
 create mode 100644 drivers/fpga/dfl-fme-pr.h
 create mode 100644 drivers/fpga/dfl-fme-region.c
 create mode 100644 drivers/fpga/dfl-fme.h
 create mode 100644 drivers/fpga/dfl-pci.c
 create mode 100644 drivers/fpga/dfl.c
 create mode 100644 drivers/fpga/dfl.h
 create mode 100644 include/uapi/linux/fpga-dfl.h

-- 
2.7.4

