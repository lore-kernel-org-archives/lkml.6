Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C1AC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F3218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfAZKKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:10:51 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38309 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAZKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:10:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QAAGgX513815
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:10:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QAAF8s513812;
        Sat, 26 Jan 2019 02:10:15 -0800
Date:   Sat, 26 Jan 2019 02:10:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-h3q9rxxkbzetgnbro5rclqft@git.kernel.org>
Cc:     mingo@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com,
        adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org,
        yhs@fb.com, wangnan0@huawei.com, kafai@fb.com, tglx@linutronix.de,
        jolsa@kernel.org, acme@redhat.com
Reply-To: wangnan0@huawei.com, kafai@fb.com, tglx@linutronix.de,
          yhs@fb.com, jolsa@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          daniel@iogearbox.net, hpa@zytor.com, namhyung@kernel.org,
          lclaudio@redhat.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add bpf_map() helper
Git-Commit-ID: b45d5511aa9029264740e2353ad7faf3cd444703
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

Commit-ID:  b45d5511aa9029264740e2353ad7faf3cd444703
Gitweb:     https://git.kernel.org/tip/b45d5511aa9029264740e2353ad7faf3cd444703
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 Jan 2019 15:01:46 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf bpf: Add bpf_map() helper

To make the declaration of maps more compact, the following patches will
make use of it.

Standardizing on it will allow to add the BTF details, i.e.
BPF_ANNOTATE_KV_PAIR() (tools/testing/selftests/bpf/bpf_helpers.h)
transparently.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-h3q9rxxkbzetgnbro5rclqft@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index e667577207dc..0482028c1d11 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -18,6 +18,14 @@ struct bpf_map {
         unsigned int numa_node;
 };
 
+#define bpf_map(name, _type, type_key, type_val, _max_entries)	\
+struct bpf_map SEC("maps") name = {				\
+	.type	     = BPF_MAP_TYPE_##_type,			\
+	.key_size    = sizeof(type_key),			\
+	.value_size  = sizeof(type_val),			\
+	.max_entries = _max_entries,				\
+}
+
 /*
  * FIXME: this should receive .max_entries as a parameter, as careful
  *	  tuning of these limits is needed to avoid hitting limits that
