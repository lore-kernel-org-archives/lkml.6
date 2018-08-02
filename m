Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A9C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E597A2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E597A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeHBKGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:06:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbeHBKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:06:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728GHCk3431735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:16:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728GHn93431731;
        Thu, 2 Aug 2018 01:16:17 -0700
Date:   Thu, 2 Aug 2018 01:16:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wi44iid0yjfht3lcvplc75fm@git.kernel.org>
Cc:     namhyung@kernel.org, wangnan0@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        acme@redhat.com, dsahern@gmail.com, adrian.hunter@intel.com,
        jolsa@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, wangnan0@huawei.com,
          namhyung@kernel.org, hpa@zytor.com, dsahern@gmail.com,
          acme@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Show better message when failing to load
 an object
Git-Commit-ID: 739e2edc848af30fefa66d6c422c00ca9a701c06
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

Commit-ID:  739e2edc848af30fefa66d6c422c00ca9a701c06
Gitweb:     https://git.kernel.org/tip/739e2edc848af30fefa66d6c422c00ca9a701c06
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 31 Jul 2018 11:58:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 11:58:57 -0300

perf bpf: Show better message when failing to load an object

Before:

  libbpf: license of tools/perf/examples/bpf/etcsnoop.c is GPL
  libbpf: section(6) version, size 4, link 0, flags 3, type=1
  libbpf: kernel version of tools/perf/examples/bpf/etcsnoop.c is 41200
  libbpf: section(7) .symtab, size 120, link 1, flags 0, type=2
  bpf: config program 'syscalls:sys_enter_openat'
  libbpf: load bpf program failed: Operation not permitted
  libbpf: failed to load program 'syscalls:sys_enter_openat'
  libbpf: failed to load object 'tools/perf/examples/bpf/etcsnoop.c'
  bpf: load objects failed

After: (just the last line changes)

  bpf: load objects failed: err=-4009: (Incorrect kernel version)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wi44iid0yjfht3lcvplc75fm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index cee658733e2c..3d02ae38ec56 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -747,7 +747,9 @@ int bpf__load(struct bpf_object *obj)
 
 	err = bpf_object__load(obj);
 	if (err) {
-		pr_debug("bpf: load objects failed\n");
+		char bf[128];
+		libbpf_strerror(err, bf, sizeof(bf));
+		pr_debug("bpf: load objects failed: err=%d: (%s)\n", err, bf);
 		return err;
 	}
 	return 0;
