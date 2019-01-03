Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD8C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98CC2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfACNS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:18:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfACNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:18:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DIGCl1384832
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:18:16 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DIG3k1384829;
        Thu, 3 Jan 2019 05:18:16 -0800
Date:   Thu, 3 Jan 2019 05:18:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6x2cawak7jno3gpp5pagzj50@git.kernel.org>
Cc:     lclaudio@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de, jolsa@kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: namhyung@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
          jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          lclaudio@redhat.com, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace beauty ioctl: Beautify USBDEVFS_
 commands
Git-Commit-ID: 38fc9da69f3385667ba8c3d45bd43065491854a6
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

Commit-ID:  38fc9da69f3385667ba8c3d45bd43065491854a6
Gitweb:     https://git.kernel.org/tip/38fc9da69f3385667ba8c3d45bd43065491854a6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 27 Dec 2018 16:20:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:06 -0300

perf trace beauty ioctl: Beautify USBDEVFS_ commands

For instance, while debugging the 'galileo' python utility to
synchronize fitbit trackers:

  # perf trace -e ioctl ./run --force
  ioctl(0</dev/pts/8>, TCSETS, 0x7ffe28666420) = 0
  ioctl(0</dev/pts/8>, TCSETS, 0x7ffe28666290) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28666290) = 0
  ioctl(2</dev/pts/8>, TCSETS, 0x7ffe28666290) = 0
  ioctl(3</home/acme/hg/galileo/run>, TCSETS, 0x7ffe286663f0) = -1 ENOTTY (Inappropriate ioctl for device)
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe286655a0) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28665470) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28665470) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe286654a0) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe286654a0) = 0
  ioctl(1</dev/pts/8>, TCSETS, 0x7ffe28665400) = 0
  ioctl(1</dev/pts/8>, TIOCSWINSZ, 0x7ffe286654c0) = 0
  ioctl(0</dev/pts/8>, TIOCSWINSZ, 0x7ffe28665560) = 0
  ioctl(0</dev/pts/8>, TIOCSWINSZ, 0x7ffe28665560) = 0
  ioctl(0</dev/pts/8>, TIOCMGET, 0x7ffe28665560) = 0
  ioctl(0</dev/pts/8>, TCSETS, 0x7ffe28665530) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_GET_CAPABILITIES, 0x561468dad048) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_GETDRIVER, 0x7ffe28665500) = -1 ENODATA (No data available)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_GETDRIVER, 0x7ffe28665500) = -1 ENODATA (No data available)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SETCONFIGURATION, 0x7ffe2866513c) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_CLAIMINTERFACE, 0x7ffe286647bc) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SUBMITURB, 0x561468dace40) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664c10) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664c10) = -1 EAGAIN (Resource temporarily unavailable)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SUBMITURB, 0x561468dace40) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664dd0) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664dd0) = -1 EAGAIN (Resource temporarily unavailable)
  <SNIP>
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_SUBMITURB, 0x561468e72ec0) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664cc0) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_REAPURBNDELAY, 0x7ffe28664cc0) = -1 EAGAIN (Resource temporarily unavailable)
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_RELEASEINTERFACE, 0x7ffe2866463c) = 0
  ioctl(10</dev/bus/usb/001/011>, USBDEVFS_RELEASEINTERFACE, 0x7ffe2866463c) = 0
  Tracker: 813F4690C3D1: Synchronisation successful
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6x2cawak7jno3gpp5pagzj50@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/ioctl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 9efeb6a936c2..620350d41209 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -112,6 +112,17 @@ static size_t ioctl__scnprintf_perf_cmd(int nr, int dir, char *bf, size_t size)
 	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAE, nr, dir);
 }
 
+static size_t ioctl__scnprintf_usbdevfs_cmd(int nr, int dir, char *bf, size_t size)
+{
+#include "trace/beauty/generated/ioctl/usbdevfs_ioctl_array.c"
+	static DEFINE_STRARRAY(usbdevfs_ioctl_cmds, "");
+
+	if (nr < strarray__usbdevfs_ioctl_cmds.nr_entries && strarray__usbdevfs_ioctl_cmds.entries[nr] != NULL)
+		return scnprintf(bf, size, "USBDEVFS_%s", strarray__usbdevfs_ioctl_cmds.entries[nr]);
+
+	return scnprintf(bf, size, "(%c, %#x, %#x)", 'U', nr, dir);
+}
+
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, bool show_prefix)
 {
 	const char *prefix = "_IOC_";
@@ -157,9 +168,20 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size, boo
 	return printed + scnprintf(bf + printed, size - printed, ", %#x, %#x, %#x)", type, nr, sz);
 }
 
+#ifndef USB_DEVICE_MAJOR
+#define USB_DEVICE_MAJOR 189
+#endif // USB_DEVICE_MAJOR
+
 size_t syscall_arg__scnprintf_ioctl_cmd(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long cmd = arg->val;
+	unsigned int fd = syscall_arg__val(arg, 0);
+	struct file *file = thread__files_entry(arg->thread, fd);
+
+	if (file != NULL) {
+		if (file->dev_maj == USB_DEVICE_MAJOR)
+			return ioctl__scnprintf_usbdevfs_cmd(_IOC_NR(cmd), _IOC_DIR(cmd), bf, size);
+	}
 
 	return ioctl__scnprintf_cmd(cmd, bf, size, arg->show_string_prefix);
 }
