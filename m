Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F982070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfACNQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:16:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfACNQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:16:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DGUxM1384542
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:16:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DGTxl1384539;
        Thu, 3 Jan 2019 05:16:29 -0800
Date:   Thu, 3 Jan 2019 05:16:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-neq1lrji5k4ku0rktn7ytnri@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org,
        acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        mingo@kernel.org, wangnan0@huawei.com, lclaudio@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          jolsa@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
          wangnan0@huawei.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty ioctl: Add generator for USBDEVFS_
 ioctl commands
Git-Commit-ID: 870c3f40dc78edec6437a2ced03976b66eeacf49
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

Commit-ID:  870c3f40dc78edec6437a2ced03976b66eeacf49
Gitweb:     https://git.kernel.org/tip/870c3f40dc78edec6437a2ced03976b66eeacf49
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 27 Dec 2018 14:27:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:04 -0300

perf beauty ioctl: Add generator for USBDEVFS_ ioctl commands

Will be associated with fds with the right device major.

  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh
  static const char *usbdevfs_ioctl_cmds[] = {
	[0] = "CONTROL",
	[10] = "SUBMITURB",
	[11] = "DISCARDURB",
	[12] = "REAPURB",
	[13] = "REAPURBNDELAY",
	[14] = "DISCSIGNAL",
	[15] = "CLAIMINTERFACE",
	[16] = "RELEASEINTERFACE",
	[17] = "CONNECTINFO",
	[18] = "IOCTL",
	[19] = "HUB_PORTINFO",
	[20] = "RESET",
	[21] = "CLEAR_HALT",
	[22] = "DISCONNECT",
	[23] = "CONNECT",
	[24] = "CLAIM_PORT",
	[25] = "RELEASE_PORT",
	[26] = "GET_CAPABILITIES",
	[27] = "DISCONNECT_CLAIM",
	[28] = "ALLOC_STREAMS",
	[29] = "FREE_STREAMS",
	[2] = "BULK",
	[30] = "DROP_PRIVILEGES",
	[31] = "GET_SPEED",
	[3] = "RESETEP",
	[4] = "SETINTERFACE",
	[5] = "SETCONFIGURATION",
	[8] = "GETDRIVER",
  };

  #if 0
  static const char *usbdevfs_ioctl_32_cmds[] = {
	[0] = "CONTROL32",
	[10] = "SUBMITURB32",
	[12] = "REAPURB32",
	[13] = "REAPURBNDELAY32",
	[14] = "DISCSIGNAL32",
	[18] = "IOCTL32",
	[2] = "BULK32",
  };
  #endif
  $

Leaving the '32' variants commented, later we can try to support those
as well, from some other hint (maybe something about the thread issuing
the ioctls) and from the _IOC_SIZE(cmd).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-neq1lrji5k4ku0rktn7ytnri@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/usbdevfs_ioctl.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/trace/beauty/usbdevfs_ioctl.sh b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
new file mode 100755
index 000000000000..930b80f422e8
--- /dev/null
+++ b/tools/perf/trace/beauty/usbdevfs_ioctl.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *usbdevfs_ioctl_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep -v 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n\n"
+printf "#if 0\n"
+printf "static const char *usbdevfs_ioctl_32_cmds[] = {\n"
+regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
+egrep $regex ${header_dir}/usbdevice_fs.h | egrep 'USBDEVFS_\w+32[[:space:]]' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n"
+printf "};\n"
+printf "#endif\n"
