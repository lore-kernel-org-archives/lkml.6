Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC734C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBA520661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957397;
	bh=PX0aLrAQBM2qO9O1wTnBJKJfIM3vZ/lJzWGGd9J2NFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQyJs+FjlO14EauLB0tsqlsS1O6vspCUNpSTzqkclKntf+i1THefO527ss9J/+Cd3
	 qhCIf14mI/ppKK5Zizt26+D2wIhwZ6QysHATO0kljeGa9uQORDQXQA9xVMsXpzYms7
	 QA9x7saQbjSi6Ot1G2UfcuIWDaedteqMK6BpTGYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfBWV34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:29:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfBWVFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9129B20657;
        Sat, 23 Feb 2019 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955949;
        bh=PX0aLrAQBM2qO9O1wTnBJKJfIM3vZ/lJzWGGd9J2NFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LnuoJgFu+DJAzkVAnDT3JaxMLEdMXH5XXQ3KfcijhagGc3XYj2YKgxlVZNLdQFzA8
         mUgC/zv3aRfK9JlzkmC+2plOwRI4dsLzIYq0JqMAq6SJgNoA4GaPDqCNBL5yEP0cSq
         gcCQd/JapSz4xkHOyp5A3sgpi+2jsuaXQF/KwFKQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 54/72] x86/cpu: Add Atom Tremont (Jacobsville)
Date:   Sat, 23 Feb 2019 16:04:04 -0500
Message-Id: <20190223210422.199966-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 00ae831dfe4474ef6029558f5eb3ef0332d80043 ]

Add the Atom Tremont model number to the Intel family list.

[ Tony: Also update comment at head of file to say "_X" suffix is
  also used for microserver parts. ]

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Megha Dey <megha.dey@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190125195902.17109-4-tony.luck@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/intel-family.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0dd6b0f4000e8..d9a9993af882a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -6,7 +6,7 @@
  * "Big Core" Processors (Branded as Core, Xeon, etc...)
  *
  * The "_X" parts are generally the EP and EX Xeons, or the
- * "Extreme" ones, like Broadwell-E.
+ * "Extreme" ones, like Broadwell-E, or Atom microserver.
  *
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
@@ -71,6 +71,7 @@
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
+#define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
 
 /* Xeon Phi */
 
-- 
2.19.1

