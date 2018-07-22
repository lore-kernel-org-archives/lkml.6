Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DFDC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2458520875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 12:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlKb5Ad2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2458520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeGVNK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 09:10:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37407 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeGVNK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 09:10:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so10245104pgq.4;
        Sun, 22 Jul 2018 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=YZnAq30hJS1BaVjvIrV5h8yjKTCgZSii9SPo3C4wSz8=;
        b=VlKb5Ad2a6g1ZAlFMrkGln4CjCwSmQkQyJxyRDRn4VvufvySviUmUXbz9IfyvP0Hxy
         guCayP6PMC75zcwBneq1MLoWQrNbJjEEN02Ewc262Iqpaj4eRT/yqGxIUXtqgD4Ynf/c
         SyhAtpUKYeKD29zOU7rESN8L9RRyBcshqlGB7Ab+jQjnA/seGB9TUedCZ594w9lvcGoC
         wkELsa1tjxiwFqADXXinpeP7P0PnpS2afYDB5sQOSkHdX31O1JzHLYX/KY4fmCV05QvH
         +qlYVbs9mJjmWARdsfQOAX6+7udnhFAhQx86oLxY8pfb+2FhuJ54E3MLAzoE9NchHdLq
         kwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=YZnAq30hJS1BaVjvIrV5h8yjKTCgZSii9SPo3C4wSz8=;
        b=q4Hgj7YkGvLgcEgWp2gpPx+q7nl9XxbpS2TUD4LljEtlmK1HCHMnscafutf5ycpXWw
         i0lm1rsRiFTrmeBJc+hMNVm3P17nxuVmrPo+M4MAAzpagHfAXlAVORdMVWWRS/yB3Xmf
         SGRrHBI3nHdcsvtAoWpuh120PjibKOcY8MrxXvbCN9gpn222rn5D7cMVsAqsKIabySTk
         tIQ8smL/SN1O6qXZLuKuPd5XygPtsPz8Rp0tpjHqg/+X6290SYKJjoRjISUZ5uGFSbqK
         5565gRm54nl2D1xLqj+vLsLhxDstmO0GS0jMZDNVGVSctXuvSGSKih3YDUh3+1zfBd4d
         ahLQ==
X-Gm-Message-State: AOUpUlFWN6PJw+Y2JNvmH5zmxv8yGc0JhATLaXmuxGR0vTW7LWkSRopb
        nz+4x1QxjdgfyjT6yoVeG0s=
X-Google-Smtp-Source: AAOMgpdLb+00f9Ke8xOhDyzg33MF1f6wcL0yCTmJjp+6esDGXwfsVE8QJ5TdO2/8kXeOaEFibKzujw==
X-Received: by 2002:a62:4ece:: with SMTP id c197-v6mr9309949pfb.240.1532261636468;
        Sun, 22 Jul 2018 05:13:56 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.185])
        by smtp.gmail.com with ESMTPSA id s66-v6sm5672798pfe.53.2018.07.22.05.13.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 05:13:55 -0700 (PDT)
Date:   Sun, 22 Jul 2018 17:46:36 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     willy@infradead.org, zyan@redhat.com, sage@redhat.com,
        idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ajitn.linux@gmail.com, brajeswar.linux@gmail.com,
        sabyasachi.linux@gmail.com
Subject: [PATCH] fs: ceph: Adding new return type vm_fault_t
Message-ID: <20180722121636.GA30907@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for page_mkwrite
and fault handler.

vmf_error() is the newly introduce inline function
in 4.17

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/ceph/addr.c | 62 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b4336b4..3031d44 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1427,7 +1427,7 @@ static void ceph_restore_sigs(sigset_t *oldset)
 /*
  * vm ops
  */
-static int ceph_filemap_fault(struct vm_fault *vmf)
+static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
@@ -1435,8 +1435,9 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	struct page *pinned_page = NULL;
 	loff_t off = vmf->pgoff << PAGE_SHIFT;
-	int want, got, ret;
+	int want, got, err;
 	sigset_t oldset;
+	vm_fault_t ret;
 
 	ceph_block_sigs(&oldset);
 
@@ -1448,8 +1449,8 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
 		want = CEPH_CAP_FILE_CACHE;
 
 	got = 0;
-	ret = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1, &got, &pinned_page);
-	if (ret < 0)
+	err = ceph_get_caps(ci, CEPH_CAP_FILE_RD, want, -1, &got, &pinned_page);
+	if (err < 0)
 		goto out_restore;
 
 	dout("filemap_fault %p %llu~%zd got cap refs on %s\n",
@@ -1461,16 +1462,17 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
 		ceph_add_rw_context(fi, &rw_ctx);
 		ret = filemap_fault(vmf);
 		ceph_del_rw_context(fi, &rw_ctx);
+		dout("filemap_fault %p %llu~%zd drop cap refs %s ret %x\n",
+			inode, off, (size_t)PAGE_SIZE,
+				ceph_cap_string(got), ret);
 	} else
