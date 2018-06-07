Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id T4f6MzJSGVvVFQAAmS7hNA
	; Thu, 07 Jun 2018 15:41:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5402A6089E; Thu,  7 Jun 2018 15:41:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A05416074D;
	Thu,  7 Jun 2018 15:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A05416074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbeFGPlt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:41:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40599 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934608AbeFGOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:41:38 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbz-0005Zn-UZ; Thu, 07 Jun 2018 15:10:00 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002jF-Gh; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>, "Len Brown" <lenb@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Dave Hansen" <dave@sr71.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.386119095@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 039/410] x86/cpu: Rename "WESTMERE2" family to
 "NEHALEM_G"
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 4b3b234f434d440fcd749b9636131b76e2ce561e upstream.

Len Brown noticed something was amiss in our INTEL_FAM6_*
definitions.  It seems like model 0x1F was a Nehalem part,
marketed as "Intel Core i7 and i5 Processors" (according to the
SDM).  But, although it was a Nehalem 0x1F had some uncore events
which were shared with Westmere.

Len also mentioned he thought it was called "Havendale", which
Wikipedia says was graphics-oriented and canceled:

	https://en.wikipedia.org/wiki/Nehalem_(microarchitecture)

So either way, it's probably not imporant what we call it, but
call it Nehalem to be accurate, and add a "G" since it seems
graphics-related.  If it were canceled that would be a good reason
why it's so sparsely and inconsistently referred to in the code.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Hansen <dave@sr71.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20160629192737.949C41A8@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: drop changes in intel_idle.c]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/intel-family.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -18,10 +18,10 @@
 #define INTEL_FAM6_CORE2_DUNNINGTON	0x1D
 
 #define INTEL_FAM6_NEHALEM		0x1E
+#define INTEL_FAM6_NEHALEM_G		0x1F /* Auburndale / Havendale */
 #define INTEL_FAM6_NEHALEM_EP		0x1A
 #define INTEL_FAM6_NEHALEM_EX		0x2E
 #define INTEL_FAM6_WESTMERE		0x25
-#define INTEL_FAM6_WESTMERE2		0x1F
 #define INTEL_FAM6_WESTMERE_EP		0x2C
 #define INTEL_FAM6_WESTMERE_EX		0x2F
 
