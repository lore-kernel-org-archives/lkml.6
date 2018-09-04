Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB08C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E792420645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcYZCa2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E792420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeIDQUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:20:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42473 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIDQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:20:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so1545329pgp.9;
        Tue, 04 Sep 2018 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zAO6Tet6gDB/CNPa1hnGxxIMwaV7xyFVyG/ZZBGAyiE=;
        b=OcYZCa2LDawXZm/av7xnKwFV5UpimbOAeUBrvXLwKg6eOm+5MQLmYaxYkEGmrQXhae
         K7NeZPvcxGiAYHNIxL1D6bmQRfvFv2K8MBVtjv814qXwFl76ETW5QYljV6VC+MPzUB7u
         7Lx2u123q3z7a+s1RbmhJV2zPhTTXlexIY9U18aJy8ty/+GxsMWaPLk8tBOtK02LnL3E
         nwGjSlJtWtpdk4DnsxaKkm9h2OzREZyprAgWxiZE7/t7eQiY+ubK2WZt4ujNkYfBdjUD
         1k18r3YiyJvYOLg1fbISgW3pB2E0QwGIAlNG3smEV7dsf/XLy4536tL/ItPANdKRG5ee
         zfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zAO6Tet6gDB/CNPa1hnGxxIMwaV7xyFVyG/ZZBGAyiE=;
        b=uEZyIRlxHanfcFdtoNEC5+dhurAGmKt+t423cJ8mPXgcT6q3r8zZpkEEXr639QZW/u
         GmYP+VTaFgH+lkOOnYODbodcNa9aZAeIHwYhOs07+p2Ee7h14MPT9ZTlAOmAwASK43vc
         d+rpmjX0E4/jn5BSBZJv9x80XKllQFgZUKxQWUUY9ailcAYPFNpdvHU7OL2LiVnWSU4g
         KRHrCh13SbD/Q2zhqnhxAa4kkOz3TLh+6X6TDWcFHxJbyejOO7Gfm/FwVW8NJ6VJUQgL
         jZkBdXbwAgGwtr/YDbliynM6qnC9bFIteUa0IBF855M2klhPq5fdP3qKRs0I1XBhHYGw
         VmOQ==
X-Gm-Message-State: APzg51DI/IL8TRL6ZZ0iyGfU10+qMOi9yfLGiPpGi/Mu6yE0T4JNaVCU
        y8fCS1HEgTg+xj9/qkgYrWYFzL6Q
X-Google-Smtp-Source: ANB0VdY0hTquZqY/42jbEhsdk1PybZKW1fnEzzjV1zetAxqdit0VOQ8rSL0etPXvJOOyxlJjg32YaQ==
X-Received: by 2002:a63:f26:: with SMTP id e38-v6mr30119377pgl.354.1536062113495;
        Tue, 04 Sep 2018 04:55:13 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id u184-v6sm29740190pgd.46.2018.09.04.04.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 04:55:12 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v2 00/15] soc: octeontx2: Add RVU admin function driver
Date:   Tue,  4 Sep 2018 17:24:35 +0530
Message-Id: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Goutham <sgoutham@marvell.com>

Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
PF0 is called administrative / admin function (AF) and has privilege access
to registers to provision different RVU functional blocks to each of
PF/VF.

This admin function (AF) driver acts as a configuration / administrative
software which provisions functional blocks to a PF/VF on demand for them
to work as one of the following
 - A basic network controller (i.e NIC).
 - NIC with packet filtering, shaping and scheduling capabilities.
 - A crypto device.
 - A combination of above etc.

PF/VFs communicate with admin function via a shared memory region.
This patch series adds logic for the following
 - RVU AF driver with functional blocks provisioning support
 - Mailbox infrastructure for communication between AF and PFs.
 - CGX driver which provides information about physcial network
   interfaces which AF processes and forwards required info to
   PF/VF drivers.

This is the first set of patches out of 70 odd patches.

Note: This driver neither receives any data nor processes it i.e no I/O,
      just does the hardware configuration.

Changes from v1:
 1 Merged RVU admin function and CGX drivers into a single module
   - Suggested by Arnd Bergmann
 2 Pulled mbox communication APIs into a separate module to remove
   admin function driver dependency in a VM where AF is not attached.
   - Suggested by Arnd Bergmann

Aleksey Makarov (2):
  soc: octeontx2: Add mailbox support infra
  soc: octeontx2: Convert mbox msg id check to a macro

Geetha sowjanya (1):
  soc: octeontx2: Reconfig MSIX base with IOVA

Linu Cherian (3):
  soc: octeontx2: Set RVU PFs to CGX LMACs mapping
  soc: octeontx2: Add support for CGX link management
  soc: octeontx2: Register for CGX lmac events

Sunil Goutham (9):
  soc: octeontx2: Add Marvell OcteonTX2 RVU AF driver
  soc: octeontx2: Reset all RVU blocks
  soc: octeontx2: Gather RVU blocks HW info
  soc: octeontx2: Add mailbox IRQ and msg handlers
  soc: octeontx2: Scan blocks for LFs provisioned to PF/VF
  soc: octeontx2: Add RVU block LF provisioning support
  soc: octeontx2: Configure block LF's MSIX vector offset
  soc: octeontx2: Add Marvell OcteonTX2 CGX driver
  MAINTAINERS: Add entry for Marvell OcteonTX2 Admin Function driver

 MAINTAINERS                                |   10 +
 drivers/soc/Kconfig                        |    1 +
 drivers/soc/Makefile                       |    1 +
 drivers/soc/marvell/Kconfig                |   18 +
 drivers/soc/marvell/Makefile               |    2 +
 drivers/soc/marvell/octeontx2/Makefile     |   10 +
 drivers/soc/marvell/octeontx2/cgx.c        |  517 +++++++++
 drivers/soc/marvell/octeontx2/cgx.h        |   65 ++
 drivers/soc/marvell/octeontx2/cgx_fw_if.h  |  225 ++++
 drivers/soc/marvell/octeontx2/mbox.c       |  303 +++++
 drivers/soc/marvell/octeontx2/mbox.h       |  211 ++++
 drivers/soc/marvell/octeontx2/rvu.c        | 1637 ++++++++++++++++++++++++++++
 drivers/soc/marvell/octeontx2/rvu.h        |  158 +++
 drivers/soc/marvell/octeontx2/rvu_cgx.c    |  194 ++++
 drivers/soc/marvell/octeontx2/rvu_reg.h    |  442 ++++++++
 drivers/soc/marvell/octeontx2/rvu_struct.h |   78 ++
 16 files changed, 3872 insertions(+)
 create mode 100644 drivers/soc/marvell/Kconfig
 create mode 100644 drivers/soc/marvell/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2/Makefile
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/cgx.h
 create mode 100644 drivers/soc/marvell/octeontx2/cgx_fw_if.h
 create mode 100644 drivers/soc/marvell/octeontx2/mbox.c
 create mode 100644 drivers/soc/marvell/octeontx2/mbox.h
 create mode 100644 drivers/soc/marvell/octeontx2/rvu.c
 create mode 100644 drivers/soc/marvell/octeontx2/rvu.h
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_cgx.c
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_reg.h
 create mode 100644 drivers/soc/marvell/octeontx2/rvu_struct.h

-- 
2.7.4

