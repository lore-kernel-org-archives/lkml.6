Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC23C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04AC2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfBYHQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 02:16:21 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:56536 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727181AbfBYHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 02:16:20 -0500
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 9D/E7-05904-146937C5; Mon, 25 Feb 2019 07:16:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRWlGSWpSXmKPExsVy8+3OTbqO04p
  jDFZMELCY+vAJm8X8I+dYLb5d6WCyuLxrDpvF0usXmSxa9x5hd2DzWDNvDaPHzll32T02repk
  8/i8SS6AJYo1My8pvyKBNWPen/dsBQvYKl5+e8PWwHiMtYuRi0NI4CmjxMp3nSxdjJxAToXE5
  NY7bCA2m4CVxO41i8HiIgKeEpu3X2UGaWAWaGeUeLbhHDtIQljAXWLW2sdgDSwCqhIvNj8Cms
  rBwSvgK7H4SRZIWEJATuLmuU5mEJtXQFDi5MwnYDOZBSQkDr54wQyxV0vi6r+D7CCtEgIKEi/
  fxEGYcRILjttDTNGUeLB8MxuEbS8x/f1VZgjbUOL7rG8sELa5xLx7U6DiNhKH/rZC1ZtKrP54
  h2UCo8gsJEfMQnLEAkamVYyWSUWZ6RkluYmZObqGBga6hobGuia6hpZmeolVukl6qaW6yal5J
  UWJQFm9xPJiveLK3OScFL281JJNjMCYSilkObKD8X17+iFGSQ4mJVFem9ziGCG+pPyUyozE4o
  z4otKc1OJDjDIcHEoSvJsmAOUEi1LTUyvSMnOA0Q2TluDgURLh1ZsClOYtLkjMLc5Mh0idYlS
  UEud9DpIQAElklObBtcESyiVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrzXQKbwZOaVwE1/
  BbSYCWhx35d8kMUliQgpqQbGtNqXP6pvNCfMiC+7l8/vnK3zqe3P5tW3OpgOKvBvs2zxOuNbw
  FRyaNuXrcqPmcwa1zpHssf8Cf+1PzWk6XXxlNliSWYTl+pzm98ofrL9kWxGyOKMGz/TSmrnJj
  95JKvzL/vObJOkbRPnTf7cEB8ucoBj58qmnbZTBbVZ7krL+CoExQjPT+hVYinOSDTUYi4qTgQ
  AHJMqQiMDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-26.tower-246.messagelabs.com!1551078976!1944568!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11829 invoked from network); 25 Feb 2019 07:16:17 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-26.tower-246.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 25 Feb 2019 07:16:17 -0000
Received: from lc010965.wago.local (10.1.101.133) by SVEX01010.wago.local
 (10.1.103.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 25 Feb
 2019 08:16:16 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id 6D09517001A3; Mon, 25 Feb 2019 08:16:16 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: regulator: tps65218: rectify units of LS3
Date:   Mon, 25 Feb 2019 08:15:03 +0100
Message-ID: <1551078903-14447-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.133]
X-ClientProxiedBy: SVEX01010.wago.local (10.1.103.228) To SVEX01010.wago.local
 (10.1.103.228)
X-KSE-ServerInfo: SVEX01010.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 25.02.2019 03:58:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 3501de6a-633d-491f-8a4a-2b9665cb6ea9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS3 has a selectable current limit.
Change units to microamp in the example.

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 Documentation/devicetree/bindings/regulator/tps65218.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
index b28e9bd..54aded3 100644
--- a/Documentation/devicetree/bindings/regulator/tps65218.txt
+++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
@@ -77,7 +77,7 @@ tps65218: tps65218@24 {
 	};
 
 	ls3: regulator-ls3 {
-		regulator-min-microvolt = <100000>;
-		regulator-max-microvolt = <1000000>;
+		regulator-min-microamp = <100000>;
+		regulator-max-microamp = <1000000>;
 	};
 };
-- 
2.7.4

