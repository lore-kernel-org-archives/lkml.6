Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC1CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5B220870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpVBwsQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5B220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbeGJStm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:49:42 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:48872 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388505AbeGJStk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:49:40 -0400
Received: by mail-qk0-f201.google.com with SMTP id 17-v6so5290343qkz.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=bl/ppoRWkR41p8O8LfYbYXELJVdEuPvWgKM8i7oPNoE=;
        b=tpVBwsQR+DAc3hffLoxUhLMEjQnV7n6+SDi5acXPi8ff8l19Yt9XSJWbNc9Z5td11k
         y+MBYzkH1Of2tzAF6VYvgg8pm9/4NFZBE/MqLAP7IpCCcyKmOLicb5LcrC4ldPmne8Kx
         76DcjQ6824J3GCB1wW1zXWN1sPqKQILUkBU28ibs6ltKA6PTDWloSe2mGG07O8YCPjgO
         8BJ/XH6pcfkbUA2JhYaDUfr2ClrlEftuXO+ijO3c7qPaAawX5eQh1YYsb8LjXhp2eCdn
         sE3zBqJ6elTA7ufPxMhL5RAET/YBqD7rzqd03Ato5AsFYfn0Ei/58bnfpd2i1Nl2Vdep
         Oe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=bl/ppoRWkR41p8O8LfYbYXELJVdEuPvWgKM8i7oPNoE=;
        b=Kz4/svWTNK4J6Qi+uo2Hm3yAPiCy0m2LOXseh0aj9ISuM2jQw2Bz2rGXHYMmSAXOX3
         oEsUptmnygjkl/Nr8ZBGKu/T8D3TiS0iGHq5p+E2opXYlruvc+5YFG9jsuJDuBuw1fJM
         bEMS7uSQSrPAMJf5WN2Q3dnuAH6LvKLP0iLm5+sDhsqjBlA8iuRyctwMQMMgtfQ+6ncx
         9+o5ehr7Hontf1pYaan4awe3vP1WgbMzA3e8DJM7k78AW0e8+eRJr8c6MokRY4sst8YR
         jSlHi2xyR5brC3/ATLMSZmUGf23suJv2td0Q0bUIfwBPel0REG0ISoWKm0a97CRW6vHr
         aPzg==
X-Gm-Message-State: APt69E27rLG21dEAZNQe2g3C800cNj4rK1pFaZwPYx+VRK2S+vEwyng/
        uSxIQlC6aqfJPbCvazQkxx0AW7sbP3Fumw9AN0ysaQ==
X-Google-Smtp-Source: AAOMgpcEczjEjRhy1tPLM56bFeMNE/GBZkB7iGvTRrJKvpr6ot+oBRpXNE1U2DSRxfUI9jUSuUHOb7CpWBSyzf+pczIwPg==
MIME-Version: 1.0
X-Received: by 2002:a0c:f886:: with SMTP id u6-v6mr15386612qvn.48.1531248561617;
 Tue, 10 Jul 2018 11:49:21 -0700 (PDT)
Date:   Tue, 10 Jul 2018 11:49:03 -0700
Message-Id: <20180710184903.68239-1-cannonmatthews@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] mm: hugetlb: don't zero 1GiB bootmem pages.
From:   Cannon Matthews <cannonmatthews@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadia Yvette Chambers <nyc@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com, Cannon Matthews <cannonmatthews@google.com>
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

To be safe, still zero the first sizeof(struct boomem_huge_page) bytes
since this is used a temporary storage place for this info until
gather_bootmem_prealloc() processes them later.

The rest of the memory does not need to be zero'd as the hugetlb pages
are always zero'd on page fault.

Tested: Booted with ~3800 1G pages, and it booted successfully in
roughly the same amount of time as with 0, as opposed to the 25+
minutes it would take before.

Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
---
 mm/hugetlb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3612fbb32e9d..c93a2c77e881 100644
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
@@ -2109,7 +2109,12 @@ int __alloc_bootmem_huge_page(struct hstate *h)
 			 * Use the beginning of the huge page to store the
 			 * huge_bootmem_page struct (until gather_bootmem
 			 * puts them into the mem_map).
+			 *
+			 * memblock_virt_alloc_try_nid_raw returns non-zero'd
+			 * memory so zero out just enough for this struct, the
+			 * rest will be zero'd on page fault.
 			 */
+			memset(addr, 0, sizeof(struct huge_bootmem_page));
 			m = addr;
 			goto found;
 		}
--
2.18.0.203.gfac676dfb9-goog

