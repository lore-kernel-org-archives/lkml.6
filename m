Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D290C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D252146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfBTU1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:27:05 -0500
Received: from gateway36.websitewelcome.com ([192.185.184.18]:40362 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbfBTU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:27:05 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 3D736400C8424
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 13:41:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wYSOgqIK52qH7wYSOgMrWg; Wed, 20 Feb 2019 14:27:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=40200 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gwYQq-002UxG-I2; Wed, 20 Feb 2019 14:27:03 -0600
Date:   Wed, 20 Feb 2019 14:25:26 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Karsten Keil <isdn@linux-pingi.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] isdn_common: Mark expected switch fall-throughs
Message-ID: <20190220202526.GA24484@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gwYQq-002UxG-I2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:40200
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/isdn/i4l/isdn_common.c: In function ‘isdn_wildmat’:
drivers/isdn/i4l/isdn_common.c:173:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
    p++;
    ~^~
drivers/isdn/i4l/isdn_common.c:174:3: note: here
   default:
   ^~~~~~~
  CC [M]  drivers/leds/leds-lp8788.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu10_smumgr.o
drivers/isdn/i4l/isdn_common.c: In function ‘isdn_status_callback’:
drivers/isdn/i4l/isdn_common.c:729:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (divert_if)
      ^
drivers/isdn/i4l/isdn_common.c:732:2: note: here
  default:
  ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that, in this particular case, the code comment is modified
in accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/isdn/i4l/isdn_common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
index 6a5b3f00f9ad..74ee00f5b310 100644
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -166,11 +166,9 @@ isdn_wildmat(char *s, char *p)
 	for (; *p; s++, p++)
 		switch (*p) {
 		case '\\':
-			/*
-			 * Literal match with following character,
-			 * fall through.
-			 */
+			/* Literal match with following character. */
 			p++;
+			/* fall through */
 		default:
 			if (*s != *p)
 				return (*s == '\0') ? 2 : 1;
@@ -729,6 +727,7 @@ isdn_status_callback(isdn_ctrl *c)
 		if (divert_if)
 			return (divert_if->stat_callback(c));
 #endif /* CONFIG_ISDN_DIVERSION */
+		/* fall through */
 	default:
 		return -1;
 	}
-- 
2.20.1

