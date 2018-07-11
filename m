Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F72C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E47320C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWTrTVAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E47320C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbeGKVjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:39:36 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:54677 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbeGKVjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:39:36 -0400
Received: by mail-yb0-f201.google.com with SMTP id a12-v6so7433385ybe.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=nDBKPbf91Tai637uASRS6DK2AOgRvueX30bPuoQVNRQ=;
        b=QWTrTVAmvfyfiuhv/Q5L8n6X4LMq3CvOK285YTQzlG3supwHfL4zLVorNxYoxO1qM5
         7pD3PautBCA/U+wQHj53is1vKifAB2CfnXg2+p7+JqfPSMMxyWQbRP4/agOFGV/PZRua
         9RTEzQgj4Ol5Ky6lP1n0iIWvQ5BJskpany4tabwPXITQ/BOyfBqnjonS2l+2pvqDv2xJ
         UlNAqEBLmCS4hmSuBLK1NlcBUDEcn+dPdoLwV91pFF6FGzo/dOt2KkVJ5wTtM3ugej4O
         13tdLUpHlF70haqhzEa0QYb5n7dFziCwOb92cV+ebJTly/qExlygTsVm6xs9Ml+2sGSh
         RaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=nDBKPbf91Tai637uASRS6DK2AOgRvueX30bPuoQVNRQ=;
        b=lNJKY4P8rHUHhbIRDdA9n9utvZiQ+qOUQ7i0XWnDLbz4/Za/qDHR+gt9YU5Wy8ciZJ
         feRBUNHqrDR38Z3lJJajxTuv5EIt/F0m+MJMwZ/MUJOnlD3iHNG3cWI+hDFSBXWtJ36B
         J//hQWmn0kV2rJ479mwixeRFvK+3OsvTWDExgPTUCoiJLSXYLElzW2ySpFEy3wq2NcyK
         X85UrVs0iFdwTtzwLMuXWhWQyM9ipsgy+GQfaNnWdZUby5fflSaRKm72rScLhAbhg/jp
         TocgaBpxrmPaWkeC06S9g93ZoV9/mglr7Opy8vd2FL4163pVEbfDFTmz8YpnKY5seyW2
         +6Ng==
X-Gm-Message-State: AOUpUlEXLxHZv/akr/EEAnWrZZHCxyUkhEeUqYfUbU0eROSUnW4E5dwt
        DKE9m6KAW+8SB6o/lguAfMrKYMZpKxcOhoddX1h1BA==
X-Google-Smtp-Source: AAOMgpcSWnlt0E9gqUH99SLNsFfKaTe+AiJjILgsX/ADbqYoX4o2XfsThSMVPkyd+jBpo0EWHJKvfZKds2yyJ1i+Ax1Nwg==
MIME-Version: 1.0
X-Received: by 2002:a25:c04b:: with SMTP id c72-v6mr130155ybf.51.1531344798000;
 Wed, 11 Jul 2018 14:33:18 -0700 (PDT)
Date:   Wed, 11 Jul 2018 14:33:13 -0700
Message-Id: <20180711213313.92481-1-cannonmatthews@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2] mm: hugetlb: don't zero 1GiB bootmem pages.
From:   Cannon Matthews <cannonmatthews@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadia Yvette Chambers <nyc@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com, mhocko@kernel.org,
        Cannon Matthews <cannonmatthews@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using 1GiB pages during early boot, use the new
memblock_virt_alloc_try_nid_raw() function to allocate memory without
zeroing it.  Zeroing out hundreds or thousands of GiB in a single core
memset() call is very slow, and can make early boot last upwards of
20-30 minutes on multi TiB machines.

The memory does not need to be zero'd as the hugetlb pages are always
zero'd on page fault.

Tested: Booted with ~3800 1G pages, and it booted successfully in
roughly the same amount of time as with 0, as opposed to the 25+
minutes it would take before.

Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
---
v2: removed the memset of the huge_bootmem_page area and added
INIT_LIST_HEAD instead.

 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3612fbb32e9d..488330f23f04 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2101,7 +2101,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
 	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
 		void *addr;

-		addr = memblock_virt_alloc_try_nid_nopanic(
+		addr = memblock_virt_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
 				0, BOOTMEM_ALLOC_ACCESSIBLE, node);
 		if (addr) {
@@ -2119,6 +2119,7 @@ int __alloc_bootmem_huge_page(struct hstate *h)
 found:
 	BUG_ON(!IS_ALIGNED(virt_to_phys(m), huge_page_size(h)));
 	/* Put them into a private list first because mem_map is not up yet */
+	INIT_LIST_HEAD(&m->list);
 	list_add(&m->list, &huge_boot_pages);
 	m->hstate = h;
 	return 1;
--
2.18.0.203.gfac676dfb9-goog

