Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mzokNK1ZGVswCgAAmS7hNA
	; Thu, 07 Jun 2018 16:13:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A53256089E; Thu,  7 Jun 2018 16:13:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0EB8960115;
	Thu,  7 Jun 2018 16:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EB8960115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935894AbeFGQNd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:13:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39138 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932930AbeFGOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:59 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zt-Be; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002gu-CR; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Johannes Thumshirn" <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Tomas Henzl" <thenzl@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "John Garry" <john.garry@huawei.com>,
        "Ewan Milne" <emilne@redhat.com>, "Jason Yan" <yanaijie@huawei.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.25667866@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 011/410] scsi: libsas: remove the numbering for each
 event enum
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Yan <yanaijie@huawei.com>

commit 0d78f969b10f27e0be34210d482a01e1ee92994c upstream.

Numbering for each event enum makes no sense. Remove the numbering so
that we don't have to calculate the number by hand every time.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
CC: John Garry <john.garry@huawei.com>
CC: Johannes Thumshirn <jthumshirn@suse.de>
CC: Ewan Milne <emilne@redhat.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Tomas Henzl <thenzl@redhat.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/scsi/libsas.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -67,31 +67,31 @@ enum ha_event {
 
 enum port_event {
 	PORTE_BYTES_DMAED     = 0U,
-	PORTE_BROADCAST_RCVD  = 1,
-	PORTE_LINK_RESET_ERR  = 2,
-	PORTE_TIMER_EVENT     = 3,
-	PORTE_HARD_RESET      = 4,
-	PORT_NUM_EVENTS       = 5,
+	PORTE_BROADCAST_RCVD,
+	PORTE_LINK_RESET_ERR,
+	PORTE_TIMER_EVENT,
+	PORTE_HARD_RESET,
+	PORT_NUM_EVENTS,
 };
 
 enum phy_event {
 	PHYE_LOSS_OF_SIGNAL   = 0U,
-	PHYE_OOB_DONE         = 1,
-	PHYE_OOB_ERROR        = 2,
-	PHYE_SPINUP_HOLD      = 3, /* hot plug SATA, no COMWAKE sent */
-	PHYE_RESUME_TIMEOUT   = 4,
-	PHY_NUM_EVENTS        = 5,
+	PHYE_OOB_DONE,
+	PHYE_OOB_ERROR,
+	PHYE_SPINUP_HOLD,             /* hot plug SATA, no COMWAKE sent */
+	PHYE_RESUME_TIMEOUT,
+	PHY_NUM_EVENTS,
 };
 
 enum discover_event {
 	DISCE_DISCOVER_DOMAIN   = 0U,
-	DISCE_REVALIDATE_DOMAIN = 1,
-	DISCE_PORT_GONE         = 2,
-	DISCE_PROBE		= 3,
-	DISCE_SUSPEND		= 4,
-	DISCE_RESUME		= 5,
-	DISCE_DESTRUCT		= 6,
-	DISC_NUM_EVENTS		= 7,
+	DISCE_REVALIDATE_DOMAIN,
+	DISCE_PORT_GONE,
+	DISCE_PROBE,
+	DISCE_SUSPEND,
+	DISCE_RESUME,
+	DISCE_DESTRUCT,
+	DISC_NUM_EVENTS,
 };
 
 /* ---------- Expander Devices ---------- */
