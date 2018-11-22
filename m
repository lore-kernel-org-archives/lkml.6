Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D547EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BA120831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BA120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392381AbeKVRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:45:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbeKVRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:45:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM77Blk3691313
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:07:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM77BM23691310;
        Wed, 21 Nov 2018 23:07:11 -0800
Date:   Wed, 21 Nov 2018 23:07:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c3tu5yg204p5mvr9kvwew07n@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, namhyung@kernel.org, dsahern@gmail.com,
        jolsa@kernel.org, hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          jolsa@kernel.org, hpa@zytor.com, dsahern@gmail.com,
          namhyung@kernel.org, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Remove example hardcoded
 set of filtered pids
Git-Commit-ID: e312747b49d382584aaa62398952832765e28f74
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

Commit-ID:  e312747b49d382584aaa62398952832765e28f74
Gitweb:     https://git.kernel.org/tip/e312747b49d382584aaa62398952832765e28f74
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 7 Nov 2018 10:09:41 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf augmented_syscalls: Remove example hardcoded set of filtered pids

Now that 'perf trace' fills in that "filtered_pids" BPF map, remove the
set of filtered pids used as an example to test that feature.

That feature works like this:

Starting a system wide 'strace' like 'perf trace' augmented session we
noticed that lots of events take place for a pid, which ends up being
the feedback loop of perf trace's syscalls being processed by the
'gnome-terminal' process:

  # perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c
     0.391 ( 0.002 ms): gnome-terminal/2469 read(fd: 17</dev/ptmx>, buf: 0x564b79f750bc, count: 8176) = 453
     0.394 ( 0.001 ms): gnome-terminal/2469 read(fd: 17</dev/ptmx>, buf: 0x564b79f75280, count: 7724) = -1 EAGAIN Resource temporarily unavailable
     0.438 ( 0.001 ms): gnome-terminal/2469 read(fd: 4<anon_inode:[eventfd]>, buf: 0x7fffc696aeb0, count: 16) = 8
     0.519 ( 0.001 ms): gnome-terminal/2469 read(fd: 17</dev/ptmx>, buf: 0x564b79f75280, count: 7724) = 114
     0.522 ( 0.001 ms): gnome-terminal/2469 read(fd: 17</dev/ptmx>, buf: 0x564b79f752f1, count: 7611) = -1 EAGAIN Resource temporarily unavailable
  ^C

So we can use --filter-pids to get rid of that one, and in this case what is
being used to implement that functionality is that "filtered_pids" BPF map that
the tools/perf/examples/bpf/augmented_raw_syscalls.c created and that 'perf trace'
bpf loader noticed and created a "struct bpf_map" associated that then got populated
by 'perf trace':

  # perf trace --filter-pids 2469 -e tools/perf/examples/bpf/augmented_raw_syscalls.c
     0.020 ( 0.002 ms): gnome-shell/1663 epoll_pwait(epfd: 12<anon_inode:[eventpoll]>, events: 0x7ffd8f3ef960, maxevents: 32, sigsetsize: 8) = 1
     0.025 ( 0.002 ms): gnome-shell/1663 read(fd: 24</dev/input/event4>, buf: 0x560c01bb8240, count: 8112) = 48
     0.029 ( 0.001 ms): gnome-shell/1663 read(fd: 24</dev/input/event4>, buf: 0x560c01bb8258, count: 8088) = -1 EAGAIN Resource temporarily unavailable
     0.032 ( 0.001 ms): gnome-shell/1663 read(fd: 24</dev/input/event4>, buf: 0x560c01bb8240, count: 8112) = -1 EAGAIN Resource temporarily unavailable
     0.040 ( 0.003 ms): gnome-shell/1663 recvmsg(fd: 46<socket:[35893]>, msg: 0x7ffd8f3ef950) = -1 EAGAIN Resource temporarily unavailable
    21.529 ( 0.002 ms): gnome-shell/1663 epoll_pwait(epfd: 5<anon_inode:[eventpoll]>, events: 0x7ffd8f3ef960, maxevents: 32, sigsetsize: 8) = 1
    21.533 ( 0.004 ms): gnome-shell/1663 recvmsg(fd: 82<socket:[42826]>, msg: 0x7ffd8f3ef7b0, flags: DONTWAIT|CMSG_CLOEXEC) = 236
    21.581 ( 0.006 ms): gnome-shell/1663 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_BUSY, arg: 0x7ffd8f3ef060) = 0
    21.605 ( 0.020 ms): gnome-shell/1663 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_CREATE, arg: 0x7ffd8f3eeea0) = 0
    21.626 ( 0.119 ms): gnome-shell/1663 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_SET_DOMAIN, arg: 0x7ffd8f3eee94) = 0
    21.746 ( 0.081 ms): gnome-shell/1663 ioctl(fd: 8</dev/dri/card0>, cmd: DRM_I915_GEM_PWRITE, arg: 0x7ffd8f3eeea0) = 0
  ^C

