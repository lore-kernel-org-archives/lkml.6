Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E42C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4145E204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4145E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeKAHCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:02:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:02:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM20b22558494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:02:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM20KY2558491;
        Wed, 31 Oct 2018 15:02:00 -0700
Date:   Wed, 31 Oct 2018 15:02:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hegbzlpd2nrn584l5jxn7sy2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        wangnan0@huawei.com, adrian.hunter@intel.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        acme@redhat.com, benjamin@python.org, dsahern@gmail.com
Reply-To: benjamin@python.org, dsahern@gmail.com, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
          namhyung@kernel.org, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Beautify the umount's 'name' argument
Git-Commit-ID: 476c92cacf383c83584ba02d06c88cf18f062afb
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

Commit-ID:  476c92cacf383c83584ba02d06c88cf18f062afb
Gitweb:     https://git.kernel.org/tip/476c92cacf383c83584ba02d06c88cf18f062afb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Oct 2018 13:23:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf trace: Beautify the umount's 'name' argument

By using the SCA_FILENAME beautifier, that works when either the
probe:vfs_getname probe is in place or with the eBPF program
tools/perf/examples/bpf/augmented_syscalls.c:

  # perf probe -l
  probe:vfs_getname (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  # perf trace -e umount
  9630.332 ( 9.521 ms): umount/8082 umount2(name: /mnt) = 0
  #

The augmented syscalls one will be done in the next patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hegbzlpd2nrn584l5jxn7sy2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index db8711061ca3..d286f73ef2e5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -838,7 +838,8 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
-	{ .name     = "umount2", .alias = "umount", },
+	{ .name     = "umount2", .alias = "umount",
+	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* name */ }, }, },
 	{ .name	    = "uname", .alias = "newuname", },
 	{ .name	    = "unlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
