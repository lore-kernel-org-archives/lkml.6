Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E279C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDFB218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ttfxxIIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfAYGyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:54:52 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:57090 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfAYGyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:54:51 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x0P6sNWo014857;
        Fri, 25 Jan 2019 15:54:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x0P6sNWo014857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548399265;
        bh=h8rpwS53NnS4Ivs3ONGYw2ef3dhr+vT5OXxbzo4VzEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttfxxIIEC9VRTaHkxy3jHaGEmmQ+s3S73dyShdyF/XBPk3a7QfwYsWILcDtFbVmpa
         xyb5k5OWUYqUezi6vxhUOXRaweIC1gnWpk88wiOtxG5P3fojrV2geLAjvQC1RgnsBo
         3H/tY9ZU3YGXbQ7odfMX3sa0y+EzuOnolkFZtK18+J+pqNRpz0CLCIZGPYOLG+EXNS
         gm2V9nz2kWB6WmumIxxdTYvCKvGpevxGmd+qynciPLewRgCwDAnq1F01SaREfTykwY
         fO//Nu08MSmODhsxWKm7CvQsVd4hQju7GR92rDoiQ8OvTK0N6gU6qHGl0KFdjytJNq
         jPw+d76yXtrFg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] media: coda: remove -I$(src) header search path
Date:   Fri, 25 Jan 2019 15:54:17 +0900
Message-Id: <1548399259-17750-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548399259-17750-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the header search path to the current directory.

The compiler will search headers in the current directory by
using #include "..." instead of #include <...>

Also, change TRACE_INCLUDE_PATH to point to the location of trace.h.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/media/platform/coda/Makefile    | 2 --
 drivers/media/platform/coda/coda-h264.c | 3 ++-
 drivers/media/platform/coda/trace.h     | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/coda/Makefile b/drivers/media/platform/coda/Makefile
index 8582843..3eed821 100644
--- a/drivers/media/platform/coda/Makefile
+++ b/drivers/media/platform/coda/Makefile
@@ -1,5 +1,3 @@
-ccflags-y += -I$(src)
-
 coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-jpeg.o
 
 obj-$(CONFIG_VIDEO_CODA) += coda.o
diff --git a/drivers/media/platform/coda/coda-h264.c b/drivers/media/platform/coda/coda-h264.c
index 635356a..6da82d1 100644
--- a/drivers/media/platform/coda/coda-h264.c
+++ b/drivers/media/platform/coda/coda-h264.c
@@ -14,7 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/videodev2.h>
-#include <coda.h>
+
+#include "coda.h"
 
 static const u8 coda_filler_size[8] = { 0, 7, 14, 13, 12, 11, 10, 9 };
 
diff --git a/drivers/media/platform/coda/trace.h b/drivers/media/platform/coda/trace.h
index a672bfc..6cf5823 100644
--- a/drivers/media/platform/coda/trace.h
+++ b/drivers/media/platform/coda/trace.h
@@ -157,7 +157,7 @@ DEFINE_EVENT(coda_buf_meta_class, coda_dec_rot_done,
 #endif /* __CODA_TRACE_H__ */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../../drivers/media/platform/coda
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE trace
 
-- 
2.7.4

