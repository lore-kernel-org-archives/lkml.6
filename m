Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A96C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F270420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbFrjbMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F270420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeJBPlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:41:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40888 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeJBPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:41:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1-v6so656146plv.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=DbFrjbMmT4p0bJUM3+yKMpB1AeTWcf1ftcYv0Uuc06JmbhA3RekiXD2VLDFJiIXp/M
         OncOHk6jrhOSoprYufsQt0DnfcVOYzbKDDbl7Z+LTNYS8QBTTsaCzzBtAXgMEtu2p0rw
         2/llz50TH7rKF58z0jjXR5kgZPJVQWzRhVtEZUlGC4ZZP/3BkFJEVg8xitwOoo55RXbL
         tj/3RXzmm0yO79n5Ighwn/2/yOvjNm2uHMK3sKhBX35T9wSdB0AfLFQCrpAAJTtmWQxO
         P7kIR+KApXgiAfeXl6YsXFB3rmHH9VV2Stxm9sYFfQCPsga9XpldN0xVTLqQDlN8VAFJ
         YSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBDvynMlQ+CLa//vjhI1FniisjjUmkbIGiogOAJ0pDw=;
        b=sExwtVPRdsANc4DR/SGn0j9Ad2wKArciHDhUtvGq1n2mfXQO7/lzhRfYh7X4xzS+RM
         ru7+qUbZ2ETAGWsdO4JsuyRelfjeE2+Ngad6RbhDUgQRF0jIKN4Oab50LvI1uW9WtjeD
         QpfmNDO9CA94VaDL7l36qajlfSaOn/4KxfxSiLXrjKg2EfNtU5DV99WtFoBHK4Is1kl7
         d26uSOxXjgjmwOil9KTxuz+h+EtdG54p9lh36S/nQwIzzpv4Ug94cupMDc09aeyJ23CS
         BrEtK3KxjdwXlzgkkY5X7fgJTd1lOccpvwdpnCxPImSf98a/X5EuopgmqgghoLCsIi5X
         VorQ==
X-Gm-Message-State: ABuFfohj1yXljbvNYTZ1+w5P4SI8GoXuEwP3L/JJDKOZtBDaeWSi29dG
        WrH0AG41Kc9Do9nqY5o6uTE=
X-Google-Smtp-Source: ACcGV62Ln85E8wMJh2z/oNxDusx/VwUAp7LFhBLjE/EZFzBcVXFZ3YhbbD2U2lyMrng2SCs7qRKYJQ==
X-Received: by 2002:a17:902:b611:: with SMTP id b17-v6mr15707352pls.217.1538470771131;
        Tue, 02 Oct 2018 01:59:31 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id 62-v6sm5057927pgc.58.2018.10.02.01.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:59:30 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v3 5/5] RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap
Date:   Tue,  2 Oct 2018 16:52:31 +0800
Message-Id: <54849b9d9a709525640011814872155eafa7a9d7.1538470103.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538470103.git.zongbox@gmail.com>
References: <cover.1538470103.git.zongbox@gmail.com>
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

