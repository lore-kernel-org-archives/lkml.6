Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C1920865
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C1920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeJKKUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:20:36 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:23294 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbeJKKUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:20:35 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9B2NuY0096770
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:23:56 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9B2NlCo096751;
        Thu, 11 Oct 2018 10:23:47 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 11 Oct 2018
 10:21:16 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <green.hu@gmail.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <deanbo422@gmail.com>
CC:     Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v2 5/5] math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning
Date:   Thu, 11 Oct 2018 10:20:50 +0800
Message-ID: <1539224450-19928-6-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539224450-19928-1-git-send-email-vincentc@andestech.com>
References: <1539224450-19928-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9B2NlCo096751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_FP_ROUND_ZERO is defined as 0 and used as a statemente in macro
_FP_ROUND. This generates "error: statement with no effect
[-Werror=unused-value]" from gcc. Defining _FP_ROUND_ZERO as (void)0 to
fix it.

This modification is quoted from glibc 'commit <In libc/:>
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

