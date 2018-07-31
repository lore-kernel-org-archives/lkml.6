Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375FDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D692083D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D692083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbeGaP2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:28:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732379AbeGaP2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:28:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D940AD4C;
        Tue, 31 Jul 2018 13:48:12 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        ard <ard@kwaak.net>, Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/3] scsi: fcoe: memleak fixes
Date:   Tue, 31 Jul 2018 15:46:00 +0200
Message-Id: <20180731134603.20089-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard reported a memory leak in FCoE at [1] and this patch set contains
the fix for this leak, a second leak I discovered while hunting the
first leak and a use-after-free in FCoE's debugging.

[1] https://marc.info/?l=linux-scsi&m=153261165228133&w=2

Johannes Thumshirn (3):
  fcoe: fix use-after-free in fcoe_ctlr_els_send
  scsi: fcoe: drop frames in ELS LOGO error path
  scsi: fcoe: clear FC_RP_STARTED flags when receiving a LOGO

 drivers/scsi/fcoe/fcoe_ctlr.c | 6 +++---
 drivers/scsi/libfc/fc_rport.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.16.4

