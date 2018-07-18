Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B224ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D2B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="bJTzg4wN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D2B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeGRXj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34073 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbeGRXj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so2671823pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZjRvZxPQspBLpfeaPSiIUV9ZEirc8l71XrDkFv8j6M=;
        b=bJTzg4wNOorGyL7+qi9C5rAmoFuUTvCyWVvOEm2x4lgXNH/XtGZ8UNyPyVrAPkIOJN
         nBZ/JH5SRJp3F/4acrWKWr6YphpXHHBP54dxjc8CXfkX/nRXxHW+/i4UqpM4BXIU80Rz
         gyONi92GoFaRVWIEofvbegEVRApOdX87xxAmiOhXOjT4xItWoiTmUUv77+VBN9aaO3um
         hL3AgddScjj6kUCLqw6192mxdoj1o9qxlG9xB/64+QUCvNDbPJPE7/+NqZeHYhcADpNz
         wFzY/Mit/dKnUXYc7C4pyEhcZSKodt9GDSGGaUNX180jGeKPuzuqCAJgL+x3W3w56Dea
         ZVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZjRvZxPQspBLpfeaPSiIUV9ZEirc8l71XrDkFv8j6M=;
        b=rMJB4Hv0kUC2WgXv/Z+KLfc9m96y4BIgyI9GsYVS4/w+gMIGbf/qCeGBrYEDprPu/s
         itUi2gqv5H8Un1DTCeYvlTYrYPBo3D7Y1joSfzttEpL59HcJq0ZegYhK/9fXBC1xarDX
         kxoPay6Eg6Oi/TGZCMQxrUJ6pQ3+OW9+AjQAeaOOjNd1Zfabe6Guhfp/Q4oyMebTgRCp
         kRqetRmv0w1Szw+8Npop1FEj7XHAI3ZTEfYw6r/G/nkCADS9L29fnOet9qPn+kENBS3h
         CRSOKuPxjayPmJpW4lqjraequ6+ByOpui02zqxBJYuOs75lS7Idw3TrEHVEr15ol+DOS
         JPmg==
X-Gm-Message-State: AOUpUlFCpVAdjG6IhpLz3LOW4N2iwiMBSQvsEf4ngqu99tnhFVcW6X7S
        Ezddqvk7ZTl8tcxnYwIJJs7aC8LhPMw=
X-Google-Smtp-Source: AAOMgpcL1W+nYEj7ocz6OxSpwIqk8lcHy1VgSscDKHNTa60kSyvf/Hah6JUXCbrL7s17HyrcdA8tYw==
X-Received: by 2002:a63:ff21:: with SMTP id k33-v6mr7381054pgi.38.1531954758650;
        Wed, 18 Jul 2018 15:59:18 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:18 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 5/8] proc/kcore: hold lock during read
Date:   Wed, 18 Jul 2018 15:58:45 -0700
Message-Id: <d7cfbc1e8a76616f3b699eaff9df0a2730380534.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531953780.git.osandov@fb.com>
References: <cover.1531953780.git.osandov@fb.com>
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
index 95aa988c5b5d..e317ac890871 100644
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
+	up_write(&kclist_lock);
+	if (ret)
+		return ret;
+	return orig_buflen - buflen;
 }
 
 
-- 
2.18.0

