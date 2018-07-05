Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D965C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFA1240AC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFA1240AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbeGENrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:47:09 -0400
Received: from gateway36.websitewelcome.com ([50.116.127.2]:20045 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753770AbeGENrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:47:06 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id C32A74017ADC4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jul 2018 07:47:56 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id b4agfEYw3bXuJb4azfOfJ9; Thu, 05 Jul 2018 08:47:05 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=42432 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fb4ae-002w7j-W1; Thu, 05 Jul 2018 08:46:33 -0500
Date:   Thu, 5 Jul 2018 08:46:32 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] parport: ieee1284: mark expected switch fall-throughs
Message-ID: <20180705134632.GA14119@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fb4ae-002w7j-W1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:42432
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/parport/ieee1284.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index 2d1a5c7..f12b9da 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -267,7 +267,7 @@ static void parport_ieee1284_terminate (struct parport *port)
 			port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 		}
 
-		/* fall-though.. */
+		/* fall through */
 
 	default:
 		/* Terminate from all other modes. */
@@ -615,6 +615,7 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 	case IEEE1284_MODE_NIBBLE:
 	case IEEE1284_MODE_BYTE:
 		parport_negotiate (port, IEEE1284_MODE_COMPAT);
+		/* fall through */
 	case IEEE1284_MODE_COMPAT:
 		DPRINTK (KERN_DEBUG "%s: Using compatibility mode\n",
 			 port->name);
-- 
2.7.4

