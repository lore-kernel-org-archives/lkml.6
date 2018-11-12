Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E69C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A4F21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7U0zM3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A4F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeKLRuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:50:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42144 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeKLRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:50:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so250793pga.9;
        Sun, 11 Nov 2018 23:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uvusb/Bv/pkIFB9xelCNhqJh6PsfA7bLbgBEcVCgKFk=;
        b=t7U0zM3V/CF4YhLMkrEV4zQ+A+B64shVTXiNRF7FqfnxOvrstZzlD60KOEA6ZSLA4s
         mhDVDE6cx24+BW1lQbDasfe1CTLNeIi1Bd6isag3izAi+NAlHFw9Wjso49AfPVpiWdjE
         dFHnX/f4EhCWfRC/VMTyqv9uzF4WTkrj5JrkcvgTqSWvnMydZU5nzGSACDS+FYKt3JWH
         CFLoEu4i2Y/A/dVVKzoxGy3hzxKxKvRtRQZreGteNwQIBld08mSfRr1EsgUncyNnrwBe
         aPTpVR1nz+wZ93FEMmyrEcaVE/VpdMl4+qEOzbzDViXIAnT0JaB9wxEX96ur3Am076l3
         yDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uvusb/Bv/pkIFB9xelCNhqJh6PsfA7bLbgBEcVCgKFk=;
        b=DoLNPIu2maExnO+3tsbGz0rZeLaTbLzvQy77p1CGd9I2ZevicKQEiW0Cek1Hks9rJq
         CPtp+cKXH9XOPZCuTxIdaIEePIzzqRh4lEggvcYc1FAjpYTbKualimDRuUM3sWHpNkB8
         +PDSNuFfj8nGD3hpJIbUsfVCgsC+i1KSBBSX8UHiG2CvHWs7FuHjJwKR1On6BC8axp2t
         1+KkuZXaQ5GeJaJGCv3GQTGo7Jbhf+snkgfdAaD0Jim9lSRd33XSND+Hsvqer2Y0AtmX
         z3ZoMo7Rs2wIqRfIRF1m1Awu/KSM+Qxnbh2vFTMVktdX5hVGoqEkpKzIZQQzNhqEDyqb
         7VdQ==
X-Gm-Message-State: AGRZ1gJAbUIRC/8vjhWYMAw16JrTM4XMadlTdLOsB+cZS+UzOGxZzgvB
        qkrZXY6/6GCqVVsz/g+7EZI=
X-Google-Smtp-Source: AJdET5fhfRvQwVOsPdqp9Bo6WClQN0jputvZuWsHJBjC+4wmtr9xvmSAWbAZornSrvVHEFoh0jw9HA==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr16127022pgi.8.1542009508751;
        Sun, 11 Nov 2018 23:58:28 -0800 (PST)
Received: from localhost.localdomain ([45.41.180.77])
        by smtp.gmail.com with ESMTPSA id u2-v6sm17050816pfn.50.2018.11.11.23.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 23:58:27 -0800 (PST)
From:   Kenneth Lee <nek.in.cn@gmail.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tim Sell <timothy.sell@unisys.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
        David Kershner <david.kershner@unisys.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        Jens Axboe <axboe@kernel.dk>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Johan Hovold <johan@kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org
Cc:     linuxarm@huawei.com, guodong.xu@linaro.org,
        zhangfei.gao@foxmail.com, haojian.zhuang@linaro.org,
        Kenneth Lee <liguozhu@hisilicon.com>
Subject: [RFCv3 PATCH 0/6] A General Accelerator Framework, WarpDrive
Date:   Mon, 12 Nov 2018 15:58:01 +0800
Message-Id: <20181112075807.9291-1-nek.in.cn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

*WarpDrive* is a general accelerator framework for the user application to
access the hardware without going through the kernel in data path.

