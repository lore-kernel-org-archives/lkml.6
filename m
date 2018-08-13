Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E9FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF002175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF002175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeHMS3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:29:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52093 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeHMS3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:29:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so9363121wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u8/RQnqvKaB52sUTxj99rxlBwtcgMKNF8ab+i1Lq2fw=;
        b=XOvKYFtmpMEZ1nlWVCOuViV3JQWoFZNMZ6CR5UN4qcT7gxTJTWD6LalKj5IzA1O6+6
         2MV5p5wG/RIzchOoAX7GjRBHzj5hMq1bZRzhukM+ezRDwJ3pbnCANDCIlUa+m5DqrZeG
         YvOYnQeTeRq+d9yD9tTiPdTCMDWOlSgj9p4WeRlJwvLp8dFSOmTnVjUilNhDk451ZeR/
         q/ZbUGo+up0vwni1rXZoA2vp0YwnySGnW24qKvHFKg2jOT518tsnNKAnDZuKpJCY0XLq
         U5lf/b61LIV9IsaW/qSRROnTnVbViRxcjtBjV0Lods/LmNM+fWAjDyqVrsyVDUri3ZIK
         UoOg==
X-Gm-Message-State: AOUpUlGcH1eLhlJaWFEiPgfGZ6AU1XdrQsEjwKRQSE5UW9ePah+7zkgQ
        lLth/JQ6kVuyJNsqDY/019g=
X-Google-Smtp-Source: AA+uWPzOfyAJfKFcSVM7PWZ/919D7tsBXQmsa0ftfxohKtspqdwbjunV/BfCEzSQ8FqdwsCbsTcS9g==
X-Received: by 2002:a1c:64c:: with SMTP id 73-v6mr7992915wmg.7.1534175210325;
        Mon, 13 Aug 2018 08:46:50 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t186-v6sm11773743wmf.14.2018.08.13.08.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 08:46:49 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 56CFB12485D;
        Mon, 13 Aug 2018 17:46:48 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, jglisse@redhat.com,
        rafael@kernel.org, david@redhat.com, yasu.isimatu@gmail.com,
        logang@deltatee.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/3] mm/memory-hotplug: Drop unused args from remove_memory_section
Date:   Mon, 13 Aug 2018 17:46:37 +0200
Message-Id: <20180813154639.19454-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180813154639.19454-1-osalvador@techadventures.net>
References: <20180813154639.19454-1-osalvador@techadventures.net>
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

