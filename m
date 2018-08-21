Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A83C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021DD208E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021DD208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeHUPEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:04:01 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:44694 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeHUPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:04:00 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id Rnk81y00T3XaVaC01nk89x; Tue, 21 Aug 2018 13:44:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fs54y-0007vD-J3; Tue, 21 Aug 2018 13:44:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fs54y-0004nO-Go; Tue, 21 Aug 2018 13:44:08 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.com>, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] scsi: core: Update SCSI_MQ_DEFAULT help text to match default
Date:   Tue, 21 Aug 2018 13:44:07 +0200
Message-Id: <20180821114407.18393-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default was changed, but the help text was not updated.

Fix grammar (s/the option/this option/) while at it.

Fixes: d5038a13eca72fb2 ("scsi: core: switch to scsi-mq by default")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/scsi/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 8fc851a9e1162a56..a0491e11bd359499 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -53,11 +53,11 @@ config SCSI_MQ_DEFAULT
 	depends on SCSI
 	---help---
 	  This option enables the new blk-mq based I/O path for SCSI
-	  devices by default.  With the option the scsi_mod.use_blk_mq
+	  devices by default.  With this option the scsi_mod.use_blk_mq
 	  module/boot option defaults to Y, without it to N, but it can
 	  still be overridden either way.
 
-	  If unsure say N.
+	  If unsure say Y.
 
 config SCSI_PROC_FS
 	bool "legacy /proc/scsi/ support"
-- 
2.17.1