Oops, yet another gnome process that is involved with the output that
'perf trace' generates, lets filter that out too:

  # perf trace --filter-pids 2469,1663 -e tools/perf/examples/bpf/augmented_raw_syscalls.c
         ? (         ): wpa_supplicant/1366  ... [continued]: select()) = 0 Timeout
     0.006 ( 0.002 ms): wpa_supplicant/1366 clock_gettime(which_clock: BOOTTIME, tp: 0x7fffe5b1e430) = 0
     0.011 ( 0.001 ms): wpa_supplicant/1366 clock_gettime(which_clock: BOOTTIME, tp: 0x7fffe5b1e3e0) = 0
     0.014 ( 0.001 ms): wpa_supplicant/1366 clock_gettime(which_clock: BOOTTIME, tp: 0x7fffe5b1e430) = 0
         ? (         ): gmain/1791  ... [continued]: poll()) = 0 Timeout
     0.017 (         ): wpa_supplicant/1366 select(n: 6, inp: 0x55646fed3ad0, outp: 0x55646fed3b60, exp: 0x55646fed3bf0, tvp: 0x7fffe5b1e4a0) ...
   157.879 ( 0.019 ms): gmain/1791 inotify_add_watch(fd: 8<anon_inode:inotify>, pathname: , mask: 16789454) = -1 ENOENT No such file or directory
         ? (         ): cupsd/1001  ... [continued]: epoll_pwait()) = 0
         ? (         ): gsd-color/1908  ... [continued]: poll()) = 0 Timeout
   499.615 (         ): cupsd/1001 epoll_pwait(epfd: 4<anon_inode:[eventpoll]>, events: 0x557a21166500, maxevents: 4096, timeout: 1000, sigsetsize: 8) ...
   586.593 ( 0.004 ms): gsd-color/1908 recvmsg(fd: 3<socket:[38074]>, msg: 0x7ffdef34e800) = -1 EAGAIN Resource temporarily unavailable
         ? (         ): fwupd/2230  ... [continued]: poll()) = 0 Timeout
         ? (         ): rtkit-daemon/906  ... [continued]: poll()) = 0 Timeout
         ? (         ): rtkit-daemon/907  ... [continued]: poll()) = 1
   724.603 ( 0.007 ms): rtkit-daemon/907 read(fd: 6<anon_inode:[eventfd]>, buf: 0x7f05ff768d08, count: 8) = 8
         ? (         ): ssh/5461  ... [continued]: select()) = 1
   810.431 ( 0.002 ms): ssh/5461 clock_gettime(which_clock: BOOTTIME, tp: 0x7ffd7f39f870) = 0
   ^C

Several syscall exit events for syscalls in flight when 'perf trace' started, etc. Saner :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-c3tu5yg204p5mvr9kvwew07n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 27 ------------------------
 1 file changed, 27 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 5fed1eff889d..3f26e705b86c 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -51,27 +51,6 @@ struct augmented_filename {
 
 pid_filter(pids_filtered);
 
-static void pid_filter__init(void)
-{
-	/*
-	 * Filter a bunch of pids: gnome-shell, kvm, firefox threads,
-	 * avahi-daemon, etc, just for testing as we go along.
-	 *
-	 * These will come from 'perf trace --filter-pids' in a explicit way
-	 * and also it will filter out itself, to avoid the feedback loop:
-	 * syscalls 'perf trace' does gets caught, reported, causing new
-	 * syscalls to get emitted, rinse repeat forever.
-	 */
-	if (pid_filter__add(&pids_filtered, 2971))
-		return; /* pid_filter__init() was already called, bail out */
-	pid_filter__add(&pids_filtered, 20016);
-	pid_filter__add(&pids_filtered, 12018);
-	pid_filter__add(&pids_filtered, 2310);
-	pid_filter__add(&pids_filtered, 3759);
-	pid_filter__add(&pids_filtered, 25978);
-	pid_filter__add(&pids_filtered, 883);
-}
-
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -81,12 +60,6 @@ int sys_enter(struct syscall_enter_args *args)
 	} augmented_args;
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
-	/*
- 	 * We still don't have a "main()" called first and only once
- 	 * call it always, it will exit as soon as it realizes the
- 	 * first hard coded filtered pid was already added.
- 	 */
-	pid_filter__init();
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
