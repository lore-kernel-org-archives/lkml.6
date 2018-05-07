Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655622-5-4401097554080837212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655622; b=R7wZFm3qQ4Gd5OqSNWRpTJ+lWAOswovo520dLMrZtw5v+qtqrh
    Z1M5hf9AknXvQA8CXzijEZUn7ln2qq52xb3tdme/W/dh0urFWXzRx1bAY8pwNEUP
    bo9A4sMG5U0SMTjjVH/g8mHdkbQuE/ghIQHHIIiFKks7OiSeryBW7R4EizaeA3SD
    30eaTHgOK0yaVs6g1WcJU72ufRt7HzggMQs1L2Fh2uABpSKK7iXSJzegq20wUh6f
    QMce8AawMujDBi223b9e7ZkYifYStn+PbFTKcemAQTHuDgLWzuNCI49xg0Qoqxno
    4vf5MOlqDyrcx8rLvCumDW4pn1htf0tddJug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655622; bh=nVdcu
    pCdHp1XngUJFkrEpL+1yXBlOCuq+q6MwizqdnM=; b=FCGLsh1RnwlEq0WKOxv5X
    6E5l/HIAsl+raEoRSB0RhT41LN4F1xihVmLMF5Vvm/7fX2zhZnt5fGv9RVVSSHsO
    pAbl0LWhcRYp3eOlhQHe1q2QPIA8GX4Koa8ha8rNL7NJD3OYZOSWX2elbq7dJejs
    d0H4A7jG2Fa2NHgIhQLPQjoUvMTGZ4sgLiYCXGnAZQIC4NtE+zKgkGVI8coLeWJO
    /+PEIRvu3Achmqg8atQqoApUc8LU+YxFL8doqVrpAxxvROr/jaBUrNzje5jRbyok
    nH6pdLFOMxZaHPx+pUVu1QcADLqSFiAno/mvTpgVKbUK9MV4XDbaCpjiIx+kZnt6
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=d1yb/DQT x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=igwOyvYl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=d1yb/DQT x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=igwOyvYl;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCn2CGHSRy3aajJs7uGyHeK+KWq3Ry8W8e0/sux57ZWBhrwnc+4xCJQpmLUJuzRpdc+krsbx5AfFOTUcC/SaiEC+roSRz3df0mUq7lJwUgxBoUSXSTRI
    mFIYU0XcZr+pEKIbnHWAxueiomF3VNacuWZe5qZq2oOaPyQNEPxrKegYKMb9NgdmB93DwSOo51To3F1lnszCPLtu0jc8rDiUgwi2Nkg+8knzeEpE5FOUlt1A
    G/B6DckIW1VhYfj6k9rTaQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=uj9jQtBjC-g7TGa3-8MA:9 a=Aamy88YkOfMwcIlu:21
    a=5QnwVMlNKJArHIrc:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqP6vPmDkels1z40BieRyjN5JeWLKxm+/Hzq5lVa8y+NGteXU2DwxN1LPrQFdpHB2RIqexuxQ==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 5/6] staging: android: vsoc: Fix ending '(' warnings in
 vsoc_ioctl
Date: Sun,  6 May 2018 18:13:27 -0700
Message-Id: <20180507011328.11982-5-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507011328.11982-1-natechancellor@gmail.com>
References: <20180507011328.11982-1-natechancellor@gmail.com>
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
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch.pl warnings about lines ending with parentheses.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/android/vsoc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 7e9cf3e4fa04..c460740f9561 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -552,10 +552,10 @@ static long vsoc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			if (!node)
 				return -ENOMEM;
 			INIT_LIST_HEAD(&node->list);
-			rv = do_create_fd_scoped_permission(
-				region_p,
-				node,
-				(struct fd_scoped_permission_arg __user *)arg);
+			rv = do_create_fd_scoped_permission
+				(region_p,
+				 node,
+				 (struct fd_scoped_permission_arg __user *)arg);
 			if (!rv) {
 				mutex_lock(&vsoc_dev.mtx);
 				list_add(&node->list, &vsoc_dev.permissions);
@@ -582,9 +582,7 @@ static long vsoc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 
 	case VSOC_MAYBE_SEND_INTERRUPT_TO_HOST:
-		if (!atomic_xchg(
-			    reg_data->outgoing_signalled,
-			    1)) {
+		if (!atomic_xchg(reg_data->outgoing_signalled, 1)) {
 			writel(reg_num, vsoc_dev.regs + DOORBELL);
 			return 0;
 		} else {
@@ -595,17 +593,16 @@ static long vsoc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case VSOC_SEND_INTERRUPT_TO_HOST:
 		writel(reg_num, vsoc_dev.regs + DOORBELL);
 		return 0;
-
 	case VSOC_WAIT_FOR_INCOMING_INTERRUPT:
-		wait_event_interruptible(
-			reg_data->interrupt_wait_queue,
-			(atomic_read(reg_data->incoming_signalled) != 0));
+		wait_event_interruptible
+			(reg_data->interrupt_wait_queue,
+			 (atomic_read(reg_data->incoming_signalled) != 0));
 		break;
 
 	case VSOC_DESCRIBE_REGION:
-		return do_vsoc_describe_region(
-			filp,
-			(struct vsoc_device_region __user *)arg);
+		return do_vsoc_describe_region
+			(filp,
+			 (struct vsoc_device_region __user *)arg);
 
 	case VSOC_SELF_INTERRUPT:
 		atomic_set(reg_data->incoming_signalled, 1);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
