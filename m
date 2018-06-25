Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2493DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C5F257EC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C5F257EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbeFYLVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:21:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753046AbeFYLVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:21:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 61590AE21;
        Mon, 25 Jun 2018 11:21:05 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 0/2] Preparation patch-set for SCSI results rework
Date:   Mon, 25 Jun 2018 13:20:57 +0200
Message-Id: <20180625112059.12872-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is small patch set with obvious prep patches for the SCSI results
rework discussed at LFS/MM and other occasions on the list.

Changes since v2:
- Dropped already applied patch 1
- Incorporated Bart's and Christoph's feedback
- Added Reviewed-bys

Johannes Thumshirn (2):
  scsi: check for equality of result byte values
  scsi: don't add scsi command result bytes

 drivers/scsi/ch.c                   |  2 +-
 drivers/scsi/dc395x.c               |  5 ++---
 drivers/scsi/imm.c                  |  2 +-
 drivers/scsi/mesh.c                 |  4 ++--
 drivers/scsi/scsi.c                 |  2 +-
 drivers/scsi/scsi_ioctl.c           |  4 ++--
 drivers/scsi/scsi_lib.c             |  4 ++--
 drivers/scsi/scsi_scan.c            |  2 +-
 drivers/scsi/scsi_transport_spi.c   |  2 +-
 drivers/scsi/sd.c                   | 14 +++++++-------
 drivers/scsi/sym53c8xx_2/sym_glue.c |  2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.h |  2 +-
 drivers/scsi/ufs/ufshcd.c           |  2 +-
 13 files changed, 23 insertions(+), 24 deletions(-)

-- 
2.16.4

