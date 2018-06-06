Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eUaaHcE4GFs7aAAAmS7hNA
	; Wed, 06 Jun 2018 19:41:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8F73E60861; Wed,  6 Jun 2018 19:41:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLLRjD0C"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2162F6074D;
	Wed,  6 Jun 2018 19:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2162F6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeFFTlt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:41:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37568 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeFFTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:41:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so14080626wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oeRlP3rcdQuwngPFalX+oE0mc/udB2Tvy8TL/+tCLLs=;
        b=jLLRjD0CSlGmKX7zU8Yk/xTctJRMY798wzyX+gsBi3+Z/Pz8B4v0mlH/brC+TyXDWw
         msHvRzp8cNvD1mfAs8Lm82aFCoYi/lnoeBjg+of7kfaQVFDVkZub+tgSspBmF/R72oyJ
         rkrcEMRuv5Qa92jNVE+GbjgzM3u3XVScUcPbYPFXnR7I0p5EFZaq5rKJ3DWY5zNk/WMp
         gSAFOj6FL7vXE/899FDxtvgavzheyxA7AAr+rRLHhbkuJvvBtxPTajA5dTN+DFmYtHjl
         1NjJYxEUse8+V6+FaA6rUq69DzrLlxBDnZxtv1s2Wz8zvAx0zt+GZa/sJem1hZs+/8zf
         vpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=oeRlP3rcdQuwngPFalX+oE0mc/udB2Tvy8TL/+tCLLs=;
        b=DhFV/Ol3Jj2yc4iuHXpfconAPGvVsQjJ1aBN4BnQ15t8Qy3r9QGulyFE4lsv480WO8
         gM+GqvC4LSofQAZ6EBk+1Hu8nehJ6RAeP3fmrnWVxlj8S5tsiUZRBNxsi9imEEs4UAQK
         TIX+l1hUtahmQH3Uhmy4QZ8028AAJR/9Y7sDe3G+YQLGvz0JShZ6uShdz8dSHQ695nKQ
         CV01LkhjwIBPc3O0gsIrQvzDxrKrGyYpZLG8i3riWY/HCF9NXgeDtrb7HPMHWa6336BV
         W1DENe+wLQDN+eoTvE6ByjONizXMU86A5AL8vuEbYmDgriyTc8cwUFP02cuYrueYm5+3
         cnQw==
X-Gm-Message-State: APt69E2vWBY1gtxGIyA8C1PuvBiuKz5QJBSxX/RCC9I2Cj0av2AsSn6k
        Q3dFeRyahw9qhPCHz9PWNvg=
X-Google-Smtp-Source: ADUXVKI8PBshUq2KutyNl2N55VJitdvrxpxrQlcx1wOc1QzorCYPBILTkhLYeGCWAzWGAbj8B357Aw==
X-Received: by 2002:a1c:4189:: with SMTP id o131-v6mr2477813wma.7.1528314106887;
        Wed, 06 Jun 2018 12:41:46 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id u108-v6sm65904216wrc.40.2018.06.06.12.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:41:46 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 59C3410C2B80; Wed,  6 Jun 2018 21:41:45 +0200 (CEST)
From: Mathieu Malaterre <malat@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mathieu Malaterre <malat@debian.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memblock: add missing include <linux/bootmem.h>
Date: Wed,  6 Jun 2018 21:41:43 +0200
Message-Id: <20180606194144.16990-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
introduced two new function definitions:
  ‘memblock_virt_alloc_try_nid_nopanic’
and
  ‘memblock_virt_alloc_try_nid’.
Commit ea1f5f3712af ("mm: define memblock_virt_alloc_try_nid_raw")
introduced the following function definition:
  ‘memblock_virt_alloc_try_nid_raw’

This commit adds an includeof header file <linux/bootmem.h> to provide the
missing function prototypes. Silence the following gcc warning (W=1):

  mm/memblock.c:1334:15: warning: no previous prototype for ‘memblock_virt_alloc_try_nid_raw’ [-Wmissing-prototypes]
  mm/memblock.c:1371:15: warning: no previous prototype for ‘memblock_virt_alloc_try_nid_nopanic’ [-Wmissing-prototypes]
  mm/memblock.c:1407:15: warning: no previous prototype for ‘memblock_virt_alloc_try_nid’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 mm/memblock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index feb9185d391e..c5fb9c846890 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -20,6 +20,7 @@
 #include <linux/kmemleak.h>
 #include <linux/seq_file.h>
 #include <linux/memblock.h>
+#include <linux/bootmem.h>
 
 #include <asm/sections.h>
 #include <linux/io.h>
-- 
2.11.0
