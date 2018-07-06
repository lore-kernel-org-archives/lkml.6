Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE440C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECC32400A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECC32400A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932925AbeGFNdz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:33:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:55730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753362AbeGFNdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:33:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26F10AD17;
        Fri,  6 Jul 2018 13:33:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/2] Remove remainig MCR SCSI drivers
Date:   Fri,  6 Jul 2018 15:33:47 +0200
Message-Id: <20180706133349.28508-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCR Support was ripped out of the kernel in 2012. I think 6 years
later we can kill the remaining drivers which couldn't have been
compiled since then.

Johannes Thumshirn (2):
  scsi: remove NCR_D700 driver
  scsi: remove NCR_Q720 driver

 MAINTAINERS             |   6 -
 drivers/scsi/Kconfig    |  32 +---
 drivers/scsi/Makefile   |   3 -
 drivers/scsi/NCR_D700.c | 405 ------------------------------------------------
 drivers/scsi/NCR_D700.h |  30 ----
 drivers/scsi/NCR_Q720.c | 376 --------------------------------------------
 drivers/scsi/NCR_Q720.h |  29 ----
 7 files changed, 4 insertions(+), 877 deletions(-)
 delete mode 100644 drivers/scsi/NCR_D700.c
 delete mode 100644 drivers/scsi/NCR_D700.h
 delete mode 100644 drivers/scsi/NCR_Q720.c
 delete mode 100644 drivers/scsi/NCR_Q720.h

-- 
2.16.4

