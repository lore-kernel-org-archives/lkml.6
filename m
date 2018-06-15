Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85A8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F005208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F005208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756802AbeFOXcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:32:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:51450 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbeFOXcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:32:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 16:32:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="237595201"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2018 16:32:40 -0700
Date:   Fri, 15 Jun 2018 16:32:40 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memblock: add missing include <linux/bootmem.h>
Message-ID: <20180615233236.GA17678@agluck-desk>
References: <20180606194144.16990-1-malat@debian.org>
 <CA+8MBbKj4A5kh=hE0vcadzD+=cEAFY7OCWFCzvubu6cWULCJ0A@mail.gmail.com>
 <20180615121716.37fb93385825b0b2f59240cc@linux-foundation.org>
 <CA+8MBbJyXC7YmnjG-k+mahC0ZiSgZy=EoiO0N5gvw8S4afLqng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+8MBbJyXC7YmnjG-k+mahC0ZiSgZy=EoiO0N5gvw8S4afLqng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This both compiles and boots on ia64.

Builds OK on x86_64 with an Enterprise OS .config that includes:
CONFIG_HAVE_MEMBLOCK=y
CONFIG_NO_BOOTMEM=y

-Tony

----

diff --git a/mm/memblock.c b/mm/memblock.c
index cc16d70b8333..0a54d488f767 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1225,6 +1225,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
 	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
 }
 
+#if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
 /**
  * memblock_virt_alloc_internal - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
@@ -1432,6 +1433,7 @@ void * __init memblock_virt_alloc_try_nid(
 	      (u64)max_addr);
 	return NULL;
 }
+#endif
 
 /**
  * __memblock_free_early - free boot memory block
