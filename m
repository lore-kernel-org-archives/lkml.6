Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E0DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5795206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQpoiPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5795206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeIDXAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:00:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40478 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:00:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so2108501pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7/Q/tCQaxlLXUL3Xmqx/qU3OL5OX2wiOS9IyzmP03tA=;
        b=jOQpoiPDG4SvQHXP8LLlZHZeGYRHGM2MsBuv0n0TCbER6H83Krkgwr8drpJZrEhc3b
         6Rx8tQXa5gfI140Cfiii4NXbRFiiBUTTJkd6MlIFntd0jGtF8djEkWBCAsYZKyWaj9++
         PKe4tSpmKGkhS8gk67g9IIwzNeBAmdOuQm5kx3IsWl/CCJz1Se/8y3NhA7X5cTjhNcee
         SG+xAB5yWqQ+8rrcS8TsTJ2VnN7nOFHd5VI6fJ8ZDMbgwQTU39IM6kdParpSeb5fbtMB
         viiLnjUXOTrf87GS4YEDL6x1OwImV0RxjdVj1nYy6n+LqQ0FjXofb7+fF/xIg2TLFTxi
         pGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7/Q/tCQaxlLXUL3Xmqx/qU3OL5OX2wiOS9IyzmP03tA=;
        b=ATywoL/2bWLlbUQLx7vx+YkP0N8ddb8jDrcne0FaDVq3EkSog57yJGq9/FDGt6mjun
         KxZW5ByoxkEKKFnKHda8eAuFtkIZhFBpYAAJBOtj1I3ggB/gdeiyRk19KYF0H7oNpyx3
         TPeqzP9UG6sDt1+vZ+9HIzfEItIbbc+irbA3KgUNvQFwLciNBRW6CmvzRul6k0BvTFUl
         NpH3eDvJg1i/teJZrWlMaFdtrhfhtI0C53VaF8lEJyh/KsP5+aZLHaQYvNV4QO955cz5
         GvMYVqd9x1EVGO31m9p7rwC+mEaE6rthDifs/rSWwMj6c0kTeDb+YZrq0EC90QrVL6W+
         XGZw==
X-Gm-Message-State: APzg51AvEP2NyjZTM5OygPwmarIouG9WNZCXAuQT+syJ+QhhyeD1G0eU
        vlqAjcfyMym8WGbWEUQ1HsY=
X-Google-Smtp-Source: ANB0Vdayyfl3UWUjB9FQOhU7rc2IOohhTAuqudybck0+I6u3MF1JCokc/aNMpqcDQnRrySaEg0xlAQ==
X-Received: by 2002:a65:6499:: with SMTP id e25-v6mr31199322pgv.224.1536086020768;
        Tue, 04 Sep 2018 11:33:40 -0700 (PDT)
Received: from localhost.localdomain (static-50-53-21-37.bvtn.or.frontiernet.net. [50.53.21.37])
        by smtp.gmail.com with ESMTPSA id l85-v6sm36666855pfk.34.2018.09.04.11.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 11:33:40 -0700 (PDT)
Subject: [PATCH 1/2] mm: Move page struct poisoning from CONFIG_DEBUG_VM to
 CONFIG_DEBUG_VM_PGFLAGS
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     alexander.h.duyck@intel.com, pavel.tatashin@microsoft.com,
        mhocko@suse.com, akpm@linux-foundation.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Date:   Tue, 04 Sep 2018 11:33:39 -0700
Message-ID: <20180904183339.4416.44582.stgit@localhost.localdomain>
In-Reply-To: <20180904181550.4416.50701.stgit@localhost.localdomain>
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@intel.com>

On systems with a large amount of memory it can take a significant amount
of time to initialize all of the page structs with the PAGE_POISON_PATTERN
value. I have seen it take over 2 minutes to initialize a system with
over 12GB of RAM.

In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
the boot time returned to something much more reasonable as the
arch_add_memory call completed in milliseconds versus seconds. However in
doing that I had to disable all of the other VM debugging on the system.

I did a bit of research and it seems like the only function that checks
for this poison value is the PagePoisoned function, and it is only called
in two spots. One is the PF_POISONED_CHECK macro that is only in use when
CONFIG_DEBUG_VM_PGFLAGS is defined, and the other is as a part of the
__dump_page function which is using the check to prevent a recursive
failure in the event of discovering a poisoned page.

With this being the case I am opting to move the poisoning of the page
structs from CONFIG_DEBUG_VM to CONFIG_DEBUG_VM_PGFLAGS so that we are
only performing the memset if it will be used to test for failures.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 mm/memblock.c |    2 +-
 mm/sparse.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 237944479d25..51e8ae927257 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1444,7 +1444,7 @@ void * __init memblock_virt_alloc_try_nid_raw(
 
 	ptr = memblock_virt_alloc_internal(size, align,
 					   min_addr, max_addr, nid);
-#ifdef CONFIG_DEBUG_VM
+#ifdef CONFIG_DEBUG_VM_PGFLAGS
 	if (ptr && size > 0)
 		memset(ptr, PAGE_POISON_PATTERN, size);
 #endif
diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07eea9a6e..0fd9ad5021b0 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -696,7 +696,7 @@ int __meminit sparse_add_one_section(struct pglist_data *pgdat,
 		goto out;
 	}
 
-#ifdef CONFIG_DEBUG_VM
+#ifdef CONFIG_DEBUG_VM_PGFLAGS
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.

