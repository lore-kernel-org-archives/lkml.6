Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8DDECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11272145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWOrcdBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11272145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJSUzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:55:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44302 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbeJSUzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:55:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id d23-v6so2390639pls.11;
        Fri, 19 Oct 2018 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/SbxNVQeLNR4Q7MsdDU+E0N+W9M8aEsScOy37n1U4zw=;
        b=HWOrcdBF/nvh5mkC194yr816eFFNmEuEanWkmfNVGGlJh/EeLdI/6f63x3wFBTn8QA
         yAPq/9HjYxvFI+74Trn+C9x8Bf5Yr4IxO6+bxtcSS3feq6+6mOZ+4G3Ahv46Gmh1NxP9
         3aFIHLFROBGcmVeQrd4cGpCDyML5m1w2OjgL8lsbpFTs5pCZdn9msSkERpJxH/M5NF4K
         6YHamnjY1pN0dnepcNkM0lWhUJQw2HCEdjoRo3eVpNfvAio0+J8cF3rL/+PKzrQHXwS9
         KpcPL945HbLgXqJ/Jw7ToqGeE91yQngQjfhDEd7tPbfgNqWP8loV0gzj+XOUt6FDshQI
         MUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/SbxNVQeLNR4Q7MsdDU+E0N+W9M8aEsScOy37n1U4zw=;
        b=dX1QkCxiydVTHsWbskhaknkr0Rly/XJrPDMxdqRgPKCXXPwMJwrHg785BzMTEg5qcj
         Qee5VTWBGld7PQgltxVWPbL02toYSWaAJIzpgmZZ+Hq4N0YujRHT9VeBqRUUtc+4/1bv
         6s1cDU+qSAUyFvLaBr9IPmCalHKWExgCpvKD8mL+916CwvhUqKs4NBDgjt+k0/0P6fpN
         RDQx0BhU2ZYeOxsFzLYjQPpmHx//GWf1xs3Vu3qCTPNPYISyBbwsxnXBD2jYOKZulHEI
         YJbIa4XOCu9s8Ix78x0ZezEB1Vh4ctkHel0EqwmDlXoOcq0fe/IunvMiU3a9gd8oFGT3
         rlgA==
X-Gm-Message-State: ABuFfogSrVisblPgfDWPXPDG+LZwmLu1QyF+Iz3JPM75i4EiLYAq+1ev
        zgTVIg836J/EPexV4KuOBG8=
X-Google-Smtp-Source: ACcGV61zGq3LnI2SSMg0hRf/eDIDxDBh6fAvq1MaSZL59r5+a8Tgp5sbIUGxO6e0djEv1zU6g7kOXg==
X-Received: by 2002:a17:902:562:: with SMTP id 89-v6mr34446359plf.315.1539953381674;
        Fri, 19 Oct 2018 05:49:41 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id o131-v6sm33640679pgo.53.2018.10.19.05.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 05:49:41 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, robin.murphy@arm.com,
        Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v2 3/4] ARM: mm: fix build error in fix_to_virt with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
Date:   Fri, 19 Oct 2018 12:49:20 +0000
Message-Id: <20181019124921.13780-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181019124921.13780-1-changbin.du@gmail.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With '-Og' optimization level, GCC would not optimize a count for a loop
as a constant value. But BUILD_BUG_ON() only accept compile-time constant
values. Let's use __fix_to_virt() to avoid the error.

arch/arm/mm/mmu.o: In function `fix_to_virt':
/home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
Makefile:1051: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Signed-off-by: Du Changbin <changbin.du@gmail.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e46a6a446cdd..c08d74e76714 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
 		pte_t *pte;
 		struct map_desc map;
 
-		map.virtual = fix_to_virt(i);
+		map.virtual = __fix_to_virt(i);
 		pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);
 
 		/* Only i/o device mappings are supported ATM */
-- 
2.17.1

