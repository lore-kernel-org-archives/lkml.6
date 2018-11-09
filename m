Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6115C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9AB20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9AB20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeKITPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:15:23 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55160 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKITPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:15:23 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gL3CT-0000te-UO; Fri, 09 Nov 2018 10:35:38 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/3] compiler-gcc: hide COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW from sparse
Date:   Fri,  9 Nov 2018 10:35:32 +0100
Message-Id: <20181109093534.15121-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Sparse doesn't support all the overflow builtins, so just hide
them from it to avoid lots of warnings/errors reported by it.

We could try to teach them to sparse, but the passed types are
variable, and sparse doesn't seem to handle that well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 2010493e1040..3154f2a84571 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -143,7 +143,7 @@
 #define KASAN_ABI_VERSION 3
 #endif
 
-#if GCC_VERSION >= 50100
+#if GCC_VERSION >= 50100 && !defined(__CHECKER__)
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
-- 
2.17.2