-		ret = -EAGAIN;
+		err = -EAGAIN;
 
-	dout("filemap_fault %p %llu~%zd dropping cap refs on %s ret %d\n",
-	     inode, off, (size_t)PAGE_SIZE, ceph_cap_string(got), ret);
 	if (pinned_page)
 		put_page(pinned_page);
 	ceph_put_cap_refs(ci, got);
 
-	if (ret != -EAGAIN)
+	if (err != -EAGAIN)
 		goto out_restore;
 
 	/* read inline data */
@@ -1478,7 +1480,6 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
 		/* does not support inline data > PAGE_SIZE */
 		ret = VM_FAULT_SIGBUS;
 	} else {
-		int ret1;
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page = find_or_create_page(mapping, 0,
 						mapping_gfp_constraint(mapping,
@@ -1487,32 +1488,32 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		ret1 = __ceph_do_getattr(inode, page,
+		err = __ceph_do_getattr(inode, page,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
-		if (ret1 < 0 || off >= i_size_read(inode)) {
+		if (err < 0 || off >= i_size_read(inode)) {
 			unlock_page(page);
 			put_page(page);
-			if (ret1 < 0)
-				ret = ret1;
+			if (err == -ENOMEM)
+				ret = VM_FAULT_OOM;
 			else
 				ret = VM_FAULT_SIGBUS;
 			goto out_inline;
 		}
-		if (ret1 < PAGE_SIZE)
-			zero_user_segment(page, ret1, PAGE_SIZE);
+		if (err < PAGE_SIZE)
+			zero_user_segment(page, err, PAGE_SIZE);
 		else
 			flush_dcache_page(page);
 		SetPageUptodate(page);
 		vmf->page = page;
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
-		dout("filemap_fault %p %llu~%zd read inline data ret %d\n",
+		dout("filemap_fault %p %llu~%zd read inline data ret %x\n",
 		     inode, off, (size_t)PAGE_SIZE, ret);
 	}
 out_restore:
 	ceph_restore_sigs(&oldset);
-	if (ret < 0)
-		ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
+	if (err < 0)
+		ret = vmf_error(err);
 
 	return ret;
 }
@@ -1520,7 +1521,7 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
 /*
  * Reuse write_begin here for simplicity.
  */
-static int ceph_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
@@ -1531,8 +1532,9 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
 	loff_t off = page_offset(page);
 	loff_t size = i_size_read(inode);
 	size_t len;
-	int want, got, ret;
+	int want, got, err;
 	sigset_t oldset;
+	vm_fault_t ret;
 
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
@@ -1546,10 +1548,10 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
 			lock_page(page);
 			locked_page = page;
 		}
-		ret = ceph_uninline_data(vma->vm_file, locked_page);
+		err = ceph_uninline_data(vma->vm_file, locked_page);
 		if (locked_page)
 			unlock_page(locked_page);
-		if (ret < 0)
+		if (err < 0)
 			goto out_free;
 	}
 
@@ -1566,9 +1568,9 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
 		want = CEPH_CAP_FILE_BUFFER;
 
 	got = 0;
-	ret = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, off + len,
+	err = ceph_get_caps(ci, CEPH_CAP_FILE_WR, want, off + len,
 			    &got, NULL);
-	if (ret < 0)
+	if (err < 0)
 		goto out_free;
 
 	dout("page_mkwrite %p %llu~%zd got cap refs on %s\n",
@@ -1586,13 +1588,13 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
 			break;
 		}
 
-		ret = ceph_update_writeable_page(vma->vm_file, off, len, page);
-		if (ret >= 0) {
+		err = ceph_update_writeable_page(vma->vm_file, off, len, page);
+		if (err >= 0) {
 			/* success.  we'll keep the page locked. */
 			set_page_dirty(page);
 			ret = VM_FAULT_LOCKED;
 		}
-	} while (ret == -EAGAIN);
+	} while (err == -EAGAIN);
 
 	if (ret == VM_FAULT_LOCKED ||
 	    ci->i_inline_version != CEPH_INLINE_NONE) {
@@ -1606,14 +1608,14 @@ static int ceph_page_mkwrite(struct vm_fault *vmf)
 			__mark_inode_dirty(inode, dirty);
 	}
 
-	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %d\n",
+	dout("page_mkwrite %p %llu~%zd dropping cap refs on %s ret %x\n",
 	     inode, off, len, ceph_cap_string(got), ret);
 	ceph_put_cap_refs(ci, got);
 out_free:
 	ceph_restore_sigs(&oldset);
 	ceph_free_cap_flush(prealloc_cf);
-	if (ret < 0)
-		ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
+	if (err < 0)
+		ret = vmf_error(err);
 	return ret;
 }
 
-- 
1.9.1

