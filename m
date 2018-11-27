Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1FAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC3620873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC3620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeK0Srj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:47:39 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:54154 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbeK0Sri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:47:38 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id AE23F35572CC480B9E3F;
        Tue, 27 Nov 2018 15:50:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAR7oPTA005625;
        Tue, 27 Nov 2018 15:50:25 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112715503971-13235280 ;
          Tue, 27 Nov 2018 15:50:39 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Wen Yang <yellowriver2010@hotmail.com>
Subject: [PATCH] scsi: ufs: Use PTR_ERR_OR_ZERO to replace the open coded version
Date:   Tue, 27 Nov 2018 15:50:25 +0800
Message-Id: <20181127075025.16018-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-27 15:50:39,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-27 15:50:21
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wAR7oPTA005625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR=5FERR=5FOR=5FZERO has implemented the same function, so use inlined fun=
ction
instead of open coded equivalent.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Vinayak Holikatti <vinholikatti@gmail.com>
CC: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
CC: Wen Yang <yellowriver2010@hotmail.com>
CC: linux-kernel@vger.kernel.org
---
 drivers/scsi/ufs/ufs-hisi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-hisi.c b/drivers/scsi/ufs/ufs-hisi.c
index 452e19f..6fdf059 100644
--- a/drivers/scsi/ufs/ufs-hisi.c
+++ b/drivers/scsi/ufs/ufs-hisi.c
@@ -514,10 +514,7 @@ static int ufs=5Fhisi=5Fget=5Fresource(struct ufs=5Fhi=
si=5Fhost *host)
 	/* get resource of ufs sys ctrl */
 	mem=5Fres =3D platform=5Fget=5Fresource(pdev, IORESOURCE=5FMEM, 1);
 	host->ufs=5Fsys=5Fctrl =3D devm=5Fioremap=5Fresource(dev, mem=5Fres);
-	if (IS=5FERR(host->ufs=5Fsys=5Fctrl))
-		return PTR=5FERR(host->ufs=5Fsys=5Fctrl);
-
-	return 0;
+	return PTR=5FERR=5FOR=5FZERO(host->ufs=5Fsys=5Fctrl);
 }
=20
 static void ufs=5Fhisi=5Fset=5Fpm=5Flvl(struct ufs=5Fhba *hba)
--=20
2.9.5

