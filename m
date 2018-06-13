Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E64E6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C87208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C87208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934831AbeFMHx7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:53:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41233 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754510AbeFMHxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:53:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88DEDAE15;
        Wed, 13 Jun 2018 07:53:54 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 0/3] Preparation patch-set for SCSI results rework
Date:   Wed, 13 Jun 2018 09:53:46 +0200
Message-Id: <20180613075349.7509-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is small patch set with obvious prep patches for the SCSI results
rework discussed at LFS/MM and other occasions on the list.

Note, I'll be on PTO for the next two weeks so I'll be slow in
responding to this patches.


Johannes Thumshirn (3):
  scsi: remove Scsi_Cmnd typedef
  scsi: check for equality of result byte values
  scsi: don't add scsi command result bytes

 drivers/scsi/3w-xxxx.c              |  2 +-
 drivers/scsi/advansys.c             |  2 +-
 drivers/scsi/aha152x.c              | 71 ++++++++++++++++++++-----------------
 drivers/scsi/aha1740.c              |  9 ++---
 drivers/scsi/aha1740.h              |  4 +--
 drivers/scsi/ch.c                   |  2 +-
 drivers/scsi/dc395x.c               |  3 +-
 drivers/scsi/gdth.c                 | 67 +++++++++++++++++-----------------
 drivers/scsi/gdth.h                 | 10 +++---
 drivers/scsi/gdth_proc.c            |  2 +-
 drivers/scsi/ibmvscsi/ibmvfc.c      |  2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c    |  2 +-
 drivers/scsi/imm.c                  |  2 +-
 drivers/scsi/libiscsi_tcp.c         |  2 +-
 drivers/scsi/megaraid.c             | 29 +++++++--------
 drivers/scsi/megaraid.h             | 14 ++++----
 drivers/scsi/mesh.c                 |  4 +--
 drivers/scsi/nsp32_debug.c          |  2 +-
 drivers/scsi/scsi.c                 |  2 +-
 drivers/scsi/scsi.h                 |  3 --
 drivers/scsi/scsi_ioctl.c           |  4 +--
 drivers/scsi/scsi_lib.c             |  4 +--
 drivers/scsi/scsi_scan.c            |  2 +-
 drivers/scsi/scsi_transport_spi.c   |  2 +-
 drivers/scsi/scsi_typedefs.h        |  2 --
 drivers/scsi/sd.c                   | 14 ++++----
 drivers/scsi/sym53c8xx_2/sym_glue.c |  2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.h |  2 +-
 drivers/scsi/ufs/ufshcd.c           |  2 +-
 29 files changed, 136 insertions(+), 132 deletions(-)
 delete mode 100644 drivers/scsi/scsi_typedefs.h

-- 
2.16.4

