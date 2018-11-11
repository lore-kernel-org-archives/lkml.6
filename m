Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524E6C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135CE20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135CE20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeKLGTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:19:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50502 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730434AbeKLFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:21 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsh-0000oF-La; Sun, 11 Nov 2018 19:58:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001rZ-9N; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Markos Chandras" <markos.chandras@imgtec.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.898610518@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 341/366] MIPS: asm: compiler: Add new macros to set
 ISA and arch asm annotations
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit be5136988e25ae0dc8379fcb937efc63d87aba9e upstream.

There are certain places where the code uses .set mips32 or .set mips64
or .set arch=r4000. In preparation of MIPS R6 support, and in order to
use as less #ifdefs as possible, we define new macros to set similar
annotations for MIPS R6.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
[bwh: Backported to 3.16: We don't support MIPS R6 but I have applied a
 commit that uses MIPS_ISA_LEVEL_RAW.  Add the R2 definitions only.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/compiler.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/arch/mips/include/asm/compiler.h
+++ b/arch/mips/include/asm/compiler.h
@@ -16,4 +16,10 @@
 #define GCC_REG_ACCUM "accum"
 #endif
 
+/* MIPS64 is a superset of MIPS32 */
+#define MIPS_ISA_LEVEL "mips64r2"
+#define MIPS_ISA_ARCH_LEVEL "arch=r4000"
+#define MIPS_ISA_LEVEL_RAW mips64r2
+#define MIPS_ISA_ARCH_LEVEL_RAW MIPS_ISA_LEVEL_RAW
+
 #endif /* _ASM_COMPILER_H */

