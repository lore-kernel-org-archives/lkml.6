Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6636C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC22214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC22214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbeKVBjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:39:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeKVBjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:39:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wALF4iVe3418559
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 07:04:44 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wALF4iUu3418556;
        Wed, 21 Nov 2018 07:04:44 -0800
Date:   Wed, 21 Nov 2018 07:04:44 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-7bds48dhckfnleie08mit314@git.kernel.org>
Cc:     mingo@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        hpa@zytor.com, adrian.hunter@intel.com, gregkh@linuxfoundation.org,
        dsahern@gmail.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, nicolas.ferre@microchip.com,
        tglx@linutronix.de, jolsa@kernel.org
Reply-To: jolsa@kernel.org, nicolas.ferre@microchip.com,
          tglx@linutronix.de, dsahern@gmail.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          gregkh@linuxfoundation.org, adrian.hunter@intel.com,
          hpa@zytor.com, wangnan0@huawei.com, acme@redhat.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools beauty ioctl: Support new ISO7816
 commands
Git-Commit-ID: a4243e1494532ab8fa679a4134153149a71fa331
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

Commit-ID:  a4243e1494532ab8fa679a4134153149a71fa331
Gitweb:     https://git.kernel.org/tip/a4243e1494532ab8fa679a4134153149a71fa331
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 19 Nov 2018 12:38:50 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Nov 2018 12:38:50 -0800

perf tools beauty ioctl: Support new ISO7816 commands

Introduced in:

  ad8c0eaa0a41 ("tty/serial_core: add ISO7816 infrastructure")

Now 'perf trace' will be able to pretty-print the 'cmd' ioctl arg when
used in capable systems with software emitting those commands.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-7bds48dhckfnleie08mit314@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 5d2a7fd8d407..eae59ad15ce3 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -31,6 +31,7 @@ static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 	"TCSETSW2", "TCSETSF2", "TIOCGRS48", "TIOCSRS485", "TIOCGPTN", "TIOCSPTLCK",
 	"TIOCGDEV", "TCSETX", "TCSETXF", "TCSETXW", "TIOCSIG", "TIOCVHANGUP", "TIOCGPKT",
 	"TIOCGPTLCK", [_IOC_NR(TIOCGEXCL)] = "TIOCGEXCL", "TIOCGPTPEER",
+	"TIOCGISO7816", "TIOCSISO7816",
 	[_IOC_NR(FIONCLEX)] = "FIONCLEX", "FIOCLEX", "FIOASYNC", "TIOCSERCONFIG",
 	"TIOCSERGWILD", "TIOCSERSWILD", "TIOCGLCKTRMIOS", "TIOCSLCKTRMIOS",
 	"TIOCSERGSTRUCT", "TIOCSERGETLSR", "TIOCSERGETMULTI", "TIOCSERSETMULTI",
