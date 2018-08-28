Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34BCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CA82087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMT2ZhV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CA82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbeH1Oso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:48:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33377 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeH1Oso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:48:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so558202pfn.0;
        Tue, 28 Aug 2018 03:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0idqYE5mDtRb6CtXggIsTt4h0MJ6qyXNFB/uGYU69VQ=;
        b=WMT2ZhV6FOPgPp/+YaopftXxLm8AqV8ngiHAirwQKfOSaeuumv9PtMEwmK2P8+ZBvN
         2MmOMtSleVlICb2Z6LBofPhuc0O+oIQJCf085J3iJQBkwNxzmle0cx+4cvxJ/xpbkVU4
         Pz7GmZUtq+CE6iyhg8rkhbqO1HVP/CLKMGNjff4byKH2XMR+voEyaR1RfqEyJuEQeei9
         +RQzMS+G12sA32RxCF8fSi0JgfhmamA8V+wQY6Up1CZgpzUVa6+n9iWoWJT1doCS5lFo
         Ui46DaBTQwfBq3z+BY65fWVJTWMMbIDwS6nBJrvKdbS8U7olq8EpPF7V0ZPQzbuydSHM
         OUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0idqYE5mDtRb6CtXggIsTt4h0MJ6qyXNFB/uGYU69VQ=;
        b=IDh6TVTbF7Do6SAdVS94TGp1/WbvnXyAK4jIfKNEPgwMQ4Hkzy9kzC9ilBjRX4UKwb
         Ck5pfZj13RL/aOkV8Yrl93xvRG5WjlgDr4qgUcunJhsf6gDMyc5gbxpMPP2VSX9RmMTm
         6kncCSAbX+6BGis/DSIndZSeMcNCtM7oF6iD91Lqz+0xyGhYJUFJTAbLiLZY1Uzk2OJV
         MHzdgXgu6JnkQXMf6I5gEpsC5riA6Ns45PJ/l0XPiA69cpEQpvtSQM5o//0vHt0k4CJS
         4NZHMs2HQzseJr0skxL8qXI7unHgH5djslZunKIrfZ4tBV75g66fBBJ0QSZdzQVrAU1Q
         RFGw==
X-Gm-Message-State: APzg51Dw3WJRUhiHyyCiqfhTLssBg10Yuax4BQPmXnqqmivzu45XK9dN
        nqVzQbJ+e4hhCJ219qkFR90v4dm3
X-Google-Smtp-Source: ANB0VdaIzCDKmBCqnCjzvPQS+mp5zSIUEyy/saKwHABmqXX2xAT7hZThEJ5Afs/Wck8lQbWFbqYVBQ==
X-Received: by 2002:a63:e206:: with SMTP id q6-v6mr958060pgh.223.1535453858491;
        Tue, 28 Aug 2018 03:57:38 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id n22-v6sm2946798pfj.68.2018.08.28.03.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 03:57:37 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
Date:   Tue, 28 Aug 2018 16:27:03 +0530
Message-Id: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
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
 drivers/soc/marvell/Kconfig                |   23 +
 drivers/soc/marvell/Makefile               |    2 +
 drivers/soc/marvell/octeontx2/Makefile     |   10 +
 drivers/soc/marvell/octeontx2/cgx.c        |  529 +++++++++
 drivers/soc/marvell/octeontx2/cgx.h        |   63 ++
 drivers/soc/marvell/octeontx2/cgx_fw_if.h  |  225 ++++
 drivers/soc/marvell/octeontx2/mbox.c       |  300 +++++
 drivers/soc/marvell/octeontx2/mbox.h       |  211 ++++
 drivers/soc/marvell/octeontx2/rvu.c        | 1625 ++++++++++++++++++++++++++++
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

