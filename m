Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F89420821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F89420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeLJVdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:33:50 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLJVdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:33:50 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M9j3f-1gbilr2rtP-00D1Ct; Mon, 10 Dec 2018 22:33:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Raghava Aditya Renukunta 
        <RaghavaAditya.Renukunta@microsemi.com>,
        Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scsi: aacraid: change event_wait to a completion
Date:   Mon, 10 Dec 2018 22:32:41 +0100
Message-Id: <20181210213301.1065510-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210213301.1065510-1-arnd@arndb.de>
References: <20181210213301.1065510-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kxdNZyNNJz19uuP6Iwhkdm+DBfCJ9YU8YmmGGgZSnvEPkbRYe4M
 l2boWkj9TelrH9D4+PQNkmvck4aJ9PWcNERJQr1LkxWliwGm8F3SvTMvoBQ2wcM0p8wVgQD
 +qzqzW8lFPppo+GaXKfFDibwBCia+nKSgg20lWO0k0xHIRnYZ3zG/+rkz/2pp2wVZOFZzrn
 WdnbnC+ASEqZmB/w2DwMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hwMhN/bSMqw=:w1J/3KC1u7cdXiIRChjDfN
 T5RXxQFbu4Ub42STk185IYJ+/2y9CB/D2E1IQjezvIcMlKv1ayusss/zdP+eZDJLUB8Gt8sxY
 g63vM7mO7uQiYhNLoU281kvE90Mnx2wmZF1QT2/SBSEBPMeBFYeXhUTMuu3jnE8dr+KM1hYWi
 crGEWDnPjKClh44Yo96C83k4I1YqP5pSreO7lEXwrtpqng/9yjXkNqsodvWOOiT1iOLTSf2p3
 AfOBaZI1hF9GxN4jwg53rW9r0unQEQ7xRxYQKO0l8vPK8TmM895fAzfNcSOyr2rQpiKT8hePY
 k6EKSUyg9HOr1mXgC2mdc+TQxPQlXxWuNfNI9JFGFg87vAzP20TtOrGiuqZxjawdII3XV0zmw
 wwwm7qtM/LZLyR8ud7irMvIxrZ2xWlBo3PX4I1eyWVqwAG/Q+N7trOKar6pSEF3acHTwi9S6c
 oSReo1Vtm3nJvlaozRjivxNeZ/v+O7y5iYfm3dTspMgBWRx3Fusda4IsmpYBffi/pLPEdRpGW
 HXjdcyE8bPw4dcPku0BaLirzilB9N75WQGg9sWfOgp4tycR2VAhsL5vFCJD/k/2A0ZfQetxP9
 Ny6uB5ZsLLwL3sIr2oh0qy4kxwHntsAGuKES9rSccVe49tB+LhiWW5UCtfap+21nzlRn3JZtU
 Wv3BumiYCuPSfdC50Geyg4x9xIcUrc1Xu1h/NCgWLkOZjrC+djyKIMgT6/tBoV/IdkQQXhR/O
 bORjjH/Y7e6Rk535A9tFY+gjY8/1kTH/uZ8afg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_wait semaphore has completion semantics, so we can
change it over to the completion interface for clarity without
changing the behavior.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/aacraid/aacraid.h  |  3 ++-
 drivers/scsi/aacraid/commctrl.c |  1 -
 drivers/scsi/aacraid/commsup.c  | 15 +++++++--------
 drivers/scsi/aacraid/dpcsup.c   | 19 +++++++++----------
 drivers/scsi/aacraid/linit.c    |  2 +-
 drivers/scsi/aacraid/src.c      |  2 +-
 6 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 531a0b9a58f8..3291d1c16864 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -40,6 +40,7 @@
 #define nblank(x) _nblank(x)[0]
 
 #include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/pci.h>
 #include <scsi/scsi_host.h>
 
