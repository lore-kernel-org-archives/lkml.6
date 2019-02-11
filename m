Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD854C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CE220844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfBKLTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:19:08 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfBKLTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:19:07 -0500
Received: from orion.localdomain ([95.117.94.93]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MY64R-1ga7r22tFF-00YPl9; Mon, 11 Feb 2019 12:19:05 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: [PATCH] input: keyboard: gpio-keys-polled: use input name from pdata if available
Date:   Mon, 11 Feb 2019 12:19:04 +0100
Message-Id: <1549883944-1210-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:5t4M4/McuYmnlk6c4Ezingt8syMfO1PFoiBPO+ESLLGNSASnoBc
 kNow00YsHT1UOPO8SewN19XfBv7ulQCDbXljdfKSLtAPLwBAQVre9AKhjUpOWs47mtpukCF
 QDBNDhjt9LMcaUHhmeA8trepqnDiBoYDzruBJKXJYMZigcGhZeJ3SEDbUtGxfOZYtLdsFzg
 yr2HSgtwV6r83Kw40wOzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s2456EcJA+w=:aUha8NLKDofW8UgEArdyrL
 nB8wOguE8w6Ys6cDcw380V7hnTbmG8md5SvkXMX67borkFxfOl/3BaHAV+1b+pifh6BEJ7ilY
 ZV7fz3uGvlCM4OntEoiHhY/detcL0g9ONHNfojSnP2psvULI3Ff7O5U52nIHYBrKxj4TUsaF8
 n0wd60BueeGNLN4DliqAbxEMw+iBpxZhlq3k3Jo91j75Xv7oY4rVemFGLPIw0xh6pw85Mfhsk
 5DaFa2jKlzvd4nMuBtdkHOhYFdzCGysCFNYYBbL3pPKOnczlnrNA3UKVnhEbU76H5g35EGj0Y
 3UpYUqGvNEs87bpGYlbldRlxocVSaWGNzMDYZ3kiLS7R0qIuXjuRsc68o7jco7+iMbICedwvt
 cQpE7abZ+X4d3WN4XIKpdQAyUe/AO96KKcuL4POhmgKAhycHu8BZXzAz44fPS0wxut2EzaVTA
 X6gI4Tw0JF4VWh9lIJO1bk6isTPDYCt9lPv30dpM73V/ALVfXGNLuK1e+ibBoV8rCQpvC8+Ym
 B2mWRs/pXdxorXQxclcvFtogioz4xw0bM7M7L+4SbuX2Jj8v8R6+I6syS4/igxWQ7nCyEzGMh
 vVAA9j86pMWRdl2JepFm+7zST8u5xVgkv3Vz2qA+lVV1twWm0X3gjU3KPIegOEhn44aJIlMC6
 P+owj7RlXA+7S1lAqWy1UwGbZH/daO1A/WW5tYt+cYBJOsW+gipeCnT5/sCw5Bm+BwQQ6ZWFF
 wJR5vkBCbXWzFSslmu61RKdjUKSTK4hs11CjjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hardcoding the input name to the driver name
('gpio-keys-polled'), allow the passing a name via platform data
('name' field was already present), but default to old behaviour
in case of NULL.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/input/keyboard/gpio_keys_polled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262..3312186 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -272,7 +272,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 	input = poll_dev->input;
 
-	input->name = pdev->name;
+	input->name = (pdata->name ? pdata->name : pdev->name);
 	input->phys = DRV_NAME"/input0";
 
 	input->id.bustype = BUS_HOST;
-- 
1.9.1

