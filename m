Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFBBC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E1F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iju0refZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E1F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeIKEPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:15:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeIKEPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Od9L2cxTtYHSCFmlhgdTQ9UdXTzSb7DfcWq2VqUGbRI=; b=Iju0refZvHClrWlYTO+2E87Nb
        SzHpVjLqfRu5XLunINFhaIAA7+oEzToFlIe2KNIdMU4IfJvQfe4ELQBUiN6hVaGW/r/9AfQcUol/e
        p+m/7gKauSLzyDzfZ4jpwiX7TkkiY0rqrFsiia5NmaWlLR6c6oRkwLbG4LzX5ZCLfllUcH22SzqXd
        wqkAZQ6xQhgjKunzPqR/QEF4kHYPZ1YZMG37w2m+LVysuJgUhuwmvq4jCC7bIQVnOlSJmiNgOoynM
        iHusQt8wJmMITVk7adklk951dN6lppNzx4a6zkrYhrqg1O2/T69d/d4A2IGkPRjr5o1b/cBv66CmP
        JN1a8NhrQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzVS8-0006pU-Fd; Mon, 10 Sep 2018 23:18:47 +0000
Subject: [PATCH] Generic radix tree: add kernel-doc chapter
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20180907165635.8469-1-kent.overstreet@gmail.com>
 <20180907165635.8469-5-kent.overstreet@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f02c9f2a-ca10-4485-e747-89d003a50ab2@infradead.org>
Date:   Mon, 10 Sep 2018 16:18:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180907165635.8469-5-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add a generic-radix-tree chapter to core-api kernel documentation.

Also fix a few kernel-doc warnings for misssing function (or macro)
parameters:

../include/linux/generic-radix-tree.h:93: warning: Function parameter or member '_radix' not described in 'genradix_free'
../include/linux/generic-radix-tree.h:161: warning: Function parameter or member '_idx' not described in 'genradix_iter_init'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/core-api/generic-radix-tree.rst |   13 +++++++++++++
 Documentation/core-api/index.rst              |    1 +
 include/linux/generic-radix-tree.h            |   12 ++++++++----
 3 files changed, 22 insertions(+), 4 deletions(-)

--- /dev/null
+++ linux-next-20180910/Documentation/core-api/generic-radix-tree.rst
@@ -0,0 +1,13 @@
+
+=================================
+Generic radix trees/sparse arrays
+=================================
+
+.. kernel-doc:: include/linux/generic-radix-tree.h
+   :doc: Generic radix trees/sparse arrays
+
+generic radix tree functions
+----------------------------
+
+.. kernel-doc:: include/linux/generic-radix-tree.h
+   :functions:
--- linux-next-20180910.orig/Documentation/core-api/index.rst
+++ linux-next-20180910/Documentation/core-api/index.rst
@@ -27,6 +27,7 @@ Core utilities
    errseq
    printk-formats
    circular-buffers
+   generic-radix-tree
    mm-api
    gfp_mask-from-fs-io
    timekeeping
--- linux-next-20180910.orig/include/linux/generic-radix-tree.h
+++ linux-next-20180910/include/linux/generic-radix-tree.h
@@ -1,16 +1,18 @@
 #ifndef _LINUX_GENERIC_RADIX_TREE_H
 #define _LINUX_GENERIC_RADIX_TREE_H
 
-/*
- * Generic radix trees/sparse arrays:
+/**
+ * DOC: Generic radix trees/sparse arrays
  *
  * Very simple and minimalistic, supporting arbitrary size entries up to
  * PAGE_SIZE.
  *
  * A genradix is defined with the type it will store, like so:
+ *
  * static GENRADIX(struct foo) foo_genradix;
  *
  * The main operations are:
+ *
  * - genradix_init(radix) - initialize an empty genradix
  *
  * - genradix_free(radix) - free all memory owned by the genradix and
@@ -86,6 +88,7 @@ void __genradix_free(struct __genradix *
 
 /**
  * genradix_free: free all memory owned by a genradix
+ * @_radix: the genradix to free
  *
  * After freeing, @_radix will be reinitialized and empty
  */
@@ -130,7 +133,8 @@ void *__genradix_ptr(struct __genradix *
 void *__genradix_ptr_alloc(struct __genradix *, size_t, gfp_t);
 
 /**
- * genradix_ptr - get a pointer to a genradix entry, allocating it if necessary
+ * genradix_ptr_alloc - get a pointer to a genradix entry, allocating it
+ *			if necessary
  * @_radix:	genradix to access
  * @_idx:	index to fetch
  * @_gfp:	gfp mask
@@ -151,7 +155,7 @@ struct genradix_iter {
 /**
  * genradix_iter_init - initialize a genradix_iter
  * @_radix:	genradix that will be iterated over
- * @_idx	index to start iterating from
+ * @_idx:	index to start iterating from
  */
 #define genradix_iter_init(_radix, _idx)			\
 	((struct genradix_iter) {				\


