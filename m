Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D498C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366E626922
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEqkdCGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366E626922
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeFZSo2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:44:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40410 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933035AbeFZSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:44:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so2893100wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mxDZ5EsF36afvprEdl/PqYlPAvCFKZnI5JqKnM505dI=;
        b=hEqkdCGwq2DvRkT7ToTtsZfnoJJSX0Q0cNwlnuTf/HjVPVaBJ1PPwzsGyAAvQXT8BO
         oN/fiRsTs9Pd5JdhY5dXaPTcqnif2GoVrvYFlZrIkejyOrrxMnTN8EpzliEUY2AjB3YN
         AVOFhyYUJ8umiy7i81UR9CKaXd/aaPYtWe3GpYKjqfbkrLWAzsSnXLaGI2ug+ExnA9lM
         I5thbsTNEa8ioIkB3O5fd8Ib9l9fcer3/MLmS/FMoQjyOgWGbML4RaipKLJzDZIOXX3W
         rJ80nYjnlpnFAjcu2DVV5svV3NT7ENtmPXMMr0jClf9B4vhzOxO7iDFM6mir8Ye65CQT
         S9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mxDZ5EsF36afvprEdl/PqYlPAvCFKZnI5JqKnM505dI=;
        b=cKXhlMukjjnNPVa+7XyLMbyshlqew3DU2bUJxu4PmWhFDG7JbfZ51IPXCDCAK8ehz4
         XRzqcMspZe14Cdp54s+grus8VkJZcCSplT1/sfk5Rob2yDt1iphuSQRo/fu6qoYgzPyZ
         QvaQUuelXeEou41T6yMBITJIHo0yROJnP31yq1b1K/2zH4/xjQuVQmc5ghcidaLcxvPz
         ihpJRiwT8kSUuooCtPXyzBAul+jst0oSXmzDieh6PAQxviogaVaw37XaH0mYFNFdLzI4
         WApEP/awifFUEN7NL/GzySzHF1ne5xtrtmLUzOvo0gE8C8pO/iT5km51+ANheGJMdOC6
         ns6w==
X-Gm-Message-State: APt69E3CBMhJT4OPupvmUcvaizTmyE1AIXgJ7Djlg/pLmjiO+o0AiFUs
        0R0sIHFGgf/TQLvsbBj2gaE=
X-Google-Smtp-Source: AAOMgpdGIHwUc8W3uB3zO8zJPm0BoaA3srdTzUWT7pjd8qj4adufAOiRbbRShR9ENuqCNUdKCYr13Q==
X-Received: by 2002:a1c:a345:: with SMTP id m66-v6mr431207wme.68.1530038665705;
        Tue, 26 Jun 2018 11:44:25 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id o129-v6sm2947374wmo.35.2018.06.26.11.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 11:44:24 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CB33D10C0487; Tue, 26 Jun 2018 20:44:23 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Stefan Agner <stefan@agner.ch>, Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/memblock: add missing include <linux/bootmem.h>
Date:   Tue, 26 Jun 2018 20:44:20 +0200
Message-Id: <20180626184422.24974-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171513.31845-1-malat@debian.org>
References: <20180625171513.31845-1-malat@debian.org>
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

Also adds #ifdef blockers to prevent compilation failure on mips/ia64 where
CONFIG_NO_BOOTMEM=n as could be seen in commit commit 6cc22dc08a24 ("revert
"mm/memblock: add missing include <linux/bootmem.h>"").

Because Makefile already does:

  obj-$(CONFIG_HAVE_MEMBLOCK) += memblock.o

The #ifdef has been simplified from:

  #if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)

to simply:

  #if defined(CONFIG_NO_BOOTMEM)

Suggested-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Michal Hocko <mhocko@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: Add missing reference to commit 6cc22dc08a24
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

