Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB99CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B792075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B792075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeIFRzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:55:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:55:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DJSC7305486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:19:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DJSC2305483;
        Thu, 6 Sep 2018 06:19:28 -0700
Date:   Thu, 6 Sep 2018 06:19:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-cl1xyghwb1usp500354mv37h@git.kernel.org>
Cc:     wangnan0@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com
Reply-To: dsahern@gmail.com, tglx@linutronix.de, acme@redhat.com,
          wangnan0@huawei.com, mingo@kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace augmented_syscalls: Rename
 augmented_*_syscall__enter to just *_syscall
Git-Commit-ID: 4c8f0a726ef808244788a237e52ce3c612bff8c3
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

Commit-ID:  4c8f0a726ef808244788a237e52ce3c612bff8c3
Gitweb:     https://git.kernel.org/tip/4c8f0a726ef808244788a237e52ce3c612bff8c3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 30 Aug 2018 11:50:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf trace augmented_syscalls: Rename augmented_*_syscall__enter to just *_syscall

As we'll also hook into the syscalls:sys_exit_SYSCALL for which there
are enter hooks.

This way we'll be able to iterate the ELF file for the eBPF program,
find the syscalls that have hooks and filter them out from the general
raw_syscalls:sys_{enter,exit} tracepoint for not-yet-augmented (the ones
with pointer arguments not yet being attached to the usual syscalls
tracepoint payload) and non augmentable syscalls (syscalls without
pointer arguments).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cl1xyghwb1usp500354mv37h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index bfa28eaf27b3..253b3ccbd17d 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -32,7 +32,7 @@ struct augmented_filename {
 	char	value[256];
 };
 
-#define augmented_filename_syscall_enter(syscall)						\
+#define augmented_filename_syscall(syscall)							\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct augmented_filename		filename;				 	\
@@ -60,7 +60,7 @@ struct syscall_enter_openat_args {
 	long		   mode;
 };
 
-augmented_filename_syscall_enter(openat);
+augmented_filename_syscall(openat);
 
 struct syscall_enter_open_args {
 	unsigned long long common_tp_fields;
@@ -70,7 +70,7 @@ struct syscall_enter_open_args {
 	long		   mode;
 };
 
-augmented_filename_syscall_enter(open);
+augmented_filename_syscall(open);
 
 struct syscall_enter_inotify_add_watch_args {
 	unsigned long long common_tp_fields;
@@ -80,7 +80,7 @@ struct syscall_enter_inotify_add_watch_args {
 	long		   mask;
 };
 
-augmented_filename_syscall_enter(inotify_add_watch);
+augmented_filename_syscall(inotify_add_watch);
 
 struct statbuf;
 
@@ -91,13 +91,13 @@ struct syscall_enter_newstat_args {
 	struct stat	   *statbuf;
 };
 
-augmented_filename_syscall_enter(newstat);
+augmented_filename_syscall(newstat);
 
 #ifndef _K_SS_MAXSIZE
 #define _K_SS_MAXSIZE 128
 #endif
 
-#define augmented_sockaddr_syscall_enter(syscall)						\
+#define augmented_sockaddr_syscall(syscall)						\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct sockaddr_storage			addr;						\
@@ -128,7 +128,7 @@ struct syscall_enter_bind_args {
 	unsigned long	   addrlen;
 };
 
-augmented_sockaddr_syscall_enter(bind);
+augmented_sockaddr_syscall(bind);
 
 struct syscall_enter_connect_args {
 	unsigned long long common_tp_fields;
@@ -138,7 +138,7 @@ struct syscall_enter_connect_args {
 	unsigned long	   addrlen;
 };
 
-augmented_sockaddr_syscall_enter(connect);
+augmented_sockaddr_syscall(connect);
 
 struct syscall_enter_sendto_args {
 	unsigned long long common_tp_fields;
@@ -151,6 +151,6 @@ struct syscall_enter_sendto_args {
 	long		   addr_len;
 };
 
-augmented_sockaddr_syscall_enter(sendto);
+augmented_sockaddr_syscall(sendto);
 
 license(GPL);
