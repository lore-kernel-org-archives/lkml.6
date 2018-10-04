Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EEFC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FA72084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FA72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJEFZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:25:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:23017 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeJEFZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:25:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 15:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,341,1534834800"; 
   d="scan'208";a="94741757"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.189.220])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2018 15:30:02 -0700
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 1/5] asm-generic, termios: add alias constants from MIPS
Date:   Thu,  4 Oct 2018 15:29:49 -0700
Message-Id: <20181004222953.2229-2-hpa@zytor.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181004222953.2229-1-hpa@zytor.com>
References: <20181004222953.2229-1-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures, in this case MIPS, need a couple of legacy alias
constants for bits. There really is no reason why we can't define them
generically for all architectures.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
linux-kernel@vger.kernel.org (open list)
---
 include/uapi/asm-generic/termbits.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..96ae175eec5b 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -8,7 +8,10 @@ typedef unsigned char	cc_t;
 typedef unsigned int	speed_t;
 typedef unsigned int	tcflag_t;
 
-#define NCCS 19
+#ifndef NCCS
+# define NCCS 19
+#endif
+
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
@@ -49,6 +52,7 @@ struct ktermios {
 #define VTIME 5
 #define VMIN 6
 #define VSWTC 7
+#define VSWTCH VSWTC
 #define VSTART 8
 #define VSTOP 9
 #define VSUSP 10
@@ -173,6 +177,7 @@ struct ktermios {
 #define ECHONL	0000100
 #define NOFLSH	0000200
 #define TOSTOP	0000400
+#define ITOSTOP TOSTOP
 #define ECHOCTL	0001000
 #define ECHOPRT	0002000
 #define ECHOKE	0004000
-- 
2.14.4

