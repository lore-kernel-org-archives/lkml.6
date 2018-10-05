Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D96520875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D96520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeJFDlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbeJFDlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EFF3530832EE;
        Fri,  5 Oct 2018 20:41:01 +0000 (UTC)
Received: from localhost (ovpn-117-52.phx2.redhat.com [10.3.117.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 871262010D59;
        Fri,  5 Oct 2018 20:41:01 +0000 (UTC)
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf: Make clang_has_option() work on Python 3
Date:   Fri,  5 Oct 2018 17:40:57 -0300
Message-Id: <20181005204058.7966-2-ehabkost@redhat.com>
In-Reply-To: <20181005204058.7966-1-ehabkost@redhat.com>
References: <20181005204058.7966-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 05 Oct 2018 20:41:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a bytes literal so it works with Python 3's version of
Popen().  Note that the b"..." syntax requires Python 2.6+.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tools/perf/util/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 1942f6dd24f6..261a55e7e1b2 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -5,7 +5,7 @@ from subprocess import Popen, PIPE
 from re import sub
 
 def clang_has_option(option):
-    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if "unknown argument" in o] == [ ]
+    return [o for o in Popen(['clang', option], stderr=PIPE).stderr.readlines() if b"unknown argument" in o] == [ ]
 
 cc = getenv("CC")
 if cc == "clang":
-- 
2.18.0.rc1.1.g3f1ff2140

