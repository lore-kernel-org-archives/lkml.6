Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA41C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08F524899
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQtc2ONF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08F524899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbeFVVGD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:06:03 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42107 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754435AbeFVVGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:06:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id w10-v6so7896258wrk.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Jsye4p+cOLXge3eoj+C91hZU95Kz3JDWe4e4VqwucQk=;
        b=nQtc2ONFvJsMYiFStX+sahhF4uktBpC5q+CtLx1mAQfRCUHObaxlQaCmj3ElXbKF14
         8DDJ+mHB9naBOJkz1DQTqkokGQpmTtbRvHGd0DNneuqCQL4gB3KjEnfovmxD3m0YD2i1
         iMCGhRlJqKJjTjmUeI1+breh6QNbIkRpl4MXj2usvVd2Q9loagFV0z6zT8ZN9XxjGpCs
         xFhhtePVqHZFraQXOB5muX/oB6pafHfE2hWp00f+w5fYFuK85rJTFUNGf3zyf1MPkTUJ
         BUalhx3Zuo9p/I4KiCPJcmmkP2Rb2lwdbLsKPjJcIoCezwhHBQi09GJoI9bG4glHOeQX
         QSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Jsye4p+cOLXge3eoj+C91hZU95Kz3JDWe4e4VqwucQk=;
        b=GPRuTv0rSp1pCDn2ai6OYYJzs1isV7xUp+shBHaNySQ3WjcZWcnkcu4X7MVkuX+dni
         YVrAnoiLnat06sn9Ga8H9GfQhAia8QRZ7rd/E9OIU/kk2VyntPItFpkUQHaugsScE+VZ
         tjhwJIj4L2jl7XjZqU7zi0DZIRR3QMK080y5zgHnuPf4vsk296kdFhedBFVsBt4Q09lc
         CnugOFK1OyMqyQ5cSmP9YxBCgI35KMPYvi6R3jE4I6P3CPPi+xS9vyUS113lvsKR+70U
         LvH4slFmZivpsz5+gdYKlId7kUTPMAU+zZPB39FiK0rxJwawtcWbmrolWOVH8AFAezVU
         ISeA==
X-Gm-Message-State: APt69E31ue+61KhcFSlRDlWXMozCkciRw9U7XVjy0+OEpoBIgiJdiiQ9
        INu4efpiP0pRKsef2TSLSKw=
X-Google-Smtp-Source: ADUXVKIj3YxORQf/AhhBmrsU/LsZCsXBxLy5Nu18ehLDbKKq/3EUDggGefebObAAY8/giijeXsrThw==
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr2804332wru.120.1529701560675;
        Fri, 22 Jun 2018 14:06:00 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id d90-v6sm3409287wmi.26.2018.06.22.14.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 14:05:59 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 0260D10C0452; Fri, 22 Jun 2018 23:05:58 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memblock: add missing include <linux/bootmem.h> and #ifdef
Date:   Fri, 22 Jun 2018 23:05:41 +0200
Message-Id: <20180622210542.2025-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
introduced two new function definitions:

  memblock_virt_alloc_try_nid_nopanic()
  memblock_virt_alloc_try_nid()

Commit ea1f5f3712af ("mm: define memblock_virt_alloc_try_nid_raw")
introduced the following function definition:

  memblock_virt_alloc_try_nid_raw()

This commit adds an include of header file <linux/bootmem.h> to provide
the missing function prototypes. Silence the following gcc warning
(W=1):

  mm/memblock.c:1334:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_raw' [-Wmissing-prototypes]
  mm/memblock.c:1371:15: warning: no previous prototype for `memblock_virt_alloc_try_nid_nopanic' [-Wmissing-prototypes]
  mm/memblock.c:1407:15: warning: no previous prototype for `memblock_virt_alloc_try_nid' [-Wmissing-prototypes]

As seen in commit 6cc22dc08a24 ("revert "mm/memblock: add missing include
<linux/bootmem.h>"") #ifdef blockers were missing which lead to compilation
failure on mips/ia64 where CONFIG_NO_BOOTMEM=n.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 4c98672bc3e2..f4b6766d7907 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -20,6 +20,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/bootmem.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -1226,6 +1227,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
 	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
 }
 
+#if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)
 /**
  * memblock_virt_alloc_internal - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
@@ -1433,6 +1435,7 @@ void * __init memblock_virt_alloc_try_nid(
 	      (u64)max_addr);
 	return NULL;
 }
+#endif
 
 /**
  * __memblock_free_early - free boot memory block
-- 
2.11.0

