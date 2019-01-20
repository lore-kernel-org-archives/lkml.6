Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0437C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCE62084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU+4BFbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfATINd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 03:13:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40794 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfATINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 03:13:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so19799179wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 00:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oF2K06y6GqbP+A72CRDkYBvyUldsNflXgLzQar1esgY=;
        b=sU+4BFbbRDOfvdREEHV7nnPZ3+BwgHKgHdD9a6wkahtBCSh3v69oulBctWBziV4Pt/
         QW3prd9wR8ndpkUgLdDbW9zPEFXMGLwtOJjxyTPygNMgl3MEeeA2/HJ4dYTNQQ4y9QzF
         h/Zy8QOpdCy2bVjVSJBsWI14zU9w1t8/p8FyPaOWAphCL0FNPHRCtyyKi6pw0xWRwaWx
         eD7hJasN7GjqsfF1oCtn7rYfOHtggI8QTg4TtiaFPEHndp+wRA/k6hAzwNq56ErZjKTs
         V3Mg7vCCld4U1Y4F7GNkafJuJpM/+/WpftnfE3ZjFn0kFFp5OLeScqxlW5WZbQ/IhR4f
         40FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oF2K06y6GqbP+A72CRDkYBvyUldsNflXgLzQar1esgY=;
        b=Cu4d6Y6mSxZWy1q0s3k21b5wCFAOSy7+u/vhQWny+/wzpL0BF2N4ZK+JHqDLh0a19B
         Jvvsv1/Sra4M0qFLy2YyMdODMYnflkiAWjAI+CTMSRYnrIuXM9PcmetXFVCGFZq6Ql1p
         PaJ59/RozMDdCjjyrZNv2yOZ0Ye9tLV276NDaknyDXn87LlSjnqX+jRBUhal/9MJC3VG
         ziZH0d6RFi1Ud9K2gQoczvxPRkRsiM1Io7sMfiCF3B2qIXUsyH8ZEPcjpUNThEJTOpNM
         0/pe1X1UTys759rxgKDgMYWeAdB8d1wtXHGFqxix6qRsQZwsO26XTnQ3mfk13dF1v4ws
         hIfw==
X-Gm-Message-State: AJcUukcCM6gWUpYlrvF74FhITaGARGcZY253o/5sbMFxMtoK2RykDJSh
        hwtjrdlRYY+NNC3lPG0Qt90=
X-Google-Smtp-Source: ALg8bN7MNDmk6xF++nrpsB/iYgKXsF08yW4AIRJ6qM5aQ/yGalX0JXWrZ5ZQp+rZ4r9pG1JZDh8F4w==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr23829190wru.45.1547972010944;
        Sun, 20 Jan 2019 00:13:30 -0800 (PST)
Received: from localhost ([2a01:4f8:1c1c:6057::1])
        by smtp.gmail.com with ESMTPSA id l20sm188093197wrb.93.2019.01.20.00.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 00:13:30 -0800 (PST)
From:   Yang Fan <nullptr.cpp@gmail.com>
To:     akpm@linux-foundation.org, will.deacon@arm.com
Cc:     Yang Fan <nullptr.cpp@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/mmap.c: Remove redundant variable 'addr' in arch_get_unmapped_area_topdown()
Date:   Sun, 20 Jan 2019 09:13:24 +0100
Message-Id: <affba895224614ac3f2cbafa9d4fa7be3361de9d.1547966629.git.nullptr.cpp@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547966629.git.nullptr.cpp@gmail.com>
References: <cover.1547966629.git.nullptr.cpp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'addr' is redundant in arch_get_unmapped_area_topdown(), 
just use parameter 'addr0' directly. Then remove the const qualifier 
of the parameter, and change its name to 'addr'.

Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>
---
 mm/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f901065c4c64..f2d163ac827a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2126,13 +2126,12 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
  */
 #ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
+arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 			  const unsigned long len, const unsigned long pgoff,
 			  const unsigned long flags)
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
 	const unsigned long mmap_end = arch_get_mmap_end(addr);
 
-- 
2.17.1

