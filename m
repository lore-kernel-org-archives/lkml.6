Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E68C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3EF218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbeLTSWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:22:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47507 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbeLTSWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:22:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIMcKe3684032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:22:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIMb3S3684029;
        Thu, 20 Dec 2018 10:22:37 -0800
Date:   Thu, 20 Dec 2018 10:22:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zypczc88gzbmeqx7b372s138@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        lclaudio@redhat.com, namhyung@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, namhyung@kernel.org, lclaudio@redhat.com,
          hpa@zytor.com, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add a prefix member to the strarray
 class
Git-Commit-ID: 2e3d7fac9db5e80d1cc26bb1453b85245c26d657
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

Commit-ID:  2e3d7fac9db5e80d1cc26bb1453b85245c26d657
Gitweb:     https://git.kernel.org/tip/2e3d7fac9db5e80d1cc26bb1453b85245c26d657
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 15:08:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:07:42 -0300

perf trace: Add a prefix member to the strarray class

So that the user, in an upcoming patch, can select printing it to get
the full string as used in the source code, not one with a common prefix
chopped off so as to make the output more compact.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zypczc88gzbmeqx7b372s138@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c            | 21 +++++++++++----------
 tools/perf/trace/beauty/beauty.h      |  7 +++++--
 tools/perf/trace/beauty/fcntl.c       |  2 +-
 tools/perf/trace/beauty/ioctl.c       | 16 ++++++++--------
 tools/perf/trace/beauty/kcmp.c        |  2 +-
 tools/perf/trace/beauty/mmap.c        |  4 ++--
 tools/perf/trace/beauty/mount_flags.c |  2 +-
 tools/perf/trace/beauty/pkey_alloc.c  |  2 +-
 tools/perf/trace/beauty/prctl.c       |  4 ++--
 tools/perf/trace/beauty/renameat.c    |  2 +-
 tools/perf/trace/beauty/sockaddr.c    |  2 +-
 tools/perf/trace/beauty/socket.c      |  2 +-
 12 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index dc8cadeb3fa5..02bc5da5cfa7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -423,6 +423,7 @@ static size_t syscall_arg__scnprintf_fd_at(char *bf, size_t size,
 					   struct syscall_arg *arg)
 {
 	int fd = arg->val;
+	/* char fd_at_prefix = "AT_FD"; */
 
 	if (fd == AT_FDCWD)
 		return scnprintf(bf, size, "CWD");
@@ -456,13 +457,13 @@ static const char *bpf_cmd[] = {
 	"MAP_CREATE", "MAP_LOOKUP_ELEM", "MAP_UPDATE_ELEM", "MAP_DELETE_ELEM",
 	"MAP_GET_NEXT_KEY", "PROG_LOAD",
 };
-static DEFINE_STRARRAY(bpf_cmd);
+static DEFINE_STRARRAY(bpf_cmd, "BPF_");
 
 static const char *epoll_ctl_ops[] = { "ADD", "DEL", "MOD", };
-static DEFINE_STRARRAY_OFFSET(epoll_ctl_ops, 1);
+static DEFINE_STRARRAY_OFFSET(epoll_ctl_ops, "EPOLL_CTL_", 1);
 
 static const char *itimers[] = { "REAL", "VIRTUAL", "PROF", };
-static DEFINE_STRARRAY(itimers);
+static DEFINE_STRARRAY(itimers, "ITIMER_");
 
 static const char *keyctl_options[] = {
 	"GET_KEYRING_ID", "JOIN_SESSION_KEYRING", "UPDATE", "REVOKE", "CHOWN",
@@ -471,7 +472,7 @@ static const char *keyctl_options[] = {
 	"ASSUME_AUTHORITY", "GET_SECURITY", "SESSION_TO_PARENT", "REJECT",
 	"INSTANTIATE_IOV", "INVALIDATE", "GET_PERSISTENT",
 };
-static DEFINE_STRARRAY(keyctl_options);
+static DEFINE_STRARRAY(keyctl_options, "KEYCTL_");
 
 static const char *whences[] = { "SET", "CUR", "END",
 #ifdef SEEK_DATA
@@ -481,7 +482,7 @@ static const char *whences[] = { "SET", "CUR", "END",
 "HOLE",
 #endif
 };
-static DEFINE_STRARRAY(whences);
+static DEFINE_STRARRAY(whences, "SEEK_");
 
 static const char *fcntl_cmds[] = {
 	"DUPFD", "GETFD", "SETFD", "GETFL", "SETFL", "GETLK", "SETLK",
@@ -489,7 +490,7 @@ static const char *fcntl_cmds[] = {
 	"SETLK64", "SETLKW64", "SETOWN_EX", "GETOWN_EX",
 	"GETOWNER_UIDS",
 };
-static DEFINE_STRARRAY(fcntl_cmds);
+static DEFINE_STRARRAY(fcntl_cmds, "F_");
 
 static const char *fcntl_linux_specific_cmds[] = {
 	"SETLEASE", "GETLEASE", "NOTIFY", [5] =	"CANCELLK", "DUPFD_CLOEXEC",
@@ -497,7 +498,7 @@ static const char *fcntl_linux_specific_cmds[] = {
 	"GET_RW_HINT", "SET_RW_HINT", "GET_FILE_RW_HINT", "SET_FILE_RW_HINT",
 };
 
-static DEFINE_STRARRAY_OFFSET(fcntl_linux_specific_cmds, F_LINUX_SPECIFIC_BASE);
+static DEFINE_STRARRAY_OFFSET(fcntl_linux_specific_cmds, "F_", F_LINUX_SPECIFIC_BASE);
 
 static struct strarray *fcntl_cmds_arrays[] = {
 	&strarray__fcntl_cmds,
@@ -511,17 +512,17 @@ static const char *rlimit_resources[] = {
 	"MEMLOCK", "AS", "LOCKS", "SIGPENDING", "MSGQUEUE", "NICE", "RTPRIO",
 	"RTTIME",
 };
-static DEFINE_STRARRAY(rlimit_resources);
+static DEFINE_STRARRAY(rlimit_resources, "RLIMIT_");
 
 static const char *sighow[] = { "BLOCK", "UNBLOCK", "SETMASK", };
-static DEFINE_STRARRAY(sighow);
+static DEFINE_STRARRAY(sighow, "SIG_");
 
 static const char *clockid[] = {
 	"REALTIME", "MONOTONIC", "PROCESS_CPUTIME_ID", "THREAD_CPUTIME_ID",
 	"MONOTONIC_RAW", "REALTIME_COARSE", "MONOTONIC_COARSE", "BOOTTIME",
 	"REALTIME_ALARM", "BOOTTIME_ALARM", "SGI_CYCLE", "TAI"
 };
-static DEFINE_STRARRAY(clockid);
+static DEFINE_STRARRAY(clockid, "CLOCK_");
 
 static size_t syscall_arg__scnprintf_access_mode(char *bf, size_t size,
 						 struct syscall_arg *arg)
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 48ff3ce05325..452e9c006d4f 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -9,18 +9,21 @@
 struct strarray {
 	int	    offset;
 	int	    nr_entries;
+	const char *prefix;
 	const char **entries;
 };
 
-#define DEFINE_STRARRAY(array) struct strarray strarray__##array = { \
+#define DEFINE_STRARRAY(array, _prefix) struct strarray strarray__##array = { \
 	.nr_entries = ARRAY_SIZE(array), \
 	.entries = array, \
+	.prefix = _prefix, \
 }
 
-#define DEFINE_STRARRAY_OFFSET(array, off) struct strarray strarray__##array = { \
+#define DEFINE_STRARRAY_OFFSET(array, _prefix, off) struct strarray strarray__##array = { \
 	.offset	    = off, \
 	.nr_entries = ARRAY_SIZE(array), \
 	.entries = array, \
+	.prefix = _prefix, \
 }
 
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, int val);
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index e6de31674e24..15d669087e0a 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -22,7 +22,7 @@ static size_t syscall_arg__scnprintf_fcntl_getfd(char *bf, size_t size, struct s
 static size_t fcntl__scnprintf_getlease(unsigned long val, char *bf, size_t size)
 {
 	static const char *fcntl_setlease[] = { "RDLCK", "WRLCK", "UNLCK", };
-	static DEFINE_STRARRAY(fcntl_setlease);
+	static DEFINE_STRARRAY(fcntl_setlease, "F_");
 
 	return strarray__scnprintf(&strarray__fcntl_setlease, bf, size, "%x", val);
 }
diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index eae59ad15ce3..ea243f6167d7 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -36,7 +36,7 @@ static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 	"TIOCSERGWILD", "TIOCSERSWILD", "TIOCGLCKTRMIOS", "TIOCSLCKTRMIOS",
 	"TIOCSERGSTRUCT", "TIOCSERGETLSR", "TIOCSERGETMULTI", "TIOCSERSETMULTI",
 	"TIOCMIWAIT", "TIOCGICOUNT", };
-	static DEFINE_STRARRAY(ioctl_tty_cmd);
+	static DEFINE_STRARRAY(ioctl_tty_cmd, "");
 
 	if (nr < strarray__ioctl_tty_cmd.nr_entries && strarray__ioctl_tty_cmd.entries[nr] != NULL)
 		return scnprintf(bf, size, "%s", strarray__ioctl_tty_cmd.entries[nr]);
@@ -47,7 +47,7 @@ static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 static size_t ioctl__scnprintf_drm_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/drm_ioctl_array.c"
-	static DEFINE_STRARRAY(drm_ioctl_cmds);
+	static DEFINE_STRARRAY(drm_ioctl_cmds, "");
 
 	if (nr < strarray__drm_ioctl_cmds.nr_entries && strarray__drm_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "DRM_%s", strarray__drm_ioctl_cmds.entries[nr]);
@@ -58,7 +58,7 @@ static size_t ioctl__scnprintf_drm_cmd(int nr, int dir, char *bf, size_t size)
 static size_t ioctl__scnprintf_sndrv_pcm_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/sndrv_pcm_ioctl_array.c"
-	static DEFINE_STRARRAY(sndrv_pcm_ioctl_cmds);
+	static DEFINE_STRARRAY(sndrv_pcm_ioctl_cmds, "");
 
 	if (nr < strarray__sndrv_pcm_ioctl_cmds.nr_entries && strarray__sndrv_pcm_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "SNDRV_PCM_%s", strarray__sndrv_pcm_ioctl_cmds.entries[nr]);
@@ -69,7 +69,7 @@ static size_t ioctl__scnprintf_sndrv_pcm_cmd(int nr, int dir, char *bf, size_t s
 static size_t ioctl__scnprintf_sndrv_ctl_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/sndrv_ctl_ioctl_array.c"
-	static DEFINE_STRARRAY(sndrv_ctl_ioctl_cmds);
+	static DEFINE_STRARRAY(sndrv_ctl_ioctl_cmds, "");
 
 	if (nr < strarray__sndrv_ctl_ioctl_cmds.nr_entries && strarray__sndrv_ctl_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "SNDRV_CTL_%s", strarray__sndrv_ctl_ioctl_cmds.entries[nr]);
@@ -80,7 +80,7 @@ static size_t ioctl__scnprintf_sndrv_ctl_cmd(int nr, int dir, char *bf, size_t s
 static size_t ioctl__scnprintf_kvm_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/kvm_ioctl_array.c"
-	static DEFINE_STRARRAY(kvm_ioctl_cmds);
+	static DEFINE_STRARRAY(kvm_ioctl_cmds, "");
 
 	if (nr < strarray__kvm_ioctl_cmds.nr_entries && strarray__kvm_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "KVM_%s", strarray__kvm_ioctl_cmds.entries[nr]);
@@ -91,8 +91,8 @@ static size_t ioctl__scnprintf_kvm_cmd(int nr, int dir, char *bf, size_t size)
 static size_t ioctl__scnprintf_vhost_virtio_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c"
-	static DEFINE_STRARRAY(vhost_virtio_ioctl_cmds);
-	static DEFINE_STRARRAY(vhost_virtio_ioctl_read_cmds);
+	static DEFINE_STRARRAY(vhost_virtio_ioctl_cmds, "");
+	static DEFINE_STRARRAY(vhost_virtio_ioctl_read_cmds, "");
 	struct strarray *s = (dir & _IOC_READ) ? &strarray__vhost_virtio_ioctl_read_cmds : &strarray__vhost_virtio_ioctl_cmds;
 
 	if (nr < s->nr_entries && s->entries[nr] != NULL)
@@ -104,7 +104,7 @@ static size_t ioctl__scnprintf_vhost_virtio_cmd(int nr, int dir, char *bf, size_
 static size_t ioctl__scnprintf_perf_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/perf_ioctl_array.c"
-	static DEFINE_STRARRAY(perf_ioctl_cmds);
+	static DEFINE_STRARRAY(perf_ioctl_cmds, "");
 
 	if (nr < strarray__perf_ioctl_cmds.nr_entries && strarray__perf_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "PERF_%s", strarray__perf_ioctl_cmds.entries[nr]);
diff --git a/tools/perf/trace/beauty/kcmp.c b/tools/perf/trace/beauty/kcmp.c
index b276a274f203..56f1e50a6012 100644
--- a/tools/perf/trace/beauty/kcmp.c
+++ b/tools/perf/trace/beauty/kcmp.c
@@ -28,7 +28,7 @@ size_t syscall_arg__scnprintf_kcmp_idx(char *bf, size_t size, struct syscall_arg
 
 static size_t kcmp__scnprintf_type(int type, char *bf, size_t size)
 {
-	static DEFINE_STRARRAY(kcmp_types);
+	static DEFINE_STRARRAY(kcmp_types, "KCMP_");
 	return strarray__scnprintf(&strarray__kcmp_types, bf, size, "%d", type);
 }
 
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index c534bd96ef5c..1a7bd716057a 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -34,7 +34,7 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 {
 #include "trace/beauty/generated/mmap_flags_array.c"
-       static DEFINE_STRARRAY(mmap_flags);
+       static DEFINE_STRARRAY(mmap_flags, "MAP_");
 
        return strarray__scnprintf_flags(&strarray__mmap_flags, bf, size, flags);
 }
@@ -78,7 +78,7 @@ static size_t syscall_arg__scnprintf_mremap_flags(char *bf, size_t size,
 static size_t madvise__scnprintf_behavior(int behavior, char *bf, size_t size)
 {
 #include "trace/beauty/generated/madvise_behavior_array.c"
-       static DEFINE_STRARRAY(madvise_advices);
+       static DEFINE_STRARRAY(madvise_advices, "MADV_");
 
        if (behavior < strarray__madvise_advices.nr_entries && strarray__madvise_advices.entries[behavior] != NULL)
                return scnprintf(bf, size, "MADV_%s", strarray__madvise_advices.entries[behavior]);
diff --git a/tools/perf/trace/beauty/mount_flags.c b/tools/perf/trace/beauty/mount_flags.c
index 712935c6620a..7129106bf797 100644
--- a/tools/perf/trace/beauty/mount_flags.c
+++ b/tools/perf/trace/beauty/mount_flags.c
@@ -14,7 +14,7 @@
 static size_t mount__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 {
 #include "trace/beauty/generated/mount_flags_array.c"
-	static DEFINE_STRARRAY(mount_flags);
+	static DEFINE_STRARRAY(mount_flags, "MS_");
 
 	return strarray__scnprintf_flags(&strarray__mount_flags, bf, size, flags);
 }
diff --git a/tools/perf/trace/beauty/pkey_alloc.c b/tools/perf/trace/beauty/pkey_alloc.c
index 1b8ed4cac815..f4818e05a48b 100644
--- a/tools/perf/trace/beauty/pkey_alloc.c
+++ b/tools/perf/trace/beauty/pkey_alloc.c
@@ -41,7 +41,7 @@ size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, uns
 static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, size_t size)
 {
 #include "trace/beauty/generated/pkey_alloc_access_rights_array.c"
-	static DEFINE_STRARRAY(pkey_alloc_access_rights);
+	static DEFINE_STRARRAY(pkey_alloc_access_rights, "PKEY_");
 
 	return strarray__scnprintf_flags(&strarray__pkey_alloc_access_rights, bf, size, access_rights);
 }
diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
index be7a5d395975..7b6466b0856d 100644
--- a/tools/perf/trace/beauty/prctl.c
+++ b/tools/perf/trace/beauty/prctl.c
@@ -13,13 +13,13 @@
 
 static size_t prctl__scnprintf_option(int option, char *bf, size_t size)
 {
-	static DEFINE_STRARRAY(prctl_options);
+	static DEFINE_STRARRAY(prctl_options, "PR_");
 	return strarray__scnprintf(&strarray__prctl_options, bf, size, "%d", option);
 }
 
 static size_t prctl__scnprintf_set_mm(int option, char *bf, size_t size)
 {
-	static DEFINE_STRARRAY(prctl_set_mm_options);
+	static DEFINE_STRARRAY(prctl_set_mm_options, "PR_SET_MM_");
 	return strarray__scnprintf(&strarray__prctl_set_mm_options, bf, size, "%d", option);
 }
 
diff --git a/tools/perf/trace/beauty/renameat.c b/tools/perf/trace/beauty/renameat.c
index 02c7207faee6..910695aff979 100644
--- a/tools/perf/trace/beauty/renameat.c
+++ b/tools/perf/trace/beauty/renameat.c
@@ -7,7 +7,7 @@
 static size_t renameat2__scnprintf_flags(unsigned long flags, char *bf, size_t size)
 {
 #include "trace/beauty/generated/rename_flags_array.c"
-       static DEFINE_STRARRAY(rename_flags);
+       static DEFINE_STRARRAY(rename_flags, "RENAME_");
 
        return strarray__scnprintf_flags(&strarray__rename_flags, bf, size, flags);
 }
diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index 9410ad230f10..95cc82a9967f 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -15,7 +15,7 @@ static const char *socket_families[] = {
 	"BLUETOOTH", "IUCV", "RXRPC", "ISDN", "PHONET", "IEEE802154", "CAIF",
 	"ALG", "NFC", "VSOCK",
 };
-DEFINE_STRARRAY(socket_families);
+DEFINE_STRARRAY(socket_families, "PF_");
 
 static size_t af_inet__scnprintf(struct sockaddr *sa, char *bf, size_t size)
 {
diff --git a/tools/perf/trace/beauty/socket.c b/tools/perf/trace/beauty/socket.c
index d971a2596417..eacbfb930fe4 100644
--- a/tools/perf/trace/beauty/socket.c
+++ b/tools/perf/trace/beauty/socket.c
@@ -12,7 +12,7 @@
 static size_t socket__scnprintf_ipproto(int protocol, char *bf, size_t size)
 {
 #include "trace/beauty/generated/socket_ipproto_array.c"
-	static DEFINE_STRARRAY(socket_ipproto);
+	static DEFINE_STRARRAY(socket_ipproto, "IPPROTO_");
 
 	return strarray__scnprintf(&strarray__socket_ipproto, bf, size, "%d", protocol);
 }
