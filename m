Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A77EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DD221773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBTIQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:16:30 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.5]:55919 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbfBTIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:16:20 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-central-1.aws.symcld.net id C0/8E-12121-FCC0D6C5; Wed, 20 Feb 2019 08:16:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRWlGSWpSXmKPExsVy8+3OTbrneXJ
  jDGZ+0LSY+vAJm8X8I+dYLU5tb2Ky+Halg8ni8q45bBazl/SzWCy9fpHJonXvEXaL/Ve8HDg9
  1sxbw+jx7eskFo+ds+6ye2xa1cnmcfzGdiaPz5vkAtiiWDPzkvIrElgzls6sKJjOXtE/SbyBc
  TVbFyMnh5DAU0aJeYdtIewKiZkd3xhBbDYBK4ndaxazgNgiAgoSH5ruAdVzcTALTGCSOHP4IC
  tIQljAQeLE4sXMIDaLgKrE+i9fwBp4BXwl/u35DrZAQkBO4ua5TrAaTgE/iUmTzjBDLPOVuNb
  /ix2iXlDi5MwnYL3MAhISB1+8gKrRkrj67yA7xBwFieUHpjFC2HESHXshZkoIaEo0LNvGBGHb
  S0x/fxUqbijxfdY3FgjbXOLtjclQvTYSh/62Qt1mKvHqx2SmCYxis5CcMQvJGQsYmVYxWiQVZ
  aZnlOQmZuboGhoY6BoaGusa61oa6iVW6SbqpZbqJqfmlRQlAiX1EsuL9Yorc5NzUvTyUks2MQ
  IjNqWQOXoH44ql6YcYJTmYlER5y27kxAjxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4NXjzo0REix
  KTU+tSMvMAaYOmLQEB4+SCO9ZLqA0b3FBYm5xZjpE6hSjopQ4rygrUEIAJJFRmgfXBktXlxhl
  pYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ8zIxA03hycwrgZv+CmgxE9DiWf+zQRaXJCKkpBoYQ
  2wd58c6v5Kce0LW482KE+WpXUwywoXTCu1ro45+K2Tes0js6r7ZmfOZLAO+Zpaskn6jv4tngV
  nbEfVG/vTdGytzprKtcDGQnssUc/Qp776KmDV5nJ+nbf96xMdanndPZ4tpyq6Xz1v8vplFv6x
  1MdH89at83qSf0kLhcWFxJhFp3peOhvkrsRRnJBpqMRcVJwIAxzlgQFIDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-30.tower-223.messagelabs.com!1550650575!1363397!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4060 invoked from network); 20 Feb 2019 08:16:15 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-30.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2019 08:16:15 -0000
Received: from lc010965.wago.local (10.1.101.135) by SVEX01009.wago.local
 (10.1.103.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 20 Feb
 2019 09:16:14 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id D5C211704213; Wed, 20 Feb 2019 09:16:14 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     J Keerthy <j-keerthy@ti.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: regulator: Add LS2 load switch
Date:   Wed, 20 Feb 2019 09:15:51 +0100
Message-ID: <1550650552-26013-3-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.135]
X-ClientProxiedBy: SVEX01010.wago.local (10.1.103.228) To SVEX01009.wago.local
 (10.1.103.227)
X-KSE-ServerInfo: SVEX01009.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 20.02.2019 07:25:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 81a9f692-418a-4f33-bb70-032f75efc73b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and change units of LS3 example from microvolt to microamp

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 Documentation/devicetree/bindings/regulator/tps65218.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index 02f0e9b..54aded3 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -71,8 +71,13 @@ tps65218: tps65218@24 {
 		regulator-always-on;
 	};
 
+	ls2: regulator-ls2 {
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
+	};
+
 	ls3: regulator-ls3 {
-		regulator-min-microvolt = <100000>;
-		regulator-max-microvolt = <1000000>;
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
 	};
 };
-- 
2.7.4

