Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3148351-1525382135-2-6030710053178413053
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525382134; b=Pwz1yMp4TJ5J2oPpeRqJDLNTAx9CuXXVpNWfQFgXyAR+iSaTcL
    Qi/pzZb3rrb77JolWwwofCrOfwNW7cZy007PThdhzuLNO+CF3QFU7prJztBO3tEI
    TlJTt7JRuIo44MuZ9TKekhx2D5Aamf6jMcXs7U8xd47M6S9Mk+9kzyx3w0F9TiSn
    K8xsMOH14B0LvaNa6C4jHeZ9S59P6IuWrulfmNQuD8DQPcjzUoQARlJGLj3v+j1k
    GZI1REcH7eU23M4sWQPnDL1xFtYkDTBVfPTNtYiPTWKBdCXW0WR7wShZYcuBdAAV
    znj+nY8FEEwgRFvQvxbcYU5+PipZ0CYBVKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525382134; bh=qpthZu+VNOPLYDef0oKiLbJ9AcuWKKVp8pfZKprlw5
    Y=; b=fJO5LJpibW4wZdr9TlVuWhyua7J+9tL0ty1xbMT2Lu2t5Lmsz9p++NBPju
    iYnF+YZj+7c2pTM1ZmMz9cbx96sBAvLpWp0fEEtzUrG+R0BfLLwuDf2/3UHeZWiq
    XR8nJwgpC3yhanerZ9e+6XNETMAA6Cq3cb7G9KZeCMciJ68BbxEf67MN5k33dpZ0
    BufGXgUwVWGmhO9CaYp/zlxhIhf9m5IQevr9P5HqAcNi9K+HVa1HDXKNTyQOwMDr
    PWtwSzV/1+KpfwV7QiOkhX8dJ7vDvhvMQNk1nUFUWMd95Z2HUQZUOlFPkMQMTUGw
    4xHV4j3PoVFT0E2X+Nm5UXMEvajQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=ISPSvVIF x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=ISPSvVIF x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPe0Ki3PcERPY/2dlwKjOqeuB5ova6ewtF3/7jicRmgtw+m9m8QeR+y8Cr05ifsTSnyXq6vv/x/edyxMO571lJGsmZO8nD8I2H+6EU9FaXNBJoleckbE
    yG3hqtenvLUx70Fz997hofOG+cm1Sf0ed3Wa+wCdrMG2nIGjKIR4FPS/kDFoqlm68xUPlwAE9cYUBF067PB/KGXNEywi3PiiZBwIvFHHbs5io4Oec0w6pU0J
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=GEo-zhqP93CLGq4jN5kA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbeECVPb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 17:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeECVPa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 May 2018 17:15:30 -0400
X-Google-Smtp-Source: AB8JxZpbcLnz/zhJ/a6xwenDL63l0xSddA2ENLTfL6X6YxaTJfpv2o1s2Tt2MHkZC2oJMzRloL0gALO+6uakDmo9Rw8=
MIME-Version: 1.0
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 3 May 2018 16:14:48 -0500
X-Gmail-Original-Message-ID: <CANk1AXSFQzBoZWQu4R9aYQSXFbr76UQ_-39ENe5hSOncKuDq+A@mail.gmail.com>
Message-ID: <CANk1AXSFQzBoZWQu4R9aYQSXFbr76UQ_-39ENe5hSOncKuDq+A@mail.gmail.com>
Subject: Re: [PATCH v5 00/28] FPGA Device Feature List (DFL) Device Drivers
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 1, 2018 at 9:50 PM, Wu Hao <hao.wu@intel.com> wrote:
> Hi All,
>
> Here is v5 patch-series adding drivers for FPGA DFL devices.
>
> This patch series provides a common framework to support FPGA Device Feature
> List (DFL), and also feature dev drivers under this DFL framework to provide
> interfaces for userspace applications to configure, enumerate, open, and
> access FPGA accelerators on DFL based FPGA device and enables system level
> management functions such as FPGA partial reconfiguration, power management
> and virtualization.

Hi Hao,

I've started looking at your v5 here.  It's 5212 lines of code, so
it's not tiny.

I see a lot of renaming from 'fpga' to 'dfl', thanks for doing that.

The main thing that stands out at first look is a new method of
registering port ops.  It would be better if the fpga bridge framework
were expanded or changed somehow to do that.  It's like we have two
bridge frameworks now.

I see that there isn't a way of specifying which FPGA mgr driver to
use, so dfl-fme-mgr.c is tied to dfl-fme-pr.c.  It would be better if
the DFL could specify which fpga manager driver to use.

Maybe I'm repeating myself here, the biggest question I'm asking
myself is: If someone had a different FPGA or a different static
region, how much of this code can be reused?  I would hope that all of
it could except for the fpga manager/bridge drivers.  That was the
intent of the original FPGA framework.  I'll have more time next week
to look in more depth.

Alan

