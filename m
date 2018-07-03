Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B715BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A51720896
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A51720896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754422AbeGCGyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:54:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753814AbeGCGyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF3A1ACF0;
        Tue,  3 Jul 2018 06:54:35 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>,
        Ming Lei <tom.leiming@gmail.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC] scsi: switch to scsi-mq by default
Date:   Tue,  3 Jul 2018 08:54:13 +0200
Message-Id: <20180703065413.6098-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been more than one year since we tried to change the default
from legacy to multi queue in SCSI. Back then we had to retract the
change because of performance issues with rotating disks.

In the meantime there have been a substantial amount of performance
improvements, thus we can re-enable scsi-mq without a significant
performance penalty.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 35c909bbf8ba..bd115bab162e 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -49,6 +49,7 @@ config SCSI_NETLINK
 
 config SCSI_MQ_DEFAULT
 	bool "SCSI: use blk-mq I/O path by default"
+	default y
 	depends on SCSI
 	---help---
 	  This option enables the new blk-mq based I/O path for SCSI
-- 
2.16.4

