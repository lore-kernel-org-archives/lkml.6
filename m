Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 19F05C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9839208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9839208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbeFLKS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:18:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:33099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbeFLKS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:18:26 -0400
Received: from juanniu018037.ss.mogujie.org ([122.225.81.134]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MaJPk-1fi8oq2npw-00JoN5; Tue, 12 Jun 2018 12:17:45 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [RESEND PATCH] x86: remove redundant check for kmem_cache_create()
Date:   Tue, 12 Jun 2018 18:16:49 +0800
Message-Id: <1528798609-111951-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:V4GS0+Yga31F3sIzKWGQ3Lmr+wpVqJmK6/bhAorF3oYg9hrVS/Z
 lSjUp52Ov3k/i10ii7ymAU4Y3nWv4myzIR/tic/71up6OkkEDP2pMvRpClYsZcU17KjyamR
 PL5OKhBBT1EVPU0160tD4mS3FH13A4L273IIsZrOWtSYf70k/8CPHv/sjYvD71zKBD+tXEQ
 MFHEvmulEasmLwBBXO+Hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IJrzMPOfLrw=:GKl8aD1ejkf2kt8hzuo64Z
 sY0OlpW8Vi41JBhqNrzuFqZ2Ou96m3rQkUqCITPyY4Oup0iC9pzFJxTU+n1uzVHRAdvFhUj22
 VZ6xUKqpwzTjkQfXr0kYst+uIElR6kpVHAZaqXTEg+A05JpzmNRWeNj/IwDyMcvaALEWiO63r
 U706A4tmkyAGd30+t43uM/w9dgdj2VBiJUtV+e41BPXoLdrz8V+jRpSGLI6rtxfI8BfZdXZM2
 RQlcHCs+zAA1CAERC8jqk5YwULeZtK3OkA1XQKKmd6HeGEQB/ik9wmqi3is7V1RRPTDq9ziZm
 ql5KRAeh55J+GG5YYx1Y0w5a7fI8yVIf7H8jpsrl6PqF2o65RCp3T3fMFJQpJd0gi4iSm7miP
 xH+yuslTKA0pOHU+FKihHurhVAPo+JPY6jvlP5HbBHaUTLWo6t8sBt9NIAjdji+gC3f2MM62h
 AYtV5NoenKlimtouptwt7gw7rfyQX3SvL5LXV4tD2mVVTMCFWNfU2RA6nGcWMWSkF29Up5YtR
 GKyaTEbtIVW0PGc3J8Zjir4l5EHc4Pb46gFlReq3un5eFGIEy9KfAQWKR+8z30omBtIPxMl14
 Io8ZlNaWO95MskLjJyFLrKSi/MKPaZY3wU62RgZJncLq4cQbD1Q4bQ0NxW/cAkA8+P+5MiC3F
 MXA+8t6IYhVvTxFB0CB7gZS1UeSg32NUIKbFb+mpmwDzqzFWdfrnk/E8czQgpdnElqskksLFq
 6pEmuQ5mauzdcTRA9RgBnHt1VSADcORgXYrK1Vsx0tJcyLVELyytvFXSNX8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag 'SLAB_PANIC' implies panic when encouter failure,
so there is no need to check NULL pointer and return error
code.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 arch/x86/mm/pgtable.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 47b5951..4392414 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -312,14 +312,14 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
 
 static struct kmem_cache *pgd_cache;
 
-static int __init pgd_cache_init(void)
+static void __init pgd_cache_init(void)
 {
 	/*
 	 * When PAE kernel is running as a Xen domain, it does not use
 	 * shared kernel pmd. And this requires a whole page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return 0;
+		return;
 
 	/*
 	 * when PAE kernel is not running as a Xen domain, it uses
@@ -329,10 +329,6 @@ static int __init pgd_cache_init(void)
 	 */
 	pgd_cache = kmem_cache_create("pgd_cache", PGD_SIZE, PGD_ALIGN,
 				      SLAB_PANIC, NULL);
-	if (!pgd_cache)
-		return -ENOMEM;
-
-	return 0;
 }
 core_initcall(pgd_cache_init);
 
-- 
1.8.3.1

