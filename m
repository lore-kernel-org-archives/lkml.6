Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2482087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="JMxd+RnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2482087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbeKPWDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:03:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54062 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeKPWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:03:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id f10-v6so21754468wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9/Jpoirvo+JBapSNqbcEaqpfZUw6b7iOGbbgwDtFxZQ=;
        b=JMxd+RnVG+AodKMinfHmpQZ+hq/rvlED2bVglPNzIBV6G26ASIQ4YQaGEnwuyjuaJ9
         MYhvkD6Bjumi/YpR/aHuXYcg6/b4+k0fU3z/sXNF+H44i7f4XHuN+ffcxe/nuozT1DBD
         saeLiT3KFqGrm9Bp2XorPBEMYvQg+5Ud1kpxn8hKjaDY0XaIqzqvyZ/BbQDdLjAc924U
         6g9qqKP6dm0/2DOLXyvkzl7GajJOizmD70N9RP8phHv3+Oqh7aPjGN8wdllz08BKy/FX
         4yBzuAhtGv9ipocX6kHAbmOTErSSbBk4cpk8dp6norjFoLD/31Ku5XT95ec+5SndiuhD
         Wc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9/Jpoirvo+JBapSNqbcEaqpfZUw6b7iOGbbgwDtFxZQ=;
        b=kePpwys8S+6sqtmjcbhJzPMO1YAHVuIFN3uOp2rTW+bW1oDKbyOkkcTKFXO7cvnWbq
         o+hCD1iwTZwf2wvUlGYBS/dNkAu0IKU6U4YWbxcFCnc1/2Nvsy4e5anrFErbIGP7rFF7
         tqeAbZ//hzeO+gpJj23+EitEOWv6Ty0OheNGO95lT28Sqerm71JPdWqcc2lGpDx3ddkU
         JCy1F0z/9YFm1VCRSm548EA/B5CFHw6zkjsJlJt8hsNG4KJKr8eNuiEFOfsYDKTlO8j4
         kat68Oy4bfYDpId329+KBV0S/gn4KtVYdU90klP8/kEcdR5u/RQd0c2EW/CcQ6FbkhPb
         CQrg==
X-Gm-Message-State: AGRZ1gLedr3pqqWmrJaoM53KV13KNS8L/8uWe2bWrLS0q3FCM8XP2XRy
        Q6yf42R+rmmJPrkIdDpYHmegog==
X-Google-Smtp-Source: AJdET5enwGsKs7ldkV10V1B5kekm7cLExtPGsWsIOBbkVFUwlBFK8cqqFjQZ+crjBT3RYDRusWtaaw==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr8606182wmf.47.1542369080093;
        Fri, 16 Nov 2018 03:51:20 -0800 (PST)
Received: from localhost.localdomain ([41.35.235.41])
        by smtp.gmail.com with ESMTPSA id e66-v6sm44686207wmf.40.2018.11.16.03.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 03:51:19 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
X-Google-Original-From: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [PATCH V2] SelfTest: KVM: Drop Asserts for madvise MADV_NOHUGEPAGE failure
Date:   Fri, 16 Nov 2018 13:50:55 +0200
Message-Id: <20181116115055.7415-1-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>

madvise() returns -1 without CONFIG_TRANSPARENT_HUGEPAGE=y. That would
trigger asserts when checking for return value of madvice. Following
similar decision to [1]. I thought it is ok to assume that madvise()
MADV_NOHUGEPAGE failures implies that THP is not supported by host kernel.

Other options was to check for Transparent Huge Page support in
/sys/kernel/mm/transparent_hugepage/enabled.

-- links --
[1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg04514.html

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1b41e71283d5..437c5bb48061 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -586,14 +586,23 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
 
 	/* As needed perform madvise */
-	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
+	if (src_type == VM_MEM_SRC_ANONYMOUS) {
+		/*
+		 * Neglect madvise error because it is ok to not have THP
+		 * support in this case.
+		 */
+		madvise(region->host_mem, npages * vm->page_size,
+			MADV_NOHUGEPAGE);
+	} else if (src_type == VM_MEM_SRC_ANONYMOUS_THP) {
 		ret = madvise(region->host_mem, npages * vm->page_size,
-			     src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
+			MADV_HUGEPAGE);
 		TEST_ASSERT(ret == 0, "madvise failed,\n"
-			    "  addr: %p\n"
-			    "  length: 0x%lx\n"
-			    "  src_type: %x",
-			    region->host_mem, npages * vm->page_size, src_type);
+			"Does the kernel have CONFIG_TRANSPARENT_HUGEPAGE=y\n"
+			"  addr: %p\n"
+			"  length: 0x%lx\n"
+			"  src_type: %x\n",
+			region->host_mem, npages * vm->page_size,
+			src_type);
 	}
 
 	region->unused_phy_pages = sparsebit_alloc();
-- 
2.18.1

