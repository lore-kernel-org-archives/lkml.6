Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CFDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFFC223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="DK5gbKhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFFC223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbeKPESd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:18:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35273 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388836AbeKPESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:18:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so5334441wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=eUb/ykbiDjRSxMeS2lRjQnFObTv9jCzDJK38qhNOr3Y=;
        b=DK5gbKhia9qRJTHZtkzxnlvs0UmYDkX3DLhm8mh1/vXrV5M7xkU8xhjqrntMKtmwZA
         5aI+BdDv95IjvCwOuB0TFqZDPG6jz0F822BgHmFUgbw97HVUKifCpPaSbBkq892FEZgl
         Ps7wudFZdo+GvKp6VUXegb35QOm1BMxs7qdygWLeLLVllAlvQ5R89IlYkb9SKs0OQoAI
         nyqR5mwzHuTozSr11EET9jxpJeIdIHUvuDLgej22uWjmAHZ5IvH4NDMrMDOyYxV/BVaF
         /K9jDbDodwnWxl6tni17/sTjIxCrHFXtHZa/kJxwE14cLrcoSeHqTGtaWANSC+fRMfDU
         5BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eUb/ykbiDjRSxMeS2lRjQnFObTv9jCzDJK38qhNOr3Y=;
        b=GybORYiFqqBveT17Ifgm2AjMhVT6Qp6BNMkVsEvRsp7S3OEh7dCjCGgP1UchvlOIWU
         YPAOe0nz/Um6u9Q6ya4aSooNIj7z2siZ1M5p+z/FrTA96iX5SBEp/lPl8GNn/V0X0bS/
         2ER+crKkUXNx3rC9oeFa1Spw18322oc1XzJ5Q/RnWKtzymczoT53iYcCwhyrwP04Utvp
         EYTcKbC+PDG3xmCveKhqUF/a2+NgbWrdtr5hl6ewPesUCsIPJ5aHNZJ1nookApL2e/Sr
         F+YPV4uksEFVPYg50wsyLzdCv8nuI+Qqe2QnSPEV//9fow0KVl0HnLfuzK73ZoTLiJ6w
         5dnw==
X-Gm-Message-State: AGRZ1gJZiKurbUPAd9tMjhGPw6LVmfl2rUsARY6EB4Ku63uPAUgCY6w1
        9gls3q5Hb16ffqEdt0hsyIHkRA==
X-Google-Smtp-Source: AJdET5eOLOANa5+P4GTahN1zAQ4iX9hQ4Q5KPTXWV4iDSHxv0HhRLzbLGbkU/em2GbAYxqX0FK7a0g==
X-Received: by 2002:a5d:6091:: with SMTP id w17-v6mr6555678wrt.193.1542305379747;
        Thu, 15 Nov 2018 10:09:39 -0800 (PST)
Received: from localhost.localdomain ([156.212.35.176])
        by smtp.gmail.com with ESMTPSA id e7-v6sm21959888wra.10.2018.11.15.10.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 10:09:39 -0800 (PST)
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
Subject: [PATCH] SelfTest: KVM: Drop Asserts for madvise failures
Date:   Thu, 15 Nov 2018 20:09:07 +0200
Message-Id: <20181115180907.13974-1-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>

madvise() returns -1 without CONFIG_TRANSPARENT_HUGEPAGE=y. That would
trigger asserts when checking for return value of madvice. Following
similar decision to [1]. I thought it is ok to assume that madvise()
failures implies that THP is not supported by host kernel.

Other options were to check for Transparent Huge Page support in
/sys/kernel/mm/transparent_hugepage/enabled.

-- links --
[1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg04514.html

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1b41e71283d5..7725cfdf1b79 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -586,14 +586,12 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
 
 	/* As needed perform madvise */
-	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
-		ret = madvise(region->host_mem, npages * vm->page_size,
-			     src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
-		TEST_ASSERT(ret == 0, "madvise failed,\n"
-			    "  addr: %p\n"
-			    "  length: 0x%lx\n"
-			    "  src_type: %x",
-			    region->host_mem, npages * vm->page_size, src_type);
+	if (src_type == VM_MEM_SRC_ANONYMOUS) {
+		madvise(region->host_mem, npages * vm->page_size,
+				MADV_NOHUGEPAGE);
+	} else if (src_type == VM_MEM_SRC_ANONYMOUS_THP) {
+		madvise(region->host_mem, npages * vm->page_size,
+				MADV_HUGEPAGE);
 	}
 
 	region->unused_phy_pages = sparsebit_alloc();
-- 
2.18.1

