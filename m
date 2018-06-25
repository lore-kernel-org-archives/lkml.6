Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A415BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406B025EE3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kET9he7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406B025EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934495AbeFYRP0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:15:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50776 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933724AbeFYRPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:15:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so10125602wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxP2DHPoQcAC9ByHdNoaj6eoO27/6dRlpCnrsVK4IE4=;
        b=kET9he7FsGyudj3ux8mPQvheEJic6xNMo1WIhZ+A9IgJ+jfYjmzNVhQWvU8QEm0eKi
         su/kxt1QAERJt6bFqfX4XYX7v8wZKST0yKX6vGJSXw0RuiqZ8bMhb0eL2FOm8WUDN7OZ
         k33gs3+DN4dn0BCR69zAEonjWPeyHXWMFS5V9m7o2GndmqUBldhT6+b0N/+bYnhQ9rwf
         q00tLnHuIgACShUmeepUbZP379ClrNWR574vDwOwvH75duBy/BfI9SuOA9ce/OLmRln6
         0uiBjuIAjxW9MCv5An+Rsgot8vmB9udXBOkqd7t9/5JPC95KQ/8ktBwYiVDMXDSJ0x1R
         GGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=gxP2DHPoQcAC9ByHdNoaj6eoO27/6dRlpCnrsVK4IE4=;
        b=pDywePkLrZqowiJ7JdS7/+2qkscvZq4rQ3wK0lIfYBd6FO68zohVVX0RSnh+nruwaC
         qjKO1ijXtsVJGBm+8vn2OxrW6CH4Dye+BWNm/T4hLeAimxZtJBbPkYywo3l0bOS/UGJZ
         C277/zcmHgBck9jvbZqWVgwZ8gTEpCmMNwtXYnsuScgkgG6deGBU/o1SmhShN+GZ3bao
         9YBcKr/jyMFMfI8pWDqf9RzOjKcE9UYp6blQ9L7Tomhkr25SvSZShQuNOgq9EB+Y7agj
         BF03eNg9tUFm9CwBzmDEXap2gFjoHPSlSiq63gQZlXVb1Ykn0Jb7w1fWOTvvKxkEpHnV
         uCBA==
X-Gm-Message-State: APt69E1mx+1RIUHGmVtWXcZppzjPt1XD0PotJb5aRArsMXSxfVsKqH0t
        5V1gldRRTTK38Khz/w+Ni+4=
X-Google-Smtp-Source: AAOMgpc93ocktWmRXLQyga/vG4OcgrN2hnBlyPq09+bIC05tlJEe+0EsZG92aqAOcXNCrbcimseGkw==
X-Received: by 2002:a1c:dac2:: with SMTP id r185-v6mr1634074wmg.31.1529946923642;
        Mon, 25 Jun 2018 10:15:23 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id u204-v6sm5474958wmd.7.2018.06.25.10.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:15:22 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id B7F9D10C03DD; Mon, 25 Jun 2018 19:15:21 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/memblock: add missing include <linux/bootmem.h>
Date:   Mon, 25 Jun 2018 19:15:12 +0200
Message-Id: <20180625171513.31845-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180622210542.2025-1-malat@debian.org>
References: <20180622210542.2025-1-malat@debian.org>
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

It also adds #ifdef blockers to prevent compilation failure on mips/ia64
where CONFIG_NO_BOOTMEM=n. Because Makefile already does:

  obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o

The #ifdef has been simplified from:

  #if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)

to simply:

  #if defined(CONFIG_NO_BOOTMEM)

Suggested-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Simplify #ifdef

 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 03d48d8835ba..611a970ac902 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -20,6 +20,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/bootmem.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
@@ -1224,6 +1225,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
 	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
 }
 
+#if defined(CONFIG_NO_BOOTMEM)
 /**
  * memblock_virt_alloc_internal - allocate boot memory block
  * @size: size of memory block to be allocated in bytes
@@ -1431,6 +1433,7 @@ void * __init memblock_virt_alloc_try_nid(
 	      (u64)max_addr);
 	return NULL;
 }
+#endif
 
 /**
  * __memblock_free_early - free boot memory block
-- 
2.11.0

