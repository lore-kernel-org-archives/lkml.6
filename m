Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JL+NHC41GVtnVQAAmS7hNA
	; Thu, 07 Jun 2018 13:37:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6384F608B8; Thu,  7 Jun 2018 13:37:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D4828606DD;
	Thu,  7 Jun 2018 13:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4828606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932818AbeFGNhs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:37:48 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:43348 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932792AbeFGNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:37:43 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id vpdc1x0093XaVaC01pdcZC; Thu, 07 Jun 2018 15:37:41 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQv6e-0000CV-4L; Thu, 07 Jun 2018 15:37:36 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fQuIC-0005vo-Qs; Thu, 07 Jun 2018 14:45:28 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Eyal Ilsar <eilsar@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] wcn36xx: Remove Unicode Byte Order Mark from testcode
Date: Thu,  7 Jun 2018 14:45:27 +0200
Message-Id: <1528375527-22761-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older gcc (< 4.4) doesn't like files starting with a Unicode BOM:

    drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray ‘\357’ in program
    drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray ‘\273’ in program
    drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray ‘\277’ in program

Remove the BOM, the rest of the file is plain ASCII anyway.

Output of "file drivers/net/wireless/ath/wcn36xx/testmode.c" before:

    drivers/net/wireless/ath/wcn36xx/testmode.c: C source, UTF-8 Unicode (with BOM) text

and after:

    drivers/net/wireless/ath/wcn36xx/testmode.c: C source, ASCII text

Fixes: 87f825e6e246cee0 ("wcn36xx: Add support for Factory Test Mode (FTM)")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/net/wireless/ath/wcn36xx/testmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/testmode.c b/drivers/net/wireless/ath/wcn36xx/testmode.c
index 1279064a3b716c2e..51a038022c8b8040 100644
--- a/drivers/net/wireless/ath/wcn36xx/testmode.c
+++ b/drivers/net/wireless/ath/wcn36xx/testmode.c
@@ -1,4 +1,4 @@
-﻿/*
+/*
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  *
  * Permission to use, copy, modify, and/or distribute this software for any
-- 
2.7.4
