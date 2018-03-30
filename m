Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4116345-1522437026-2-13827224822312209528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522437025; b=BRBOkWjWQKycvlHQNf1XIAc9982MKvlXdJOSz14FPeVzO40g0Z
    F0PVoL2ct59tlmvslB1WRmcNfVvBjCJ8vvMZJCC+R5UjPLzXL6dj2sOHLVtE8h0a
    S9Rodn4SdM3RqKcy4m8Jv/TjfwFPr/h+y4Z3uG2quoW3OBwQrVT8X9jaCZHhHyQJ
    NxE58aTuIpgd/lQ2K2zeNQAkuQ0ZHUNxRukWeFmrpGGHkkxDeZ2S1DhFoMUR9nXA
    R2oxpNiT/11H6mcPgivPNAo8OQF+O+JcriabRxKkKHlMyTb1fi+JpqEJWxwK25UB
    6E2LzSWqcTk5f1kybDZU/OBvi8/ANFgnU4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522437025; bh=1D8/2
    P6p9DvSFBE71zqJZ5SaM0fzY3MpbA6WkoQHY28=; b=vNjlOMmae8J9JwLDpJ+cq
    M+qs1Ut9aCO++rT+M9WH/ZZsXtkqATjSSCXp/b80YmEesISKEH9NSwe6TbCwpnZC
    3uu886UeX5ZDVDXYqQIsvmSK4DQQ093V06h7QMNmDjKi6V6/YgMuICcSduZEFrRp
    6gOOhIaGCCWG5L2s4OIEuyrC7+me1rBZDkinNlyU+Vs66Gv9a11t+0uk8LDlzscO
    aBBng6jEMJ84PbeHcAi1MT5k+BYqP1Z9nwJow9c4kW0Pj1bkc69ZGPzDfJ6iNDpp
    xyXGrxHheHBtDviNZFbcP8rIcQv8sRjyl1UkxUwHJ/sYbuKElmWGDzJq2oD5dmDw
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCK0tYSGAp9Fg1d90LYYCrfZt+iUn1XvcPWQwr6qoK4uIrKsyc8lwBBZiU7QxnrnA8pV6UhwPXN4AnirnosYIKVQOQxbmak++RMB1SX/V9U3RcWf+t5o
    4gTZP9rFNY/g5h46suifeg24Kg/r1Wo2zGV8KYIq1r2q7J4iMxjjh9zcD6M4jdm7fN9ev8/FMMkHg6BEbrnbWu4PadbRafa2nbJwHsO959Yhj7mVQWkQK3qo
    oWqgO+XYTQhxyA4zlWN9dA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=JfrnYn6hAAAA:8 a=sK_hXKufAAAA:8 a=DDOyTI_5AAAA:8 a=MX-Qvybvn9NLPrmuF0wA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=yWjlxG-dkHreuWcaj4iL:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH] staging: lustre: libcfs: use dynamic minors for /dev/{lnet,
 obd}
Date: Fri, 30 Mar 2018 15:10:06 -0400
Message-Id: <1522437006-31539-1-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "John L. Hammond" <john.hammond@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "John L. Hammond" <john.hammond@intel.com>

Request dynamic minor allocation when registering /dev/lnet and
/dev/obd.

Signed-off-by: John L. Hammond <john.hammond@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-100086
Reviewed-on: https://review.whamcloud.com/29741
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Reviewed-by: Jian Yu <jian.yu@intel.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
Reviewed-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h    |  1 -
 drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h      | 11 -----------
 .../staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h   |  2 --
 drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c        |  1 -
 drivers/staging/lustre/lnet/libcfs/linux/linux-module.c       |  5 ++---
 drivers/staging/lustre/lnet/libcfs/module.c                   |  1 +
 drivers/staging/lustre/lustre/obdclass/class_obd.c            |  6 ++++--
 drivers/staging/lustre/lustre/obdclass/linux/linux-module.c   |  3 +--
 8 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
index 30e333a..cf4c606 100644
--- a/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
@@ -50,7 +50,6 @@
 #include <linux/kernel.h>
 #include <linux/kmod.h>
 #include <linux/kthread.h>
-#include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
 #include <linux/module.h>