>
> This patch series only adds the basic functions for FPGA accelerators and
> partial reconfiguration. Patches for more functions, e.g power management
> and virtualization, will be submitted after this series gets reviewed.
>
> Note this patch series is only verified on DFL based Intel(R) FPGA PCIe
> devices (e.g Intel Server Platform with In-package FPGA and Intel FPGA PCIe
> Acceleration Cards).
>
> Patch 1: add a document for FPGA DFL framework driver overview, including
> Device Feature List (DFL) introduction, the HW architecture, driver
> organization, device enumeration and opens.
>
> Patch 2: add region_id for fpga_image_info data structure, which allows
> driver to pass region id information to fpga-mgr for FPGA reconfiguration
> function. (Used by Patch 17)
>
> Patch 3: add a 'status' sysfs interface to fpga-mgr class, it reflects
> the status of the fpga-mgr including reconfiguration errors. (Used by
> Patch 18)
>
> Patch 4-5: add compat_id support in fpga manager and region, this compat
> id is used for compatibility check before further actions (e.g partial
> reconfiguration). (Used by Patch 19 and 22)
>
> Patch 6-11: add FPGA device feature list support, it provides common
> enumeration interfaces which creates container device (FPGA base region)
> and all feature devices by walking through all the 'Device Feature Lists'
> provided low level drivers. A global list is added to DFL framework to
> manage port ops from different ports.
>
> Patch 12-13: implement FPGA PCIe device driver. It locates all 'Device
> Feature Lists' in PCIe device memory and invokes common interfaces from
> above device feature list framework to finish the enumeration.
>
> Patch 14-17: implement FPGA Management Engine (FME) driver. It's a
> platform driver matching with the FME platform device created by above
> device feature list framework during enumeration. Sysfs and device file
> ioctls are exposed as user interfaces to allow partial reconfiguration
> to Accelerated Function Units (AFUs) from user space applications.
>
> Patch 18-22: implement FPGA manager/bridge/region platform drivers for
> Intel FPGA Management Engine (FME). These platform drivers match with
> platform devices created by above FME driver, they use the generic
> fpga-mgr/bridge/region class infrastructure to implement FPGA partial
> reconfiguration function.
>
> Patch 23-28: implement FPGA Accelerated Function Unit (AFU) driver.
> It's a platform driver matching with AFU platform device created by above
> device feature list framework during enumeration. It provides user
> interfaces to expose the AFU MMIO region, map/unmap dma buffer, and
> control the port which AFU connects to.
>
> Changes from v4:
> - Update the dfl.txt documentation, remove descriptions for the APIs and
>   features which are not implemented in this patch series.
> - Add DFL_ / dfl_ prefix for APIs and data structure, to avoid directly
>   using DFL_ / fpga_xxx naming.
> - Use "static region" and "PR bistream" instead of "blue bitstream" and
>   "green bistream" terminology in description to avoid misunderstanding.
> - Fix building issues caused by BIT() on 64bit register definition and
>   missing correct header file for readq and writeq.
> - Remove port specific code in DFL framework, and introduce port ops support
>   to resolve the dependency issue between FME driver module and Port driver
>   module. (more details in Patch 10).
> - Add compat id to fpga manager, as in case some hardware implements the
>   compat id in fpga manager's register, not register belongs to fpga region,
>   and its value is shared by all related fpga regions.
> - Pass mapped ioaddr to fme manager platform device from dfl-fme-pr via pdata.
> - Move PR hardware register definition to dfl-fme-mgr.c.
> - Fix other comments from Alan and Moritz, including description improvement,
>   coding style issue and etc.
>
> Changes from v3:
> - Fix SPDX license issue.
> - Rename documentation to dfl.txt, add introduction for Device Feature List
>   (DFL) and re-organize the content.
> - Rename to FPGA Device Feature List (DFL) drivers from Intel FPGA device
>   drivers for better reuse purposes. Unified driver and files to dfl-*.*
> - Remove static feature_info table from common enumeration code, and switch
>   to use feature id for sub feature driver matching.
> - Remove next_afu register checking for AFU from common enumeration code.
> - Remove interface_id sysfs for dfl-fme-mgr and use per fpga-region
>   compat_id instead. (new patch 13, 15, 19).
> - Add more comments for driver data structures and functions.
> - Fix typos, issues in debug message/commit message and other places.
>
> Changes from v2:
> - Split common enumeration code from pcie driver to a separated module
>   which for device feature list support.
> - Drop fpga-dev class and switch to use fpga base region as container.
> - Update the intel-fpga.txt documentation for new driver organization.
> - Rename feature device drivers for future code reuse.
> - Rebase code due to fpga APIs changes
> - replace bitfields with marco and shift.
> - fix typos, checkpatch issue and other comments.
>
> Changes from v1:
> - Use GPLv2 license instead of Dual BSD/GPL.
> - Move the code to drivers/fpga folder.
> - Update the intel-fpga.txt documentation for new driver organization.
> - Add documentation for new sysfs interfaces.
> - Switch to use common fpga-region interface for partial reconfiguration
>   (PR) function in FME. It creates fpga-region/fpga-mgr/fpga-bridge
>   platform devices and leave the implementation to their platform drivers.
> - Add platform drivers for FME fpga-mgr/bridge/region platform devices.
> - Fix kbuild warnings, typos and other comments.
>
> This patch series depends on the below patchset from Alan Tull.
> [PATCH v4 0/4] fpga: change api, don't use drive data[1]
>
> [1] https://marc.info/?l=linux-fpga&m=152356504900466&w=2
>
> Kang Luwei (3):
>   fpga: dfl: add FPGA Management Engine driver basic framework
>   fpga: dfl: fme: add header sub feature support
>   fpga: dfl: fme: add partial reconfiguration sub feature support
>
> Wu Hao (22):
>   docs: fpga: add a document for FPGA Device Feature List (DFL)
>     Framework Overview
>   fpga: mgr: add region_id to fpga_image_info
>   fpga: mgr: add status for fpga-manager
>   fpga: mgr: add compat_id support
>   fpga: region: add compat_id support
>   fpga: add device feature list support
>   fpga: dfl: add chardev support for feature devices
>   fpga: dfl: add dfl_fpga_cdev_find_port
>   fpga: dfl: add dfl_fpga_port_ops support.
>   fpga: dfl: add dfl_fpga_check_port_id function.
>   fpga: dfl-pci: add enumeration for feature devices
>   fpga: dfl: fme: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls
>     support
>   fpga: dfl: add fpga manager platform driver for FME
>   fpga: dfl: fme-mgr: add compat_id support
>   fpga: dfl: add fpga bridge platform driver for FME
>   fpga: dfl: add fpga region platform driver for FME
>   fpga: dfl: fme-region: add support for compat_id
>   fpga: dfl: add FPGA Accelerated Function Unit driver basic framework
>   fpga: dfl: afu: add port ops support
>   fpga: dfl: afu: add header sub feature support
>   fpga: dfl: afu: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls
>     support
>   fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support
>
> Xiao Guangrong (2):
>   fpga: dfl: add feature device infrastructure
>   fpga: dfl: afu: add afu sub feature support
>
> Zhang Yi (1):
>   fpga: add FPGA DFL PCIe device driver
>
>  Documentation/ABI/testing/sysfs-class-fpga-manager |   24 +
>  Documentation/ABI/testing/sysfs-class-fpga-region  |    9 +
>  Documentation/ABI/testing/sysfs-platform-dfl-fme   |   23 +
>  Documentation/ABI/testing/sysfs-platform-dfl-port  |   16 +
>  Documentation/fpga/dfl.txt                         |  285 ++++++
>  Documentation/ioctl/ioctl-number.txt               |    1 +
>  drivers/fpga/Kconfig                               |   68 ++
>  drivers/fpga/Makefile                              |   14 +
>  drivers/fpga/dfl-afu-dma-region.c                  |  463 +++++++++
>  drivers/fpga/dfl-afu-main.c                        |  636 +++++++++++++
>  drivers/fpga/dfl-afu-region.c                      |  166 ++++
>  drivers/fpga/dfl-afu.h                             |  100 ++
>  drivers/fpga/dfl-fme-br.c                          |  114 +++
>  drivers/fpga/dfl-fme-main.c                        |  279 ++++++
>  drivers/fpga/dfl-fme-mgr.c                         |  349 +++++++
>  drivers/fpga/dfl-fme-pr.c                          |  474 ++++++++++
>  drivers/fpga/dfl-fme-pr.h                          |   84 ++
>  drivers/fpga/dfl-fme-region.c                      |   89 ++
>  drivers/fpga/dfl-fme.h                             |   38 +
>  drivers/fpga/dfl-pci.c                             |  310 ++++++
>  drivers/fpga/dfl.c                                 | 1000 ++++++++++++++++++++
>  drivers/fpga/dfl.h                                 |  416 ++++++++
>  drivers/fpga/fpga-mgr.c                            |   28 +
>  drivers/fpga/fpga-region.c                         |   22 +
>  include/linux/fpga/fpga-mgr.h                      |   24 +
>  include/linux/fpga/fpga-region.h                   |    2 +
>  include/uapi/linux/fpga-dfl.h                      |  178 ++++
>  27 files changed, 5212 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-fme
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-port
>  create mode 100644 Documentation/fpga/dfl.txt
>  create mode 100644 drivers/fpga/dfl-afu-dma-region.c
>  create mode 100644 drivers/fpga/dfl-afu-main.c
>  create mode 100644 drivers/fpga/dfl-afu-region.c
>  create mode 100644 drivers/fpga/dfl-afu.h
>  create mode 100644 drivers/fpga/dfl-fme-br.c
>  create mode 100644 drivers/fpga/dfl-fme-main.c
>  create mode 100644 drivers/fpga/dfl-fme-mgr.c
>  create mode 100644 drivers/fpga/dfl-fme-pr.c
>  create mode 100644 drivers/fpga/dfl-fme-pr.h
>  create mode 100644 drivers/fpga/dfl-fme-region.c
>  create mode 100644 drivers/fpga/dfl-fme.h
>  create mode 100644 drivers/fpga/dfl-pci.c
>  create mode 100644 drivers/fpga/dfl.c
>  create mode 100644 drivers/fpga/dfl.h
>  create mode 100644 include/uapi/linux/fpga-dfl.h
>
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fpga" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
