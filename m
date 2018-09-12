Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB81C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA8621471
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wwiFzd33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA8621471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIMABa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeIMAB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:01:29 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDD12133F;
        Wed, 12 Sep 2018 18:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536778538;
        bh=xrrLyYjGFhuSjVBHXYzfCUrtnQZIUUX4B3r1tcPH5Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wwiFzd33zVknCwKnm4Q6clPjIge8djg0mCyxnMJ+IcAEz2ixL/ntylPZ9WYZKviKb
         QQAD6+edT70hBAo8OGSOMf9LzSA90BLpQchhUqzd1bn4XigASzDnCmAxaxW6Apheka
         5gPCHAxi/V1Y9dFTIgciEnclpe2sWky/wucAXf5Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Ahern <dsahern@gmail.com>, Eric Anholt <eric@anholt.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/7] tools headers uapi: Update tools's copy of drm/drm.h
Date:   Wed, 12 Sep 2018 15:55:05 -0300
Message-Id: <20180912185509.32187-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