@@ -1313,7 +1314,7 @@ struct fib {
 	 *	This is the event the sendfib routine will wait on if the
 	 *	caller did not pass one and this is synch io.
 	 */
-	struct semaphore	event_wait;
+	struct completion	event_wait;
 	spinlock_t		event_lock;
 
 	u32			done;	/* gets set to 1 when fib is complete */
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 6a6ad9477786..e2899ff7913e 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -41,7 +41,6 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h> /* ssleep prototype */
 #include <linux/kthread.h>
-#include <linux/semaphore.h>
 #include <linux/uaccess.h>
 #include <scsi/scsi_host.h>
 
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 7ed51a77e39d..d5a6aa9676c8 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -44,7 +44,6 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
-#include <linux/semaphore.h>
 #include <linux/bcd.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
@@ -189,7 +188,7 @@ int aac_fib_setup(struct aac_dev * dev)
 		fibptr->hw_fib_va = hw_fib;
 		fibptr->data = (void *) fibptr->hw_fib_va->data;
 		fibptr->next = fibptr+1;	/* Forward chain the fibs */
-		sema_init(&fibptr->event_wait, 0);
+		init_completion(&fibptr->event_wait);
 		spin_lock_init(&fibptr->event_lock);
 		hw_fib->header.XferState = cpu_to_le32(0xffffffff);
 		hw_fib->header.SenderSize =
@@ -623,7 +622,7 @@ int aac_fib_send(u16 command, struct fib *fibptr, unsigned long size,
 		}
 		if (wait) {
 			fibptr->flags |= FIB_CONTEXT_FLAG_WAIT;
-			if (down_interruptible(&fibptr->event_wait)) {
+			if (wait_for_completion_interruptible(&fibptr->event_wait)) {
 				fibptr->flags &= ~FIB_CONTEXT_FLAG_WAIT;
 				return -EFAULT;
 			}
@@ -659,7 +658,7 @@ int aac_fib_send(u16 command, struct fib *fibptr, unsigned long size,
 			 * hardware failure has occurred.
 			 */
 			unsigned long timeout = jiffies + (180 * HZ); /* 3 minutes */
-			while (down_trylock(&fibptr->event_wait)) {
+			while (!try_wait_for_completion(&fibptr->event_wait)) {
 				int blink;
 				if (time_is_before_eq_jiffies(timeout)) {
 					struct aac_queue * q = &dev->queues->queue[AdapNormCmdQueue];
@@ -689,9 +688,9 @@ int aac_fib_send(u16 command, struct fib *fibptr, unsigned long size,
 				 */
 				schedule();
 			}
-		} else if (down_interruptible(&fibptr->event_wait)) {
+		} else if (wait_for_completion_interruptible(&fibptr->event_wait)) {
 			/* Do nothing ... satisfy
-			 * down_interruptible must_check */
+			 * wait_for_completion_interruptible must_check */
 		}
 
 		spin_lock_irqsave(&fibptr->event_lock, flags);
@@ -777,7 +776,7 @@ int aac_hba_send(u8 command, struct fib *fibptr, fib_callback callback,
 			return -EFAULT;
 
 		fibptr->flags |= FIB_CONTEXT_FLAG_WAIT;
-		if (down_interruptible(&fibptr->event_wait))
+		if (wait_for_completion_interruptible(&fibptr->event_wait))
 			fibptr->done = 2;
 		fibptr->flags &= ~(FIB_CONTEXT_FLAG_WAIT);
 
@@ -1538,7 +1537,7 @@ static int _aac_reset_adapter(struct aac_dev *aac, int forced, u8 reset_type)
 		  || fib->flags & FIB_CONTEXT_FLAG_WAIT) {
 			unsigned long flagv;
 			spin_lock_irqsave(&fib->event_lock, flagv);
-			up(&fib->event_wait);
+			complete(&fib->event_wait);
 			spin_unlock_irqrestore(&fib->event_lock, flagv);
 			schedule();
 			retval = 0;
diff --git a/drivers/scsi/aacraid/dpcsup.c b/drivers/scsi/aacraid/dpcsup.c
index ddc69738375f..40a771dd1c0e 100644
--- a/drivers/scsi/aacraid/dpcsup.c
+++ b/drivers/scsi/aacraid/dpcsup.c
@@ -38,7 +38,6 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/blkdev.h>
-#include <linux/semaphore.h>
 
 #include "aacraid.h"
 
@@ -129,7 +128,7 @@ unsigned int aac_response_normal(struct aac_queue * q)
 			spin_lock_irqsave(&fib->event_lock, flagv);
 			if (!fib->done) {
 				fib->done = 1;
-				up(&fib->event_wait);
+				complete(&fib->event_wait);
 			}
 			spin_unlock_irqrestore(&fib->event_lock, flagv);
 
@@ -376,16 +375,16 @@ unsigned int aac_intr_normal(struct aac_dev *dev, u32 index, int isAif,
 				start_callback = 1;
 			} else {
 				unsigned long flagv;
-				int complete = 0;
+				int completed = 0;
 
 				dprintk((KERN_INFO "event_wait up\n"));
 				spin_lock_irqsave(&fib->event_lock, flagv);
 				if (fib->done == 2) {
 					fib->done = 1;
-					complete = 1;
+					completed = 1;
 				} else {
 					fib->done = 1;
-					up(&fib->event_wait);
+					complete(&fib->event_wait);
 				}
 				spin_unlock_irqrestore(&fib->event_lock, flagv);
 
@@ -395,7 +394,7 @@ unsigned int aac_intr_normal(struct aac_dev *dev, u32 index, int isAif,
 					mflags);
 
 				FIB_COUNTER_INCREMENT(aac_config.NativeRecved);
-				if (complete)
+				if (completed)
 					aac_fib_complete(fib);
 			}
 		} else {
@@ -428,16 +427,16 @@ unsigned int aac_intr_normal(struct aac_dev *dev, u32 index, int isAif,
 				start_callback = 1;
 			} else {
 				unsigned long flagv;
-				int complete = 0;
+				int completed = 0;
 
 				dprintk((KERN_INFO "event_wait up\n"));
 				spin_lock_irqsave(&fib->event_lock, flagv);
 				if (fib->done == 2) {
 					fib->done = 1;
-					complete = 1;
+					completed = 1;
 				} else {
 					fib->done = 1;
-					up(&fib->event_wait);
+					complete(&fib->event_wait);
 				}
 				spin_unlock_irqrestore(&fib->event_lock, flagv);
 
@@ -447,7 +446,7 @@ unsigned int aac_intr_normal(struct aac_dev *dev, u32 index, int isAif,
 					mflags);
 
 				FIB_COUNTER_INCREMENT(aac_config.NormalRecved);
-				if (complete)
+				if (completed)
 					aac_fib_complete(fib);
 			}
 		}
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 42defee90eb2..1c5d54c2f031 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1560,7 +1560,7 @@ static void __aac_shutdown(struct aac_dev * aac)
 			struct fib *fib = &aac->fibs[i];
 			if (!(fib->hw_fib_va->header.XferState & cpu_to_le32(NoResponseExpected | Async)) &&
 			    (fib->hw_fib_va->header.XferState & cpu_to_le32(ResponseExpected)))
-				up(&fib->event_wait);
+				complete(&fib->event_wait);
 		}
 		kthread_stop(aac->thread);
 		aac->thread = NULL;
diff --git a/drivers/scsi/aacraid/src.c b/drivers/scsi/aacraid/src.c
index 7a51ccfa8662..8377aec0649d 100644
--- a/drivers/scsi/aacraid/src.c
+++ b/drivers/scsi/aacraid/src.c
@@ -106,7 +106,7 @@ static irqreturn_t aac_src_intr_message(int irq, void *dev_id)
 			spin_lock_irqsave(&dev->sync_fib->event_lock, sflags);
 			if (dev->sync_fib->flags & FIB_CONTEXT_FLAG_WAIT) {
 				dev->management_fib_count--;
-				up(&dev->sync_fib->event_wait);
+				complete(&dev->sync_fib->event_wait);
 			}
 			spin_unlock_irqrestore(&dev->sync_fib->event_lock,
 						sflags);
-- 
2.20.0

