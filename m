Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E801C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF58B20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu0IZNVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF58B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeIDUyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:54:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41258 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:54:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so1870790plr.8;
        Tue, 04 Sep 2018 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M4QpRLBVTJikY6BxzWTJ+PgCfWG/byCkTEpCLn4NuPE=;
        b=hu0IZNVyfqxH2wd+TnUV+lppEVU68U/wpM1pmPtJtIb46WWSD9YNlcO8v9OFLHI6rB
         8qPKlrcVNwsLca05l4q6eq3iR9QfdTZI3HaO8EY+VVwtpzaZ+j9MXum+RRn9J3rgx/6n
         YN/bzQwHr8Lk6kdsvMobA8OhszFEKtfDdvotNfSoLRVjor1fwNG770FkuQUikmC11DhV
         nNrvpsWYoMzlaedON661rNP+26shPc85o37yz9Z1iG7xgXaiyySZn9dyZ0yOc232wK/R
         2ngbALE0uG0Z9HTNRI+rykvgOdNc4FhyvvVFHEqNRFlFV2o/S8oao1Cucpw0PVOmMtn2
         5BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M4QpRLBVTJikY6BxzWTJ+PgCfWG/byCkTEpCLn4NuPE=;
        b=Zfhzg1qvwdluzKZPzP9XF9jnlHCNwhbv/kIntDbNKW4uANKiW0+Zrupt2jbxNdLGmy
         HiGxEgknYgd9svsBjPhwAm7hxRLhBZ5Xy8Eq5x8ewo8EZ7jwTwhLryS/NN85/InKZ/go
         IhDsnsjzypTLRgVW7pOMVvNDjx3beeh+jAyAq6zFm2qaPp0bxWHwE3d97+Jai90rnqjd
         KSkBbUSVAmIAvvoa4FuyZSWuKb0Ggx6N/JJSVZpgRpq7BPAgI7lN6+Oodl95lKer1uHP
         5UnmiDu8plho6OURgEgXFLWMT7qixqlM2nGrZsL9PZC4VYuQDg2oTr3tQ2OIdb/iUX1Q
         COMg==
X-Gm-Message-State: APzg51BUSE/dp/1TUx/0R+tBHSb+mpPRKXOt5ZNaM0VTd/Jjrums7cjM
        MSakR47cVqcLKfrA7UdFqmn9EZj/
X-Google-Smtp-Source: ANB0VdZHiXl9yAvm1VR3X89ccNGPbrVZizSNzvd6mZpWw6ed/CExL80c8rnX9hikH2WRmzl9Dowq9Q==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4-v6mr33296921plo.124.1536078533825;
        Tue, 04 Sep 2018 09:28:53 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id j191-v6sm32243827pfc.136.2018.09.04.09.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 09:28:52 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        andrew@lunn.ch, davem@davemloft.net, netdev@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>
Subject: [PATCH v3 00/15] soc: octeontx2: Add RVU admin function driver
Date:   Tue,  4 Sep 2018 21:58:30 +0530
Message-Id: <1536078525-31534-1-git-send-email-sunil.kovvuri@gmail.com>
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

Changes from v2:
 No changes, submitted again with netdev mailing list in loop.
   - Suggested by Arnd Bergmann and Andrew Lunn

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

