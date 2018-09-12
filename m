Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC5DC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2CA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2CA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeIMA0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:26:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbeIMA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:26:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJJw6Z2744035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:19:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJJwD42744032;
        Wed, 12 Sep 2018 12:19:58 -0700
Date:   Wed, 12 Sep 2018 12:19:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-n7qib1bac6mc6w9oke7r4qdc@git.kernel.org>
Cc:     wangnan0@huawei.com, brian.starkey@arm.com, peterz@infradead.org,
        acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        liviu.dudau@arm.com, eric@anholt.net, dsahern@gmail.com,
        seanpaul@chromium.org, mingo@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, brian.starkey@arm.com, wangnan0@huawei.com,
          peterz@infradead.org, acme@redhat.com, hpa@zytor.com,
          seanpaul@chromium.org, mingo@kernel.org, namhyung@kernel.org,
          jolsa@kernel.org, liviu.dudau@arm.com, eric@anholt.net,
          dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Update tools's copy of
 drm/drm.h
Git-Commit-ID: 434ea1bfbfc707f5fed9292df6a9b91dfb8e41f2
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

Commit-ID:  434ea1bfbfc707f5fed9292df6a9b91dfb8e41f2
Gitweb:     https://git.kernel.org/tip/434ea1bfbfc707f5fed9292df6a9b91dfb8e41f2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Sep 2018 11:07:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Sep 2018 11:07:56 -0300

tools headers uapi: Update tools's copy of drm/drm.h

To get the changes in:

	d67b6a206507 ("drm: writeback: Add client capability for exposing writeback connectors")

This is for an argument to a DRM ioctl, which is not being prettyfied in
the 'perf trace' DRM ioctl beautifier, but will now that syscalls are
starting to have pointer arguments augmented via BPF.

This time around this just cures the following warning during perf's
build:

	Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'
	diff -u tools/include/uapi/drm/drm.h include/uapi/drm/drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-n7qib1bac6mc6w9oke7r4qdc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 9c660e1688ab..300f336633f2 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -687,6 +687,15 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ASPECT_RATIO    4
 
+/**
+ * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
+ *
+ * If set to 1, the DRM core will expose special connectors to be used for
+ * writing back to memory the scene setup in the commit. Depends on client
+ * also supporting DRM_CLIENT_CAP_ATOMIC
+ */
+#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	5
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
