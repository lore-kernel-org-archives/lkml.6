Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C4AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA9F20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VKB0s3y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA9F20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeGLKsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:48:46 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:50899 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeGLKsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:48:46 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w6CAcbcm004202;
        Thu, 12 Jul 2018 19:38:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w6CAcbcm004202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531391918;
        bh=2AiEC+QN3PqDcABbJ5HRDgwyByA5pxmTqf1I58mKE+I=;
        h=From:To:Cc:Subject:Date:From;
        b=VKB0s3y3d3JAF5xmtzBo2POUdxhfQwocGNgsWdiyotgsnvQ4Pp3WbJZf22Y2s+oAV
         cQ+1fbfG8KDV3ieu/IQd3bsgQLlw/gxUXnqtLskpuDXmHFwD5mq0g4qcs7zt3rpPUv
         7+5boaEQss4DQrKHA64Wz7D/uYEDEAqb9jt/Z8gYQ1zhsd/853UpQxb7lPcRz7Qcda
         p+yP9x5gFdwKE0AOYVMZrm8vSwjYApK9NTSPFs4O4R17ZBUGCWFp74CzZHUJr9yfNj
         YkYZthDA09UCxgPTPwE+Y8XlHzomZWHCpMlKlf/cz+y7Chkk9P9bAxnH7/U/Mquw7S
         wRo1JbIPV6Jpw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: suppress warnings from 'getconf LFS_*'
Date:   Thu, 12 Jul 2018 19:38:36 +0900
Message-Id: <1531391916-24086-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppress warnings for systems that do not recognize LFS_*.

 getconf: no such configuration parameter `LFS_CFLAGS'
 getconf: no such configuration parameter `LFS_LDFLAGS'
 getconf: no such configuration parameter `LFS_LIBS'

Fixes: d7f14c66c273 ("kbuild: Enable Large File Support for hostprogs")
Reported-by: Chen Feng <puck.chen@hisilicon.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0f035ae..abc74f8 100644
--- a/Makefile
+++ b/Makefile
@@ -353,9 +353,9 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
 	  else if [ -x /bin/bash ]; then echo /bin/bash; \
 	  else echo sh; fi ; fi)
 
-HOST_LFS_CFLAGS := $(shell getconf LFS_CFLAGS)
-HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS)
-HOST_LFS_LIBS := $(shell getconf LFS_LIBS)
+HOST_LFS_CFLAGS := $(shell getconf LFS_CFLAGS 2>/dev/null)
+HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
+HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 HOSTCC       = gcc
 HOSTCXX      = g++
-- 
2.7.4

