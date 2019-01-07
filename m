Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1853AC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EA12087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 08:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJTzgmzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfAGIFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 03:05:22 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45480 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfAGIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 03:05:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so20390677pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 00:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kfdCkGhUiRbAOgir5HhOxtbVcWo8hMEtSNSE2dL8r9E=;
        b=jJTzgmzZJZPxQf6KJK+v6NnyA17dljz2r5ltNg4pdtf6JI6+lUyQDAi1OFNs43E+yn
         2bB1pGRuTtFOnOr8DmJfXMTwSYX9VPslamG+p/7ps/Vz3mI1PF0CGDsyM/4NIiiuOClY
         TGdQtdDIdwka8QR3I+1/zrb5I1zDRJqoXqa0FBagPuP4Y1kGrRgrVNLcH6yXQRtuB/FQ
         sW5eJOGvLrQdqMWSKd49m3M5oUVDRhJXcLRNGYYVNHVl0lHJBM/LwqUHK2yeBwy6C01N
         /FDsBig2w8zuImOVXAxHoGU1vy8aXX6DhrrmFA6i9cfsjNykO+vIi5UeOH4uXu0DjNJA
         CvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kfdCkGhUiRbAOgir5HhOxtbVcWo8hMEtSNSE2dL8r9E=;
        b=PMjooo3UB0p8l3TaCLQeFg1RgQ0YKWdEFbLTCwdvDkmZNl/2xIz7HzDurO2MyIuZEM
         FFZT6bNsrtiq3gPxpvfL5t6phtOU2SXMTbJ5aQKLAvNi5wPIy+NTw87J4/ey3FpfQ9wF
         xNxRkA0YznWLsPmUl2YovDb68fAdQYClIJ1M76SA3qW1aYwWbEwA2aH2SH5jCe/a1tie
         R+mjWiU6UtA0icN56HE8a2jRPBtPd/k7rh5noxR8Fz8+FHr3OTrG3DDPeOTwLTlHn7op
         H/BO3DZiX2SlowwIvdPbjw+rlk+MNFmb5EQpDnrr2UGBiFmRb+R4zGygsoHa05FNslGY
         EhPA==
X-Gm-Message-State: AA+aEWbutqqzR0wVxWCXIdyuwWyqw6m+3V7tZiBqOQ2TdshNODBxwIcM
        MriZpPEushwgvwU50IewKw==
X-Google-Smtp-Source: ALg8bN7hbpRU1yme4cFZnQRWusC/H5BPQsO37MVTw7+pzpKYR7A4M8ZlTCc1p5HfOoe+gHwX9PtTnQ==
X-Received: by 2002:a62:c505:: with SMTP id j5mr62066762pfg.149.1546848320048;
        Mon, 07 Jan 2019 00:05:20 -0800 (PST)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 83sm112726798pgf.57.2019.01.07.00.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 00:05:19 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org, kexec@lists.infradead.org
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
Subject: [PATCHv5] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
Date:   Mon,  7 Jan 2019 16:04:59 +0800
Message-Id: <1546848299-23628-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
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
v4 -> v5:
  add a wrapper of bottom up allocation func
v3 -> v4:
  instead of exporting the stage of parsing mem hotplug info, just using the bottom-up allocation func directly
 arch/x86/kernel/setup.c  |  8 ++++----
 include/linux/memblock.h |  3 +++
 mm/memblock.c            | 29 +++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d494b9b..80e7923 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -546,10 +546,10 @@ static void __init reserve_crashkernel(void)
 		 * as old kexec-tools loads bzImage below that, unless
 		 * "crashkernel=size[KMG],high" is specified.
 		 */
-		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+		crash_base = memblock_find_range_bottom_up(CRASH_ALIGN,
+			(max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN,
+			NUMA_NO_NODE);
+
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index aee299a..a35ae17 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -116,6 +116,9 @@ phys_addr_t memblock_find_in_range_node(phys_addr_t size, phys_addr_t align,
 					int nid, enum memblock_flags flags);
 phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
 				   phys_addr_t size, phys_addr_t align);
+phys_addr_t __init_memblock
+memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
+	phys_addr_t size, phys_addr_t align, int nid);
 void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
 int memblock_add(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index 81ae63c..f68287e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -192,6 +192,35 @@ __memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
 	return 0;
 }
 
+phys_addr_t __init_memblock
+memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
+	phys_addr_t size, phys_addr_t align, int nid)
+{
+	phys_addr_t ret;
+	enum memblock_flags flags = choose_memblock_flags();
+
+	/* pump up @end */
+	if (end == MEMBLOCK_ALLOC_ACCESSIBLE)
+		end = memblock.current_limit;
+
+	/* avoid allocating the first page */
+	start = max_t(phys_addr_t, start, PAGE_SIZE);
+	end = max(start, end);
+
+again:
+	ret = __memblock_find_range_bottom_up(start, end, size, align,
+					    nid, flags);
+
+	if (!ret && (flags & MEMBLOCK_MIRROR)) {
+		pr_warn("Could not allocate %pap bytes of mirrored memory\n",
+			&size);
+		flags &= ~MEMBLOCK_MIRROR;
+		goto again;
+	}
+
+	return ret;
+}
+
 /**
  * __memblock_find_range_top_down - find free area utility, in top-down
  * @start: start of candidate range
-- 
2.7.4

