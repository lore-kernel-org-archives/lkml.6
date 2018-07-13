Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91817ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CA72147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="j1zJOCPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CA72147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbeGMAWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:22:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35227 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387792AbeGMAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:21:48 -0400
Received: by mail-pl0-f65.google.com with SMTP id k1-v6so11357493plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=002zvLp0GE64hLrexFk+R4hBFgfxdKVoabfUzR+Vo8Q=;
        b=j1zJOCPPt1IADlHyGEMJA+5iVYJ8Itp7UkQ8IP4JDiQEC9D1+fZyyCuQ/fwJuYgRTK
         f8PgOMS3NBp7NMjKKn7Ag4Z9T3PjvGk5My8IxFv5LRlm/I+yAiiZvMbpyyak05J7aUcR
         tJTA9fAAbIEsWHU1pwhF60to+RVn6xghsMeObvqQP/qu3oB8h3q0d1RIiqIWwGIX7iJj
         e0wfg8ZpdrfAJpj5wO1RSpoecpJcKZ+nFhHHpFs+1xBBEanvXM541puJBQa+lBvvqgXu
         BSrphVkFJsrCQReNWUdyi7x2MwYZY4ek2KmygVSH6m25Q8dhIe1VNhJs/kanwmxmokC2
         m79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=002zvLp0GE64hLrexFk+R4hBFgfxdKVoabfUzR+Vo8Q=;
        b=sniuTU2MZxmHa/OTyg9MGH4bwZE74P4X+les7knUavJN1Id3TmJt0FMeS/nKW7+Ovp
         hcndNyRJ8Z5Aaduc3ONbvQWgUL8orYovGzrc4ZDKc2GZJZi3K4qMIciNFquYHpsL9j5F
         FYEfb/R24UDjxEeGJqF9MiQtcGYPEfhjKw+ZOFI8km7JJ0lsF8dGZCeAJXzZcOcNUdGp
         u1JJ7mY+ShL1NW1NqdfVsjyLymJbe4cvOXqZYh7LU957v1gsgTiSrCMyLuZaQt7CIUds
         b1bTxB1l26A91auIO1I20GORG2aupuQOgSndviJIFLoWP1u+xtyxfmJpgBjWR88E20CW
         39tA==
X-Gm-Message-State: AOUpUlERZsbRi2p3OTpBbtzNOGsrKQsbCe/ccYVCnZ3JxvjN1ndAeYSR
        +LvPKCSdQDvCJGYe4soRNjFW6hW6ibA=
X-Google-Smtp-Source: AAOMgpcWFmd0zMso3aGTtx3cwdwYyWA3MlgZY68JoepqAXw9KcJRdveyysvxb1lMQgsZ34JSVw9/OQ==
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr4081820plo.117.1531440590147;
        Thu, 12 Jul 2018 17:09:50 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:74a0])
        by smtp.gmail.com with ESMTPSA id b86-v6sm4452067pfj.35.2018.07.12.17.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:09:49 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v2 4/7] proc/kcore: hold lock during read
Date:   Thu, 12 Jul 2018 17:09:36 -0700
Message-Id: <e610dcf31e4dec99c43e8f4353cf6f448c4d4782.1531440458.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1531440458.git.osandov@fb.com>
References: <cover.1531440458.git.osandov@fb.com>
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
index 33667db6e370..f1ae848c7bcc 100644
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

