Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77530C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F99204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNI4pbeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F99204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeGBPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:24:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34413 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeGBPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:24:41 -0400
Received: by mail-pg0-f68.google.com with SMTP id y5-v6so1017220pgv.1;
        Mon, 02 Jul 2018 08:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uCBRb6bVQV0F1DGKZ+TVH7YiB2iTGBJhK5QIlrZfdUg=;
        b=gNI4pbeXh+uwKOJXjufqjAnn/tssmPTToDbdcJA6HfeI2Qjw0NReUq2S7br9HYPnQU
         zDjkgCjvzfL+JeCLtFrt+1wy5FM3n8a5B4wc6kediBnmLcLpuq4ZPbjvD1MGFmqV8fOG
         GgSB2XC8Fbj7mdgpQNc/gbhTemzdRgOu1b5/cSpZwb24zNF7EOn4XMav+oODYqJ0ST5g
         ZSyJ/PTeNX3Z+l1xkYfBvdSkNY3ODUTqGYNi0drJoEDpcQvGnButTy9YdUqcDrGYEnYO
         9uLhMtZR1mkzmPcfMcXdFVq1DkwkH8X1r2x6lUnYPatxEpxQNuX8eEnJmQQZOc+0ipVS
         U9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uCBRb6bVQV0F1DGKZ+TVH7YiB2iTGBJhK5QIlrZfdUg=;
        b=Lxuye9AbfJqubu+kZ7R71J1j0Q9l1tmnvX0iETnieA1alvl4HGcFM8R9AMnoo97d/5
         7FVY8YRDN+wlwkNtZehimQYxqHLrmf1vGpy6joi2Wq+gjKj38wFD1w5IGyWJzzG4Cp5Z
         tUq/1sk6SUnhfQuxYOODIywbB2fiZ57f+QQQdvP9xpaEkf9tM0CHQXz/zHNiW87EayWV
         rnZM72Y7fIzW1zRYgOIjdemUNONckCwgkfDfG8NCAjI7xGGMLmDFSNqwm5Wd2Hq+yujR
         bhJoepB3+0tRmN5yBFaPYAihiZpPnRcKGUOdXn9L7n9Jd2i2a7dSmzL/vOTpLwhNnXmb
         Q5FQ==
X-Gm-Message-State: APt69E1q5/KsnTxS9dyQISJP44yK/Vh6yZEMmEh+7Zb3/wJcxm8HrvhI
        JDd5xmdrZQ9VpMwADJ5Ym5k=
X-Google-Smtp-Source: ADUXVKI/5cpQk7rOEGffwv7o8jFvIcGRkdGyexVT2yqmrrp6NPb09fna/xP4VYVrlxaC0hFl47YCiA==
X-Received: by 2002:a65:4005:: with SMTP id f5-v6mr21244590pgp.302.1530545080495;
        Mon, 02 Jul 2018 08:24:40 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id b67-v6sm10153684pfd.74.2018.07.02.08.24.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 08:24:39 -0700 (PDT)
Date:   Mon, 2 Jul 2018 20:57:09 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] fs: nfs: Adding new return type vm_fault_t
Message-ID: <20180702152709.GA3837@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a 
VM_FAULT value rather than an errno.  Once all
instances are converted, vm_fault_t will become
a distinct type.

see commit 1c8f422059ae ("mm: change return type to
vm_fault_t") for reference.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/nfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 81cca49..29553fd 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -532,13 +532,13 @@ static void nfs_swap_deactivate(struct file *file)
  * writable, implying that someone is about to modify the page through a
  * shared-writable mapping
  */
-static int nfs_vm_page_mkwrite(struct vm_fault *vmf)
+static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct file *filp = vmf->vma->vm_file;
 	struct inode *inode = file_inode(filp);
 	unsigned pagelen;
-	int ret = VM_FAULT_NOPAGE;
+	vm_fault_t ret = VM_FAULT_NOPAGE;
 	struct address_space *mapping;

 	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
--
1.9.1

