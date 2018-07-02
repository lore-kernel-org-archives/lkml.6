Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51179C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0C8208B3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxVqWjOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0C8208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeGBPa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:30:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38196 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGBPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:30:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so7680991pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SOeaUhNubE0TGKpHw3MK/vaDFDR+omLetn32skLI30M=;
        b=NxVqWjODTcMumt0a4px0T0bDtFeVAIk+KasIOqtwd7oIHsHylTRJP0Rz47H/iTicwF
         3AZ4ykaG/lycX1/LYYB8Y1aiCniOm61AKQWSvYYTdzhWfTqrBOxqfm0OYZMZcU0PHADf
         /VuAPKXXz1wXvnzR4V4D0jAbSawS8va1sy+ivqGK4Vyl1YRJKyh/PWvavyLBZI+9ks6k
         prIsXz1NsjmRf3JpWYkDwo5QXotqtGbEcDzCS5feTVn/Et2tlTeaqP1eqvIJxKcvqgZi
         GNL+RBHcnF/uZY9i89pAyCn2oB3RLjcGPhF4XLu/2pxhDjZ9N5AIspWfrTv/XwkEui0Z
         78xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SOeaUhNubE0TGKpHw3MK/vaDFDR+omLetn32skLI30M=;
        b=EbeaAEH2JyZgPQWtGaCsSZyzvVjY2zMb5Eqgw89gmMTp1Z/mVaDCObLeE/OOakvInp
         2+BiIzf949EkH83xFbKY7h/k4V3eQR2FlLKB7IHQZR4svKudLeRFNaTybf4+cZSmlWJ5
         H4wsPklzyrQFmaPA17406B19ECFl5dZ68JcagMFuMtt9CsgrQWsBi7vrHg7M2SOz7UN3
         DbsQyGS73NEuVkysCjdk/d6UC00XDtZ9+0Yfwu/T6sN9Tf6LoOEN44ntEtU6aabeGHnb
         OH60jW0H38hYCvqKvuF8g+CU5vvtTvgRzKmARS09KXkDW55+Y6/cVtMWA4DCOpwF6nHX
         xIYQ==
X-Gm-Message-State: APt69E16JTwYK5C4Z34ppKU5TwJ8JvSFAp9uiHDyO5sXeQEyO4go22Bs
        AFKzptlJ0iwGuKYCgfZkvzmYEA==
X-Google-Smtp-Source: AAOMgpeMMm/bKU3wyoRvbcMa3FKTSNPwt2ITOBYsjys13XENPg9f9Ow8qnsWbcOcqHpD3IDXuUFiPw==
X-Received: by 2002:a63:9902:: with SMTP id d2-v6mr14030909pge.343.1530545456314;
        Mon, 02 Jul 2018 08:30:56 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id a8-v6sm32879452pfe.72.2018.07.02.08.30.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 08:30:54 -0700 (PDT)
Date:   Mon, 2 Jul 2018 21:03:25 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     ganeshgr@chelsio.com, rahul.lakkireddy@chelsio.com,
        davem@davemloft.net, adobriyan@gmail.com, willy@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: proc: Adding new typedef vm_fault_t
Message-ID: <20180702153325.GA3875@jordon-HP-15-Notebook-PC>
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
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index a45f0af..7243e94 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -265,7 +265,7 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
  * On s390 the fault handler is used for memory regions that can't be mapped
  * directly with remap_pfn_range().
  */
-static int mmap_vmcore_fault(struct vm_fault *vmf)
+static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 {
 #ifdef CONFIG_S390
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-- 
1.9.1

