Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29982081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29982081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeK2BcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:32:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeK2BcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:32:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wASESRpa2323191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Nov 2018 06:28:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wASESQZr2323188;
        Wed, 28 Nov 2018 06:28:26 -0800
Date:   Wed, 28 Nov 2018 06:28:26 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-30ba72a990f5096ae08f284de17986461efcc408@git.kernel.org>
Cc:     aarcange@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, tim.c.chen@linux.intel.com,
        asit.k.mallick@intel.com, dave.hansen@intel.com, luto@kernel.org,
        jkosina@suse.cz, tglx@linutronix.de, arjan@linux.intel.com,
        longman9394@gmail.com, casey.schaufler@intel.com, mingo@kernel.org,
        hpa@zytor.com, thomas.lendacky@amd.com, jpoimboe@redhat.com,
        ak@linux.intel.com, david.c.stewart@intel.com,
        torvalds@linux-foundation.org, jcm@redhat.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        dwmw@amazon.co.uk
Reply-To: casey.schaufler@intel.com, mingo@kernel.org,
          longman9394@gmail.com, arjan@linux.intel.com, hpa@zytor.com,
          thomas.lendacky@amd.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, keescook@chromium.org,
          jcm@redhat.com, dwmw@amazon.co.uk, torvalds@linux-foundation.org,
          ak@linux.intel.com, david.c.stewart@intel.com,
          jpoimboe@redhat.com, tim.c.chen@linux.intel.com,
          aarcange@redhat.com, peterz@infradead.org,
          gregkh@linuxfoundation.org, asit.k.mallick@intel.com,
          jkosina@suse.cz, dave.hansen@intel.com, luto@kernel.org
In-Reply-To: <20181125185004.893886356@linutronix.de>
References: <20181125185004.893886356@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculataion: Mark command line parser data
 __initdata
Git-Commit-ID: 30ba72a990f5096ae08f284de17986461efcc408
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

Commit-ID:  30ba72a990f5096ae08f284de17986461efcc408
Gitweb:     https://git.kernel.org/tip/30ba72a990f5096ae08f284de17986461efcc408
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 25 Nov 2018 19:33:43 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Nov 2018 11:57:09 +0100

x86/speculataion: Mark command line parser data __initdata

No point to keep that around.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Casey Schaufler <casey.schaufler@intel.com>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Waiman Long <longman9394@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dave Stewart <david.c.stewart@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181125185004.893886356@linutronix.de

---
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4fcbccb16200..9279cbabe16e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -248,7 +248,7 @@ static const struct {
 	const char *option;
 	enum spectre_v2_mitigation_cmd cmd;
 	bool secure;
-} mitigation_options[] = {
+} mitigation_options[] __initdata = {
 	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
 	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
 	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
@@ -486,7 +486,7 @@ static const char * const ssb_strings[] = {
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
-} ssb_mitigation_options[] = {
+} ssb_mitigation_options[]  __initdata = {
 	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
 	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
 	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
