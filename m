Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD2220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD2220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wago.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbeLFJ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:58:04 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.131]:27203 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727832AbeLFJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:58:03 -0500
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.eu-west-1.aws.symcld.net id EC/0C-12541-8A2F80C5; Thu, 06 Dec 2018 09:58:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsVy8+3OTborPnH
  EGHQ3aFuc2t7EZHH/61FGi8u75rBZzF7Sz+LA4nHn2h42j+M3tjN5fN4kF8AcxZqZl5RfkcCa
  cXjTPqaCiawV02bdY2xg3MTSxcjFISSwilHi9PU/jBDOE0aJdyeXMncxcgI5FRJnJ89lBLHZB
  Kwkdq9ZzAJiiwi4Siz+eZwNxGYWcJDoP7GIFcQWFnCT+HNgBTuIzSKgIvGiZQXQHA4OXgFfib
  4tGSBhCQE5iZvnOsHG8woISpyc+YQFYoyExMEXL6DWaklc/XeQHaJeQeLc+m1MEHacxOffLUw
  gIyUENCVOL0uCCNtLTH9/lRnCNpT4PusbC4RtLrF00nNWCNtG4tDfVjYI21Ti+5ErrDD28fZZ
  zBMYxWYhuWgWkosWMDKtYrRIKspMzyjJTczM0TU0MNA1NDTSNQLRBhZ6iVW6yXqppbrlqcUlu
  oZ6ieXFesWVuck5KXp5qSWbGIFRllJwImcH4+729EOMkhxMSqK83QfYY4T4kvJTKjMSizPii0
  pzUosPMcpwcChJ8B76yBEjJFiUmp5akZaZA4x3mLQEB4+SCG8tSJq3uCAxtzgzHSJ1ilFRSpw
  3+D1QQgAkkVGaB9cGSzGXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgnzSoOM58nMK4Gb/gpo
  MRPQ4pwtTCCLSxIRUlINjKas86oNpB48yZNwPPX693eNvU4F1qKu1xzMA1qzude1f0/vuhNcX
  a5zR3LR++2bHony3jprpZnOL3v1ig/LdKdzW8w3bJ0t314tXuHAaZjxrd76surKRT2WW2sXaB
  6MNlUQERYrTP0j+omDS0mF511Czp373BxOHf9mRE5+vsM8ynaDpLCSEktxRqKhFnNRcSIAmdA
  obCwDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-13.tower-308.messagelabs.com!1544090280!3491985!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26942 invoked from network); 6 Dec 2018 09:58:00 -0000
Received: from unknown (HELO SVEX01006.wago.local) (217.237.185.178)
  by server-13.tower-308.messagelabs.com with AES128-SHA encrypted SMTP; 6 Dec 2018 09:58:00 -0000
Received: from SVEX01013.wago.local (10.1.103.231) by SVEX01006.wago.local
 (10.1.101.122) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 6 Dec
 2018 10:57:59 +0100
Received: from lc010965.wago.local (10.1.101.138) by SVEX01013.wago.local
 (10.1.103.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 6 Dec 2018
 10:57:59 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)        id
 880E31700209; Thu,  6 Dec 2018 10:57:59 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Date:   Thu, 6 Dec 2018 10:57:59 +0100
Message-ID: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.138]
X-ClientProxiedBy: SVEX01013.wago.local (10.1.103.231) To SVEX01013.wago.local
 (10.1.103.231)
X-KSE-ServerInfo: SVEX01013.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 06.12.2018 02:15:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 0e6009ac-ccf0-4540-927c-32c649c0c00d
X-PP-Proceessed: 76874689-fff8-43e0-8f1a-01f8fc6dac97
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free allocated IRQ if reading the device ID fails.

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/mfd/tps65218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index 910f569..19270bc 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -244,7 +244,7 @@ static int tps65218_probe(struct i2c_client *client,
 	ret = regmap_read(tps->regmap, TPS65218_REG_CHIPID, &chipid);
 	if (ret) {
 		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
-		return ret;
+		goto err_irq;
 	}
 
 	tps->rev = chipid & TPS65218_CHIPID_REV_MASK;
-- 
2.7.4

