Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C89C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A291217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfACNur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:50:47 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:23696 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730599AbfACNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:50:46 -0500
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id DF/48-18993-3331E2C5; Thu, 03 Jan 2019 13:50:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRWlGSWpSXmKPExsVy8+3OTbpGwno
  xBm+2GVtMffiEzWL+kXOsFqe2NzFZ3P96lNHi25UOJovLu+awWcxe0s9isfT6RSaL1r1H2C32
  X/Fy4PJYM28No8e3r5NYPHbOusvusWlVJ5vHnWt72DyO39jO5PF5k1wAexRrZl5SfkUCa0bzg
  e+sBddZK3qXnmdsYNzC0sXIxSEksIpRYv7VxYwQzhNGiZ4zLcwQzkpGiZnnGoDKODnYBKwkdq
  9ZDGaLCChLPFjawApSxCywlUnixt+LbF2MHBzCAi4Sc57GgNSwCKhIPJi2jRHE5hXwlmjeeZs
  ZxJYQkJO4ea4TzOYU8JU4Ov0gmC0k4CNxf8ZkNoh6QYmTM5+A7WIWkJA4+OIFVI2WxNV/B9lB
  VkkIKEi8fBMHMTJOYu7Mo0wQYU2JzgdZEGF7ienvr0JtNZT4PusbC4RtLnHncBcjhG0jcehvK
  xuEbSqx6et0OHvC/GaWCYwSs5AcNAvJQQsYmVYxWiQVZaZnlOQmZuboGhoY6BoaGukaWprrGh
  qZ6yVW6SbppZbqlqcWl+ga6iWWF+sVV+Ym56To5aWWbGIERn5KwdH6HYyt3emHGCU5mJREeU1
  u6MYI8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuANFtSLERIsSk1PrUjLzAGmIJi0BAePkggvnxBQ
  mre4IDG3ODMdInWKUVFKnFcHpE8AJJFRmgfXBkt7lxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzM
  CoJ81aATOHJzCuBm/4KaDET0GITCR2QxSWJCCmpBsbDfDVHNXn98tw6rt1yZXvPW7LpQM4uSc
  Vw33CWBdvndrHMmNb0Z6Zb44vZATleFudY1DsU5zx4kSHj3jLz4LxlJn2VVvKbL2fNfBblFcw
  5V4R90tSZYUtnVRmdCmn89HXDMZ/7Vz4EKbfc4egUXic56cdPm98yHYunNE7612DO4Z2uN+n/
  Ii0lluKMREMt5qLiRACdeJvXdgMAAA==
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-26.tower-288.messagelabs.com!1546523441!5183639!5
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18587 invoked from network); 3 Jan 2019 13:50:42 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-26.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 3 Jan 2019 13:50:42 -0000
Received: from SVEX01011.wago.local (10.1.103.229) by SVEX01005.wago.local
 (10.1.101.121) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 3 Jan
 2019 14:47:48 +0100
Received: from lc010965.wago.local (10.1.101.133) by SVEX01011.wago.local
 (10.1.103.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 3 Jan 2019
 14:47:47 +0100
Received: from LC010965.wago.local (lc010965.wago.local [127.0.0.1])    by
 lc010965.wago.local (Postfix) with ESMTP id C59E81700FF9;      Thu,  3 Jan 2019
 14:47:47 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 0/2] Add input voltage configuration for TPS65218
Date:   Thu, 3 Jan 2019 14:47:04 +0100
Message-ID: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.133]
X-ClientProxiedBy: SVEX01011.wago.local (10.1.103.229) To SVEX01011.wago.local
 (10.1.103.229)
X-KSE-ServerInfo: SVEX01011.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 03.01.2019 11:05:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 7aa37ed7-add0-4ed7-8916-66d632c2b0a3
X-PP-Proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to configure input-voltage settings
of the TPS65218 regulator via device tree.

Changes for v2:
 - handle the different options in separate functions
 - add "ti," prefix and "-microvolt" postfix
 - remove debug prints
 - abort with an error in case of invalid values.
 - extend documentation of the options (taken from the datasheet)

Christian Hohnstaedt (2):
  dt-bindings: regulator: extend tps65218 bindings
  mfd: tps65218.c: Add input voltage options

 .../devicetree/bindings/regulator/tps65218.txt     | 22 ++++++
 drivers/mfd/tps65218.c                             | 87 ++++++++++++++++++++++
 include/linux/mfd/tps65218.h                       |  4 +
 3 files changed, 113 insertions(+)

-- 
2.7.4

