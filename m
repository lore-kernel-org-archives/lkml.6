Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05FC64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B269E20878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llJyOIKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B269E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeJCJ7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:59:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36191 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeJCJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:59:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so880750pgv.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 20:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=llJyOIKcGT/3qJR9GzkclSLGh2c3cN4qwf+z2v31BO4vntlAGTBeojgVAUS6o8eIDm
         b4EIanPvZAB6xVNlJPmMFdICb9zRQqF23MM4otJ9jvdk6AcbOJemtwevF1X3UGPkkuvq
         wwFqegteig4g2rFsbbLaBOWzTeaJtIui8AoH7tn56H0YAU4LaWXtDb8J8heE6j9mTO7B
         ZFR9XZuphFa4dO3YhAPAAJqT5w9fUvW6gJZGkS4A/E5YmFBuk4hNCDzkidp68NMwcB3e
         iE7hxRzObyQo1jQtbLGsQPAvdEjv4d0V8lBuaUdqA4sVxOtM8H2p7U/28q0D4Pcvr1cv
         zLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=rWRRpJXVioKM2T04la7v7Qpgfg0WStF6YFwBUGe8LCWh3DKd7im090JlYIoJFEQBad
         1mRKRRNNT+9J1GhRxa/+jqwQeC8BVwbkTQXM7+PbgnYtNk1w24psxpg7fZZVqmkfoS+9
         UMrBwyvX9Y/OT+117CQZ8jyv0p/d0h9yVXc1n+P/CV5cMRZWuQab8WjkigO8GCWg0P3d
         vpF3MDQT91vx8ogF18tBTcEbjq6sW2AO3zIYmGmr8Qg1OvMaNxcuzL3v5c7+wlU2OrTd
         mXnqiLz84LK15HkHmjNHRQd/OL42TYVz+YiPbGpS6VTmpL53+pl6ZtNFZqWfIiKptxmZ
         aDvw==
X-Gm-Message-State: ABuFfohZP3xm5+49ga/wr9vNeb/quI8s9NeG1gHQ9L3yN7AZeEsukJXV
        TJuA1qTu0NU6MjomX/Hvibg=
X-Google-Smtp-Source: ACcGV62/6tCgPPAKhKgQ/LLOd/bTYYaJLObPXOTkiO87jcJNyWzO5iiZ+VQsARaUG8CSmzrXXJ7a+w==
X-Received: by 2002:a63:1411:: with SMTP id u17-v6mr16880911pgl.247.1538536368856;
        Tue, 02 Oct 2018 20:12:48 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id v23-v6sm21777747pfm.80.2018.10.02.20.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 20:12:48 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v4 5/5] RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
Date:   Wed,  3 Oct 2018 11:10:02 +0800
Message-Id: <d851bbf26416d6fe5e55a2bec3121890cc95babd.1538535528.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538535527.git.zongbox@gmail.com>
References: <cover.1538535527.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincentc@andestech.com>

For 32bit, the upper 32-bit of phys_addr_t will be flushed to zero
after AND with PAGE_MASK because the data type of PAGE_MASK is
unsigned long. To fix this problem, the page alignment is done by
subtracting the page offset instead of AND with PAGE_MASK.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 arch/riscv/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/ioremap.c b/arch/riscv/mm/ioremap.c
index 70ef272..bd2f2db 100644
--- a/arch/riscv/mm/ioremap.c
+++ b/arch/riscv/mm/ioremap.c
@@ -42,7 +42,7 @@ static void __iomem *__ioremap_caller(phys_addr_t addr, size_t size,
 
 	/* Page-align mappings */
 	offset = addr & (~PAGE_MASK);
-	addr &= PAGE_MASK;
+	addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-- 
2.7.4

