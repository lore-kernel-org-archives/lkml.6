Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BEC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3380021872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfAYUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:31:43 -0500
Received: from gateway30.websitewelcome.com ([192.185.146.7]:45074 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfAYUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:31:43 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 5F96A620
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 14:31:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id n88cgRb0p2PzOn88cg1TVx; Fri, 25 Jan 2019 14:31:42 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=43850 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gn88b-002Y6d-P0; Fri, 25 Jan 2019 14:31:41 -0600
Date:   Fri, 25 Jan 2019 14:31:40 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] lib/cmdline.c: mark expected switch fall-throughs
Message-ID: <20190125203140.GA1814@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gn88b-002Y6d-P0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:43850
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

lib/cmdline.c:137:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/cmdline.c:140:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/cmdline.c:143:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/cmdline.c:146:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/cmdline.c:149:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/cmdline.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/cmdline.c b/lib/cmdline.c
index 171c19b6888e..dc59d6216318 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -135,18 +135,23 @@ unsigned long long memparse(const char *ptr, char **retptr)
 	case 'E':
 	case 'e':
 		ret <<= 10;
+		/* fall through */
 	case 'P':
 	case 'p':
 		ret <<= 10;
+		/* fall through */
 	case 'T':
 	case 't':
 		ret <<= 10;
+		/* fall through */
 	case 'G':
 	case 'g':
 		ret <<= 10;
+		/* fall through */
 	case 'M':
 	case 'm':
 		ret <<= 10;
+		/* fall through */
 	case 'K':
 	case 'k':
 		ret <<= 10;
-- 
2.20.1

