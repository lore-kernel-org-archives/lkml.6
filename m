Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931CCC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5725120844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5725120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeIFRkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:40:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIFRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:40:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D58xl303140
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:05:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D58fJ303137;
        Thu, 6 Sep 2018 06:05:08 -0700
Date:   Thu, 6 Sep 2018 06:05:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0nvkyciqdkrgy829lony5925@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, wangnan0@huawei.com, dsahern@gmail.com,
        jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: wangnan0@huawei.com, dsahern@gmail.com, jolsa@kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Streamline bpf examples and headers
 installation
Git-Commit-ID: dad2762aac17eac01ea97779e78a061ed1b83b86
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

Commit-ID:  dad2762aac17eac01ea97779e78a061ed1b83b86
Gitweb:     https://git.kernel.org/tip/dad2762aac17eac01ea97779e78a061ed1b83b86
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 Aug 2018 17:31:52 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:49:25 -0300

perf tools: Streamline bpf examples and headers installation

We were emitting 4 lines, two of them misleading:

  make: Entering directory '/home/acme/git/perf/tools/perf'
  <SNIP>
    INSTALL  lib
    INSTALL  include/bpf
    INSTALL  lib
    INSTALL  examples/bpf
  <SNIP>
  make: Leaving directory '/home/acme/git/perf/tools/perf'

Make it more compact by showing just two lines:

  make: Entering directory '/home/acme/git/perf/tools/perf'
    INSTALL  bpf-headers
    INSTALL  bpf-examples
  make: Leaving directory '/home/acme/git/perf/tools/perf'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0nvkyciqdkrgy829lony5925@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b3d1b12a5081..5224ade3d5af 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -777,14 +777,12 @@ endif
 	$(call QUIET_INSTALL, libexec) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 ifndef NO_LIBBPF
-	$(call QUIET_INSTALL, lib) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, include/bpf) \
-		$(INSTALL) include/bpf/*.h '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, lib) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
-	$(call QUIET_INSTALL, examples/bpf) \
-		$(INSTALL) examples/bpf/*.c '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, bpf-headers) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
+		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, bpf-examples) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
+		$(INSTALL) examples/bpf/*.c -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
 endif
 	$(call QUIET_INSTALL, perf-archive) \
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
