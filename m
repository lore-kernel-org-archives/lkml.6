Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E74D20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKCJWjnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E74D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeGYLHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:07:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36714 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeGYLHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:07:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so6143638lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cgw709ofsERJ+D62PUlElyHEPGhEDBMyoUL1H2Y3XZE=;
        b=SKCJWjnIU3lyq4FYlmI7Zcr3CaG3RLKyCQt7Fdd1/0qKo/s0CYhN6Q5dhRQgVyK/VK
         gTHbR7WJZ/8W4O+7ETql2for2UZRuZnjSPW6+Boi3vL+uLVXXgyvOgnulpVxkoJUY6u8
         5vBSc06QPEMTSjecbMk61N4XmES75ExnaR4TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cgw709ofsERJ+D62PUlElyHEPGhEDBMyoUL1H2Y3XZE=;
        b=daDYSu2TOkhXDP8WQMPftOAPvPdVxBpxZgfP0PmvWPQd2ksTiyO68gLIG3vKtkkU0/
         KOc8ONCBr51tj1g7gK3uPEPb/2aObFoe3f1qkk+Hvn5dzUD5wkx147gvwxGouiJl0DZd
         NdjWU62G+4C4jrg3aBySff7KN7UZqODFucHhSBGzINaQe2eM1E9PulJ80mJLsTTfIPv1
         bQbHqKa+UaavYUaN0ELlbDr0Zyis6oX0H3SrmwuUCrhfCYJ0gVHiV27I6agPGOsZa0sl
         wYUpkz0ibno6JBFM7vRyy8Q9jVV8n2VafDk0+jRRzZ/4r2yuZ7FbHcXJEqdHqdNsFMst
         3PuA==
X-Gm-Message-State: AOUpUlHXGXDOImoHfIWkVJ3cATVgSWBXItWR4jjX57y16c1l+X50/gVl
        QimuiLbcX0yr0Oq3tUL5zHckdw==
X-Google-Smtp-Source: AAOMgpfdHGjhADoQrtCu3U4Bjb4+JlEwzvj0OO2nLSwwQCppm1tZvbpjbk/3sxUHKUaW2SUIe2WZlA==
X-Received: by 2002:a2e:4701:: with SMTP id u1-v6mr15487858lja.54.1532512564825;
        Wed, 25 Jul 2018 02:56:04 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id 20-v6sm2675198ljs.32.2018.07.25.02.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 02:56:04 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     riel@surriel.com, peterz@infradead.org, mingo@kernel.org,
        songliubraving@fb.com, linux@armlinux.org.uk,
        dave.hansen@intel.com, x86@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm: asm/tlb.h: Fix build error implicit func declaration
Date:   Wed, 25 Jul 2018 11:55:57 +0200
Message-Id: <20180725095557.19668-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on arm 32 with LPAE enabled we don't include asm-generic/tlb.h,
where we have tlb_flush_remove_tables_local and tlb_flush_remove_tables
defined.
mm/memory.c: In function ‘tlb_remove_table_smp_sync’:
mm/memory.c:339:2: error: implicit declaration of function ‘tlb_flush_remove_tables_local’; did you mean ‘tlb_remove_table’? [-Werror=implicit-function-declaration]
  tlb_flush_remove_tables_local(mm);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table
mm/memory.c: In function ‘tlb_table_flush’:
mm/memory.c:372:2: error: implicit declaration of function ‘tlb_flush_remove_tables’; did you mean ‘tlb_remove_table’? [-Werror=implicit-function-declaration]
  tlb_flush_remove_tables(tlb->mm);
  ^~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table

To fix this issue we define them in arm 32's specific asm/tlb.h file.

Fixes: 2ff6ddf19c0e ("x86/mm/tlb: Leave lazy TLB mode at page table free time")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

Ingo, would it make sense for you to pick it up into the x86 tree since
that contains the bug ?

Cheers,
Anders

 arch/arm/include/asm/tlb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index d5562f9ce600..f854148c8d7c 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -292,5 +292,13 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 {
 }
 
+static inline void tlb_flush_remove_tables(struct mm_struct *mm)
+{
+}
+
+static inline void tlb_flush_remove_tables_local(void *arg)
+{
+}
+
 #endif /* CONFIG_MMU */
 #endif
-- 
2.18.0

