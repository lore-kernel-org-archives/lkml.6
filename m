Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeESLrY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:47:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbeESLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:47:21 -0400
Date: Sat, 19 May 2018 04:47:10 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-icljqe87e8pak8mu6mkki9d4@git.kernel.org>
Cc: hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
        wangnan0@huawei.com, tglx@linutronix.de, adrian.hunter@intel.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        acme@redhat.com
Reply-To: jolsa@kernel.org, wangnan0@huawei.com, namhyung@kernel.org,
        hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Fixup include and examples install
 messages
Git-Commit-ID: cfc4033be77abcf5953bed2fd201100515fcb357
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cfc4033be77abcf5953bed2fd201100515fcb357
Gitweb:     https://git.kernel.org/tip/cfc4033be77abcf5953bed2fd201100515fcb357
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 17 May 2018 17:22:22 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 19 May 2018 06:42:50 -0300

perf bpf: Fixup include and examples install messages

Before:

  INSTALL  lib
install include/bpf/*.h '/home/acme/lib/include/perf/bpf'
  INSTALL  lib
install examples/bpf/*.c '/home/acme/lib/examples/perf/bpf'

After:

  INSTALL  lib
  INSTALL  include/bpf
  INSTALL  lib
  INSTALL  examples/bpf

Reported-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: dd8e4ead6e98 ("perf bpf: Add bpf.h to be used in eBPF proggies")
Fixes: 8f12a2ff00e5 ("perf bpf: Add 'examples' directories")
Link: https://lkml.kernel.org/n/tip-icljqe87e8pak8mu6mkki9d4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c63a3971d719..ecc9fc952655 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -770,9 +770,11 @@ endif
 ifndef NO_LIBBPF
 	$(call QUIET_INSTALL, lib) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, include/bpf) \
 		$(INSTALL) include/bpf/*.h '$(DESTDIR_SQ)$(perf_include_instdir_SQ)/bpf'
 	$(call QUIET_INSTALL, lib) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
+	$(call QUIET_INSTALL, examples/bpf) \
 		$(INSTALL) examples/bpf/*.c '$(DESTDIR_SQ)$(perf_examples_instdir_SQ)/bpf'
 endif
 	$(call QUIET_INSTALL, perf-archive) \
