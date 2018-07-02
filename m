Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F2DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B33A25DD2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUfcYPbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B33A25DD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeGBPRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:17:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43557 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbeGBPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:17:50 -0400
Received: by mail-pl0-f67.google.com with SMTP id c41-v6so8101860plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I2fjCge1kd8TkhrfsWKn8s94/95REt1ZZ18xMh+xj8w=;
        b=nUfcYPbZUK0DAsJOBqgffKjDkT/Ugc4fej0bIVPll6HOCITCEflpStFxsvIm/bAD6P
         k9+JZhu2kAWfmfQJpf1S9+2pMzS3EVZZxqVujcSl2IKhb8E2SEywvISAYPTc98h6guK5
         m3p/HFyzQ4LIMOi+GBsjSonyUwnEPXUA1HmZ8acvYPHX+42Wd4H6AeJyhH5YGxPV7kkL
         maNVL7orxYBc2JplBhc4q1BEwzHpS4M52YTJoUMRHIU4C2RinZjQDIpXN2B/oqoiO0MV
         URsnJxsRObDUAgwsv1OGKGJ/yGskijlxeH92murtvrFyy8oBK9NezvUGjUqvhtvjq918
         zY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I2fjCge1kd8TkhrfsWKn8s94/95REt1ZZ18xMh+xj8w=;
        b=p3JAg4qaHkCc17KCtzZyPqF6QEa1RHyQ1urj/SJdSU/qyLiPFBkW12Koat+vNM+ZGn
         fN4s81rN/sm3uCMjxl+PE1ambdJRrQeXt9wJHeuWq/54PZRvuCPc8SfXqMLv2utjo/zr
         HNZSHme+kKL9cYfgjpBf+yWlfOw5iJIGSDVkm8K1uMbcJmIqlXcXeUZHtnFhLKq/6lvw
         Y1ErWCXprQ8GBMxDW2724SPIlScGvbBMVeBmBiWX2rkCiasaxh1BqS50gvr3icQ7nMdV
         UpkvvlzLxleXTQf8rcyeo0XtA/G2jUPf0C3pXIDB5nyGtpYB614f84bmnql6RjMK1tL+
         TbBw==
X-Gm-Message-State: APt69E04nxFGl1aSHHUjx3435ucOctsPCLfK+mqXHVTH1QReNRfZ6/5N
        qKI+v5bHDR4Oqaj62VFTGV8=
X-Google-Smtp-Source: ADUXVKI72gUhWOTLm5NrD4fn50g4r72JKWHlG00iIyF9PLjkcg9FWCXqAD054USTNmL7I6+p2YtEhw==
X-Received: by 2002:a17:902:345:: with SMTP id 63-v6mr26596137pld.328.1530544669700;
        Mon, 02 Jul 2018 08:17:49 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id c85-v6sm10130128pfd.110.2018.07.02.08.17.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 08:17:48 -0700 (PDT)
Date:   Mon, 2 Jul 2018 20:50:17 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] fs: afs: Adding new return type vm_fault_t
Message-ID: <20180702152017.GA3780@jordon-HP-15-Notebook-PC>
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
 fs/afs/internal.h | 3 ++-
 fs/afs/write.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f38d6a5..35e405c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -21,6 +21,7 @@
 #include <linux/fscache.h>
 #include <linux/backing-dev.h>
 #include <linux/uuid.h>
+#include <linux/mm_types.h>
 #include <net/net_namespace.h>
 #include <net/af_rxrpc.h>

@@ -949,7 +950,7 @@ extern int afs_write_end(struct file *file, struct address_space *mapping,
 extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
 extern int afs_flush(struct file *, fl_owner_t);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
-extern int afs_page_mkwrite(struct vm_fault *);
+extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
 extern int afs_launder_page(struct page *);

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 9370e2f..5c41274 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -751,7 +751,7 @@ int afs_flush(struct file *file, fl_owner_t id)
  * notification that a previously read-only page is about to become writable
  * - if it returns an error, the caller will deliver a bus error signal
  */
-int afs_page_mkwrite(struct vm_fault *vmf)
+vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
--
1.9.1

