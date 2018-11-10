Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F44C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB33720892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 08:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz0amzoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB33720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeKJSfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 13:35:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46147 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeKJSfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 13:35:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so3085043otm.13;
        Sat, 10 Nov 2018 00:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0GFGuYgzZxJ3ASj+D6szW4N2wm3+49wcIAPj0KPxSg=;
        b=Kz0amzoAT3QR5wiQKRNG3LSjRyINQ6zgVNu+DC373ZrISsJ/ovSbqjC06ID1hHnRX8
         XHWXLHIDd1cFmyHchSIkCPZSxjx+gycOtuOJAtUrFhSvUFqFuFGiSZexTKT++DEftv3h
         +MgXNsJBqHooVug74HRmwxsOnDjz99MKxB46VI4Qfoavxm/R80qmj1iuNEFtVLaHSUhF
         1v75+i5TlWkd700mCFOi2CUZTxscn1ct9N366AhLqe16Jr8zz0xZm7na+b42wYMlsygf
         t85pZJzxmbgVxY6+UXI+4U+EZZTRD4upZMgFSLE9ea3nG9ZaB4w8wGEplprHsP7q6cI6
         Ge8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0GFGuYgzZxJ3ASj+D6szW4N2wm3+49wcIAPj0KPxSg=;
        b=ntDKSkZI1VAwYTKjQ7mBgvJaHLj5YB+HD5EuCPTxbhaKiPdPc40iNjOWCa0P4CfXC3
         4u02KOK5YUn6NX7ICHj9PT+v01O6kA5/20YO5rS67vyydpl+zY6G3pWBwpum1QPuIOoJ
         NUhie6XH0AQZlR9AX5yeQvU9H0ui7aDPjjm7pbs0k2s2GAs7VcRuwzKzFXL5A7s+6aSh
         CQjEFgA3ohmk0IUGsGC1ynbmKrfSFhLjpTGl8k6R1B8qyk8tJ+JMHHS1VEK6d+buXJu2
         ug9Zyn6FbTqAA2PmfHq+eKPesSY3VB2SoKNaDR6Xa2EXxuqR7YTxG3oNZNNpF7zI908l
         2kHQ==
X-Gm-Message-State: AGRZ1gL6tFRLdJrgV9O5qPVNwsx+YMgxTR/bC55FYHlOnl7DxELy+xOu
        jcm5RC/xHq969v61jUd3h8Y=
X-Google-Smtp-Source: AJdET5fLNLdvIeAjT73P4uhetNjtK4d6WDtiKblgifPS/AOvmC2BF/omXA5bIeRNAgx44OZgo0ICrg==
X-Received: by 2002:a9d:4a21:: with SMTP id h30mr7378598otf.280.1541839856221;
        Sat, 10 Nov 2018 00:50:56 -0800 (PST)
Received: from sandstorm.nvidia.com ([2600:1700:43b0:3120:feaa:14ff:fe9e:34cb])
        by smtp.gmail.com with ESMTPSA id c7-v6sm3908683oia.58.2018.11.10.00.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 00:50:55 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2 1/6] mm/gup: finish consolidating error handling
Date:   Sat, 10 Nov 2018 00:50:36 -0800
Message-Id: <20181110085041.10071-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181110085041.10071-1-jhubbard@nvidia.com>
References: <20181110085041.10071-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

An upcoming patch wants to be able to operate on each page that
get_user_pages has retrieved. In order to do that, it's best to
have a common exit point from the routine. Most of this has been
taken care of by commit df06b37ffe5a4 ("mm/gup: cache dev_pagemap while
pinning pages"), but there was one case remaining.

Also, there was still an unnecessary shadow declaration (with a
different type) of the "ret" variable, which this commit removes.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f76e77a2d34b..55a41dee0340 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -696,12 +696,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
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

