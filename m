Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40002C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCE72145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCE72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbeHBJ6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:58:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48159 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHBJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:58:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7288hNZ3430643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:08:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7288hcN3430640;
        Thu, 2 Aug 2018 01:08:43 -0700
Date:   Thu, 2 Aug 2018 01:08:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2amnveu1ns4emjn70xuavpje@git.kernel.org>
Cc:     jolsa@kernel.org, adrian.hunter@intel.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, mingo@kernel.org,
        namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          mingo@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, dsahern@gmail.com,
          adrian.hunter@intel.com, wangnan0@huawei.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools include uapi: Grab a copy of linux/in.h
Git-Commit-ID: a4b2061242ecc024b1ee975e066b6e38db1c6b9e
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

Commit-ID:  a4b2061242ecc024b1ee975e066b6e38db1c6b9e
Gitweb:     https://git.kernel.org/tip/a4b2061242ecc024b1ee975e066b6e38db1c6b9e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 26 Jul 2018 09:26:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:52:37 -0300

tools include uapi: Grab a copy of linux/in.h

We'll use it to create tables for the 'protocol' argument to the
socket syscall when the 'family' arg is one of AF_INET or AF_INET6.

Add it to check_headers.sh so that when a new protocol gets added we get
a notification during the build process.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2amnveu1ns4emjn70xuavpje@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {include => tools/include}/uapi/linux/in.h | 0
 tools/perf/check-headers.sh                | 1 +
 2 files changed, 1 insertion(+)

diff --git a/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
similarity index 100%
copy from include/uapi/linux/in.h
copy to tools/include/uapi/linux/in.h
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 814aaf269949..de28466c0186 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -7,6 +7,7 @@ include/uapi/drm/i915_drm.h
 include/uapi/linux/fcntl.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
+include/uapi/linux/in.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
