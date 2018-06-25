Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DA826240
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTFep+/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DA826240
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934391AbeFYWr0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:47:26 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:55482 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933659AbeFYWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:20 -0400
Received: by mail-oi0-f74.google.com with SMTP id p186-v6so9922206oic.22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=D75bzu57Vb+Gc0Gy/OAz1HCmAwb32W6lqiuANod/EaU=;
        b=nTFep+/ODWuqgiYZs2NxMthfQltjLNJJqhsZ6YtZV2bVhdZ3qNx54YXAyvGQ7OzJ1X
         kNnI8Q1CBuaXBduBXB8U21AlIxEn6kHhZqR/6R9uww86qMpRlNaWsugAdJ0wVgj2uEDS
         0CZzHhFmCpm+5daVPF3iXNVLh8AOGX5xj6h75jqy0ChFZZ/eGq7J2dXFvpdbDdZd4V3d
         zf8bRsi9tRsTu9VAjdDkoOk8gspUpotiVYAa4dEjX6C1waH+r8iz8GmCwbAZn7yP4Phk
         juAqcL7bc8/BP2Bf+MUFoUN3brInz0KLfTtXDEdvhLy3xrLv/usLe/84SinK1hYi5BB3
         cAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=D75bzu57Vb+Gc0Gy/OAz1HCmAwb32W6lqiuANod/EaU=;
        b=mw1VKP9glYQLhgHDYP5YT5DOPlEvGCCNJit56Mxt2Vi/xDxpn+KZPVxQ/lH9hnha9L
         UYtxWuBP3u57BCKThUGdzLKDHXpdmvUuVVkccP5ZN0J5gC6lKawVbgO+hohmAAAHBb2F
         9Ds1NRTEMacoeOTXlQbxDbqgi4eZGZ3Q1XjzBuYd3hMh6qplNv83KMj3TsPiVxB3ib3b
         5OZby3YGYhzzBmoHrM+HgFkTdEvAtAWrE18RLJgTt3MlbCPjB+uADa82li005QhKr2Kf
         QSlKLrntKIsU8yq+IaDjk5XUNlnTz8ij3wngwM/DzSLL7w4iexH21TOGBlUybf/Z8m00
         FVPw==
X-Gm-Message-State: APt69E1Ds+yD5Gk29wC0q938FKrYnu/Zb8TiDJ2e6yZ+TyaovjxAl4fN
        8lIOXiAlV0LPDtRvI2v5hGk4sjaQU4BU5Q==
X-Google-Smtp-Source: AAOMgpcQTfcZ30Vu91D/khdpDSy9W6riHjZbVBKvf9oIAD/DCju8oxcERdHxXZ8e7WSsxzij1P7EXWbc5txrIQ==
MIME-Version: 1.0
X-Received: by 2002:a9d:4c13:: with SMTP id l19-v6mr6998073otf.68.1529966479864;
 Mon, 25 Jun 2018 15:41:19 -0700 (PDT)
Date:   Mon, 25 Jun 2018 15:38:56 -0700
In-Reply-To: <20180625224014.134829-1-thgarnie@google.com>
Message-Id: <20180625224014.134829-9-thgarnie@google.com>
References: <20180625224014.134829-1-thgarnie@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 08/27] x86/CPU: Adapt assembly for PIE support
From:   Thomas Garnier <thgarnie@google.com>
To:     kernel-hardening@lists.openwall.com
Cc:     Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible. Use the new _ASM_MOVABS macro instead of
the 'mov $symbol, %dst' construct.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/processor.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cfd29ee8c3da..25b5842a4646 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -50,7 +50,7 @@ static inline void *current_text_addr(void)
 {
 	void *pc;
 
-	asm volatile("mov $1f, %0; 1:":"=r" (pc));
+	asm volatile(_ASM_MOVABS " $1f, %0; 1:":"=r" (pc));
 
 	return pc;
 }
@@ -711,6 +711,7 @@ static inline void sync_core(void)
 		: ASM_CALL_CONSTRAINT : : "memory");
 #else
 	unsigned int tmp;
+	unsigned long tmp2;
 
 	asm volatile (
 		UNWIND_HINT_SAVE
@@ -721,11 +722,13 @@ static inline void sync_core(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"leaq 1f(%%rip), %1\n\t"
+		"pushq %1\n\t"
 		"iretq\n\t"
 		UNWIND_HINT_RESTORE
 		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+		: "=&r" (tmp), "=&r" (tmp2), ASM_CALL_CONSTRAINT
+		: : "cc", "memory");
 #endif
 }
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

