Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B6DC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961E720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeFTAeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:34:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeFTAeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:34:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0XvZY3300744
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:33:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0XuqL3300741;
        Tue, 19 Jun 2018 17:33:56 -0700
Date:   Tue, 19 Jun 2018 17:33:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-684fb246578b9e81fc7b4ca5c71eae22edb650b2@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mka@chromium.org,
        hpa@zytor.com, mingo@kernel.org, jpoimboe@redhat.com
Reply-To: linux-kernel@vger.kernel.org, mka@chromium.org,
          tglx@linutronix.de, mingo@kernel.org, jpoimboe@redhat.com,
          hpa@zytor.com
In-Reply-To: <791712792aa4431bdd55bf1beb33a169ddf3b4a2.1529423255.git.jpoimboe@redhat.com>
References: <791712792aa4431bdd55bf1beb33a169ddf3b4a2.1529423255.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Add machine_real_restart() to the
 noreturn list
Git-Commit-ID: 684fb246578b9e81fc7b4ca5c71eae22edb650b2
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

Commit-ID:  684fb246578b9e81fc7b4ca5c71eae22edb650b2
Gitweb:     https://git.kernel.org/tip/684fb246578b9e81fc7b4ca5c71eae22edb650b2
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Tue, 19 Jun 2018 10:47:50 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 02:10:37 +0200

objtool: Add machine_real_restart() to the noreturn list

machine_real_restart() is annotated as '__noreturn", so add it to the
objtool noreturn list.  This fixes the following warning with clang and
CONFIG_CC_OPTIMIZE_FOR_SIZE=y:

  arch/x86/kernel/reboot.o: warning: objtool: native_machine_emergency_restart() falls through to next function machine_power_off()

Reported-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Link: https://lkml.kernel.org/r/791712792aa4431bdd55bf1beb33a169ddf3b4a2.1529423255.git.jpoimboe@redhat.com

---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 38047c6aa575..f4a25bd1871f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -164,6 +164,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"fortify_panic",
 		"usercopy_abort",
+		"machine_real_restart",
 	};
 
 	if (func->bind == STB_WEAK)
