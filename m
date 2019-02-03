Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F164C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1544121907
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfBCOFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:05:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52802 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727843AbfBCNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0003ti-3t; Sun, 03 Feb 2019 13:49:39 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9T-0006nA-CG; Sun, 03 Feb 2019 14:49:39 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        linux-mm@kvack.org, "Ingo Molnar" <mingo@redhat.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Konrad Wilk" <konrad.wilk@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Wenkuan Wang" <Wenkuan.Wang@windriver.com>,
        "Robert Elliot" <elliott@hpe.com>,
        "Borislav Petkov" <bp@alien8.de>, "Toshi Kani" <toshi.kani@hpe.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.355567159@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 002/305] x86/asm: Move PUD_PAGE macros to page_types.h
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit 832102671855f73962e7a04fdafd48b9385ea5c6 upstream.

PUD_SHIFT is defined according to a given kernel configuration, which
allows it be commonly used by any x86 kernels.  However, PUD_PAGE_SIZE
and PUD_PAGE_MASK, which are set from PUD_SHIFT, are defined in
page_64_types.h, which can be used by 64-bit kernel only.

Move PUD_PAGE_SIZE and PUD_PAGE_MASK to page_types.h so that they can
be used by any x86 kernels as well.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Konrad Wilk <konrad.wilk@oracle.com>
Cc: Robert Elliot <elliott@hpe.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/1442514264-12475-3-git-send-email-toshi.kani@hpe.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Wenkuan Wang <Wenkuan.Wang@windriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/page_64_types.h | 3 ---
 arch/x86/include/asm/page_types.h    | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -20,9 +20,6 @@
 #define MCE_STACK 4
 #define N_EXCEPTION_STACKS 4  /* hw limit: 7 */
 
-#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
-#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
-
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
  * PGDIR_SIZE*16 (pgd slot 272).  The gap is to allow a space for a
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -20,6 +20,9 @@
 #define PMD_PAGE_SIZE		(_AC(1, UL) << PMD_SHIFT)
 #define PMD_PAGE_MASK		(~(PMD_PAGE_SIZE-1))
 
+#define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
+#define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
+
 #define HPAGE_SHIFT		PMD_SHIFT
 #define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1))

