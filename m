Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65773C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BA820645
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYewTL9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BA820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeKXJOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 04:14:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45348 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbeKXJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 04:14:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so3846396pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8gTioXrfb1hYx42mMThFJ6Ee2wmmeYe6sGLfcA6NCF4=;
        b=vYewTL9QPPafvi2N1eOi2z6a7zFe8Yg9JWNZcpCtrzsUraWPrdjOkzqwX0gT4bPlKU
         E0rlwiyLrEznbQHhO8N6wKfS4bgpKwJryVgANrwjSkt9nBOfqKj8pibDcx6G5og6ajba
         9HFUrT2bHrRR747kAK/yMhoEXZOF47lgG/PT3BCwZcjVUs54ZtVkzM1b6Gy56Vn79w08
         Ld7KwFqcIO1mXAX/DhqwrShLsG7YoUCgKyTdYOW2kFdajqWBuevZe62J6nytMwQqhjfi
         MUlYi+JaQkWJxVe7AssVoEoF53jRakIIL2MjetM50R8gPcElF+HPFv8bZ9P9TZpogkHf
         eHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8gTioXrfb1hYx42mMThFJ6Ee2wmmeYe6sGLfcA6NCF4=;
        b=f+0/otEjpPRq5px5YGwqRmKxCARZnPpX41fc4deLKILU8EKT1E48H16y4ZFOUtor7G
         sxCpLl38vtNvhVa2jb6bQ/URo43Dbf6nGDM3k1K7oWlSrpt9Tif7JpElRl1Mr5oGYABO
         yF6fCivlgcDGtSqYdudctVgZHA0QzreukB3R3y1CCbydrc1R4tUpQw5SWfELNu/rO+hi
         LogT24GlF6mlcj6VAkgVS9UJUdqCEpGchX9uOOddi7t1BkiOUwlr1dlY0Yftd85B6czF
         zT8CRIjeA5jO3k8Yj4hYY+VY4RwhBtPuLIgzplVW+cU5JgKFXOCgeXy8Vhvf4yVYS472
         1h7g==
X-Gm-Message-State: AA+aEWZI429Z0Kqs08ZYR5t27kgPz8kXE/9OjUo2+yM/J8mzZAoogBMZ
        L6SzXc80/h7ONi2+9BfX+qIfnqX0
X-Google-Smtp-Source: AFSGD/U49Tpwi4lMf1SUIy0yi7S9z4NRrp4MEWgcW1RyA91zkUkX/pEXnCDHoj6aaalZKEeBPKD4ew==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr15498659pgk.102.1543012121902;
        Fri, 23 Nov 2018 14:28:41 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e64-v6sm41919903pfc.122.2018.11.23.14.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 14:28:41 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] drivers/base/memory.c: remove an unnecessary check on NR_MEM_SECTIONS
Date:   Sat, 24 Nov 2018 06:28:11 +0800
Message-Id: <20181123222811.18216-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit cb5e39b8038b ("drivers: base: refactor add_memory_section() to
add_memory_block()"), add_memory_block() is introduced, which is only
invoked in memory_dev_init().

When combine these two loops in memory_dev_init() and
add_memory_block(), they looks like this:

    for (i = 0; i < NR_MEM_SECTIONS; i += sections_per_block)
        for (j = i;
	    (j < i + sections_per_block) && j < NR_MEM_SECTIONS;
	    j++)

Since it is sure (i < NR_MEM_SECTIONS) and j sits in its own memory
block, the check of (j < NR_MEM_SECTIONS) is not necessary.

This patch just removes this check.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 drivers/base/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 0e5985682642..547997a2249b 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -688,7 +688,7 @@ static int add_memory_block(int base_section_nr)
 	int i, ret, section_count = 0, section_nr;
 
 	for (i = base_section_nr;
-	     (i < base_section_nr + sections_per_block) && i < NR_MEM_SECTIONS;
+	     i < base_section_nr + sections_per_block;
 	     i++) {
 		if (!present_section_nr(i))
 			continue;
-- 
2.15.1

