Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9462C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC692403D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC692403D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeGELBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:01:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753542AbeGELBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AA9AAEBB;
        Thu,  5 Jul 2018 11:01:43 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 0/4] SCSI results rework preparation part 2
Date:   Thu,  5 Jul 2018 13:01:36 +0200
Message-Id: <20180705110140.19545-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the first part of the preparation work for my scsi results handling
rework is done, here's the second batch.

The first patch changes the AAC_STAT_GOOD define into an open-coded
version in aacraid. The other three patches convert the three
ScsiResult() macros in bfa, lpfc and ncr53c8xx to their open-coded
equivalen.

This is helpful for subsequent refactoring, as it's easier to identify
which code parts need more work and Coccinelle Spatches are easier to
apply.

Johannes Thumshirn (4):
  scsi: aacraid: remove AAC_STAT_GOOD define
  scsi: bfa: remove ScsiResult macro
  scsi: lpfc: remove ScsiResult macro
  scsi: ncr53c8xx: remove ScsiResult macro

 drivers/scsi/aacraid/aachba.c | 41 ++++++++++++++++++++++++++--------------
 drivers/scsi/bfa/bfad_im.c    | 19 ++++++++-----------
 drivers/scsi/bfa/bfad_im.h    |  1 -
 drivers/scsi/lpfc/lpfc_crtn.h |  1 -
 drivers/scsi/lpfc/lpfc_scsi.c | 44 +++++++++++++++++++++----------------------
 drivers/scsi/ncr53c8xx.c      | 10 +++++-----
 6 files changed, 62 insertions(+), 54 deletions(-)

-- 
2.16.4

