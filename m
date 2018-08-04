Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39ABC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A16217C7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A16217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbeHDLLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:11:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbeHDLLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:11:01 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1E417BC6;
        Sat,  4 Aug 2018 09:11:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
        Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        DM ML <dm-devel@redhat.com>,
        Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 092/124] scsi: scsi_dh: replace too broad "TP9" string with the exact models
Date:   Sat,  4 Aug 2018 11:01:21 +0200
Message-Id: <20180804082705.926393569@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xose Vazquez Perez <xose.vazquez@gmail.com>

[ Upstream commit 37b37d2609cb0ac267280ef27350b962d16d272e ]

SGI/TP9100 is not an RDAC array:
    ^^^
https://git.opensvc.com/gitweb.cgi?p=multipath-tools/.git;a=blob;f=libmultipath/hwtable.c;h=88b4700beb1d8940008020fbe4c3cd97d62f4a56;hb=HEAD#l235

This partially reverts commit 35204772ea03 ("[SCSI] scsi_dh_rdac :
Consolidate rdac strings together")

[mkp: fixed up the new entries to align with rest of struct]

Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Cc: DM ML <dm-devel@redhat.com>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_dh.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/scsi_dh.c
+++ b/drivers/scsi/scsi_dh.c
@@ -58,7 +58,10 @@ static const struct scsi_dh_blist scsi_d
 	{"IBM", "3526",			"rdac", },
 	{"IBM", "3542",			"rdac", },
 	{"IBM", "3552",			"rdac", },
-	{"SGI", "TP9",			"rdac", },
+	{"SGI", "TP9300",		"rdac", },
+	{"SGI", "TP9400",		"rdac", },
+	{"SGI", "TP9500",		"rdac", },
+	{"SGI", "TP9700",		"rdac", },
 	{"SGI", "IS",			"rdac", },
 	{"STK", "OPENstorage",		"rdac", },
 	{"STK", "FLEXLINE 380",		"rdac", },


