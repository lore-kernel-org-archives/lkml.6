Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37221C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC24220881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC24220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbeLCCXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:23:38 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:16372 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbeLCCXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:23:37 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 650694C26F0E5C6F37AF;
        Mon,  3 Dec 2018 10:23:32 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB32NPXu034507;
        Mon, 3 Dec 2018 10:23:25 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120310232897-14343508 ;
          Mon, 3 Dec 2018 10:23:28 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Davidlohr Bueso <dave@stgolabs.net>, paulmck@linux.ibm.com,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH v2] locktorture: Fix assignment of boolean variables
Date:   Mon, 3 Dec 2018 10:23:18 +0800
Message-Id: <20181203022318.58083-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-03 10:23:29,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-03 10:23:25
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB32NPXu034507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by coccinelle:

kernel/locking/locktorture.c:703:6-10: WARNING: Assignment of bool to 0/1
kernel/locking/locktorture.c:918:2-20: WARNING: Assignment of bool to 0/1
kernel/locking/locktorture.c:949:3-20: WARNING: Assignment of bool to 0/1
kernel/locking/locktorture.c:682:2-19: WARNING: Assignment of bool to 0/1
kernel/locking/locktorture.c:688:2-19: WARNING: Assignment of bool to 0/1
kernel/locking/locktorture.c:648:2-20: WARNING: Assignment of bool to 0/1
kernel/locking/locktorture.c:654:2-20: WARNING: Assignment of bool to 0/1

This patch also makes the code more readable.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Davidlohr Bueso <dave@stgolabs.net>
CC: "Paul E. McKenney" <paulmck@linux.ibm.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-kernel@vger.kernel.org
---
 kernel/locking/locktorture.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 7d0b0ed74404..cd95c01491d8 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -645,13 +645,13 @@ static int lock=5Ftorture=5Fwriter(void *arg)
 		cxt.cur=5Fops->writelock();
 		if (WARN=5FON=5FONCE(lock=5Fis=5Fwrite=5Fheld))
 			lwsp->n=5Flock=5Ffail++;
-		lock=5Fis=5Fwrite=5Fheld =3D 1;
+		lock=5Fis=5Fwrite=5Fheld =3D true;
 		if (WARN=5FON=5FONCE(lock=5Fis=5Fread=5Fheld))
 			lwsp->n=5Flock=5Ffail++; /* rare, but... */
=20
 		lwsp->n=5Flock=5Facquired++;
 		cxt.cur=5Fops->write=5Fdelay(&rand);
-		lock=5Fis=5Fwrite=5Fheld =3D 0;
+		lock=5Fis=5Fwrite=5Fheld =3D false;
 		cxt.cur=5Fops->writeunlock();
=20
 		stutter=5Fwait("lock=5Ftorture=5Fwriter");
@@ -679,13 +679,13 @@ static int lock=5Ftorture=5Freader(void *arg)
 			schedule=5Ftimeout=5Funinterruptible(1);
=20
 		cxt.cur=5Fops->readlock();
-		lock=5Fis=5Fread=5Fheld =3D 1;
+		lock=5Fis=5Fread=5Fheld =3D true;
 		if (WARN=5FON=5FONCE(lock=5Fis=5Fwrite=5Fheld))
 			lrsp->n=5Flock=5Ffail++; /* rare, but... */
=20
 		lrsp->n=5Flock=5Facquired++;
 		cxt.cur=5Fops->read=5Fdelay(&rand);
-		lock=5Fis=5Fread=5Fheld =3D 0;
+		lock=5Fis=5Fread=5Fheld =3D false;
 		cxt.cur=5Fops->readunlock();
=20
 		stutter=5Fwait("lock=5Ftorture=5Freader");
@@ -700,7 +700,7 @@ static int lock=5Ftorture=5Freader(void *arg)
 static void =5F=5Ftorture=5Fprint=5Fstats(char *page,
 				  struct lock=5Fstress=5Fstats *statp, bool write)
 {
-	bool fail =3D 0;
+	bool fail =3D false;
 	int i, n=5Fstress;
 	long max =3D 0, min =3D statp ? statp[0].n=5Flock=5Facquired : 0;
 	long long sum =3D 0;
@@ -915,7 +915,7 @@ static int =5F=5Finit lock=5Ftorture=5Finit(void)
=20
 	/* Initialize the statistics so that each run gets its own numbers. */
 	if (nwriters=5Fstress) {
-		lock=5Fis=5Fwrite=5Fheld =3D 0;
+		lock=5Fis=5Fwrite=5Fheld =3D false;
 		cxt.lwsa =3D kmalloc=5Farray(cxt.nrealwriters=5Fstress,
 					 sizeof(*cxt.lwsa),
 					 GFP=5FKERNEL);
@@ -946,7 +946,7 @@ static int =5F=5Finit lock=5Ftorture=5Finit(void)
 		}
=20
 		if (nreaders=5Fstress) {
-			lock=5Fis=5Fread=5Fheld =3D 0;
+			lock=5Fis=5Fread=5Fheld =3D false;
 			cxt.lrsa =3D kmalloc=5Farray(cxt.nrealreaders=5Fstress,
 						 sizeof(*cxt.lrsa),
 						 GFP=5FKERNEL);
--=20
2.19.1

