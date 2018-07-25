Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BC8C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5611120852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ly9JcTaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5611120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeGZBOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:14:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36038 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeGZBNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so6317228pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oqP8n13yd1O4w8D2hrqTvkNxTGtNRWoLTcWbgV3cEAM=;
        b=ly9JcTajj7UB9jQWSaJE6M+IG6z8jZbvYHKMUovAl6kAjBlAj29xS6UBeWrYv99vTf
         DmroyeAJpx31HCOOPJsEPnrk/G24nwvh4v9RtN4/eQGIyxl50kbPO89W5bEbuNYhjtEa
         hY/DVVWc2O8j2rc+Z/aP3phWgrKve0UATmihj5YYoRUWh4URcdWEhlzXggOKDxg0UFXf
         TVHxPURJpsOS299oweYDnAM+SQ2chkV2dd3Yjh9O9fPI547hS9ogde2LZ1UwiJ44HEQg
         FLtp4ZrH7xYyMvMp9/9eSbhadMhB7k8IwTmUp2ITwxxYrUK6YwSK/+TwDn6Vqdj/MoeV
         bSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oqP8n13yd1O4w8D2hrqTvkNxTGtNRWoLTcWbgV3cEAM=;
        b=ejjt11vSPEXL7ol0RqdAvHCvOz7Ieh0o1usDUGi2PVJxbEnG/09JSZOcDADi4ylpBn
         xcrV1QiBPcms+SzjydFOcXOAr5ryj3N8NQcl3Z4kio+bcHS3s0WD3gAQbHewqcn7dilv
         An/Ep1Pd+7IgGlX0GAnKYgbH8CucHLfnNWDQirzj9IzQDrMN6cjroi9pSfhNZKCIuPnX
         eCqfHw6CJyHjswypyNhnwf/xWHkK5ZDJ4vbqxWvdrko+nrPUd1JF4Tz322jkN22cI+B3
         1CuIwL55OQR1K5NG3TfL7huhmrngt7JiKxIdrEKoj9xzBoYDst1IBnMJeOokPRQ6TwZ4
         HF7w==
X-Gm-Message-State: AOUpUlFhQfijK/oNjv7oiA7bLrMycLjUgqVlAACkQ37AXAb1zQrwZx/p
        uICxGUHK1j1M4DPl5Y+c6wy6BUnzMSE=
X-Google-Smtp-Source: AAOMgpcl/Pz6JS8SJDNPc4gi4YOKowmiwd1ciXjAtzWaBXKXil4E8XV68VUMLBwF+6rmug0eE+6BRg==
X-Received: by 2002:a62:843:: with SMTP id c64-v6mr24267445pfd.14.1532563173339;
        Wed, 25 Jul 2018 16:59:33 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:32 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 5/9] proc/kcore: hold lock during read
Date:   Wed, 25 Jul 2018 16:59:16 -0700
Message-Id: <d441d43131017081713f92e3b4dfce6b8f4d3b75.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
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
index 95aa988c5b5d..dc34642bbdb7 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -440,19 +440,18 @@ static ssize_t
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
@@ -465,28 +464,26 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
@@ -499,25 +496,29 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
@@ -525,26 +526,35 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
+	up_read(&kclist_lock);
+	if (ret)
+		return ret;
+	return orig_buflen - buflen;
 }
 
 
-- 
2.18.0