WarpDrive is the name for the whole framework. The component in kernel
is called uacce, meaning "Unified/User-space-access-intended Accelerator
Framework". It makes use of the capability of IOMMU to maintain a
unified virtual address space between the hardware and the process.

The first patch in this patchset contains document of the framework.
Please refer to it for more information.

WarpDrive is intended to be used with Jean Philippe Brucker's SVA
patchset[1], which enables IO side page fault and PASID support. But
this patchset itself is simply the first step to support the no-PASID
version.

The patch 1 is document of the framework. The patch 2 add uacce support.
The patch 3 and 4 are drivers for Hisilicon's ZIP Accelerator. It is
registered to crypto subsystem. The patch 5 adds uacce support to the
accelerator driver. It then can work in either crypto or uacce mode. It
can support both mode at the same time when PASID mode is added in the
future.

The patch 6 is is a user space sample demonstrating how WarpDrive is
used.

The intension of this RFC is to know if the idea is acceptable.
So the focus is the uacce itself. The patch 3 and 4 will be sent to mainline
by another topic. We assume they will be accepted first and we can
upstream uacce. And if SVA is upstreamed, the new feature will be added
accordingly.

Change History:
V3 changed from V2:
	1. Build uacce from original IOMMU interface. V2 is built on VFIO.
	   But the VFIO way locking the user memory in place will not
	   work properly if the process fork a child. Because the
	   copy-on-write strategy will make the parent process lost its
	   page. This is not acceptable to accelerator user.
	2. The kernel component is renamed to uacce from sdmdev
	   accordingly
	3. Document is updated for the new design. The Static Shared
	   Virtual Memory concept is introduced to replace the User
	   Memory Sharing concept.
	4. Rebase to the lastest kernel (4.20.0-rc1)
	5. As an RFC, this version is tested only with "test-to-pass"
	   test case and not tested with Jean's SVA patch.

V2 changed from V1:
	1. Change kernel framework name from SPIMDEV (Share Parent IOMMU
	   Mdev) to SDMDEV (Share Domain Mdev).
	2. Allocate Hardware Resource when a new mdev is created (While
	   it is allocated when the mdev is openned)
	3. Unmap pages from the shared domain when the sdmdev iommu group is
	   detached. (This procedure is necessary, but missed in V1)
	4. Update document accordingly.
	5. Rebase to the latest kernel (4.19.0-rc1)


Refernces:
[1] https://www.spinics.net/lists/kernel/msg2651481.html
[2] https://github.com/Kenneth-Lee/linux-kernel-warpdrive/tree/warpdrive-sva-v0.5
[3] https://lkml.org/lkml/2018/7/22/34

Best Regards
Kenneth Lee

