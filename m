Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228598-1527605309-2-10146015027137300274
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527605309; b=Uk17f6QafQ0I0UMyJVGGdcK1XfNWkJQrFUcwIC/gc85atInRuk
    EDwed7tRqTucsoJHPH//xA3PH1zw+MSCaPw9kpKIUBACowVmOPTxO8ppWqn0AUqI
    3H1odmw1KMA5KudsrYEK7K+BGmxN6o7czbrXaTozQR8vrx6LeYxRkS0r6fH6nubM
    ZCQVhOgeBi9XmYkqpUHrTg1hh462S9s+rJzcmWCeNdE0q6937zSzxWQItuZPGOFi
    qTL9Mmp21MOy/xdTUZ6O4W30dy0CmnvJS0OmiO+5EYrHlOOsaFaNp6/v4qe/lOMJ
    XflVSAc4L4DVERZw+a8iRaKxPwfS2qATQkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527605309; bh=
    esBFL3bJJqdjUY4IuWwcTEJ8/TNaqhdkM1KTquCiceA=; b=SN0MPjF9BtqtLEie
    ChpOxTH4i91QavJgrK2EycwqxdBrZzPDN8NI6yKdxASmiRYPseCubkHlcXVTH+BL
    KuvXMvB5dPsQbxd081UUYU8rqpqMclWrzB+Plj38ZHyEL6AWCNVXkwWQSrlo2mh6
    Rtvv1uJvMf8wm+lGgskicmqxVoMBqsyECqfCirAhlNL8LAG7KBpKDtLLea1x1/Vm
    +oQ2uyGWtoX84+sEohMVgl8NoCCkzpflzF2cGsdNdKgpPsXmaefo7rLMnXC3PHmp
    my7qL3w3wsg3roBhI4w9sdhV7cpAe/4okI5I2yBWnuURC/7/zsN2gN23b11rS9pT
    2seSHQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=gjN/OqoU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=gjN/OqoU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBdiAvrBzyeYH9gT0QjOX1dU2TVMVI1aG17FmSt2vqYRzrt+Y/Fw3zrELTnwH4uVAsmvfavktcmlMW+XYonUugt40tM8d6+2fF/keRE4CQudJHYzdSYg
    PUbO2TWLzeLot1fDSfVNjKVohKZWCnfquv4aHRwbDAcuNRsNuDbZxEOHSx4RuKk42SENR7mBZQHJX53L7VBGK+8+9PvttOzRDZmWi9dLUcswM3tEvmah4xMl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=C98QseHVKh0Tj_lAxXMA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935576AbeE2OsY (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:48:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55950 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936677AbeE2Oqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:48 -0400
X-Google-Smtp-Source: ADUXVKJcjFJjsCjNAH6UL4Zu3fRSFthGwhbZxYiGuR8OFKYigR3drmp6Rd8JNpqM5AZ2SkplovybqA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/28] ovl: Do not do metadata only copy-up for truncate operation
Date: Tue, 29 May 2018 16:46:10 +0200
Message-Id: <20180529144612.16675-27-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144612.16675-1-mszeredi@redhat.com>
References: <20180529144612.16675-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vivek Goyal <vgoyal@redhat.com>

truncate should copy up full file (and not do metacopy only), otherwise it
will be broken.  For example, use truncate to increase size of a file so
that any read beyong existing size will return null bytes.  If we don't
copy up full file, then we end up opening lower file and read from it only
reads upto the old size (and not new size after truncate).  Hence to avoid
such situations, copy up data as well when file size changes.

So far it was being done by d_real(O_WRONLY) call in truncate() path.  Now
that patch has been reverted.  So force full copy up in ovl_setattr() if
size of file is changing.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ac1d2a581a6e..e31d64206a01 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -19,6 +19,7 @@
 int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	int err;
+	bool full_copy_up = false;
 	struct dentry *upperdentry;
 	const struct cred *old_cred;
 
@@ -36,9 +37,15 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		err = -ETXTBSY;
 		if (atomic_read(&realinode->i_writecount) < 0)
 			goto out_drop_write;
+
+		/* Truncate should trigger data copy up as well */
+		full_copy_up = true;
 	}
 
-	err = ovl_copy_up(dentry);
+	if (!full_copy_up)
+		err = ovl_copy_up(dentry);
+	else
+		err = ovl_copy_up_with_data(dentry);
 	if (!err) {
 		struct inode *winode = NULL;
 
-- 
2.14.3
