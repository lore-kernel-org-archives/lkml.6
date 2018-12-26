Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE39C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7978C2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DcChs5JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeLZCGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:06:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45488 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLZCGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:06:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id y78so8732327qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ikr3Ra5EuhOrNtxrNCXKUlSEBXE4b8Xs1IWA6lspR/I=;
        b=DcChs5JSxuTLyStcDGQS4hxEQyUy0suQXId6oKYXSh9CZ+q40uAaJTCnAS2SwdU6+c
         6rVqD/VnspRoUEDUQRnkPgGbdz8HazinPgZHPIkpGBRKnnoXlFos3CjiATPHZn33eUsv
         XqYHBEgBzhavajRZzlVMp51DEAr0AUbZmaVxcodavg/7og/jym2TK+x94KDd5+TXR4kE
         qZ0IHUGICzIT3ftbU/AjmFSeuOA6nm0qBTMYQxZffwB8R5NAtxW3hIwm8w3jqtjrzm/y
         40VeZc9YtMdoO96L8wC8bwYAoxd+/BJ8ran2zuCmfH8O5Vek/pI1C4Hm49RE3rWz57Ws
         Qpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ikr3Ra5EuhOrNtxrNCXKUlSEBXE4b8Xs1IWA6lspR/I=;
        b=JdhdWk9vFSY+IA2K+frrMx+Z8SSh2LMOJfGO+Qc2puE4RlJv3NI3noBZmg3C5sLXPC
         zrJYS5Rq5CbqwUZtMiNwhBRYmTIRsR/g4lhdk3dPAegFkdKfZ1upu8/dE97keTZM1NY6
         2AfOTiDFJkH7lYJUbZyHanloDARLdtFYK0mpbES7r19Vgfsqq0qe5HB5NNjP4uG/SyAJ
         APXDYTjH0zubBfe2ajzeHtZyxcy68u/r2CSuOavnp1zuuiz2Q8ffK4G++fl4Lpm5Ogs0
         K6V6A/zGAkbLeH4iWVTlYQdEhNbpkdGD9aGOEp9f1X4OyMUhfPnrGFWHZRF2Z3Cy+463
         i2Vw==
X-Gm-Message-State: AJcUukevfNopllrr5Gn175fFVX9l/W0AiZmUiS2hGsm0kzlmJOyN/3bY
        CJ8/hOsrKDp9vPVONybkYpKCLg==
X-Google-Smtp-Source: ALg8bN4GquUtjdR5/5YXnS0aUfLrf7fPn9RuHDwgtdlxF3dHtmYPrLXed+Hi09h80vUtI8N5bkh8Aw==
X-Received: by 2002:a37:af42:: with SMTP id y63mr15876085qke.251.1545789964113;
        Tue, 25 Dec 2018 18:06:04 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e4sm12499934qka.31.2018.12.25.18.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 18:06:03 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        andreyknvl@google.com, dvyukov@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -mmotm] arm64: skip kmemleak for KASAN again
Date:   Tue, 25 Dec 2018 21:05:50 -0500
Message-Id: <20181226020550.63712-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to 871ac3d540f (kasan: initialize shadow to 0xff for tag-based
mode), kmemleak is broken again with KASAN. It needs a similar fix
from e55058c2983 (mm/memblock.c: skip kmemleak for kasan_init()).

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/mm/kasan_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 48d8f2fa0d14..4b55b15707a3 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -47,8 +47,7 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
 {
 	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
 						__pa(MAX_DMA_ADDRESS),
-						MEMBLOCK_ALLOC_ACCESSIBLE,
-						node);
+						MEMBLOCK_ALLOC_KASAN, node);
 	return __pa(p);
 }
 
-- 
2.17.2 (Apple Git-113)

