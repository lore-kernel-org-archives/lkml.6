Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDEFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C642086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfANIQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:16:46 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.6]:35181 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbfANIQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:16:46 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-a.eu-central-1.aws.symcld.net id FB/C1-02885-A654C3C5; Mon, 14 Jan 2019 08:16:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRWlGSWpSXmKPExsVy8+3OTbpZrjY
  xBrN/s1lMffiEzWL+kXOsFqe2NzFZ3P96lNHi25UOJovLu+awWcxe0s9isfT6RSaL1r1H2C32
  X/Fy4PJYM28No8e3r5NYPHbOusvusWlVJ5vHnWt72DyO39jO5PF5k1wAexRrZl5SfkUCa0bbh
  xbGgtNsFXteNDA2ME5n7WLk4hASWM0ocf/5V3YI5ymjxP/Ws2xdjJxAToVE97npTCA2m4CVxO
  41i1lAbBEBOYkpX6ezgDQwC2xlkrjx9yJYg7CAi8SNT0fAilgEVCVuXmxjBrF5BXwluq/9YAW
  xJYCab57rBItzCvhIPGieArXMW+LT9sdsEPWCEidnPgGbwywgIXHwxQtmiBotiav/DrJDzFGQ
  2Ne4GMjmALLjJBYct4cIa0o8WL6ZDcK2l5j+/iozhG0o8X3WNxYI21xidsMWqDE2Eof+tkLVm
  0qs/niHBcaeML+ZZQKjxCwkF81CctECRqZVjBZJRZnpGSW5iZk5uoYGBrqGhsa6IFIvsUo3US
  +1VDc5Na+kKBEoqZdYXqxXXJmbnJOil5dasokRGPsphQzcOxgnLE8/xCjJwaQkyvvZySZGiC8
  pP6UyI7E4I76oNCe1+BCjDAeHkgRvkQtQTrAoNT21Ii0zB5iEYNISHDxKIrzxIGne4oLE3OLM
  dIjUKUZFKXHebyAJAZBERmkeXBss8V1ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMw7D2QKT
  2ZeCdz0V0CLmYAWs72xBllckoiQkmpg1Iqd2qexWYOjf81jc82zcxLMa20z78t9VE3VNdf1Ed
  swaeVUa6VVXQJB/bfyJ2R6zrX3ODyXR6BsWo7xv4dbi/W+VfxJZxDMeJDleHzXm4Ni/5Q+p1e
  1OTIz8Lcesgpb/qpmyT0+myoOg/8Cf1l/HuSxnHzE5YHOQqt82ajVK53npx75X7dRiaU4I9FQ
  i7moOBEAiX4cpncDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-37.tower-223.messagelabs.com!1547453801!105249!2
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24987 invoked from network); 14 Jan 2019 08:16:42 -0000
Received: from unknown (HELO SVEX01005.wago.local) (217.237.185.178)
  by server-37.tower-223.messagelabs.com with AES128-SHA encrypted SMTP; 14 Jan 2019 08:16:42 -0000
Received: from SVEX01010.wago.local (10.1.103.228) by SVEX01005.wago.local
 (10.1.101.121) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 14 Jan
 2019 09:16:40 +0100
Received: from lc010965.wago.local (10.1.101.131) by SVEX01010.wago.local
 (10.1.103.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Mon, 14 Jan
 2019 09:16:40 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)        id
 3323317029D7; Mon, 14 Jan 2019 09:16:40 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Keerthy <j-keerthy@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v3 0/2] Add input voltage configuration for TPS65218
Date:   Mon, 14 Jan 2019 09:16:32 +0100
Message-ID: <1547453794-18770-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
References: <1546523226-358-1-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.131]
X-ClientProxiedBy: SVEX01010.wago.local (10.1.103.228) To SVEX01010.wago.local
 (10.1.103.228)
X-KSE-ServerInfo: SVEX01010.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 14.01.2019 03:24:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: 3501de6a-633d-491f-8a4a-2b9665cb6ea9
X-PP-Proceessed: 8707ce24-8c4e-4a04-80f2-2a31f9152b06
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to configure input-voltage settings
of the TPS65218 regulator via device tree.

Changes for v3 (whitespace changes only):
 - fix indentation issues found by "checkpatch.pl --strict" in tps65218.c

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
 drivers/mfd/tps65218.c                             | 89 ++++++++++++++++++++++
 include/linux/mfd/tps65218.h                       |  4 +
 3 files changed, 115 insertions(+)

--
2.7.4

