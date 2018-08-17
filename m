Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F191C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCE9218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCE9218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeHQMDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:03:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52224 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeHQMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:02:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so6853810wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=upiL4gOH82Gjjlk/+gr255iw16SUVePVGsiKWqYTAYM=;
        b=C9hkLcbzymB4bVQwcxpzWL2Z86BdIwQJhVm5Rl8GHkI1GJUiAS6xrB5x6o03UuGIjk
         ze3LV2z9U1K9kLmDOGeJVKh0Xikxd5iRvtEBg33jJsNag0HxQ8c4O5EJ7dzONDVPIJcX
         wuqoHViWpuzUw1o50NW7TsvsNq62EA+RpBLlsfx4kqiQBj8elfZAAEBUFetS+tRbK7X8
         A51AFfNGdmbRV5jIbVGmZ8dhp2o2gLwIlzG6DU30EytPLBeT8r5lp6YXlEzD+rUm2S7+
         iDghJt1oTIcLI0y5EMp/jfHCxT+VClYNAFyiF5Ji22JTiXPstzODiduJx0wFsMT0odew
         zZlA==
X-Gm-Message-State: AOUpUlFdnkS5a7KOY+oJPQEfmLKYTtbUEwglebE/DqHv91xVgMyW1Omx
        XA9XdG7rRxmKpd40+bwmmqE=
X-Google-Smtp-Source: AA+uWPxd4nwZq9IopgDnsyqrIM7yxwFr1StDyiY9YZHh2vQ+Ngsn1PhRbOX/fYKtoQg7Snjw6pf/Hw==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr19334799wmo.84.1534496423040;
        Fri, 17 Aug 2018 02:00:23 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id l10-v6sm1433555wre.0.2018.08.17.02.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:00:22 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id D8A9B124935;
        Fri, 17 Aug 2018 11:00:20 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 1/4] mm/memory-hotplug: Drop unused args from remove_memory_section
Date:   Fri, 17 Aug 2018 11:00:14 +0200
Message-Id: <20180817090017.17610-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180817090017.17610-1-osalvador@techadventures.net>
References: <20180817090017.17610-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

unregister_memory_section() calls remove_memory_section()
with three arguments:

* node_id
* section
* phys_device

Neither node_id nor phys_device are used.
Let us drop them from the function.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 drivers/base/memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c8a1cb0b6136..2c622a9a7490 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -752,8 +752,7 @@ unregister_memory(struct memory_block *memory)
 	device_unregister(&memory->dev);
 }
 
-static int remove_memory_section(unsigned long node_id,
-			       struct mem_section *section, int phys_device)
+static int remove_memory_section(struct mem_section *section)
 {
 	struct memory_block *mem;
 
@@ -785,7 +784,7 @@ int unregister_memory_section(struct mem_section *section)
 	if (!present_section(section))
 		return -EINVAL;
 
-	return remove_memory_section(0, section, 0);
+	return remove_memory_section(section);
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
2.13.6

