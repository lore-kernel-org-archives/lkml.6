Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43871C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD1820779
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="E+IkZtxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD1820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeI0DYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:24:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40722 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI0DYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:24:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id e9-v6so486016qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=uNw1SEfuNh5muyIlKMjO8zXN2XjQ0Df1a1ZQWi9S3hE=;
        b=E+IkZtxWnldcnfnVAFchZ1hWE504qBGKdX2eijVXxr7G+Yns/Lw/m0dK3zwPRS5BR7
         NPhHdsbYsqv7Rk+GL8cmQXek2L9S55HKsJVPA0JzSGx8F5+cBMI0QQ9EHQtfNLwA7i4t
         sC3pLwKemV+y20kKGmmL7K6hBp6n0IfS+xlPMNJ1jxbDFLwniUzBbzgyaLZ1K5mkWh7P
         eg9pTRdVcxR0Iz8T8p0VWPa/8okeH8kK+cdMZva7oNTlzpExw4ukGzcJj8CVcUfue3GZ
         UYlI0UuSGIZmFrnbVaBQ6nzmTHAXCMDv3kggv8aYdCPINTF/+3uSSqUkA/HIfFou9+kA
         XliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=uNw1SEfuNh5muyIlKMjO8zXN2XjQ0Df1a1ZQWi9S3hE=;
        b=JMuPvcsKblcMYznAD2QWniIHHS3IN+RE0IxMMhEzVh6tk3zGvMBe/SyZnYOTLMHCQZ
         dJvU1w3AEJ7f2OTVBYmp7kkMnB5Ec9wcXwUbKP5gLFpcIej3Q7rPWZbycS/nbQxPzYoK
         gnx3BZ3TieuV1MBAtM6x3uzM2HPL9i2/HA3Jm39MpPwe/uW3loSNtP4dbIzrL5a0Tzpy
         HhJyzXGPgNT7fPNjWl8F5B9g41FXQtjjTPAPKKDy8hnaA5pQXO3taYQogzqHebcJtgrg
         3skJ6mVm4Xf+890ovkxJ3s4UvSkWGz15e0cRKuiDwByvy8rxCN1eNe/d3MQ8ugOhSPMJ
         K/gQ==
X-Gm-Message-State: ABuFfohh86sBJN6cvMdfz2rTMV33vFHo2gCg+mreDsc3R6SjMbS1fmIC
        q0l+T+AZ9qC2j+AVJYMUfwPyfg==
X-Google-Smtp-Source: ACcGV62nU0p/SpQCuwEhccw6FtSj8cKf4zvclsHPNrLrKJb3VdwuIBbYKgcnnrv2S2qANr8nkWYi+g==
X-Received: by 2002:ac8:39a1:: with SMTP id v30-v6mr5494082qte.58.1537996153608;
        Wed, 26 Sep 2018 14:09:13 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r9-v6sm37064qta.87.2018.09.26.14.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:09:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, riel@redhat.com, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] mm: allow ->page_mkwrite to do retries
Date:   Wed, 26 Sep 2018 17:08:55 -0400
Message-Id: <20180926210856.7895-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180926210856.7895-1-josef@toxicpanda.com>
References: <20180926210856.7895-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we didn't set the retry flag on our vm_fault.  We want to allow
file systems to drop the mmap_sem if they so choose, so set this flag
and deal with VM_FAULT_RETRY appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mm/memory.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6f8abde84986..821435855177 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2384,11 +2384,13 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
 	unsigned int old_flags = vmf->flags;
 
 	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
+	vmf->flags |= old_flags & FAULT_FLAG_ALLOW_RETRY;
 
 	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
 	/* Restore original flags so that caller is not surprised */
 	vmf->flags = old_flags;
-	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
+	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
+			    VM_FAULT_RETRY)))
 		return ret;
 	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
 		lock_page(page);
@@ -2683,7 +2685,8 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp || (tmp &
-				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
+				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
+				       VM_FAULT_RETRY)))) {
 			put_page(vmf->page);
 			return tmp;
 		}
@@ -3716,7 +3719,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
 		unlock_page(vmf->page);
 		tmp = do_page_mkwrite(vmf);
 		if (unlikely(!tmp ||
-				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
+				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
+					VM_FAULT_RETRY)))) {
 			put_page(vmf->page);
 			return tmp;
 		}
-- 
2.14.3

