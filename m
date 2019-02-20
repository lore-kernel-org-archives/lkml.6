Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE4D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfBTIQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:16:20 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:55294 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbfBTIQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:16:19 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id 18/6A-30036-0DC0D6C5; Wed, 20 Feb 2019 08:16:16 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRWlGSWpSXmKPExsVy8+3OTbrneXJ
  jDJpWmVhMffiEzWL+kXOsFqe2NzFZfLvSwWRxedccNovZS/pZLJZev8hk0br3CLvF/iteDpwe
  a+atYfT49nUSi8fOWXfZPTat6mTzOH5jO5PH501yAWxRrJl5SfkVCawZKzpnshfcZa54/ekIS
  wNjO3MXIxeHkMBTRomzSxrZuhg5gZwKiYWLdzKC2GwCVhK71yxmAbFFBBQkPjTdYwNpYBaYwC
  Rx5vBBVpCEsICtxOS2dUwgNouAqsTl6ffA4rwCvhK9NzrABkkIyEncPNfJDBEXlDg58wnYUGY
  BTYnW7b/ZIWx5ieats5khjtCSuPrvIDtEr4JE89mlTBB2nMTaQyfZIGxNiYZl26Di9hLT319l
  hrANJb7P+sYCYZtLvL0xGeoGG4lDf1uhek0lXv2YzDSBUXQWkpNmITlpFpKTFjAyr2K0TCrKT
  M8oyU3MzNE1NDDQNTQ01gWSliZ6iVW6iXqppbrJqXklRYlAWb3E8mK94src5JwUvbzUkk2MwM
  hNKWQ4tIPxy9L0Q4ySHExKorxlN3JihPiS8lMqMxKLM+KLSnNSiw8xynBwKEnw6nHnxggJFqW
  mp1akZeYAUwhMWoKDR0mE9ywXUJq3uCAxtzgzHSJ1ilFRSpxXlBUoIQCSyCjNg2uDpa1LjLJS
  wryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5mZiBpvBk5pXATX8FtJgJaPGs/9kgi0sSEVJSDYx1J
  QFugfKFUX31jXM1cu+6R845cnbxC82t75mFlrH+mTwh0crktpOTKZ+RHpe339nJL/m50yXqg5
  a7pjaf6fr+9ejyoHdyGbducH9KrZW4GMSjGfxLNTFX1Ixx2uO2C8qcn9U8zvTytgR2v+Z6cT9
  Ni818XdTT1zN+9l321Hif9eHHwoDVakosxRmJhlrMRcWJAPyZ3alWAwAA
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-30.tower-223.messagelabs.com!1550650575!1363397!2
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4077 invoked from network); 20 Feb 2019 08:16:15 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-30.tower-223.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 20 Feb 2019 08:16:15 -0000
Received: from lc010965.wago.local (10.1.101.137) by SVEX01009.wago.local
 (10.1.103.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Wed, 20 Feb
 2019 09:16:14 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id CE9321704211; Wed, 20 Feb 2019 09:16:14 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     J Keerthy <j-keerthy@ti.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] regulator: tps65218: Fix LS3 and add LS2
Date:   Wed, 20 Feb 2019 09:15:49 +0100
Message-ID: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.101.137]
X-ClientProxiedBy: SVEX01014.wago.local (10.1.103.232) To SVEX01009.wago.local
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

The patch-series fixes issues in the LS3 configuration
and adds support for the LS2 regulator in the tps65218

Christian Hohnstaedt (3):
  regulator: tps65218.c: fix LS3 issues
  dt-bindings: regulator: Add LS2 load switch
  regulator: tps65218: Add support for LS2

 .../devicetree/bindings/regulator/tps65218.txt     |  9 +++++++--
 drivers/regulator/tps65218-regulator.c             | 23 +++++++++++++++-------
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.7.4

