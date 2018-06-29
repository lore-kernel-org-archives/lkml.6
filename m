Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF34C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6517F27C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6517F27C7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeF2UE5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:04:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52077 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbeF2UE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:04:56 -0400
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1fYzdU-0005Mn-6V; Fri, 29 Jun 2018 20:04:52 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1fYzdQ-0005ZC-TZ; Fri, 29 Jun 2018 13:04:48 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Cc:     Kamal Mostafa <kamal@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] security: CONFIG_HARDENED_USERCOPY does not need to select BUG
Date:   Fri, 29 Jun 2018 13:04:21 -0700
Message-Id: <1530302661-20953-1-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows for CONFIG_HARDENED_USERCOPY without CONFIG_BUG.

Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 security/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index c430206..7667774 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -153,7 +153,6 @@ config HAVE_HARDENED_USERCOPY_ALLOCATOR
 config HARDENED_USERCOPY
 	bool "Harden memory copies between kernel and userspace"
 	depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
-	select BUG
 	imply STRICT_DEVMEM
 	help
 	  This option checks for obviously wrong memory regions when
-- 
2.7.4

