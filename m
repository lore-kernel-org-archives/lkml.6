Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BBCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0098E223B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ZFCx5dfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0098E223B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934852AbeGFTdr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:33:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36371 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934749AbeGFTcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so9179679pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/c2cbz49BSin2oba/l/28h6YQKrdT8yfUVnQW4QRAUA=;
        b=ZFCx5dflIcjiWh8ILZc2CbItNn/eY42n2GzU+mVzo8ZHcIGqQuOaGuByWbRQOFy2rX
         8KExb8Di2as19gadUw0XL43sz72+lgRXrVCJXP5QqnY41Zr6jaWJL3/ykUAkUTMN7qdf
         Ym79DP//zBHEqlKCb2TD5m6uX6SvxrDuh6n/o3DLv4DopYeJ4O57HZimKck3s/LPeoR8
         oDLkVZHeIIqazOSrFgSuC15rrT+POXOkGgb8oMSkVoN5fJfw1+A74czXewFJq6MA7oLO
         w54EnBHOmBHrTCvQFxzNbQmsgZHofBeHyHIAZMij3/SzOzSWy+lTF4fYNvq1De090E0F
         qLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/c2cbz49BSin2oba/l/28h6YQKrdT8yfUVnQW4QRAUA=;
        b=ndts+agniGE/daQoBU5gDSfQuJ3NLoWkb9Z7L8P9Kaw1T581uDmJ4bUfsb6BYHYHgw
         dfuFriP6D1d6N5Du94pnDLQ2CvACpB6ebNR+iigIH/TJrWVEYvUbn3wpBu20wJwi1oBR
         P2do2f/DkT6C5bia3YspwTg6JPIKKUFFtaN+EFILpGwipVN2c2x6N/EwpngFa4Nq6DmJ
         Ey4VYXTG0mSA2fwsJXcDovwwb00rc/4R630DC4vDhDIaRm8BlIgz+xlxZEkAYBwysxbg
         gODPIGkqDjdOFHEtv+qns9WjfdMFD9Lv9zFO3OkpXK4p40JyVB3Zc/4gvnKJ8QOIa8GG
         RZRA==
X-Gm-Message-State: APt69E3+/wzqAlPJi015cY2kDtC+xm/4EH1T5NeKx9RzOWN9mNYY64vw
        w0w2H04EhxLUywyGxzcRJ2U+FAA56b4=
X-Google-Smtp-Source: AAOMgpdAz8ENon+vSyTUOXTZIePNg/k4zf/VIx7Ind7wFokMvFcJBPOBZaaj70SHgohF0ETuU3a7gA==
X-Received: by 2002:a62:9992:: with SMTP id t18-v6mr11809529pfk.239.1530905569241;
        Fri, 06 Jul 2018 12:32:49 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:48 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 4/7] proc/kcore: hold lock during read
Date:   Fri,  6 Jul 2018 12:32:35 -0700
Message-Id: <974fd58d9eb5eb536a2b6b5580137ee567864c32.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530904769.git.osandov@fb.com>
References: <cover.1530904769.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that we're using an rwsem, we can hold it during the entirety of
read_kcore() and have a common return path. This is preparation for the
next change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 70 ++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index f335400300d3..b7ff2e2ec350 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -438,19 +438,18 @@ static ssize_t
 read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 {
 	char *buf = file->private_data;
-	ssize_t acc = 0;
 	size_t size, tsz;
 	size_t elf_buflen;
 	int nphdr;
 	unsigned long start;
+	size_t orig_buflen = buflen;
+	int ret = 0;
 
 	down_read(&kclist_lock);
 	size = get_kcore_size(&nphdr, &elf_buflen);
 
-	if (buflen == 0 || *fpos >= size) {
-		up_read(&kclist_lock);
-		return 0;
-	}
+	if (buflen == 0 || *fpos >= size)
+		goto out;
 
 	/* trim buflen to not go beyond EOF */
 	if (buflen > size - *fpos)
@@ -463,28 +462,26 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		tsz = elf_buflen - *fpos;
 		if (buflen < tsz)
 			tsz = buflen;
-		elf_buf = kzalloc(elf_buflen, GFP_ATOMIC);
+		elf_buf = kzalloc(elf_buflen, GFP_KERNEL);
 		if (!elf_buf) {
-			up_read(&kclist_lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
 		elf_kcore_store_hdr(elf_buf, nphdr, elf_buflen);
-		up_read(&kclist_lock);
 		if (copy_to_user(buffer, elf_buf + *fpos, tsz)) {
 			kfree(elf_buf);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto out;
 		}
 		kfree(elf_buf);
 		buflen -= tsz;
 		*fpos += tsz;
 		buffer += tsz;
-		acc += tsz;
 
 		/* leave now if filled buffer already */
 		if (buflen == 0)
-			return acc;
-	} else
-		up_read(&kclist_lock);
+			goto out;
+	}
 
 	/*
 	 * Check to see if our file offset matches with any of
@@ -497,25 +494,29 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	while (buflen) {
 		struct kcore_list *m;
 
-		down_read(&kclist_lock);
 		list_for_each_entry(m, &kclist_head, list) {
 			if (start >= m->addr && start < (m->addr+m->size))
 				break;
 		}
-		up_read(&kclist_lock);
 
 		if (&m->list == &kclist_head) {
-			if (clear_user(buffer, tsz))
-				return -EFAULT;
+			if (clear_user(buffer, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		} else if (m->type == KCORE_VMALLOC) {
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
-			if (copy_to_user(buffer, buf, tsz))
-				return -EFAULT;
+			if (copy_to_user(buffer, buf, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		} else if (m->type == KCORE_USER) {
 			/* User page is handled prior to normal kernel page: */
-			if (copy_to_user(buffer, (char *)start, tsz))
-				return -EFAULT;
+			if (copy_to_user(buffer, (char *)start, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		} else {
 			if (kern_addr_valid(start)) {
 				/*
@@ -523,26 +524,35 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				 * hardened user copy kernel text checks.
 				 */
 				if (probe_kernel_read(buf, (void *) start, tsz)) {
-					if (clear_user(buffer, tsz))
-						return -EFAULT;
+					if (clear_user(buffer, tsz)) {
+						ret = -EFAULT;
+						goto out;
+					}
 				} else {
-					if (copy_to_user(buffer, buf, tsz))
-						return -EFAULT;
+					if (copy_to_user(buffer, buf, tsz)) {
+						ret = -EFAULT;
+						goto out;
+					}
 				}
 			} else {
-				if (clear_user(buffer, tsz))
-					return -EFAULT;
+				if (clear_user(buffer, tsz)) {
+					ret = -EFAULT;
+					goto out;
+				}
 			}
 		}
 		buflen -= tsz;
 		*fpos += tsz;
 		buffer += tsz;
-		acc += tsz;
 		start += tsz;
 		tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);
 	}
 
-	return acc;
+out:
+	up_write(&kclist_lock);
+	if (ret)
+		return ret;
+	return orig_buflen - buflen;
 }
 
 
-- 
2.18.0

