Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B1EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6006F214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpYZcl/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6006F214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbeKZV7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbeKZV7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:59:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CAB21479;
        Mon, 26 Nov 2018 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230329;
        bh=99Jz98kxONQsk5T+TYP8sQqleGggScHd8CpMM+dDOG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpYZcl/2U6OxblTeCdTUKAm5G84mmALpQjqy3md1LX6H4TRrGcZdxc2lSTwSBPjhF
         8Alvrrh0gywLDA1gFUaU8MkA1y1kmGh5U9/2MaQI4Jz8YTCYulstrpHpNB7FLb/DWP
         P27Nb8vlWo9RulWnQN8q3YIdlMh178W0WS4Xk/5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, bhe@redhat.com,
        willy@infradead.org, linux-mm@kvack.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 094/118] x86/ldt: Remove unused variable in map_ldt_struct()
Date:   Mon, 26 Nov 2018 11:51:28 +0100
Message-Id: <20181126105105.473322783@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit b082f2dd80612015cd6d9d84e52099734ec9a0e1 upstream

Splitting out the sanity check in map_ldt_struct() moved page table syncing
into a separate function, which made the pgd variable unused. Remove it.

[ tglx: Massaged changelog ]

Fixes: 9bae3197e15d ("x86/ldt: Split out sanity check in map_ldt_struct()")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: peterz@infradead.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: bhe@redhat.com
Cc: willy@infradead.org
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181026122856.66224-4-kirill.shutemov@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/ldt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 2a71ded9b13e..65590eee6289 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -207,7 +207,6 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	bool is_vmalloc;
 	spinlock_t *ptl;
 	int i, nr_pages;
-	pgd_t *pgd;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return 0;
@@ -221,13 +220,6 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	/* Check if the current mappings are sane */
 	sanity_check_ldt_mapping(mm);
 
-	/*
-	 * Did we already have the top level entry allocated?  We can't
-	 * use pgd_none() for this because it doens't do anything on
-	 * 4-level page table kernels.
-	 */
-	pgd = pgd_offset(mm, LDT_BASE_ADDR);
-
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
 	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
-- 
2.17.1



