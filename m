Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334C0C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE51F2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKJEDFVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE51F2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeLDLSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:18:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeLDLFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415642154B;
        Tue,  4 Dec 2018 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921502;
        bh=f2krCO6Bwl+jQxo6X75vj32nZy3FddXYIOkYkewyk3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKJEDFVOQtLfx5SVX2Ix6qy5YIgtI8wL10OOdYAxERsUG6esuiDAC6WQ+cOstCNiV
         Ot/TnHvPC5gHay/R/6MR720TtlXDLcLRCk0HAQqTRhhDspiC26WyXH2GzXUmNdus8+
         +tMQ6YHh/KpgbpFhjIqiKor3CmVQ/OuGhXB4lcQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 095/146] x86/speculation: Unify conditional spectre v2 print functions
Date:   Tue,  4 Dec 2018 11:49:41 +0100
Message-Id: <20181204103730.646854830@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner tglx@linutronix.de

commit 495d470e9828500e0155027f230449ac5e29c025 upstream

There is no point in having two functions and a conditional at the call
site.

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
Link: https://lkml.kernel.org/r/20181125185004.986890749@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -256,15 +256,9 @@ static const struct {
 	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 };
 
-static void __init spec2_print_if_insecure(const char *reason)
+static void __init spec_v2_print_cond(const char *reason, bool secure)
 {
-	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s selected on command line.\n", reason);
-}
-
-static void __init spec2_print_if_secure(const char *reason)
-{
-	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
+	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
 		pr_info("%s selected on command line.\n", reason);
 }
 
@@ -307,11 +301,8 @@ static enum spectre_v2_mitigation_cmd __
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (mitigation_options[i].secure)
-		spec2_print_if_secure(mitigation_options[i].option);
-	else
-		spec2_print_if_insecure(mitigation_options[i].option);
-
+	spec_v2_print_cond(mitigation_options[i].option,
+			   mitigation_options[i].secure);
 	return cmd;
 }
 


