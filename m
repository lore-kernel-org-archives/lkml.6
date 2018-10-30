Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EC7C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37A22080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37A22080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeJaERW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:17:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:23873 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeJaERT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:17:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="103876721"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 12:22:34 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v4 01/18] x86/speculation: Clean up spectre_v2_parse_cmdline()
Date:   Tue, 30 Oct 2018 11:49:08 -0700
Message-Id: <fc5b88cf55fe685ec45044c906da9d0c526ff686.1540923609.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary else statement in spectre_v2_parse_cmdline()
to save a indentation level.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fe32103..bbda9b6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -283,22 +283,21 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
 		return SPECTRE_V2_CMD_NONE;
-	else {
-		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
-		if (ret < 0)
-			return SPECTRE_V2_CMD_AUTO;
 
-		for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
-			if (!match_option(arg, ret, mitigation_options[i].option))
-				continue;
-			cmd = mitigation_options[i].cmd;
-			break;
-		}
+	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
+	if (ret < 0)
+		return SPECTRE_V2_CMD_AUTO;
 
-		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPECTRE_V2_CMD_AUTO;
-		}
+	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
+		if (!match_option(arg, ret, mitigation_options[i].option))
+			continue;
+		cmd = mitigation_options[i].cmd;
+		break;
+	}
+
+	if (i >= ARRAY_SIZE(mitigation_options)) {
+		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
+		return SPECTRE_V2_CMD_AUTO;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
-- 
2.9.4

