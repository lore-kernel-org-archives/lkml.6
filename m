Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20822C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405E21871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519646;
	bh=lP4hGtVKzOOYYFlJyLlPKJUPTD7RBLnkxDod7jusCo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kqzgjqyBZ3BvuygoMKzZwmXqQ4FmjQDgXFucEZskaFIMGawCAkma1mkHn3QiJlDzC
	 vr1eXhxpmJ6xZbhkc5pP1Xwcg/Rgg6yaNfihjhi2JsxqkMGqXgkZz25pJtD8DD/GUg
	 HxNIrcHbEqX85MF2QG1bvmDhHCiPCAfuIfk7rAms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfACMrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730661AbfACMrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:22 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB34221872;
        Thu,  3 Jan 2019 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519641;
        bh=lP4hGtVKzOOYYFlJyLlPKJUPTD7RBLnkxDod7jusCo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U40Mywl3BJ9MG9CppEb9mLwKANtiV67MGRPlfpQsZMbQARv/KgviHYt2ChoYPRQJn
         dKYv+pFX+vbDsBSU7eFv9PjI7mRmT04wHFsBC6PB2OAqwH4W7oJztrz738nmO4oM7V
         6JUipITZKJHBceRjzfzt15pqbwkDC5g4KVHNjwSQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herton Krzesinski <herton@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/29] tools power turbostat: Override CFLAGS assignments and add LDFLAGS to build command
Date:   Thu,  3 Jan 2019 09:46:00 -0300
Message-Id: <20190103124609.29672-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that the user can specify outside CFLAGS/LDFLAGS values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Link: http://lkml.kernel.org/r/20181212102537.25902-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/power/x86/turbostat/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 2ab25aa38263..1598b4fa0b11 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -9,13 +9,13 @@ ifeq ("$(origin O)", "command line")
 endif
 
 turbostat : turbostat.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
-CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
-- 
2.19.2

