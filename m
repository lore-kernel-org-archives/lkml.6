Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84757ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A02920C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8+GUvl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A02920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbeGQK2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:28:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39355 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbeGQK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:28:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id p23-v6so244714plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8o4sZVJQSBGDEta+NME7mQcHJS9snLouehPKnWTVcE=;
        b=s8+GUvl1Glm4MwjuCLw5M4sf1hdjJilbFC1B32p3oXsWv4ZQvRjczYVLNxdUA8wa/r
         o2UXqiruneJSNHymgcKaLfyFGGoE4wVsb9ay5Zz00coghzkQSjLFKiEs4RR04gNfBhOF
         VE3djNS/5f8ETDzAqfyuGaJz+ljmwY65QURn0LgoCvOcwiTeeRsNR+EWWrXyRi0CGd+h
         s7WIsrOt9KNeYWMwL3aCUKbgvxVbWJuU4jOFxrWfJl8QlWe14g7qj025F9KKZ96ePqz4
         YFLrUpI9He87HlOPTG8WVjJmg1xnxRHcEIzP3b5L63T8ebK1GApfk8azh9lLHjLKZ96j
         RrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o8o4sZVJQSBGDEta+NME7mQcHJS9snLouehPKnWTVcE=;
        b=Lp6ipJ2zJmtTT6kyhbBj7+4lCelrjHho9YKA3NdgzCJuzBsm/UkPovwOwj+ufEUl4z
         nPWFaKI2E++1W/3u7dJSHin96Yd3WdE5qW7ZlcJFFGZ+rwAH/Mcu7oFPFb1LxWeEiGXM
         2/soZEaalA1Z4bt+cV0Oj8KISssU3kJFwImpAXa66gd8nxdiJoiOmqkiZa5W06diJaJO
         VFqNlOcarU+jbEeiFvtXD0cpKZYYbTDoA+NUUR2Ob9k0hPxDAOuYX1nyX+Axrz37ZJDI
         2Hmc6oCf8vgLxXuns0X5ZoJ0t0iDQqaXRs9AywbSFOWLEZDsFJyCUlHiTfgCfxlGhRgi
         D0sA==
X-Gm-Message-State: AOUpUlEsA98ugTp7lC8GnfaPgUlN+VgV2UlL6pwm9wh+CQkYprPrszl/
        E0Zeae2hicdmzQUDP62KaNeYtg==
X-Google-Smtp-Source: AAOMgpdF6RVKzXJyaLJUEYyBo1s5H6/kbvECkF7X8WQhxLq2AOr13yJPjx12Eit642tnRN7RH7JT8Q==
X-Received: by 2002:a17:902:e3:: with SMTP id a90-v6mr962715pla.227.1531821393756;
        Tue, 17 Jul 2018 02:56:33 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id u2-v6sm1232542pfn.59.2018.07.17.02.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:56:33 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] arm64/mm: Make swapper_pg_dir smaller
Date:   Tue, 17 Jul 2018 17:56:06 +0800
Message-Id: <20180717095608.11008-5-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717095608.11008-1-yaojun8558363@gmail.com>
References: <20180717095608.11008-1-yaojun8558363@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We setup final page tables in swapper_pg_dir, which just contains
PGD. And the PUD/PMD are allocated dynamically. So we can make it
smaller.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 2 +-
 arch/arm64/mm/mmu.c             | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 61d7cee3eaa6..2446911f4262 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -237,7 +237,7 @@ SECTIONS
 	. += RESERVED_TTBR0_SIZE;
 #endif
 	swapper_pg_dir = .;
-	. += SWAPPER_DIR_SIZE;
+	. += PAGE_SIZE;
 	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cdce3ec4c7bb..d24be05ec1d4 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -633,14 +633,6 @@ void __init paging_init(void)
 	map_mem(swapper_pg_dir);
 	cpu_replace_ttbr1(swapper_pg_dir);
 	init_mm.pgd = swapper_pg_dir;
-
-	/*
-	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
-	 * allocated with it.
-	 */
-	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
-		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
-		      - PAGE_SIZE);
 }
 
 /*
-- 
2.17.1

