Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9289E20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfBYGmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:42:50 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:27918 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbfBYGmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:42:49 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 5A/CF-18573-66E837C5; Mon, 25 Feb 2019 06:42:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRWlGSWpSXmKPExsVy8+3OTbppfcU
  xBievM1lMffiEzWL+kXOsFqe2NzFZfLvSwWRxedccNovZS/pZLJZev8hk0br3CLvF/iteDpwe
  a+atYfT49nUSi8fOWXfZPTat6mTzOH5jO5PH501yAWxRrJl5SfkVCawZrZuuMBacZ67oPdjN2
  sB4j6mLkYtDSOApo8TFaYeBHE4gp0Kiaf5zRhCbTcBKYveaxSwgtoiAssTV73vBbGaBXiaJqf
  /DQWxhAQuJ3qNLwXpZBFQlPmy6yQ5i8wr4SjRsWMIMYksIyEncPNcJZnMK+ElMmnSGGWKXr8S
  1/l9Q9YISJ2c+gZovIXHwxQuoGi2Jq/8OAtVwAM1RkHj5Jg5iZJzEyl2nWSFsTYmGZduYIGx7
  ienvr0KtNZT4PusbC4RtLjHv3hSouI3Eob+tbBC2qcSrH5OZJjCKzUJyxSwkVyxgZFrFaJFUl
  JmeUZKbmJmja2hgoGtoaKRraGmsa2hmopdYpZuol1qqW55aXKJrqJdYXqxXXJmbnJOil5daso
  kRGLMpBQeX7GB8tDz9EKMkB5OSKK9NbnGMEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQneuB6gnGB
  RanpqRVpmDjB5wKQlOHiURHiTeoHSvMUFibnFmekQqVOMilLivPdA+gRAEhmleXBtsIR1iVFW
  SpiXkYGBQYinILUoN7MEVf4VozgHo5IwbyPIFJ7MvBK46a+AFjMBLe77kg+yuCQRISXVwLjhU
  ujXDO/GLx/6fn/OvN5+OlrbOn72Y4sn8+fsY3hQuO360hvlTPF1E6I+HMiuKPrstPHqq5kak+
  JmnE0W7qhz2bpslotO2lvHfKuH5kEXBSoMxD4/MmQIOBnCZS7bOFmvuli+6/nkbdp5smzbvhW
  zuAjXLbuhs1wtLvf0nz0sZUnXD/fN/aLEUpyRaKjFXFScCABrRwKWUwMAAA==
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-21.tower-262.messagelabs.com!1551076965!1857759!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5846 invoked from network); 25 Feb 2019 06:42:46 -0000
Received: from unknown (HELO mail.wago.com) (217.237.185.178)
  by server-21.tower-262.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 25 Feb 2019 06:42:46 -0000
Received: from lc010965.wago.local (10.1.101.133) by SVEX01009.wago.local
 (10.1.103.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 25 Feb
 2019 07:42:45 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)
        id 2557B17001A3; Mon, 25 Feb 2019 07:42:45 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Mark Brown <broonie@kernel.org>
CC:     J Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] regulator: tps65218: support LS2
Date:   Mon, 25 Feb 2019 07:41:04 +0100
Message-ID: <1551076866-12578-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1550650552-26013-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.133]
X-ClientProxiedBy: SVEX01009.wago.local (10.1.103.227) To SVEX01009.wago.local
 (10.1.103.227)
X-KSE-ServerInfo: SVEX01009.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 25.02.2019 03:58:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 81a9f692-418a-4f33-bb70-032f75efc73b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the LS2 regulator in the tps65218 device


Christian Hohnstaedt (2):
  dt-bindings: regulator: Add LS2 load switch documentation
  regulator: tps65218: Add support for LS2

 .../devicetree/bindings/regulator/tps65218.txt         |  4 ++--
 drivers/regulator/tps65218-regulator.c                 | 18 +++++++++++++-----
 include/linux/mfd/tps65218.h                           |  3 ++-
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.7.4

