Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4791CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D07217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519607;
	bh=LY/u1JmV+Gz9J96frir/ckQPcm127Fhja/ZJwIGa7dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qqh5EgrEKGd69p0WuQRkPK7th8iRpNdXZSJMNfnAgAwBozeV+5U3lRAuodSZfotl1
	 yjXdn4fF7pxlwkqAjunuP1j1A+0g4Dmjr+jESmjefQKvIyUhwtkNmEG4DsEU3Iaoj9
	 1DC3G5UYa3u6ahf94mcP6pC8TJvxtu5CXQf//sRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfACMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731149AbfACMqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:42 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 321E22070D;
        Thu,  3 Jan 2019 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519601;
        bh=LY/u1JmV+Gz9J96frir/ckQPcm127Fhja/ZJwIGa7dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVHc9WVOC+Xj/0WsqcBbLYMnJiE9c/eSy0fEF7iXhWRG0/auxuSPglN1vUIKJpfjJ
         Oh4F1p11Et6tDcU2bVgM310VKVDTcr85373vrvXUE5JUD2S0ZA4ud9/kbXHTfabY8C
         FPLmzXEsT+KcEPUmwKzj7XU6LQA51cfvafT5gBDU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/29] perf trace: Rename thread_thread->paths to thread_trace->files
Date:   Thu,  3 Jan 2019 09:45:48 -0300
Message-Id: <20190103124609.29672-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can add more per file attributes besides the pathname, such
as which ioctl beautifier to use, for cases such as the sound and
usbdeffs ioctls, that both use the 'U' command, so we have to
differentiate at the major number for the device file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1895cmhrdz2dkl5prf2cj2yj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 42 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1e9e886b2811..d4bca74f282c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -957,6 +957,10 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 	return printed + fprintf(fp, "): ");
 }
 
+struct file {
+	char *pathname;
+};
+
 /**
  * filename.ptr: The filename char pointer that will be vfs_getname'd
  * filename.entry_str_pos: Where to insert the string translated from
@@ -980,9 +984,9 @@ struct thread_trace {
 		char	      *name;
 	} filename;
 	struct {
-		int	  max;
-		char	  **table;
-	} paths;
+		int	      max;
+		struct file   *table;
+	} files;
 
 	struct intlist *syscall_stats;
 };
@@ -992,7 +996,7 @@ static struct thread_trace *thread_trace__new(void)
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
 	if (ttrace)
-		ttrace->paths.max = -1;
+		ttrace->files.max = -1;
 
 	ttrace->syscall_stats = intlist__new(NULL);
 
@@ -1040,26 +1044,26 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 {
 	struct thread_trace *ttrace = thread__priv(thread);
 
-	if (fd > ttrace->paths.max) {
-		char **npath = realloc(ttrace->paths.table, (fd + 1) * sizeof(char *));
+	if (fd > ttrace->files.max) {
+		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
-		if (npath == NULL)
+		if (nfiles == NULL)
 			return -1;
 
-		if (ttrace->paths.max != -1) {
-			memset(npath + ttrace->paths.max + 1, 0,
-			       (fd - ttrace->paths.max) * sizeof(char *));
+		if (ttrace->files.max != -1) {
+			memset(nfiles + ttrace->files.max + 1, 0,
+			       (fd - ttrace->files.max) * sizeof(struct file));
 		} else {
-			memset(npath, 0, (fd + 1) * sizeof(char *));
+			memset(nfiles, 0, (fd + 1) * sizeof(struct file));
 		}
 
-		ttrace->paths.table = npath;
-		ttrace->paths.max   = fd;
+		ttrace->files.table = nfiles;
+		ttrace->files.max   = fd;
 	}
 
-	ttrace->paths.table[fd] = strdup(pathname);
+	ttrace->files.table[fd].pathname = strdup(pathname);
 
-	return ttrace->paths.table[fd] != NULL ? 0 : -1;
+	return ttrace->files.table[fd].pathname != NULL ? 0 : -1;
 }
 
 static int thread__read_fd_path(struct thread *thread, int fd)
@@ -1099,7 +1103,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 	if (fd < 0)
 		return NULL;
 
-	if ((fd > ttrace->paths.max || ttrace->paths.table[fd] == NULL)) {
+	if ((fd > ttrace->files.max || ttrace->files.table[fd].pathname == NULL)) {
 		if (!trace->live)
 			return NULL;
 		++trace->stats.proc_getname;
@@ -1107,7 +1111,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 			return NULL;
 	}
 
-	return ttrace->paths.table[fd];
+	return ttrace->files.table[fd].pathname;
 }
 
 size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
@@ -1146,8 +1150,8 @@ static size_t syscall_arg__scnprintf_close_fd(char *bf, size_t size,
 	size_t printed = syscall_arg__scnprintf_fd(bf, size, arg);
 	struct thread_trace *ttrace = thread__priv(arg->thread);
 
-	if (ttrace && fd >= 0 && fd <= ttrace->paths.max)
-		zfree(&ttrace->paths.table[fd]);
+	if (ttrace && fd >= 0 && fd <= ttrace->files.max)
+		zfree(&ttrace->files.table[fd].pathname);
 
 	return printed;
 }
-- 
2.19.2

