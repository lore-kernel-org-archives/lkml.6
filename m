Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36239C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A2421783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIQCqdVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfAJOzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:55:04 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39414 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfAJOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:55:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so5289801pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 06:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZROv1A/sYj6JvGQP/ciFLdFMP9ppu+olFL8waBnQ3zc=;
        b=HIQCqdVyCtyjgufumY5Uz2k819abJru0S0Di2EGblX3AM6oXJ+mpz9+XXpieDhfcEq
         5Yvr5jQQRGnjtMXpGqfmP/Ukowbom6oTvHXCAr6D48mVIdjbRleNbHZXnvIqncMBK5an
         P3GtJ5zgrU+eVpe0HSSoIbvchkfs6s58uIHoZbPaX9HxySrpypaNMDlbvWTNPkGiYyrv
         3X+9gqlEA7v/ULsR1RlBr2kX6loSeuOfV1pR6QSqA8opwVKzYOeDSUZjrz959RVmgwRc
         smGv/U7Ok2OP2BlNOVNPWYp8Xo47l4dfdTd314tMz5hDF9ZW/ye8CPSFb1y7YZmbfUCi
         H++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZROv1A/sYj6JvGQP/ciFLdFMP9ppu+olFL8waBnQ3zc=;
        b=Ag34Zsxsu/z0KmKAVJLVofBJyLGBvRk8+EEle/vq9pMEIueHStZKZW3BPhrgF6Egvv
         v2J4HrfIRWlRrEjO+YrNGVPCtZC0UG+XEym7TyjKtYdfsRxh7CA/dtzHy6gsDvMGLvui
         r005qyNZgoxrEv2hJckn1orClgToXWt8qUXcMO9KKcwvb+YnhVuSw3OEfvbBhKs0IoAt
         rp85jrCY4JcCuTPep+AvUQ0z+84LDl7VMCnSxrIBwuOfX7GA0MOdZjLYbM3Y9vb/kyys
         6r8nE1+hlzGnwV+r0ROoD6Spv0JfVL9heT61L9EgLXSZTihNRRQyYOOxNsVoggGVsCgq
         wEFQ==
X-Gm-Message-State: AJcUukegw4roK28fDF4/1HydZ0RYEIDx2rNcYtXGfH8VAstQVeaGC0wE
        YlvdJ9kUD53fvBEBJ/3dND3bncDl
X-Google-Smtp-Source: ALg8bN49kheJY6V/FPhhJqWB7DnOBR7JGlsMaZBaHvqYU5IKaVFbjrwGGW+4HNMkukHn1+4capKzng==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr10724890plb.241.1547132102317;
        Thu, 10 Jan 2019 06:55:02 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.54.206])
        by smtp.gmail.com with ESMTPSA id l85sm135461494pfg.161.2019.01.10.06.55.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 06:55:01 -0800 (PST)
Date:   Thu, 10 Jan 2019 20:29:00 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jglisse@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hmm: Convert to use vm_fault_t
Message-ID: <20190110145900.GA1317@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert to use vm_fault_t type as return type for
fault handler.

kbuild reported warning during testing of
*mm-create-the-new-vm_fault_t-type.patch* available in below link -
https://patchwork.kernel.org/patch/10752741/

[auto build test WARNING on linus/master]
[also build test WARNING on v5.0-rc1 next-20190109]
[if your patch is applied to the wrong git tree, please drop us a note
to help improve the system]

kernel/memremap.c:46:34: warning: incorrect type in return expression
                         (different base types)
kernel/memremap.c:46:34: expected restricted vm_fault_t
kernel/memremap.c:46:34: got int

This patch has fixed the warnings and also hmm_devmem_fault() is
converted to return vm_fault_t to avoid further warnings.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/hmm.h | 4 ++--
 mm/hmm.c            | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 66f9ebb..ad50b7b 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -468,7 +468,7 @@ struct hmm_devmem_ops {
 	 * Note that mmap semaphore is held in read mode at least when this
 	 * callback occurs, hence the vma is valid upon callback entry.
 	 */
-	int (*fault)(struct hmm_devmem *devmem,
+	vm_fault_t (*fault)(struct hmm_devmem *devmem,
 		     struct vm_area_struct *vma,
 		     unsigned long addr,
 		     const struct page *page,
@@ -511,7 +511,7 @@ struct hmm_devmem_ops {
  * chunk, as an optimization. It must, however, prioritize the faulting address
  * over all the others.
  */
-typedef int (*dev_page_fault_t)(struct vm_area_struct *vma,
+typedef vm_fault_t (*dev_page_fault_t)(struct vm_area_struct *vma,
 				unsigned long addr,
 				const struct page *page,
 				unsigned int flags,
diff --git a/mm/hmm.c b/mm/hmm.c
index a04e4b8..fe1cd87 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -990,7 +990,7 @@ static void hmm_devmem_ref_kill(struct percpu_ref *ref)
 	percpu_ref_kill(ref);
 }
 
-static int hmm_devmem_fault(struct vm_area_struct *vma,
+static vm_fault_t hmm_devmem_fault(struct vm_area_struct *vma,
 			    unsigned long addr,
 			    const struct page *page,
 			    unsigned int flags,
-- 
1.9.1

