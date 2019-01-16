Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F177520840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfAPTbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:31:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfAPTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:31:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GJUtM3397585
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 11:30:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GJUs2r397582;
        Wed, 16 Jan 2019 11:30:54 -0800
Date:   Wed, 16 Jan 2019 11:30:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shirish S <tipbot@zytor.com>
Message-ID: <tip-c95b323dcd3598dd7ef5005d6723c1ba3b801093@git.kernel.org>
Cc:     tony.luck@intel.com, shirish.s@amd.com, bp@suse.de,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        mingo@redhat.com, x86@kernel.org, tglx@linutronix.de,
        Shirish.S@amd.com, hpa@zytor.com, mingo@kernel.org
Reply-To: Shirish.S@amd.com, tglx@linutronix.de, x86@kernel.org,
          mingo@kernel.org, hpa@zytor.com, bp@suse.de, shirish.s@amd.com,
          tony.luck@intel.com, mingo@redhat.com,
          linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
In-Reply-To: <1547106849-3476-2-git-send-email-shirish.s@amd.com>
References: <1547106849-3476-2-git-send-email-shirish.s@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE/AMD: Turn off MC4_MISC thresholding on all
 family 0x15 models
Git-Commit-ID: c95b323dcd3598dd7ef5005d6723c1ba3b801093
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

Commit-ID:  c95b323dcd3598dd7ef5005d6723c1ba3b801093
Gitweb:     https://git.kernel.org/tip/c95b323dcd3598dd7ef5005d6723c1ba3b801093
Author:     Shirish S <Shirish.S@amd.com>
AuthorDate: Thu, 10 Jan 2019 07:54:40 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 15 Jan 2019 18:11:38 +0100

x86/MCE/AMD: Turn off MC4_MISC thresholding on all family 0x15 models

MC4_MISC thresholding is not supported on all family 0x15 processors,
hence skip the x86_model check when applying the quirk.

 [ bp: massage commit message. ]

Signed-off-by: Shirish S <shirish.s@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1547106849-3476-2-git-send-email-shirish.s@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 672c7225cb1b..d0c54160b439 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1612,11 +1612,10 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 			mce_flags.overflow_recov = 1;
 
 		/*
-		 * Turn off MC4_MISC thresholding banks on those models since
+		 * Turn off MC4_MISC thresholding banks on all models since
 		 * they're not supported there.
 		 */
-		if (c->x86 == 0x15 &&
-		    (c->x86_model >= 0x10 && c->x86_model <= 0x1f)) {
+		if (c->x86 == 0x15) {
 			int i;
 			u64 hwcr;
 			bool need_toggle;
