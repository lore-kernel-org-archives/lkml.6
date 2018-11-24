Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C866FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8357720865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYCMy6PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8357720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeKXUCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:02:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45057 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeKXUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:02:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so14258334wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 01:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JOChgtr5G51PVwI83po1hgEHkCkjr21KXgeBrDBdLdY=;
        b=QYCMy6PWcVqE6kuhY3fvsWFfX0N73DhJRvAg7L2kOE4jTede3gJ86JbuCSZvZiMAIB
         jWNoxiEqDNyVLRza1oNawA/78InCNmGz+fP6nZNPqSha2qEguY8okYh76MKNuAc0GqWL
         iZ9Y3PLjjwwUjOldVAQH1zILe2RH1sd+uuRYiZrQ5zEjLCC2u//5nIwAJklxolaVvljv
         G14/9SbouFgTuF6NA24EEPqA2aCJM6stn4CbHfGosVxn2HVVMrIWsfFF9GazjgDrgblL
         3VoxvL5aBdA3mffnM/AShWYhUW03bNyXLmXTOUo+2HttekXZjAEOgqutWpQkE9l6Falh
         IlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JOChgtr5G51PVwI83po1hgEHkCkjr21KXgeBrDBdLdY=;
        b=ooSbw8IfNNWCrM+NiX3MGpd+qG8k9OenMBNRd/UK5/+O1liITiH17iuQtcULJHxJu7
         yQ0vLydSicy/Mc2W3VsDPq1aJYd7FEWOdacCl1vrMZoTxf156k0g+xnDmix8AMEH98sU
         MyasV85/f8YAc9ckj/jsm+PLHj7VAMftZuONe8/INkMM/bYFRUsU6vZ0puiRWrxHbQ4z
         kwEtdpIF9M6g8DearDpM5ftlSsLIOX3lraTvceWX+qKtws0yVyNu9Vp1WynFqYojJVd+
         UmrT30XYaZfvEqmYCp2l4d0E0S2HgTiDX6TKhSK2Svv2MGTw3lJQaKannW8pE1iGk1QI
         mZpQ==
X-Gm-Message-State: AA+aEWazftCT5PAayL+vObblzellfXV4FEasHh/WXa6mHa/uELAQWUsM
        g7roy8DMZ0wyiRccU/eMUdJT2Eg=
X-Google-Smtp-Source: AFSGD/U2O4TQBC9bNhxe7r1IiYNU0Kt7lcBtKGWq5Q59OkZyZdg1F8V9pqaKWeeHFZtek2BumllOGw==
X-Received: by 2002:adf:f149:: with SMTP id y9mr18180825wro.284.1543050853467;
        Sat, 24 Nov 2018 01:14:13 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id e190sm13434375wmf.0.2018.11.24.01.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 01:14:12 -0800 (PST)
Date:   Sat, 24 Nov 2018 12:14:11 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: make free_reserved_area() return "const char *"
Message-ID: <20181124091411.GC10969@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and propagate through down the call stack.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/mm/init.c               |    2 +-
 include/linux/mm.h               |    2 +-
 mm/page_alloc.c                  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -967,7 +967,7 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
 }
 
 extern unsigned long arch_align_stack(unsigned long sp);
-extern void free_init_pages(char *what, unsigned long begin, unsigned long end);
+void free_init_pages(const char *what, unsigned long begin, unsigned long end);
 extern void free_kernel_image_pages(void *begin, void *end);
 
 void default_idle(void);
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -742,7 +742,7 @@ int devmem_is_allowed(unsigned long pagenr)
 	return 1;
 }
 
-void free_init_pages(char *what, unsigned long begin, unsigned long end)
+void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 {
 	unsigned long begin_aligned, end_aligned;
 
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2054,7 +2054,7 @@ extern void free_initmem(void);
  * Return pages freed into the buddy system.
  */
 extern unsigned long free_reserved_area(void *start, void *end,
-					int poison, char *s);
+					int poison, const char *s);
 
 #ifdef	CONFIG_HIGHMEM
 /*
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7072,7 +7072,7 @@ void adjust_managed_page_count(struct page *page, long count)
 }
 EXPORT_SYMBOL(adjust_managed_page_count);
 
-unsigned long free_reserved_area(void *start, void *end, int poison, char *s)
+unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
 {
 	void *pos;
 	unsigned long pages = 0;
