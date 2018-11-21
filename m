Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEFAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FC021479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHHJRWxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FC021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeKUSrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:47:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38581 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeKUSrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:47:39 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so4384809plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kftceXIcb6/zigFfaFkzsAJF44js3nOBOOlSdzU22Ls=;
        b=WHHJRWxR9It6+U+CjcsrKZ63VdV8uOyo/6ygBQY1kw5qTfSe3OSnAm3/vv7CRDD88W
         hGRjDUfMtyW1MI7gydwaaIT+8A4x9NgwhA0tamcRSqG4Lf1IeEnfDeAHo5QFiJUiyvgp
         x6hXrQHY/c3HYr/8Y7cNH3k6OWxNn5GdRW+hxf41uNUY2Yag/sPvkXh/MX9FxbaPanGU
         Rnwy4NAln2jaxGxPE8hR2Ept47rPXOhZTSTw7+V7HeL905wKNQg9G+j+gDiRiZQ8neej
         m4IsbeP5246QYYnxjUOswSrmsbxD6ZVf4o/h2rQcHSgf5kysUIKkDB8pa+H7Ueh7LUYT
         iL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kftceXIcb6/zigFfaFkzsAJF44js3nOBOOlSdzU22Ls=;
        b=BzYDMlwKeeoPMG872ncD0WD8XMRzi/ikIaYlcjcu0oSu0M95fYkiL5m+Si0n+dISY7
         qAJEGU9icw1/jax07mFa+yC3DczKW42102KAtZ232LaNYsWxwJrUECsEvzorWO67O68D
         ig6nEaBKwdDd1IczLD72I4XUFdKN/LpysWVsrLWsCMJX2CS6byQ/o2XfXkYNSlRbMmi6
         8csvpQQoVbFCUQTKS4ZT7c8yWLdt6i6Tbh4Tb9HpJq5vxss+eSfVU2QtljKl8CrF6rd3
         xZgxn6nIUAFekT4EWMe3egv6RkA3XgVGS8uJzlaOcbCpsoixg+kiR4cTFvNy9oxO86Hm
         Rh1Q==
X-Gm-Message-State: AA+aEWbWs1dLPvGFN48NDfwVzG6xTszmWDx2xMCtGA/4w7WIdWH07okc
        pvSoDTeh4KLjI0836yVoid4=
X-Google-Smtp-Source: AJdET5e53EApUzyk0b4pViAnWg7jopvCQX/IeZgKso3hqDupkq8BTYSVRc1VIc1gjmBh9tUevalNYA==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr5070960pgb.66.1542788047526;
        Wed, 21 Nov 2018 00:14:07 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m20sm45739390pgb.56.2018.11.21.00.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 00:14:06 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] mm/gup: finish consolidating error handling
Date:   Wed, 21 Nov 2018 00:14:02 -0800
Message-Id: <20181121081402.29641-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121081402.29641-1-jhubbard@nvidia.com>
References: <20181121081402.29641-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Commit df06b37ffe5a4 ("mm/gup: cache dev_pagemap while pinning pages")
attempted to operate on each page that get_user_pages had retrieved. In
order to do that, it created a common exit point from the routine.
However, one case was missed, which this patch fixes up.

Also, there was still an unnecessary shadow declaration (with a
different type) of the "ret" variable, which this patch removes.

Fixes: df06b37ffe5a4 ("mm/gup: cache dev_pagemap while pinning pages")

Reviewed-by: Keith Busch <keith.busch@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index aa43620a3270..8cb68a50dbdf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -702,12 +702,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		if (!vma || start >= vma->vm_end) {
 			vma = find_extend_vma(mm, start);
 			if (!vma && in_gate_area(mm, start)) {
-				int ret;
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
 						pages ? &pages[i] : NULL);
 				if (ret)
-					return i ? : ret;
+					goto out;
 				ctx.page_mask = 0;
 				goto next_page;
 			}
-- 
2.19.1

