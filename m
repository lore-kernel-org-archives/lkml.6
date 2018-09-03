Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF587C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C02C20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 00:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u65quzxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C02C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeICFJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:09:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46395 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICFJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:09:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so7883144pfn.13;
        Sun, 02 Sep 2018 17:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QALzlleB03IYthe+39ZMS0b1QQZHxNMtkmGfdyep46U=;
        b=u65quzxhLsyw1Y7iN9qElYyHDG+4XHBDMD1wvELH+7xxCwMBqbOTdFLh7eCyCK5LhC
         TdDWW0s0kYRr5PBUM+8Tv+MoEBi+2xlzRE6eQ/Q2Rr4WO7VXqV5xAt04dT3I9F5ReIyt
         53ybZiO/2INRCkIvXARUMbWZO+XYc3dF+Q6Jyt/wSIeXP/jaiB5ju9sjlmsf6jizBekn
         3vADVPq7jeT2/ghseK4EbJOXnWGDfDRJhxJVMRLmuFg+JfGWqz1BVIHAmBPAGBOo4FsC
         e296qOTj1xCIlHiTsNeBHnTJLPKtVkZX+o1oDlWHA4gKSncdBALelUBR6pCkIpRxxbKo
         W9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QALzlleB03IYthe+39ZMS0b1QQZHxNMtkmGfdyep46U=;
        b=TUxT9Fza6LON72TtO41ZYKjtupNiCvkwNZ653atG1sMP2pQkqg9ys0pnPYmay8FGL6
         K88a2LgYc2FkLsWYolCr710MlhxxjV692AmcY9TroR4OQNZvcEbIwR8arIkNI9zU0hig
         6P9xUDGHyUaAwEy1WbIhbmOqvg61mkD6uRCsVV1EHeMqgZFWqKTAYwVQFeLZAbhUJjUP
         HVQxhtnO3psAhSsn35D6zuAQ7nFeWParvx97vEBuhtwbj8QGaCnw2mxJwW3IuGgRxjr7
         YONnzJ6xrI1bL+yjEMavEVeO2fHjvcNedbbGuwgl1F04EoANC2nsl1UduiOeI8vyEx4r
         h7xA==
X-Gm-Message-State: APzg51AAaYbJML6vhAxzhSItMsHd5HbuEag4ptX4ffgFW9w8r+TZG5Ro
        dczOnQh9CtEhp7i4gBtWbmg=
X-Google-Smtp-Source: ANB0VdZAZtWIfV7BCKqeTMByNFZqt7k7JzyQ6mar4mZFVqhGFw0FgWeJwAB4PAkatQfDIpq5haLTjA==
X-Received: by 2002:a63:8a41:: with SMTP id y62-v6mr22515253pgd.278.1535935934960;
        Sun, 02 Sep 2018 17:52:14 -0700 (PDT)
Received: from localhost.localdomain ([203.160.89.93])
        by smtp.gmail.com with ESMTPSA id w81-v6sm31487064pfk.92.2018.09.02.17.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 17:52:13 -0700 (PDT)
From:   Kenneth Lee <nek.in.cn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc:     linuxarm@huawei.com
Subject: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
Date:   Mon,  3 Sep 2018 08:51:57 +0800
Message-Id: <20180903005204.26041-1-nek.in.cn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

WarpDrive is an accelerator framework to expose the hardware capabilities
directly to the user space. It makes use of the exist vfio and vfio-mdev
facilities. So the user application can send request and DMA to the
hardware without interaction with the kernel. This removes the latency
of syscall.

WarpDrive is the name for the whole framework. The component in kernel
is called SDMDEV, Share Domain Mediated Device. Driver driver exposes its
hardware resource by registering to SDMDEV as a VFIO-Mdev. So the user
library of WarpDrive can access it via VFIO interface.

The patchset contains document for the detail. Please refer to it for more
information.

This patchset is intended to be used with Jean Philippe Brucker's SVA
patch [1], which enables not only IO side page fault, but also PASID
support to IOMMU and VFIO.

With these features, WarpDrive can support non-pinned memory and
multi-process in the same accelerator device.  We tested it in our SoC
integrated Accelerator (board ID: D06, Chip ID: HIP08). A reference work
tree can be found here: [2].

But it is not mandatory. This patchset is tested in the latest mainline
kernel without the SVA patches.  So it supports only one process for each
accelerator.

We have noticed the IOMMU aware mdev RFC announced recently [3].

The IOMMU aware mdev has similar idea but different intention comparing to
WarpDrive. It intends to dedicate part of the hardware resource to a VM.
And the design is supposed to be used with Scalable I/O Virtualization.
While sdmdev is intended to share the hardware resource with a big amount
of processes.  It just requires the hardware supporting address
translation per process (PCIE's PASID or ARM SMMU's substream ID).

But we don't see serious confliction on both design. We believe they can be
normalized as one.

The patch 1 is document of the framework. The patch 2 and 3 add sdmdev
support. The patch 4, 5 and 6 is drivers for Hislicon's ZIP Accelerator
which is registered to both crypto and warpdrive(sdmdev) and can be
used from kernel or user space at the same time. The patch 7 is a user
space sample demonstrating how WarpDrive works.


Change History:
V2 changed from V1:
	1. Change kernel framework name from SPIMDEV (Share Parent IOMMU
	   Mdev) to SDMDEV (Share Domain Mdev).
	2. Allocate Hardware Resource when a new mdev is created (While
	   it is allocated when the mdev is openned)
	3. Unmap pages from the shared domain when the sdmdev iommu group is
	   detached. (This procedure is necessary, but missed in V1)
	4. Update document accordingly.
	5. Rebase to the latest kernel (4.19.0-rc1)
	
	According the review comment on RFCv1, We did try to use dma-buf
	as back end of WarpDrive. It can work properly with the current
	solution [4], but it cannot make use of process's
	own memory address space directly. This is important to many
	acceleration scenario. So dma-buf will be taken as a backup
	alternative for noiommu scenario, it will be added in the future
	version. 


