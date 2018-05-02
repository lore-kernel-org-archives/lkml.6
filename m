Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230105-2-17913845562604108183
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230105; b=je8dTkO3Ci4Tq2zUub632Zea3NHgJoa2T6D7at2tzu/xtfbMtz
    IW83E6VnKdflscj8T/6NRvsA8+z6cViRsZKPwmICJv9Xp56eVcBctFtZ5uQT3rPg
    nB6wRFI3vZggjM27Gn8xY179mGKim1llQnTrG2Y+ezdzSiCS3xyMgar5HXgykJr9
    l2JV0HjtMiUHqm4yE5Mvc+qR5SfzPnFk5wxFFOJ5LUK6pAP83NYKNX8cX5tDng4v
    xfK3iyMafOKXRJT9iXzo40N7VRsseA1+jNtfiJUucL2JJtM63dUpks7MvMDeW74p
    i4U1sP7d83sfeMYe97ISe1rXbjbgy5q9fPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525230105; bh=74Qko4R9gznF/JACvk3DoVXC0Fo486
    4+7qTXGAgIM+M=; b=lXp6G1GslxXZUClRAiPn5PnSo8t2Ct/wR+2XprVtR8+kxg
    BrAjIj42TY04uW6/YJ8HaJHBXDf1TqnPg67uYcNmJDP8kSetq3kmGvVOTeqo4pvF
    65G/VuQk1f7HvNCMUykUZROzeSCXFUVNu6TNy5oURL3xKJ7GFcup0IMEzlAZq6CP
    MpXoIKl4OUVPmSVM1ROte1XUdZBq+1J/O+EnKMVjsTTixQItxzvAEFgU07nnw3yV
    U1IkSMjpi2OgSq8NSWMiZNuBcdfNWH1LDDD8Ynkdj+HChk0Gt9GUN7xZfraNUI+7
    JsqBG47iPvKxyJbhwzwv8Hj8A4UGcmrkaRn53T1w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfALThWbPVodeDo4UHvsPjCdsnGi9dCWhDaCpRwYYOhpHxTZYj52n/AavKlwGgnIhffT8AxGPk4GAtLo4sxxZlJPFK8/3N1Jwa+Ld581aKiP3LFzozooW
    qwTm+1sslKqy5mLdVh/i6mxpFQLUW4mZL02D1T7w2pNvE6rvyDx2d7Ah2zVz/JojQkLIkZEx+wH7wc8dPfmbZ/le7+qK/yQ4J9kIoHsqZP5ZWxU1adrj/ZOh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=gu6fZOg2AAAA:8
    a=VwQbUJbxAAAA:8 a=IzA52azBULwISUeP4VgA:9 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750859AbeEBDBl (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:01:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:63823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbeEBDBl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058155"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 00/28] FPGA Device Feature List (DFL) Device Drivers
Date: Wed,  2 May 2018 10:50:03 +0800
Message-Id: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is v5 patch-series adding drivers for FPGA DFL devices.

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
organization, device enumeration and opens.

Patch 2: add region_id for fpga_image_info data structure, which allows
driver to pass region id information to fpga-mgr for FPGA reconfiguration
function. (Used by Patch 17)

Patch 3: add a 'status' sysfs interface to fpga-mgr class, it reflects
the status of the fpga-mgr including reconfiguration errors. (Used by
Patch 18)

Patch 4-5: add compat_id support in fpga manager and region, this compat
id is used for compatibility check before further actions (e.g partial
reconfiguration). (Used by Patch 19 and 22)

Patch 6-11: add FPGA device feature list support, it provides common
enumeration interfaces which creates container device (FPGA base region)
and all feature devices by walking through all the 'Device Feature Lists'
provided low level drivers. A global list is added to DFL framework to
manage port ops from different ports.

Patch 12-13: implement FPGA PCIe device driver. It locates all 'Device
Feature Lists' in PCIe device memory and invokes common interfaces from
above device feature list framework to finish the enumeration.

Patch 14-17: implement FPGA Management Engine (FME) driver. It's a
platform driver matching with the FME platform device created by above
device feature list framework during enumeration. Sysfs and device file
ioctls are exposed as user interfaces to allow partial reconfiguration
to Accelerated Function Units (AFUs) from user space applications.

Patch 18-22: implement FPGA manager/bridge/region platform drivers for
Intel FPGA Management Engine (FME). These platform drivers match with
platform devices created by above FME driver, they use the generic
fpga-mgr/bridge/region class infrastructure to implement FPGA partial
reconfiguration function.

Patch 23-28: implement FPGA Accelerated Function Unit (AFU) driver.
It's a platform driver matching with AFU platform device created by above
device feature list framework during enumeration. It provides user
interfaces to expose the AFU MMIO region, map/unmap dma buffer, and
control the port which AFU connects to.

Changes from v4:
- Update the dfl.txt documentation, remove descriptions for the APIs and
  features which are not implemented in this patch series.
- Add DFL_ / dfl_ prefix for APIs and data structure, to avoid directly
  using DFL_ / fpga_xxx naming.
- Use "static region" and "PR bistream" instead of "blue bitstream" and
  "green bistream" terminology in description to avoid misunderstanding.
- Fix building issues caused by BIT() on 64bit register definition and
  missing correct header file for readq and writeq.
- Remove port specific code in DFL framework, and introduce port ops support
  to resolve the dependency issue between FME driver module and Port driver
  module. (more details in Patch 10).
- Add compat id to fpga manager, as in case some hardware implements the
  compat id in fpga manager's register, not register belongs to fpga region,
  and its value is shared by all related fpga regions.
- Pass mapped ioaddr to fme manager platform device from dfl-fme-pr via pdata.
- Move PR hardware register definition to dfl-fme-mgr.c.
- Fix other comments from Alan and Moritz, including description improvement,
  coding style issue and etc.

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
[PATCH v4 0/4] fpga: change api, don't use drive data[1]

[1] https://marc.info/?l=linux-fpga&m=152356504900466&w=2

Kang Luwei (3):
  fpga: dfl: add FPGA Management Engine driver basic framework
  fpga: dfl: fme: add header sub feature support
  fpga: dfl: fme: add partial reconfiguration sub feature support

Wu Hao (22):
  docs: fpga: add a document for FPGA Device Feature List (DFL)
    Framework Overview
  fpga: mgr: add region_id to fpga_image_info
  fpga: mgr: add status for fpga-manager
  fpga: mgr: add compat_id support
  fpga: region: add compat_id support
  fpga: add device feature list support
  fpga: dfl: add chardev support for feature devices
  fpga: dfl: add dfl_fpga_cdev_find_port
  fpga: dfl: add dfl_fpga_port_ops support.
  fpga: dfl: add dfl_fpga_check_port_id function.
  fpga: dfl-pci: add enumeration for feature devices
  fpga: dfl: fme: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls
    support
  fpga: dfl: add fpga manager platform driver for FME
  fpga: dfl: fme-mgr: add compat_id support
  fpga: dfl: add fpga bridge platform driver for FME
  fpga: dfl: add fpga region platform driver for FME
  fpga: dfl: fme-region: add support for compat_id
  fpga: dfl: add FPGA Accelerated Function Unit driver basic framework
  fpga: dfl: afu: add port ops support
  fpga: dfl: afu: add header sub feature support
  fpga: dfl: afu: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls
    support
  fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support

Xiao Guangrong (2):
  fpga: dfl: add feature device infrastructure
  fpga: dfl: afu: add afu sub feature support

Zhang Yi (1):
  fpga: add FPGA DFL PCIe device driver

 Documentation/ABI/testing/sysfs-class-fpga-manager |   24 +
 Documentation/ABI/testing/sysfs-class-fpga-region  |    9 +
 Documentation/ABI/testing/sysfs-platform-dfl-fme   |   23 +
 Documentation/ABI/testing/sysfs-platform-dfl-port  |   16 +
 Documentation/fpga/dfl.txt                         |  285 ++++++
 Documentation/ioctl/ioctl-number.txt               |    1 +
 drivers/fpga/Kconfig                               |   68 ++
 drivers/fpga/Makefile                              |   14 +
 drivers/fpga/dfl-afu-dma-region.c                  |  463 +++++++++
 drivers/fpga/dfl-afu-main.c                        |  636 +++++++++++++
 drivers/fpga/dfl-afu-region.c                      |  166 ++++
 drivers/fpga/dfl-afu.h                             |  100 ++
 drivers/fpga/dfl-fme-br.c                          |  114 +++
 drivers/fpga/dfl-fme-main.c                        |  279 ++++++
 drivers/fpga/dfl-fme-mgr.c                         |  349 +++++++
 drivers/fpga/dfl-fme-pr.c                          |  474 ++++++++++
 drivers/fpga/dfl-fme-pr.h                          |   84 ++
 drivers/fpga/dfl-fme-region.c                      |   89 ++
 drivers/fpga/dfl-fme.h                             |   38 +
 drivers/fpga/dfl-pci.c                             |  310 ++++++
 drivers/fpga/dfl.c                                 | 1000 ++++++++++++++++++++
 drivers/fpga/dfl.h                                 |  416 ++++++++
 drivers/fpga/fpga-mgr.c                            |   28 +
 drivers/fpga/fpga-region.c                         |   22 +
 include/linux/fpga/fpga-mgr.h                      |   24 +
 include/linux/fpga/fpga-region.h                   |    2 +
 include/uapi/linux/fpga-dfl.h                      |  178 ++++
 27 files changed, 5212 insertions(+)
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
1.8.3.1

