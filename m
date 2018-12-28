Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A2FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBBA21901
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVquMnSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbeL1DAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:00:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39429 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeL1DAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:00:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so9470913pld.6;
        Thu, 27 Dec 2018 19:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P0OefrDCdHfbwKHsy88ZHJA55EsjPCyehr3d+WFCOV4=;
        b=hVquMnSv0Ml5RfLfRRlUw5ccjVZO8IO58JCttGnW+Xd4z+HbnLWdfE+l5K8XbJJpJy
         VxM0kcA1U/nrXNjez2VlBCrlByGCzIMoGAdhXHAKCkWynwgoZgvGhQELg8dAJe+HdTse
         hE22hYcqs0L5G0MhYhbtnY4xNrcOAOHkT5olYNqHKiJv+ccSWBRN+cDxG+7l73SS2vF7
         HE0K9pl1zIb+2Hc1bsWSKL196UTxLswmt1CYk8zwR5fVVsGoTtvG80cLIgsdzhKgXi8l
         /iT50X6mgDQUwoG/KLgnGGaHq7yb03JIZ3F8BVEHGw4Z7hLlWrmQSnDAOV8OPxqYjp5B
         3Klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P0OefrDCdHfbwKHsy88ZHJA55EsjPCyehr3d+WFCOV4=;
        b=bkyvQRx0UlZiw0Z6+XlKNzs6cYGC5zaIaCHbJyEBthNCrvo27Dq1uRuC0OOwoMjPiU
         0TPYhvuJxsuhujU+3e0c4chUI5XgSl3RrxEpJDlMEA779k/tVLjNT10l8FGQl2DZdCPs
         TwNwraqEL2ZEr0B0GokfYLQTcIw+BBHE40tE10tMm61c0RYFaq4/Y0n+qOA+tpPa43m/
         22U+KMkmIS8Vsa2tzlLgcMemTRBOJnKlU1pBo5YiId91eiod/bC/ZPANR8PrapXhKtxM
         cnjvLXLVOa3JMAzbTBlPAKXQhMC8Nn+D6HXIUX8GFhu+dWTI9Zn8m5jZz92VtIZSH72b
         +rZg==
X-Gm-Message-State: AJcUukeI+kErcv0P9w2kzu8lil/HonDS31smXksskNnn2l7OI4LOfV4t
        Kt8fBz3DKPcwxHHLtEnewJO9pXLdFCuS
X-Google-Smtp-Source: ALg8bN5NGXBadvb4zjPp8Ma6rh/JW4c0pihJ5b2zJkj0mgku8l+owH6L8c5esFok507v7A7TXYWjNw==
X-Received: by 2002:a17:902:9a04:: with SMTP id v4mr26364353plp.34.1545966037745;
        Thu, 27 Dec 2018 19:00:37 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 202sm80185958pfy.87.2018.12.27.19.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 19:00:36 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCHv3 2/2] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
Date:   Fri, 28 Dec 2018 11:00:02 +0800
Message-Id: <1545966002-3075-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Customer reported a bug on a high end server with many pcie devices, where
kernel bootup with crashkernel=384M, and kaslr is enabled. Even
though we still see much memory under 896 MB, the finding still failed
intermittently. Because currently we can only find region under 896 MB,
if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
randomly, and crashkernel reservation need be aligned to 128 MB, that's
why failure is found. It raises confusion to the end user that sometimes
crashkernel=X works while sometimes fails.
If want to make it succeed, customer can change kernel option to
"crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
limited space to behave even though its grammer looks more generic.
And we can't answer questions raised from customer that confidently:
1) why it doesn't succeed to reserve 896 MB;
2) what's wrong with memory region under 4G;
3) why I have to add ',high', I only require 384 MB, not 3840 MB.

This patch simplifies the method suggested in the mail [1]. It just goes
bottom-up to find a candidate region for crashkernel. The bottom-up may be
better compatible with the old reservation style, i.e. still want to get
memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.

There is one trivial thing about the compatibility with old kexec-tools:
if the reserved region is above 896M, then old tool will fail to load
bzImage. But without this patch, the old tool also fail since there is no
memory below 896M can be reserved for crashkernel.

[1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Daniel Vacek <neelx@redhat.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/setup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d494b9b..165f9c3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
 
 	/* 0 means: find the address automatically */
 	if (crash_base <= 0) {
+		bool bottom_up = memblock_bottom_up();
+
+		memblock_set_bottom_up(true);
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
 		 * as old kexec-tools loads bzImage below that, unless
 		 * "crashkernel=size[KMG],high" is specified.
 		 */
 		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
+		memblock_set_bottom_up(bottom_up);
+
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
-- 
2.7.4

