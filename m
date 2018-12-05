Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADDD20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADDD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeLESGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:06:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLESGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:06:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5I4TfD1375280
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 10:04:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5I4TpP1375277;
        Wed, 5 Dec 2018 10:04:29 -0800
Date:   Wed, 5 Dec 2018 10:04:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sean Christopherson <tipbot@zytor.com>
Message-ID: <tip-29434801e7e9c6d05fbea4533b3c0bd6be612f62@git.kernel.org>
Cc:     luto@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com, peterz@infradead.org,
        bp@alien8.de, riel@surriel.com, dvlasenk@redhat.com,
        mingo@kernel.org, brgerst@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          brgerst@gmail.com, hpa@zytor.com, dvlasenk@redhat.com,
          mingo@kernel.org, riel@surriel.com,
          sean.j.christopherson@intel.com, peterz@infradead.org,
          bp@alien8.de, dave.hansen@linux.intel.com, tglx@linutronix.de,
          luto@kernel.org
In-Reply-To: <20181204212600.28090-3-sean.j.christopherson@intel.com>
References: <20181204212600.28090-3-sean.j.christopherson@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/vdso: Remove a stale/misleading comment from the
 linker script
Git-Commit-ID: 29434801e7e9c6d05fbea4533b3c0bd6be612f62
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  29434801e7e9c6d05fbea4533b3c0bd6be612f62
Gitweb:     https://git.kernel.org/tip/29434801e7e9c6d05fbea4533b3c0bd6be612f62
Author:     Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate: Tue, 4 Dec 2018 13:25:58 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 08:58:12 +0100

x86/vdso: Remove a stale/misleading comment from the linker script

Once upon a time, vdso2c aggressively stripped data from the vDSO
image when generating the final userspace image.  This included
stripping the .altinstructions and .altinstr_replacement sections.
Eventually, the stripping process reverted to "objdump -S" and no
longer removed the aforementioned sections, but the comment remained.

Keeping the .alt* sections at the end of the PT_LOAD segment is no
longer necessary, but there's no harm in doing so and it's a helpful
reminder that they don't need to be included in the final vDSO image,
i.e. someone may want to take another stab at zapping/stripping the
unneeded sections.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: da861e18eccc ("x86, vdso: Get rid of the fake section mechanism")
Link: http://lkml.kernel.org/r/20181204212600.28090-3-sean.j.christopherson@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 0cedc905c8d6..93c6dc7812d0 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -65,11 +65,6 @@ SECTIONS
 
 	.text		: { *(.text*) }			:text	=0x90909090,
 
-	/*
-	 * At the end so that eu-elflint stays happy when vdso2c strips
-	 * these.  A better implementation would avoid allocating space
-	 * for these.
-	 */
 	.altinstructions	: { *(.altinstructions) }	:text
 	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
 
