Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F06C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A497920C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A497920C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJIMr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:47:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37219 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeJIMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:47:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995W6h5910334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:32:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995W59W910331;
        Mon, 8 Oct 2018 22:32:05 -0700
Date:   Mon, 8 Oct 2018 22:32:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eduardo Habkost <tipbot@zytor.com>
Message-ID: <tip-e13a5d69c31d35538e80176d54d95b6addf4dcbf@git.kernel.org>
Cc:     ehabkost@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
        adrian.hunter@intel.com
Reply-To: dsahern@gmail.com, jolsa@kernel.org, tglx@linutronix.de,
          acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
          mingo@kernel.org, ehabkost@redhat.com, namhyung@kernel.org,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20181005204058.7966-2-ehabkost@redhat.com>
References: <20181005204058.7966-2-ehabkost@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: Make clang_has_option() work on Python
 3
Git-Commit-ID: e13a5d69c31d35538e80176d54d95b6addf4dcbf
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

Commit-ID:  e13a5d69c31d35538e80176d54d95b6addf4dcbf
Gitweb:     https://git.kernel.org/tip/e13a5d69c31d35538e80176d54d95b6addf4dcbf
Author:     Eduardo Habkost <ehabkost@redhat.com>
AuthorDate: Fri, 5 Oct 2018 17:40:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:30:44 -0300

perf python: Make clang_has_option() work on Python 3

Use a bytes literal so it works with Python 3's version of Popen().
Note that the b"..." syntax requires Python 2.6+.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181005204058.7966-2-ehabkost@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
