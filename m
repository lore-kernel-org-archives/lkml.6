Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462D9242DF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWhUDse3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462D9242DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeGBPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:47:01 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46362 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeGBPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:47:00 -0400
Received: by mail-pg0-f65.google.com with SMTP id q14-v6so7309873pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gMGrlSOJKtf/iu/SMspe4Z54j0Y4xShrp4HSUz4Dod8=;
        b=NWhUDse3hQIb7bUOg1eZTvEu1iV6ge8fV24h91QWm6hA38ZUSDW+uvyVbhADfm3xOl
         D5eQWHHLYmgMWTcTLJoqDETYfxBU+DgOEQnBAChAUQDiKUvS6ui4uF8twuLBQsMgJQ9W
         tyD1/Aoa9vmsD9xcsxSFOtruAt4Nw29A9JOBppWJzDwcP8IBzp2Pe/cUszQC/xthNMQn
         LLhiZ6HTiQvtLQPODCzDC9qOfmVNndZHXUV0DPuJNM5d9mbpu49U6QKLdsULFZKs/m78
         r8yEDEhQ8F33is6PN74G+OlGCjOxLQGAF4VWCAhTbdUkAR/sNOgHYBmZPE5D7xzjIQum
         JH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gMGrlSOJKtf/iu/SMspe4Z54j0Y4xShrp4HSUz4Dod8=;
        b=OpAaj1bNCaOdrKIWHDlVMa8797LQikpI8rmExwIMrvpzQtYnUHCCKtHPSvng3XcS9l
         grh8wJi66ntj6lwXqlLw/0ub95+GB/7lNDYjFgozzBmh3lWfM/xFzs20hPADvkvJe8VR
         CSXdsw4v3EoDNB/PzC+a3x2q1EXS+NT9Nc5twzZtn+FSwPZ/JKU9OMnkSq+h65sMuUZv
         J+YhBWLdrRqQgWPpyV8Hcip/3JACNdFsVLHOJdVbEFEBL7Wcf8pSChN/5Ai4dp9DBgWF
         XCR1uMMP9eu57hEAgB9EOwAbc0YCnBBrkS5wkDdjB7Tm6gfsIA1u5CPV2BlO/zMx36ZB
         g7+w==
X-Gm-Message-State: APt69E1jCj7UZs5sHoL0IUnsHoysrs6bMntCE1AraD1Z1NAQU7GmcBUl
        ZBP9E9dWvF8omOIRmbnftU4=
X-Google-Smtp-Source: AAOMgpd3+FDasgXqUsWgr8WnXwO1Juwuy5N09s1jngZ5rI21RHc2Kg+MDvSooiW/C45pJGOsUxzjlA==
X-Received: by 2002:a62:ba13:: with SMTP id k19-v6mr25904538pff.245.1530546419697;
        Mon, 02 Jul 2018 08:46:59 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.216.114])
        by smtp.gmail.com with ESMTPSA id x90-v6sm56542680pfk.151.2018.07.02.08.46.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 08:46:58 -0700 (PDT)
Date:   Mon, 2 Jul 2018 21:19:28 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] fs: 9p: Adding new return type vm_fault_t
Message-ID: <20180702154928.GA3964@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for page_mkwrite
handler.

see commit 1c8f422059ae ("mm: change return type to
vm_fault_t") for reference.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/9p/vfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 03c9e32..5f2e48d 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -533,7 +533,7 @@ int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
 	return retval;
 }

-static int
+static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct v9fs_inode *v9inode;
--
1.9.1

