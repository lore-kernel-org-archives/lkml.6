Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB592070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfBTIQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:16:44 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.117]:51654 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbfBTIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:16:20 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-central-1.aws.symcld.net id CC/BD-16347-0DC0D6C5; Wed, 20 Feb 2019 08:16:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRWlGSWpSXmKPExsVy8+3OTbrneXJ
  jDLonWlhMffiEzWL+kXOsFqe2NzFZfLvSwWRxedccNovZS/pZLJZev8hk0br3CLvF/iteDpwe
  a+atYfT49nUSi8fOWXfZPTat6mTzOH5jO5PH501yAWxRrJl5SfkVCawZWxb1sBSs5aq4+u8gY
  wPja44uRi4OIYGnjBIbJp5k72LkAHIqJF7PCOli5ORgE7CS2L1mMQuILSKgIPGh6R4bSD2zwA
  QmiTOHD7KCJISBit5eOcIC0ssioCpxczcfSJhXwFfi447dTCC2hICcxM1zncwgNqeAn8SkSWf
  AbCGgmmv9v9gh6gUlTs58AraLWUBTonX7b3YIW16ieetsqHotCaC72SFmKki07JzHBmHHSXz+
  3cIEcoIEUO/pZUkQYXuJ6e+vMkPYhhLfZ31jgbDNJd7emMwIYdtIHPrbCjXGVOL7kSusExjFZ
  yG5aBaSi2YhuWgBI/MqRsukosz0jJLcxMwcXUMDA11DQ2NdU11DExO9xCrdJL3UUt3k1LySok
  SgrF5iebFecWVuck6KXl5qySZGYIynFLJO2MG4ZHn6IUZJDiYlUd6yGzkxQnxJ+SmVGYnFGfF
  FpTmpxYcYZTg4lCR49bhzY4QEi1LTUyvSMnOAyQYmLcHBoyTCe5YLKM1bXJCYW5yZDpE6xago
  Jc4rygqUEABJZJTmwbXBEtwlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8TMxAU3gy80rgp
  r8CWswEtHjW/2yQxSWJCCmpBsbyj0oXDMNvOLI4fDzNsdmhpeNr5QHz1+qPH9+ybPpQqjjhTn
  Kpas4mBs97zX+vF4o1eJhVqU8J511pWvu67V32960+v83PvP2w/lhhtbr8FNYdUjqOL7NCT5X
  sXRP2zDbX9fAX4bSA/L0+59/csX+Zle/p/FqXOXxNuOnT/5qHS/4sZN7Uv0qJpTgj0VCLuag4
  EQC2zEcGawMAAA==
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-28.tower-239.messagelabs.com!1550650575!1443181!2
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1497 invoked from network); 20 Feb 2019 08:16:15 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-28.tower-239.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2019 08:16:15 -0000
Received: from lc010965.wago.local (10.1.101.136) by SVEX01013.wago.local
 (10.1.103.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 20 Feb
 2019 09:16:14 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id D15F017002D8; Wed, 20 Feb 2019 09:16:14 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     J Keerthy <j-keerthy@ti.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] regulator: tps65218.c: fix LS3 issues
Date:   Wed, 20 Feb 2019 09:15:50 +0100
Message-ID: <1550650552-26013-2-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.101.136]
X-ClientProxiedBy: SVEX01013.wago.local (10.1.103.231) To SVEX01013.wago.local
 (10.1.103.231)
X-KSE-ServerInfo: SVEX01013.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 20.02.2019 07:25:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 0e6009ac-ccf0-4540-927c-32c649c0c00d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix list of valid LS3 currents from mA to µA
- Fix selection of min/max microAmps of LS3.
  Selecting one of the configured values as max value now really
  selects it instead of the next lower one

Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
---
 drivers/regulator/tps65218-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 6209bee..5dd559e 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -188,7 +188,8 @@ static struct regulator_ops tps65218_ldo1_dcdc34_ops = {
 	.set_suspend_disable	= tps65218_pmic_set_suspend_disable,
 };
 
-static const int ls3_currents[] = { 100, 200, 500, 1000 };
+static const int ls3_currents[] = { 100000, 200000, 500000, 1000000 };
+
 
 static int tps65218_pmic_set_input_current_lim(struct regulator_dev *dev,
 					       int lim_uA)
@@ -214,7 +215,7 @@ static int tps65218_pmic_set_current_limit(struct regulator_dev *dev,
 	unsigned int num_currents = ARRAY_SIZE(ls3_currents);
 	struct tps65218 *tps = rdev_get_drvdata(dev);
 
-	while (index < num_currents && ls3_currents[index] < max_uA)
+	while (index < num_currents && ls3_currents[index] <= max_uA)
 		index++;
 
 	index--;
-- 
2.7.4

