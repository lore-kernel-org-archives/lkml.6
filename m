Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F77C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4AE2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfBRSwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:52:07 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.119]:21987 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726258AbfBRSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:52:06 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id C300D12C7B5A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:52:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id vo1NgIe7biQervo1NgWvTf; Mon, 18 Feb 2019 12:52:05 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=43684 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gvo1M-000UmY-En; Mon, 18 Feb 2019 12:52:05 -0600
Date:   Mon, 18 Feb 2019 12:52:01 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: vt6656: key: Mark expected switch fall-throughs
Message-ID: <20190218185201.GA15168@embeddedor>
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
X-Exim-ID: 1gvo1M-000UmY-En
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:43684
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/staging/vt6656/key.c: In function ‘vnt_set_keymode’:
drivers/staging/vt6656/key.c:70:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
   key->hw_key_idx = entry;
   ~~~~~~~~~~~~~~~~^~~~~~~
drivers/staging/vt6656/key.c:71:2: note: here
  case VNT_KEY_ALLGROUP:
  ^~~~
drivers/staging/vt6656/key.c:73:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (onfly_latch)
      ^
drivers/staging/vt6656/key.c:75:2: note: here
  case VNT_KEY_GROUP_ADDRESS:
  ^~~~
drivers/staging/vt6656/key.c:76:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
   key_mode |= mode;
   ~~~~~~~~~^~~~~~~
drivers/staging/vt6656/key.c:77:2: note: here
  case VNT_KEY_GROUP:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/vt6656/key.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/key.c b/drivers/staging/vt6656/key.c
index 91dede54cc1f..dcd933a6b66e 100644
--- a/drivers/staging/vt6656/key.c
+++ b/drivers/staging/vt6656/key.c
@@ -63,17 +63,19 @@ static int vnt_set_keymode(struct ieee80211_hw *hw, u8 *mac_addr,
 	}
 
 	switch (key_type) {
-		/* fallthrough */
 	case VNT_KEY_DEFAULTKEY:
 		/* default key last entry */
 		entry = MAX_KEY_TABLE - 1;
 		key->hw_key_idx = entry;
+		/* fall through */
 	case VNT_KEY_ALLGROUP:
 		key_mode |= VNT_KEY_ALLGROUP;
 		if (onfly_latch)
 			key_mode |= VNT_KEY_ONFLY_ALL;
+		/* fall through */
 	case VNT_KEY_GROUP_ADDRESS:
 		key_mode |= mode;
+		/* fall through */
 	case VNT_KEY_GROUP:
 		key_mode |= (mode << 4);
 		key_mode |= VNT_KEY_GROUP;
-- 
2.20.1

