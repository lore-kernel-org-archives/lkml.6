Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D7C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD67D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbfBMC5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:57:12 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.130]:42549 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388244AbfBMC5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:57:10 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 28DE6303E2AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 20:57:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tkjVg7tRY4FKptkjVgSYK0; Tue, 12 Feb 2019 20:57:09 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=38868 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtkjU-001tLj-Eq; Tue, 12 Feb 2019 20:57:08 -0600
Date:   Tue, 12 Feb 2019 20:57:07 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alex Dubov <oakad@yahoo.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] memstick: mark expected switch fall-throughs
Message-ID: <20190213025707.GA16307@embeddedor>
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
X-Exim-ID: 1gtkjU-001tLj-Eq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:38868
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/memstick/host/jmb38x_ms.c: In function ‘jmb38x_ms_write_data’:
drivers/memstick/host/jmb38x_ms.c:261:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->io_pos++;
   ~~~~~~~~~~~~^~
drivers/memstick/host/jmb38x_ms.c:262:2: note: here
  case 2:
  ^~~~
drivers/memstick/host/jmb38x_ms.c:264:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->io_pos++;
   ~~~~~~~~~~~~^~
drivers/memstick/host/jmb38x_ms.c:265:2: note: here
  case 1:
  ^~~~
drivers/memstick/host/tifm_ms.c: In function ‘tifm_ms_write_data’:
drivers/memstick/host/tifm_ms.c:168:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->io_pos++;
   ~~~~~~~~~~~~^~
drivers/memstick/host/tifm_ms.c:169:2: note: here
  case 2:
  ^~~~
drivers/memstick/host/tifm_ms.c:171:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->io_pos++;
   ~~~~~~~~~~~~^~
drivers/memstick/host/tifm_ms.c:172:2: note: here
  case 1:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/memstick/host/jmb38x_ms.c | 2 ++
 drivers/memstick/host/tifm_ms.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index bcdca9fbef51..49c71f55489f 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -259,9 +259,11 @@ static unsigned int jmb38x_ms_write_data(struct jmb38x_ms_host *host,
 	case 3:
 		host->io_word[0] |= buf[off + 2] << 16;
 		host->io_pos++;
+		/* fall through */
 	case 2:
 		host->io_word[0] |= buf[off + 1] << 8;
 		host->io_pos++;
+		/* fall through */
 	case 1:
 		host->io_word[0] |= buf[off];
 		host->io_pos++;
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index bed205849d02..1bbb2ead9556 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -166,9 +166,11 @@ static unsigned int tifm_ms_write_data(struct tifm_ms *host,
 	case 3:
 		host->io_word |= buf[off + 2] << 16;
 		host->io_pos++;
+		/* fall through */
 	case 2:
 		host->io_word |= buf[off + 1] << 8;
 		host->io_pos++;
+		/* fall through */
 	case 1:
 		host->io_word |= buf[off];
 		host->io_pos++;
-- 
2.20.1

