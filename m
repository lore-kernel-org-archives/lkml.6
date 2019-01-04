Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FB3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B075218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626865;
	bh=GSKDHMUbKZFUAhVeaGGq69PtYDm3d+jgAiKhf0DTipo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zC4qOkUlfBhwN+Oga2oKhSWpvil0DUVJ0q2S3rYvToFrx1MGqpMnNf16I2dXo4MUX
	 hKIM1VY6CobiLUa0TtFNy6CJK+AROcMrDrXVApt63fRDoF0Zq+VRio4K//dT5ChpSf
	 tG/iC64zfryDMM5ce7eb+erwraJBwuEMG/f1taRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfADSeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbfADSeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E935218E2;
        Fri,  4 Jan 2019 18:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626860;
        bh=GSKDHMUbKZFUAhVeaGGq69PtYDm3d+jgAiKhf0DTipo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUBRFEVqu2UedzZpQoQGgk3CnHbI3y9Q2P+5WBmAEsxrOWHrXQauP1kRLio6YdrJK
         AMXDSqkoeu9y2N1URPd2SKkfSt3SJ/p8B1f3k+2w/ZJo1V8oaIeZB6Oqk7DySvRO9F
         Qyu8W58qoNnGE9Oufn2s4TpWRs94I1D9OyhiZz4w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jiri Olsa <jolsa@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 07/16] tools headers uapi: Update i915_drm.h
Date:   Fri,  4 Jan 2019 15:33:28 -0300
Message-Id: <20190104183337.12771-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in these csets:

  fe841686470d Revert "drm/i915/perf: add a parameter to control the size of OA buffer"
  cd956bfcd0f5 drm/i915/perf: add a parameter to control the size of OA buffer
  4bdafb9ddfa4 drm/i915: Remove i915.enable_ppgtt override

Not one of them result in any changes in tools/perf/, this is just to
silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mdw7ta6qz7d2rl77gf00uqe8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index a4446f452040..298b2e197744 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -412,6 +412,14 @@ typedef struct drm_i915_irq_wait {
 	int irq_seq;
 } drm_i915_irq_wait_t;
 
+/*
+ * Different modes of per-process Graphics Translation Table,
+ * see I915_PARAM_HAS_ALIASING_PPGTT
+ */
+#define I915_GEM_PPGTT_NONE	0
+#define I915_GEM_PPGTT_ALIASING	1
+#define I915_GEM_PPGTT_FULL	2
+
 /* Ioctl to query kernel params:
  */
 #define I915_PARAM_IRQ_ACTIVE            1
-- 
2.20.1

