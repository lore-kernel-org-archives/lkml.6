Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D445FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAC02070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519638;
	bh=8+7Szf4BjGmVRwKPTvgw3ZJjQ7fakZBGjBGOP8FxlpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Y6tCWd5evArDovgLS+XfSE+dX7sFpJVv2Bpxek0oWRL7761TJApCgKaLPm0orF/g
	 GvbdhtSpx6a1Du1pSoLTwv0iw+p8BMhZHGTYO6I4xJZTVL1b8QFgDt5idJkLi5iid9
	 iHfzDOFRLTbpLKIhmbOLMfAWUREa7qhyHg8xVbbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfACMrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731536AbfACMrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:15 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2FCB217D9;
        Thu,  3 Jan 2019 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519635;
        bh=8+7Szf4BjGmVRwKPTvgw3ZJjQ7fakZBGjBGOP8FxlpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Ht++tqHutqV5nVMvKt62X+ycKFiKi+DYjJYjLYVHAZd5qoBSY0RFUYPbMyyLa7y3
         eNCTv1wG9cOdvuNVz0gpFcnPt+bb2ePbj4CVCdjObGW5YSxhfQpjO1/eKRfPbEyj67
         kfJHiztlRME1HyvGcSZkHAEck8le5FqwIEZbXVKc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Herton Krzesinski <herton@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/29] tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
Date:   Thu,  3 Jan 2019 09:45:58 -0300
Message-Id: <20190103124609.29672-19-acme@kernel.org>
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

So user could specify outside CFLAGS/LDFLAGS values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Herton Krzesinski <herton@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Link: https://lkml.kernel.org/r/20181212102537.25902-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/power/x86/x86_energy_perf_policy/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index f4534fb8b951..ae7a0e09b722 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -9,12 +9,12 @@ ifeq ("$(origin O)", "command line")
 endif
 
 x86_energy_perf_policy : x86_energy_perf_policy.c
-CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+override CFLAGS +=	-Wall
+override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
-	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
+	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
 
 .PHONY : clean
 clean :
-- 
2.19.2

