Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD70C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5770C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5770C20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeH1ER4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:17:56 -0400
Received: from exmail.andestech.com ([59.124.169.137]:36248 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeH1ERz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:17:55 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7S0QNJR089058;
        Tue, 28 Aug 2018 08:26:23 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Tue, 28 Aug 2018
 08:28:49 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <deanbo422@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <greentime@andestech.com>, Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 2/2] math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning
Date:   Tue, 28 Aug 2018 08:28:43 +0800
Message-ID: <1535416123-23265-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7S0QNJR089058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_FP_ROUND_ZERO is defined as 0 and used as a statemente in macro
_FP_ROUND. This will generate "error: statement with no effect
[-Werror=unused-value]" from gcc when compiling. Defining
_FP_ROUND_ZERO as (void)0 to fix it.

This modification references the content of glibc 'commit <In libc/:>
(8ed1e7d5894000c155acbd06f)'

Signed-off-by: Vincent Chen <vincentc@andestech.com>
---
 include/math-emu/soft-fp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/math-emu/soft-fp.h b/include/math-emu/soft-fp.h
index 3f284bc..5650c16 100644
--- a/include/math-emu/soft-fp.h
+++ b/include/math-emu/soft-fp.h
@@ -138,7 +138,7 @@
       _FP_FRAC_ADDI_##wc(X, _FP_WORK_ROUND);		\
 } while (0)
 
-#define _FP_ROUND_ZERO(wc, X)		0
+#define _FP_ROUND_ZERO(wc, X)		(void)0
 
 #define _FP_ROUND_PINF(wc, X)				\
 do {							\
-- 
1.7.1

