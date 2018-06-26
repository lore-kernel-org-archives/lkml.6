Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398A526591
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398A526591
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeFZGzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:55:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47037 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeFZGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:54:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6slc31591454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:54:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6slG11591450;
        Mon, 25 Jun 2018 23:54:47 -0700
Date:   Mon, 25 Jun 2018 23:54:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-atwz0arwanq1npu8pptwkoxt@git.kernel.org>
Cc:     tglx@linutronix.de, dsahern@gmail.com, hpa@zytor.com,
        maarten.lankhorst@linux.intel.com, ankit.k.nautiyal@intel.com,
        adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com
Reply-To: ankit.k.nautiyal@intel.com, maarten.lankhorst@linux.intel.com,
          hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
          tglx@linutronix.de, dsahern@gmail.com, namhyung@kernel.org,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers uapi: Synchronize drm/drm.h
Git-Commit-ID: 7b818dc57230bf050bbc4218cd4df8ec59b9945d
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

Commit-ID:  7b818dc57230bf050bbc4218cd4df8ec59b9945d
Gitweb:     https://git.kernel.org/tip/7b818dc57230bf050bbc4218cd4df8ec59b9945d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 15 Jun 2018 11:33:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

tools headers uapi: Synchronize drm/drm.h

To pick up the new ioctls added in these csets:

  7595bda2fb43 ("drm: Add DRM client cap for aspect-ratio")

The DRM caps are not yet being decoded in 'perf trace', so this sync
doesn't incur in any change in behaviour in any tools, just silencing
this tools/perf/ build warning:

	Warning: Kernel ABI header at 'tools/include/uapi/drm/drm.h' differs from latest version at 'include/uapi/drm/drm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-atwz0arwanq1npu8pptwkoxt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/drm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index 6fdff5945c8a..9c660e1688ab 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -680,6 +680,13 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ATOMIC	3
 
+/**
+ * DRM_CLIENT_CAP_ASPECT_RATIO
+ *
+ * If set to 1, the DRM core will provide aspect ratio information in modes.
+ */
+#define DRM_CLIENT_CAP_ASPECT_RATIO    4
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
