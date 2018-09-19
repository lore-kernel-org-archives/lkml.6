Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF683ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E67F2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E67F2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbeISRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:15:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbeISRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:15:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8JBaroL1145279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Sep 2018 04:36:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8JBaqq21145276;
        Wed, 19 Sep 2018 04:36:52 -0700
Date:   Wed, 19 Sep 2018 04:36:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6d41907c630d3196be89c9ed5a7f8258486b3eaf@git.kernel.org>
Cc:     dsahern@gmail.com, tmricht@linux.ibm.com, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, yhs@fb.com, wangnan0@huawei.com,
        kafai@fb.com, daniel@iogearbox.net, jolsa@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org,
        quentin.monnet@netronome.com, ast@kernel.org,
        brueckner@linux.ibm.com, jakub.kicinski@netronome.com
Reply-To: adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, yhs@fb.com,
          dsahern@gmail.com, tmricht@linux.ibm.com,
          jakub.kicinski@netronome.com, wangnan0@huawei.com,
          tglx@linutronix.de, kafai@fb.com, jolsa@kernel.org,
          daniel@iogearbox.net, ast@kernel.org,
          quentin.monnet@netronome.com, namhyung@kernel.org,
          brueckner@linux.ibm.com
In-Reply-To: <20180917151636.GA21790@kernel.org>
References: <20180917151636.GA21790@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib bpf: Provide wrapper for strerror_r to
 build in !_GNU_SOURCE systems
Git-Commit-ID: 6d41907c630d3196be89c9ed5a7f8258486b3eaf
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

Commit-ID:  6d41907c630d3196be89c9ed5a7f8258486b3eaf
Gitweb:     https://git.kernel.org/tip/6d41907c630d3196be89c9ed5a7f8258486b3eaf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Sep 2018 16:47:14 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Sep 2018 10:16:18 -0300

tools lib bpf: Provide wrapper for strerror_r to build in !_GNU_SOURCE systems

Same problem that got fixed in a similar fashion in tools/perf/ in
c8b5f2c96d1b ("tools: Introduce str_error_r()"), fix it in the same
way, licensing needs to be sorted out to libbpf to use libapi, so,
for this simple case, just get the same wrapper in tools/lib/bpf.

This makes libbpf and its users (bpftool, selftests, perf) to build
again in Alpine Linux 3.[45678] and edge.

Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: 1ce6a9fc1549 ("bpf: fix build error in libbpf with EXTRA_CFLAGS="-Wp, -D_FORTIFY_SOURCE=2 -O2"")
Link: https://lkml.kernel.org/r/20180917151636.GA21790@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/Build       |  2 +-
 tools/lib/bpf/libbpf.c    | 20 ++++++++++----------
 tools/lib/bpf/str_error.c | 18 ++++++++++++++++++
 tools/lib/bpf/str_error.h |  6 ++++++
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index 13a861135127..6eb9bacd1948 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1 +1 @@
-libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o
+libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2abd0f112627..bdb94939fd60 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -50,6 +50,7 @@
 #include "libbpf.h"
 #include "bpf.h"
 #include "btf.h"
+#include "str_error.h"
 
 #ifndef EM_BPF
 #define EM_BPF 247
@@ -469,7 +470,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 		obj->efile.fd = open(obj->path, O_RDONLY);
 		if (obj->efile.fd < 0) {
 			char errmsg[STRERR_BUFSIZE];
-			char *cp = strerror_r(errno, errmsg, sizeof(errmsg));
+			char *cp = str_error(errno, errmsg, sizeof(errmsg));
 
 			pr_warning("failed to open %s: %s\n", obj->path, cp);
 			return -errno;
@@ -810,8 +811,7 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 						      data->d_size, name, idx);
 			if (err) {
 				char errmsg[STRERR_BUFSIZE];
-				char *cp = strerror_r(-err, errmsg,
-						      sizeof(errmsg));
+				char *cp = str_error(-err, errmsg, sizeof(errmsg));
 
 				pr_warning("failed to alloc program %s (%s): %s",
 					   name, obj->path, cp);
@@ -1140,7 +1140,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 
 		*pfd = bpf_create_map_xattr(&create_attr);
 		if (*pfd < 0 && create_attr.btf_key_type_id) {
-			cp = strerror_r(errno, errmsg, sizeof(errmsg));
+			cp = str_error(errno, errmsg, sizeof(errmsg));
 			pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
 				   map->name, cp, errno);
 			create_attr.btf_fd = 0;
@@ -1155,7 +1155,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 			size_t j;
 
 			err = *pfd;
-			cp = strerror_r(errno, errmsg, sizeof(errmsg));
+			cp = str_error(errno, errmsg, sizeof(errmsg));
 			pr_warning("failed to create map (name: '%s'): %s\n",
 				   map->name, cp);
 			for (j = 0; j < i; j++)
@@ -1339,7 +1339,7 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 	}
 
 	ret = -LIBBPF_ERRNO__LOAD;
-	cp = strerror_r(errno, errmsg, sizeof(errmsg));
+	cp = str_error(errno, errmsg, sizeof(errmsg));
 	pr_warning("load bpf program failed: %s\n", cp);
 
 	if (log_buf && log_buf[0] != '\0') {
@@ -1654,7 +1654,7 @@ static int check_path(const char *path)
 
 	dir = dirname(dname);
 	if (statfs(dir, &st_fs)) {
-		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		cp = str_error(errno, errmsg, sizeof(errmsg));
 		pr_warning("failed to statfs %s: %s\n", dir, cp);
 		err = -errno;
 	}
@@ -1690,7 +1690,7 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 	}
 
 	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
-		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		cp = str_error(errno, errmsg, sizeof(errmsg));
 		pr_warning("failed to pin program: %s\n", cp);
 		return -errno;
 	}
@@ -1708,7 +1708,7 @@ static int make_dir(const char *path)
 		err = -errno;
 
 	if (err) {
-		cp = strerror_r(-err, errmsg, sizeof(errmsg));
+		cp = str_error(-err, errmsg, sizeof(errmsg));
 		pr_warning("failed to mkdir %s: %s\n", path, cp);
 	}
 	return err;
@@ -1770,7 +1770,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 	}
 
 	if (bpf_obj_pin(map->fd, path)) {
-		cp = strerror_r(errno, errmsg, sizeof(errmsg));
+		cp = str_error(errno, errmsg, sizeof(errmsg));
 		pr_warning("failed to pin map: %s\n", cp);
 		return -errno;
 	}
diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
new file mode 100644
index 000000000000..b8798114a357
--- /dev/null
+++ b/tools/lib/bpf/str_error.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: LGPL-2.1
+#undef _GNU_SOURCE
+#include <string.h>
+#include <stdio.h>
+#include "str_error.h"
+
+/*
+ * Wrapper to allow for building in non-GNU systems such as Alpine Linux's musl
+ * libc, while checking strerror_r() return to avoid having to check this in
+ * all places calling it.
+ */
+char *str_error(int err, char *dst, int len)
+{
+	int ret = strerror_r(err, dst, len);
+	if (ret)
+		snprintf(dst, len, "ERROR: strerror_r(%d)=%d", err, ret);
+	return dst;
+}
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
new file mode 100644
index 000000000000..355b1db571d1
--- /dev/null
+++ b/tools/lib/bpf/str_error.h
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: LGPL-2.1
+#ifndef BPF_STR_ERROR
+#define BPF_STR_ERROR
+
+char *str_error(int err, char *dst, int len);
+#endif // BPF_STR_ERROR
