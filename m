Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC7F214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrgI+r0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC7F214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbeKTDKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:46328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388888AbeKTDKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B20C2148E;
        Mon, 19 Nov 2018 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645991;
        bh=82f7v2o6cYPP0xdUUDaXZr9V/a6oY2cMkLldNN1+GLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrgI+r0enijXfhML47tGz3sBtrJfNQdUFX8+YSOKAcogb3mfinqRedDWuH7PSj1ev
         o1LxHGxCaFbCeGOgQuXbITzu/Hekt50N1D+p3vkaMgedkQhFYC2n+b8BLiZJTPJIaQ
         Af8pQtlvIUJD8J9zpIeSVNd4lBGiwUlCfakCa3C8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergii Romantsov <sergii.romantsov@globallogic.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.18 167/171] drm/i915: Mark pin flags as u64
Date:   Mon, 19 Nov 2018 17:29:23 +0100
Message-Id: <20181119162641.077694578@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 0014868b9c3c1dda1de6711cf58c3486fb422d07 upstream.

Since the flags are being used to operate on a u64 variable, they too
need to be marked as such so that the inverses are full width (and not
zero extended on 32b kernels and bdw+).

Reported-by: Sergii Romantsov <sergii.romantsov@globallogic.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: stable@vger.kernel.org
Reviewed-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181102161232.17742-2-chris@chris-wilson.co.uk
(cherry picked from commit 83b466b1dc5f0b4d33f0a901e8b00197a8f3582d)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_gtt.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem_gtt.h
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.h
@@ -627,20 +627,20 @@ int i915_gem_gtt_insert(struct i915_addr
 			u64 start, u64 end, unsigned int flags);
 
 /* Flags used by pin/bind&friends. */
-#define PIN_NONBLOCK		BIT(0)
-#define PIN_MAPPABLE		BIT(1)
-#define PIN_ZONE_4G		BIT(2)
-#define PIN_NONFAULT		BIT(3)
-#define PIN_NOEVICT		BIT(4)
+#define PIN_NONBLOCK		BIT_ULL(0)
+#define PIN_MAPPABLE		BIT_ULL(1)
+#define PIN_ZONE_4G		BIT_ULL(2)
+#define PIN_NONFAULT		BIT_ULL(3)
+#define PIN_NOEVICT		BIT_ULL(4)
 
-#define PIN_MBZ			BIT(5) /* I915_VMA_PIN_OVERFLOW */
-#define PIN_GLOBAL		BIT(6) /* I915_VMA_GLOBAL_BIND */
-#define PIN_USER		BIT(7) /* I915_VMA_LOCAL_BIND */
-#define PIN_UPDATE		BIT(8)
+#define PIN_MBZ			BIT_ULL(5) /* I915_VMA_PIN_OVERFLOW */
+#define PIN_GLOBAL		BIT_ULL(6) /* I915_VMA_GLOBAL_BIND */
+#define PIN_USER		BIT_ULL(7) /* I915_VMA_LOCAL_BIND */
+#define PIN_UPDATE		BIT_ULL(8)
 
-#define PIN_HIGH		BIT(9)
-#define PIN_OFFSET_BIAS		BIT(10)
-#define PIN_OFFSET_FIXED	BIT(11)
+#define PIN_HIGH		BIT_ULL(9)
+#define PIN_OFFSET_BIAS		BIT_ULL(10)
+#define PIN_OFFSET_FIXED	BIT_ULL(11)
 #define PIN_OFFSET_MASK		(-I915_GTT_PAGE_SIZE)
 
 #endif