Refernces:
[1] https://www.spinics.net/lists/kernel/msg2651481.html
[2] https://github.com/Kenneth-Lee/linux-kernel-warpdrive/tree/warpdrive-sva-v0.5
[3] https://lkml.org/lkml/2018/7/22/34
[4] https://github.com/Kenneth-Lee/linux-kernel-warpdrive/tree/warpdrive-v0.7-dmabuf

Best Regards
Kenneth Lee

Kenneth Lee (7):
  vfio/sdmdev: Add documents for WarpDrive framework
  iommu: Add share domain interface in iommu for sdmdev
  vfio: add sdmdev support
  crypto: add hisilicon Queue Manager driver
  crypto: Add Hisilicon Zip driver
  crypto: add sdmdev support to Hisilicon QM
  vfio/sdmdev: add user sample

 Documentation/00-INDEX                    |   2 +
 Documentation/warpdrive/warpdrive.rst     | 100 +++
 Documentation/warpdrive/wd-arch.svg       | 728 ++++++++++++++++
 drivers/crypto/Makefile                   |   2 +-
 drivers/crypto/hisilicon/Kconfig          |  25 +
 drivers/crypto/hisilicon/Makefile         |   2 +
 drivers/crypto/hisilicon/qm.c             | 979 ++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h             | 122 +++
 drivers/crypto/hisilicon/zip/Makefile     |   2 +
 drivers/crypto/hisilicon/zip/zip.h        |  57 ++
 drivers/crypto/hisilicon/zip/zip_crypto.c | 353 ++++++++
 drivers/crypto/hisilicon/zip/zip_crypto.h |   8 +
 drivers/crypto/hisilicon/zip/zip_main.c   | 195 +++++
 drivers/iommu/iommu.c                     |  29 +-
 drivers/vfio/Kconfig                      |   1 +
 drivers/vfio/Makefile                     |   1 +
 drivers/vfio/sdmdev/Kconfig               |  10 +
 drivers/vfio/sdmdev/Makefile              |   3 +
 drivers/vfio/sdmdev/vfio_sdmdev.c         | 363 ++++++++
 drivers/vfio/vfio_iommu_type1.c           | 151 +++-
 include/linux/iommu.h                     |  15 +
 include/linux/vfio_sdmdev.h               |  96 +++
 include/uapi/linux/vfio_sdmdev.h          |  29 +
 samples/warpdrive/AUTHORS                 |   2 +
 samples/warpdrive/ChangeLog               |   1 +
 samples/warpdrive/Makefile.am             |   9 +
 samples/warpdrive/NEWS                    |   1 +
 samples/warpdrive/README                  |  32 +
 samples/warpdrive/autogen.sh              |   3 +
 samples/warpdrive/cleanup.sh              |  13 +
 samples/warpdrive/configure.ac            |  52 ++
 samples/warpdrive/drv/hisi_qm_udrv.c      | 223 +++++
 samples/warpdrive/drv/hisi_qm_udrv.h      |  53 ++
 samples/warpdrive/test/Makefile.am        |   7 +
 samples/warpdrive/test/comp_hw.h          |  23 +
 samples/warpdrive/test/test_hisi_zip.c    | 206 +++++
 samples/warpdrive/wd.c                    | 309 +++++++
 samples/warpdrive/wd.h                    | 154 ++++
 samples/warpdrive/wd_adapter.c            |  74 ++
 samples/warpdrive/wd_adapter.h            |  43 +
 40 files changed, 4470 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/warpdrive/warpdrive.rst
 create mode 100644 Documentation/warpdrive/wd-arch.svg
 create mode 100644 drivers/crypto/hisilicon/qm.c
 create mode 100644 drivers/crypto/hisilicon/qm.h
 create mode 100644 drivers/crypto/hisilicon/zip/Makefile
 create mode 100644 drivers/crypto/hisilicon/zip/zip.h
 create mode 100644 drivers/crypto/hisilicon/zip/zip_crypto.c
 create mode 100644 drivers/crypto/hisilicon/zip/zip_crypto.h
 create mode 100644 drivers/crypto/hisilicon/zip/zip_main.c
 create mode 100644 drivers/vfio/sdmdev/Kconfig
 create mode 100644 drivers/vfio/sdmdev/Makefile
 create mode 100644 drivers/vfio/sdmdev/vfio_sdmdev.c
 create mode 100644 include/linux/vfio_sdmdev.h
 create mode 100644 include/uapi/linux/vfio_sdmdev.h
 create mode 100644 samples/warpdrive/AUTHORS
 create mode 100644 samples/warpdrive/ChangeLog
 create mode 100644 samples/warpdrive/Makefile.am
 create mode 100644 samples/warpdrive/NEWS
 create mode 100644 samples/warpdrive/README
 create mode 100755 samples/warpdrive/autogen.sh
 create mode 100755 samples/warpdrive/cleanup.sh
 create mode 100644 samples/warpdrive/configure.ac
 create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.c
 create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.h
 create mode 100644 samples/warpdrive/test/Makefile.am
 create mode 100644 samples/warpdrive/test/comp_hw.h
 create mode 100644 samples/warpdrive/test/test_hisi_zip.c
 create mode 100644 samples/warpdrive/wd.c
 create mode 100644 samples/warpdrive/wd.h
 create mode 100644 samples/warpdrive/wd_adapter.c
 create mode 100644 samples/warpdrive/wd_adapter.h

-- 
2.17.1