Kenneth Lee (6):
  uacce: Add documents for WarpDrive/uacce
  uacce: add uacce module
  crypto/hisilicon: add hisilicon Queue Manager driver
  crypto/hisilicon: add Hisilicon zip driver
  crypto: add uacce support to Hisilicon qm
  uacce: add user sample for uacce/warpdrive

 Documentation/warpdrive/warpdrive.rst       | 260 ++++++
 Documentation/warpdrive/wd-arch.svg         | 764 ++++++++++++++++
 Documentation/warpdrive/wd.svg              | 526 +++++++++++
 Documentation/warpdrive/wd_q_addr_space.svg | 359 ++++++++
 drivers/Kconfig                             |   2 +
 drivers/Makefile                            |   1 +
 drivers/crypto/hisilicon/Kconfig            |  19 +-
 drivers/crypto/hisilicon/Makefile           |   2 +
 drivers/crypto/hisilicon/qm.c               | 926 ++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h               | 227 +++++
 drivers/crypto/hisilicon/qm_usr_if.h        |  32 +
 drivers/crypto/hisilicon/zip/Makefile       |   2 +
 drivers/crypto/hisilicon/zip/zip.h          |  57 ++
 drivers/crypto/hisilicon/zip/zip_crypto.c   | 362 ++++++++
 drivers/crypto/hisilicon/zip/zip_crypto.h   |  18 +
 drivers/crypto/hisilicon/zip/zip_main.c     | 191 ++++
 drivers/uacce/Kconfig                       |  11 +
 drivers/uacce/Makefile                      |   2 +
 drivers/uacce/uacce.c                       | 902 +++++++++++++++++++
 include/linux/uacce.h                       | 117 +++
 include/uapi/linux/uacce.h                  |  33 +
 samples/warpdrive/AUTHORS                   |   3 +
 samples/warpdrive/ChangeLog                 |   1 +
 samples/warpdrive/Makefile.am               |   9 +
 samples/warpdrive/NEWS                      |   1 +
 samples/warpdrive/README                    |  32 +
 samples/warpdrive/autogen.sh                |   3 +
 samples/warpdrive/cleanup.sh                |  13 +
 samples/warpdrive/conf.sh                   |   4 +
 samples/warpdrive/configure.ac              |  52 ++
 samples/warpdrive/drv/hisi_qm_udrv.c        | 228 +++++
 samples/warpdrive/drv/hisi_qm_udrv.h        |  57 ++
 samples/warpdrive/drv/wd_drv.h              |  19 +
 samples/warpdrive/test/Makefile.am          |   7 +
 samples/warpdrive/test/test_hisi_zip.c      | 150 ++++
 samples/warpdrive/wd.c                      |  96 ++
 samples/warpdrive/wd.h                      |  97 ++
 samples/warpdrive/wd_adapter.c              |  71 ++
 samples/warpdrive/wd_adapter.h              |  36 +
 39 files changed, 5691 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/warpdrive/warpdrive.rst
 create mode 100644 Documentation/warpdrive/wd-arch.svg
 create mode 100644 Documentation/warpdrive/wd.svg
 create mode 100644 Documentation/warpdrive/wd_q_addr_space.svg
 create mode 100644 drivers/crypto/hisilicon/qm.c
 create mode 100644 drivers/crypto/hisilicon/qm.h
 create mode 100644 drivers/crypto/hisilicon/qm_usr_if.h
 create mode 100644 drivers/crypto/hisilicon/zip/Makefile
 create mode 100644 drivers/crypto/hisilicon/zip/zip.h
 create mode 100644 drivers/crypto/hisilicon/zip/zip_crypto.c
 create mode 100644 drivers/crypto/hisilicon/zip/zip_crypto.h
 create mode 100644 drivers/crypto/hisilicon/zip/zip_main.c
 create mode 100644 drivers/uacce/Kconfig
 create mode 100644 drivers/uacce/Makefile
 create mode 100644 drivers/uacce/uacce.c
 create mode 100644 include/linux/uacce.h
 create mode 100644 include/uapi/linux/uacce.h
 create mode 100644 samples/warpdrive/AUTHORS
 create mode 100644 samples/warpdrive/ChangeLog
 create mode 100644 samples/warpdrive/Makefile.am
 create mode 100644 samples/warpdrive/NEWS
 create mode 100644 samples/warpdrive/README
 create mode 100755 samples/warpdrive/autogen.sh
 create mode 100755 samples/warpdrive/cleanup.sh
 create mode 100755 samples/warpdrive/conf.sh
 create mode 100644 samples/warpdrive/configure.ac
 create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.c
 create mode 100644 samples/warpdrive/drv/hisi_qm_udrv.h
 create mode 100644 samples/warpdrive/drv/wd_drv.h
 create mode 100644 samples/warpdrive/test/Makefile.am
 create mode 100644 samples/warpdrive/test/test_hisi_zip.c
 create mode 100644 samples/warpdrive/wd.c
 create mode 100644 samples/warpdrive/wd.h
 create mode 100644 samples/warpdrive/wd_adapter.c
 create mode 100644 samples/warpdrive/wd_adapter.h

-- 
2.17.1

