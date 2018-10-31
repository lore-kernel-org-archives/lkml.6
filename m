Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F7DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D663C2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D663C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeKAG6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:58:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36609 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeKAG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:58:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VLvxF42557875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 14:57:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VLvxUW2557872;
        Wed, 31 Oct 2018 14:57:59 -0700
Date:   Wed, 31 Oct 2018 14:57:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yacf9jvkwfwg2g95r2us3xb3@git.kernel.org>
Cc:     adrian.hunter@intel.com, benjamin@python.org, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, mingo@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com
Reply-To: acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, benjamin@python.org, hpa@zytor.com,
          wangnan0@huawei.com, dsahern@gmail.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include uapi: Grab a copy of linux/fs.h
Git-Commit-ID: f443f38c5789ece6ebe59ae21c27bf861e61c4e2
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

Commit-ID:  f443f38c5789ece6ebe59ae21c27bf861e61c4e2
Gitweb:     https://git.kernel.org/tip/f443f38c5789ece6ebe59ae21c27bf861e61c4e2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 24 Oct 2018 14:31:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:22 -0300

tools include uapi: Grab a copy of linux/fs.h

We'll use it to create tables for the 'flags' argument to the 'mount'
and 'umount' syscalls.

Add it to check_headers.sh so that when a new protocol gets added we get
a notification during the build process.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yacf9jvkwfwg2g95r2us3xb3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {include => tools/include}/uapi/linux/fs.h | 4 ++--
 tools/perf/check-headers.sh                | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
similarity index 99%
copy from include/uapi/linux/fs.h
copy to tools/include/uapi/linux/fs.h
index a441ea1bfe6d..73e01918f996 100644
--- a/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -279,8 +279,8 @@ struct fsxattr {
 #define FS_ENCRYPTION_MODE_AES_256_CTS		4
 #define FS_ENCRYPTION_MODE_AES_128_CBC		5
 #define FS_ENCRYPTION_MODE_AES_128_CTS		6
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
+#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7
+#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8
 
 struct fscrypt_policy {
 	__u8 version;
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index c72cc73a6b09..9531f7bd7d9b 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -5,6 +5,7 @@ HEADERS='
 include/uapi/drm/drm.h
 include/uapi/drm/i915_drm.h
 include/uapi/linux/fcntl.h
+include/uapi/linux/fs.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