diff --git a/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h b/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
index d9da625..cccb32d 100644
--- a/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lnet/lnetctl.h
@@ -119,16 +119,5 @@ struct lnet_fault_stat {
 
 #define LNET_DEV_ID 0
 #define LNET_DEV_PATH "/dev/lnet"
-#define LNET_DEV_MAJOR 10
-#define LNET_DEV_MINOR 240
-#define OBD_DEV_ID 1
-#define OBD_DEV_NAME "obd"
-#define OBD_DEV_PATH "/dev/" OBD_DEV_NAME
-#define OBD_DEV_MAJOR 10
-#define OBD_DEV_MINOR 241
-#define SMFS_DEV_ID  2
-#define SMFS_DEV_PATH "/dev/snapdev"
-#define SMFS_DEV_MAJOR 10
-#define SMFS_DEV_MINOR 242
 
 #endif
diff --git a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
index 9590864..6e4e109 100644
--- a/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
+++ b/drivers/staging/lustre/include/uapi/linux/lustre/lustre_ioctl.h
@@ -51,8 +51,6 @@ enum md_echo_cmd {
 #define OBD_DEV_ID 1
 #define OBD_DEV_NAME "obd"
 #define OBD_DEV_PATH "/dev/" OBD_DEV_NAME
-#define OBD_DEV_MAJOR 10
-#define OBD_DEV_MINOR 241
 
 #define OBD_IOCTL_VERSION	0x00010004
 #define OBD_DEV_BY_DEVNAME	0xffffd0de
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
index 0092166..1d728f1 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-debug.c
@@ -48,7 +48,6 @@
 #include <linux/completion.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
-#include <linux/miscdevice.h>
 
 # define DEBUG_SUBSYSTEM S_LNET
 
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
index ddf6256..c8908e8 100644
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
+++ b/drivers/staging/lustre/lnet/libcfs/linux/linux-module.c
@@ -33,10 +33,9 @@
 
 #define DEBUG_SUBSYSTEM S_LNET
 
+#include <linux/miscdevice.h>
 #include <linux/libcfs/libcfs.h>
 
-#define LNET_MINOR 240
-
 static inline size_t libcfs_ioctl_packlen(struct libcfs_ioctl_data *data)
 {
 	size_t len = sizeof(*data);
@@ -191,7 +190,7 @@ int libcfs_ioctl_getdata(struct libcfs_ioctl_hdr **hdr_pp,
 };
 
 struct miscdevice libcfs_dev = {
-	.minor = LNET_MINOR,
+	.minor = MISC_DYNAMIC_MINOR,
 	.name = "lnet",
 	.fops = &libcfs_fops,
 };
diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/lustre/lnet/libcfs/module.c
index a03f924..4b9acd7 100644
--- a/drivers/staging/lustre/lnet/libcfs/module.c
+++ b/drivers/staging/lustre/lnet/libcfs/module.c
@@ -30,6 +30,7 @@
  * This file is part of Lustre, http://www.lustre.org/
  * Lustre is a trademark of Sun Microsystems, Inc.
  */
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
diff --git a/drivers/staging/lustre/lustre/obdclass/class_obd.c b/drivers/staging/lustre/lustre/obdclass/class_obd.c
index 3e24b76..7b5be6b 100644
--- a/drivers/staging/lustre/lustre/obdclass/class_obd.c
+++ b/drivers/staging/lustre/lustre/obdclass/class_obd.c
@@ -32,7 +32,9 @@
  */
 
 #define DEBUG_SUBSYSTEM S_CLASS
-# include <linux/atomic.h>
+
+#include <linux/atomic.h>
+#include <linux/miscdevice.h>
 
 #include <obd_support.h>
 #include <obd_class.h>
@@ -462,7 +464,7 @@ static int __init obdclass_init(void)
 
 	err = misc_register(&obd_psdev);
 	if (err) {
-		CERROR("cannot register %d err %d\n", OBD_DEV_MINOR, err);
+		CERROR("cannot register OBD miscdevices: err %d\n", err);
 		return err;
 	}
 
diff --git a/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c b/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
index 7bceee7..3b1d096 100644
--- a/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
+++ b/drivers/staging/lustre/lustre/obdclass/linux/linux-module.c
@@ -42,7 +42,6 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/major.h>
 #include <linux/sched.h>
 #include <linux/lp.h>
 #include <linux/slab.h>
@@ -271,7 +270,7 @@ static long obd_class_ioctl(struct file *filp, unsigned int cmd,
 
 /* modules setup */
 struct miscdevice obd_psdev = {
-	.minor = OBD_DEV_MINOR,
+	.minor = MISC_DYNAMIC_MINOR,
 	.name  = OBD_DEV_NAME,
 	.fops  = &obd_psdev_fops,
 };
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
