Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F239C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E9120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfANUfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:35:14 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.105]:11124 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbfANUfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:35:14 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 3C82585F64
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:35:13 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j8wzgbClGdnCej8wzgg1EW; Mon, 14 Jan 2019 14:35:13 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=59138 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj8wx-000L18-R5; Mon, 14 Jan 2019 14:35:12 -0600
Date:   Mon, 14 Jan 2019 14:35:07 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] adfs: mark expected switch fall-throughs
Message-ID: <20190114203507.GA17953@embeddedor>
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
X-Exim-ID: 1gj8wx-000L18-R5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:59138
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/adfs/dir_f.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 0fbfd0b04ae0..382c9d7ad375 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -24,8 +24,11 @@ static inline unsigned int adfs_readval(unsigned char *p, int len)
 
 	switch (len) {
 	case 4:		val |= p[3] << 24;
+			/* fall through */
 	case 3:		val |= p[2] << 16;
+			/* fall through */
 	case 2:		val |= p[1] << 8;
+			/* fall through */
 	default:	val |= p[0];
 	}
 	return val;
@@ -35,8 +38,11 @@ static inline void adfs_writeval(unsigned char *p, int len, unsigned int val)
 {
 	switch (len) {
 	case 4:		p[3] = val >> 24;
+			/* fall through */
 	case 3:		p[2] = val >> 16;
+			/* fall through */
 	case 2:		p[1] = val >> 8;
+			/* fall through */
 	default:	p[0] = val;
 	}
 }
-- 
2.20.1

