Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E2D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E2D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeK0TSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:18:18 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:46336 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbeK0TSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:18:17 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 5B19D120B702D7C9F218;
        Tue, 27 Nov 2018 16:20:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAR8KVBD050407;
        Tue, 27 Nov 2018 16:20:31 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112716204518-13245100 ;
          Tue, 27 Nov 2018 16:20:45 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Wen Yang <yellowriver2010@hotmail.com>
Subject: [PATCH] scsi: qla2xxx: Use PTR_ERR_OR_ZERO to replace the open coded version
Date:   Tue, 27 Nov 2018 16:20:27 +0800
Message-Id: <20181127082027.46223-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-27 16:20:45,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-27 16:20:26
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAR8KVBD050407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR=5FERR=5FOR=5FZERO has implemented the same function, so use inlined fun=
ction
instead of open coded equivalent.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: qla2xxx-upstream@qlogic.com
CC: linux-scsi@vger.kernel.org
CC: Wen Yang <yellowriver2010@hotmail.com>
CC: linux-kernel@vger.kernel.org
---
 drivers/scsi/qla2xxx/tcm=5Fqla2xxx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm=5Fqla2xxx.c b/drivers/scsi/qla2xxx/tc=
m=5Fqla2xxx.c
index 65053c066680..633f258085c7 100644
--- a/drivers/scsi/qla2xxx/tcm=5Fqla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm=5Fqla2xxx.c
@@ -1577,10 +1577,7 @@ static int tcm=5Fqla2xxx=5Fcheck=5Finitiator=5Fnode=
=5Facl(
 				       sizeof(struct qla=5Ftgt=5Fcmd),
 				       TARGET=5FPROT=5FALL, port=5Fname,
 				       qlat=5Fsess, tcm=5Fqla2xxx=5Fsession=5Fcb);
-	if (IS=5FERR(se=5Fsess))
-		return PTR=5FERR(se=5Fsess);
-
-	return 0;
+	return PTR=5FERR=5FOR=5FZERO(se=5Fsess);
 }
=20
 static void tcm=5Fqla2xxx=5Fupdate=5Fsess(struct fc=5Fport *sess, port=5Fi=
d=5Ft s=5Fid,
--=20
2.19.1

