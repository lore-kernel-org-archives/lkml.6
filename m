Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5gxNO1dBGVtmbAAAmS7hNA
	; Thu, 07 Jun 2018 14:30:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7B643608CF; Thu,  7 Jun 2018 14:30:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D96DE607DC;
	Thu,  7 Jun 2018 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D96DE607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933778AbeFGOaY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:30:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933062AbeFGOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:10 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0005hJ-FF; Thu, 07 Jun 2018 15:09:08 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-000367-26; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Michael Weiser" <michael.weiser@gmx.de>,
        "Will Deacon" <will.deacon@arm.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.180616774@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 268/410] arm64: Disable unhandled signal log messages
 by default
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

From: Michael Weiser <michael.weiser@gmx.de>

commit 5ee39a71fd89ab7240c5339d04161c44a8e03269 upstream.

aarch64 unhandled signal kernel messages are very verbose, suggesting
them to be more of a debugging aid:

sigsegv[33]: unhandled level 2 translation fault (11) at 0x00000000, esr
0x92000046, in sigsegv[400000+71000]
CPU: 1 PID: 33 Comm: sigsegv Tainted: G        W        4.15.0-rc3+ #3
Hardware name: linux,dummy-virt (DT)
pstate: 60000000 (nZCv daif -PAN -UAO)
pc : 0x4003f4
lr : 0x4006bc
sp : 0000fffffe94a060
x29: 0000fffffe94a070 x28: 0000000000000000
x27: 0000000000000000 x26: 0000000000000000
x25: 0000000000000000 x24: 00000000004001b0
x23: 0000000000486ac8 x22: 00000000004001c8
x21: 0000000000000000 x20: 0000000000400be8
x19: 0000000000400b30 x18: 0000000000484728
x17: 000000000865ffc8 x16: 000000000000270f
x15: 00000000000000b0 x14: 0000000000000002
x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0008000020008008
x9 : 000000000000000f x8 : ffffffffffffffff
x7 : 0004000000000000 x6 : ffffffffffffffff
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 00000000004003e4 x2 : 0000fffffe94a1e8
x1 : 000000000000000a x0 : 0000000000000000

Disable them by default, so they can be enabled using
/proc/sys/debug/exception-trace.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -45,7 +45,7 @@ static const char *handler[]= {
 	"Error"
 };
 
-int show_unhandled_signals = 1;
+int show_unhandled_signals = 0;
 
 static void dump_backtrace_entry(unsigned long where, unsigned long stack)
 {
