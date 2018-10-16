Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D451C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6CF208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6CF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJPW6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:58:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPW6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:58:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48B615277B;
        Tue, 16 Oct 2018 15:07:13 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08C1558901;
        Tue, 16 Oct 2018 15:07:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     "Signed-off-by : Len Brown" <len.brown@intel.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 05/10] tools power x86_energy_perf_policy: Override CFLAGS assignments and add LDFLAGS to build command
Date:   Tue, 16 Oct 2018 17:06:10 +0200
Message-Id: <20181016150614.21260-6-jolsa@kernel.org>
In-Reply-To: <20181016150614.21260-1-jolsa@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 16 Oct 2018 15:07:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So user could specify outside CFLAGS/LDFLAGS values.

Cc: Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

