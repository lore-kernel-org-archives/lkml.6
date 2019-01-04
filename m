Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D43C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F0B218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626852;
	bh=vrqFA8cagMrVrYsEazhEmsniDJQ01E0bt+5cwaUlGl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tkJopcMmO0u28LeCqbBJ2CBdOmN/5FuGG5vVBLliLI/2nSk0/Ivv44O+KO48zriA1
	 qK0wBN4ptr8Q43nFtM3LGPg+9YIxliYO8G9VouYt0DdI93wIOwBDPMRaSjI298+uKa
	 cbaDXut+4jIGlRuWeiWF15bZWKRzazmLQ17ztWts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfADSeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbfADSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:06 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4EB218E2;
        Fri,  4 Jan 2019 18:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626845;
        bh=vrqFA8cagMrVrYsEazhEmsniDJQ01E0bt+5cwaUlGl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cq9AnozUSSp4wHsKgyb2pS+XH5CAMrsH64Mfu+/Fez60Ms1rJm0ZxY5O964oXeClk
         PP4ALS7VzTLP55NMhWSi8Ct6+xElFLuSXX/Ukhl5wrfEI+I8b71xlgWDsRgotORD7Q
         4h8CYPBPXTKzP3b1jFSlX57jurvK+gKj9pOrlWpA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 02/16] tools headers x86: Sync disabled-features.h
Date:   Fri,  4 Jan 2019 15:33:23 -0300
Message-Id: <20190104183337.12771-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To silence the following tools/perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h

Picking up the changes in dae0a1059300 ("x86/cpufeatures, x86/fault:
Mark SMAP as disabled when configured out") that didn't entail any
functionality change in the tooling side.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vvge5xh6ii12oszexqknbgwp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/disabled-features.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 33833d1909af..a5ea841cc6d2 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -16,6 +16,12 @@
 # define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
 #endif
 
+#ifdef CONFIG_X86_SMAP
+# define DISABLE_SMAP	0
+#else
+# define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
+#endif
+
 #ifdef CONFIG_X86_INTEL_UMIP
 # define DISABLE_UMIP	0
 #else
@@ -68,7 +74,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX)
+#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
-- 
2.20.1

