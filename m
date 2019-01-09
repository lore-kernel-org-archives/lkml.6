Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5369C20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfAIHRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:17:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:17:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097HOR43856529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:17:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097HNXO3856526;
        Tue, 8 Jan 2019 23:17:23 -0800
Date:   Tue, 8 Jan 2019 23:17:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-i2ricmpwpdrpukfq3298jr1z@git.kernel.org>
Cc:     dhowells@redhat.com, wangnan0@huawei.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, lclaudio@redhat.com,
        adrian.hunter@intel.com, acme@redhat.com, tglx@linutronix.de,
        jolsa@kernel.org, namhyung@kernel.org
Reply-To: jolsa@kernel.org, lclaudio@redhat.com, acme@redhat.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          wangnan0@huawei.com, dhowells@redhat.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Grab a copy of linux/mount.h
Git-Commit-ID: 250bfc87ddc427fa001bbc8bc1468ce5fc06645b
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

Commit-ID:  250bfc87ddc427fa001bbc8bc1468ce5fc06645b
Gitweb:     https://git.kernel.org/tip/250bfc87ddc427fa001bbc8bc1468ce5fc06645b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 8 Jan 2019 13:42:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 14:09:28 -0300

tools include uapi: Grab a copy of linux/mount.h

We were using a copy of uapi/linux/fs.h to create the mount syscall
'flags' string table to use in 'perf trace', to convert from the number
obtained via the raw_syscalls:sys_enter into a string, using
tools/perf/trace/beauty/mount_flags.sh, but in e262e32d6bde ("vfs:
Suppress MS_* flag defs within the kernel unless explicitly enabled")
those defines got moved to linux/mount.h, so grab a copy of mount.h too.

Keep the uapi/linux/fs.h as we'll use it for the SEEK_ constants.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-i2ricmpwpdrpukfq3298jr1z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {include => tools/include}/uapi/linux/mount.h | 0
 tools/perf/check-headers.sh                   | 1 +
 2 files changed, 1 insertion(+)

diff --git a/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
similarity index 100%
copy from include/uapi/linux/mount.h
copy to tools/include/uapi/linux/mount.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 6cb98f8570a2..b51e952ab35f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -10,6 +10,7 @@ include/uapi/linux/fs.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
+include/uapi/linux/mount.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
