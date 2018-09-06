Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C5AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6D9206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6D9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeIFRtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:49:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeIFRtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:49:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DE0SO304617
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:14:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DDxHh304614;
        Thu, 6 Sep 2018 06:13:59 -0700
Date:   Thu, 6 Sep 2018 06:13:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yhzarcvsjue8pgpvkjhqgioc@git.kernel.org>
Cc:     adrian.hunter@intel.com, namhyung@kernel.org, dsahern@gmail.com,
        hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        wangnan0@huawei.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
          namhyung@kernel.org, dsahern@gmail.com, mingo@kernel.org,
          wangnan0@huawei.com, tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add linux/socket.h to the headers
 accessible to bpf proggies
Git-Commit-ID: 403f833d15a33bfd8e50dd79fa8e25fb4aa132f6
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

Commit-ID:  403f833d15a33bfd8e50dd79fa8e25fb4aa132f6
Gitweb:     https://git.kernel.org/tip/403f833d15a33bfd8e50dd79fa8e25fb4aa132f6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 Aug 2018 17:41:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf bpf: Add linux/socket.h to the headers accessible to bpf proggies

So that we don't have to define sockaddr_storage in the
augmented_syscalls.c bpf example when hooking into syscalls needing it,
idea is to mimic the system headers. Eventually we probably need to have
sys/socket.h, etc.  Start by having at least linux/socket.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yhzarcvsjue8pgpvkjhqgioc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf                                | 4 +++-
 {include/uapi => tools/perf/include/bpf}/linux/socket.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5224ade3d5af..92514fb3689f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -779,7 +779,9 @@ endif
 ifndef NO_LIBBPF
 	$(call QUIET_INSTALL, bpf-headers) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
-		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'; \
+		$(INSTALL) include/bpf/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'; \
+		$(INSTALL) include/bpf/linux/*.h -t '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf/linux'
 	$(call QUIET_INSTALL, bpf-examples) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'; \
 		$(INSTALL) examples/bpf/*.c -t '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
diff --git a/include/uapi/linux/socket.h b/tools/perf/include/bpf/linux/socket.h
similarity index 94%
copy from include/uapi/linux/socket.h
copy to tools/perf/include/bpf/linux/socket.h
index 8eb96021709c..7f844568dab8 100644
--- a/include/uapi/linux/socket.h
+++ b/tools/perf/include/bpf/linux/socket.h
@@ -19,4 +19,6 @@ struct __kernel_sockaddr_storage {
 				/* _SS_MAXSIZE value minus size of ss_family */
 } __attribute__ ((aligned(_K_SS_ALIGNSIZE)));	/* force desired alignment */
 
+#define sockaddr_storage __kernel_sockaddr_storage
+
 #endif /* _UAPI_LINUX_SOCKET_H */
