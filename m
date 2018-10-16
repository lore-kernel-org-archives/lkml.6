Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F0CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EC72089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EC72089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeJPW5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPW5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:57:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68794CA1D8;
        Tue, 16 Oct 2018 15:06:52 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2DF15890E;
        Tue, 16 Oct 2018 15:06:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: [PATCH 03/10] tools cpupower debug: Allow to use outside build flags
Date:   Tue, 16 Oct 2018 17:06:08 +0200
Message-Id: <20181016150614.21260-4-jolsa@kernel.org>
In-Reply-To: <20181016150614.21260-1-jolsa@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 16 Oct 2018 15:06:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CFLAGS and LDFLAGS to be used during the build.

Cc: Thomas Renninger <trenn@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/power/cpupower/debug/x86_64/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/debug/x86_64/Makefile b/tools/power/cpupower/debug/x86_64/Makefile
index 59af84b8ef45..b1b6c43644e7 100644
--- a/tools/power/cpupower/debug/x86_64/Makefile
+++ b/tools/power/cpupower/debug/x86_64/Makefile
@@ -13,10 +13,10 @@ INSTALL = /usr/bin/install
 default: all
 
 $(OUTPUT)centrino-decode: ../i386/centrino-decode.c
-	$(CC) $(CFLAGS) -o $@ $<
+	$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $<
 
 $(OUTPUT)powernow-k8-decode: ../i386/powernow-k8-decode.c
-	$(CC) $(CFLAGS) -o $@ $<
+	$(CC) $(CFLAGS) -o $@ $(LDFLAGS) $<
 
 all: $(OUTPUT)centrino-decode $(OUTPUT)powernow-k8-decode
 
-- 
2.17.2

