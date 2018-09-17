Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87FECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9713F20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9713F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeIQU3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:29:08 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:40973 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbeIQU3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:29:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5495681CC;
        Mon, 17 Sep 2018 15:01:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean02_45ce144452d0b
X-Filterd-Recvd-Size: 2042
Received: from joe-laptop.perches.com (mb42736d0.tmodns.net [208.54.39.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Sep 2018 15:01:19 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Neaten logging uses
Date:   Mon, 17 Sep 2018 08:01:07 -0700
Message-Id: <cover.1537183087.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several defects exist in the logging uses

o Missing KERN_<LEVEL>
o Unnecessary KERN_<LEVEL> uses with panic
o Mismatched MPT3SAS_FMT and %s: with name and __func__

Correct these defects and perhaps add some clarity to the logging.

Joe Perches (7):
  mpt3sas: Add ioc_<level> logging macros
  mpt3sas: Convert uses of pr_<level> with MPT3SAS_FMT to ioc_<level>
  mpt3sas: Convert mlsleading uses of pr_<level> with MPT3SAS_FMT
  mpt3sas: Convert logging uses with MPT3SAS_FMT and reply_q_name to %s:
  mpt3sas: Remove KERN_WARNING from panic uses
  mpt3sas: Convert logging uses with MPT3SAS_FMT without logging levels
  mpt3sas: Remove unused macro MPT3SAS_FMT

 drivers/scsi/mpt3sas/mpt3sas_base.c         | 1116 +++++++++-----------
 drivers/scsi/mpt3sas/mpt3sas_base.h         |    9 +-
 drivers/scsi/mpt3sas/mpt3sas_config.c       |   89 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c          |  493 ++++-----
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 1487 ++++++++++++---------------
 drivers/scsi/mpt3sas/mpt3sas_transport.c    |  337 +++---
 drivers/scsi/mpt3sas/mpt3sas_trigger_diag.c |  101 +-
 drivers/scsi/mpt3sas/mpt3sas_warpdrive.c    |   70 +-
 8 files changed, 1618 insertions(+), 2084 deletions(-)

-- 
2.15.0

