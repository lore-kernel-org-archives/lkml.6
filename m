Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8202133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLRIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:06:35 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:54525 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbeLRIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:34 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 89/45-08839-78AA81C5; Tue, 18 Dec 2018 08:06:31 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRWlGSWpSXmKPExsVy8+3OTbrtqyR
  iDL7dELKY+vAJm8X8I+dYLe5/Pcpo8e1KB5PF5V1z2CxmL+lnsVh6/SKTReveI+wW+694OXB6
  rJm3htHj29dJLB47Z91l99i0qpPN4861PWwenzfJBbBFsWbmJeVXJLBm/OlbxFwwm7li4YYu1
  gbGI0xdjFwcQgKrGSV+T5rHCuE8ZZQ40/sayOEEciokJnY3sYHYbAJWErvXLGbpYuTgEBFQkT
  j3xhyknllgCpPExtnTWEBqhAUcJR697WUHsVkEVCUadywBi/MK+Eh0floIZksIyEncPNfJDBE
  XlDg58wlYnFlAQuLgixfMEHu1JK7+O8gOUa8g0bJzHhvIXgmBOInL/dkQYU2J5zueMkLY9hLT
  319lhrANJb7P+ga1ylzi+MfLUHEbiUN/W9kgbFOJFXNh4qYSx9tnMU9gFJuF5KJZSC5awMi0i
  tEiqSgzPaMkNzEzR9fQwEDX0NBY10TXwkgvsUo3SS+1VDc5Na+kKBEoqZdYXqxXXJmbnJOil5
  dasokRGLUphSxBOxiXLU8/xCjJwaQkynt6uUSMEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQleoxV
  AOcGi1PTUirTMHGD6gElLcPAoifAqg6R5iwsSc4sz0yFSpxgVpcR5U0ESAiCJjNI8uDZYyrrE
  KCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZg3AGQKT2ZeCdz0V0CLmYAW52xhAllckoiQkmpg5
  Ky4Oi/yEdf1Ix8V3X8+VVDz5onsWB6XbFX7Mf/jOgmXfhGWPVnVDVG6+8/IXqyNyEj03dltN4
  d5/6RZp5pvuTOoa65/9f+Zy+qFBvLCk6eHL+KeZbwhUcfynOa9+T2n/JivflWvcFic75wt8N5
  qisZz76L5roy1q84rXrx4WEhLv0+n9NNjJZbijERDLeai4kQA0VLqAVQDAAA=
X-Env-Sender: Christian.Hohnstaedt@wago.com
X-Msg-Ref: server-9.tower-239.messagelabs.com!1545120390!2399605!1
X-Originating-IP: [217.237.185.178]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14635 invoked from network); 18 Dec 2018 08:06:31 -0000
Received: from unknown (HELO SVEX01006.wago.local) (217.237.185.178)
  by server-9.tower-239.messagelabs.com with AES128-SHA encrypted SMTP; 18 Dec 2018 08:06:31 -0000
Received: from SVEX01012.wago.local (10.1.103.230) by SVEX01006.wago.local
 (10.1.101.122) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 18 Dec
 2018 09:06:30 +0100
Received: from lc010965.wago.local (10.1.101.136) by SVEX01012.wago.local
 (10.1.103.230) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Tue, 18 Dec
 2018 09:06:29 +0100
Received: by lc010965.wago.local (Postfix, from userid 11100404)        id
 BEA5E170069F; Tue, 18 Dec 2018 09:06:29 +0100 (CET)
From:   Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH 0/2] Add input voltage configuration for TPS65218
Date:   Tue, 18 Dec 2018 09:05:54 +0100
Message-ID: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.101.136]
X-ClientProxiedBy: SVEX01012.wago.local (10.1.103.230) To SVEX01012.wago.local
 (10.1.103.230)
X-KSE-ServerInfo: SVEX01012.wago.local, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 18.12.2018 03:56:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-PP-Proceessed: deb34f4f-1670-42da-9b53-f8c7bceb0e0a
X-PP-Proceessed: 76874689-fff8-43e0-8f1a-01f8fc6dac97
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to configure input-voltage settings
of the TPS65218 regulator via device tree.

Christian Hohnstaedt (2):
  dt-bindings: regulator: extend tps65218 bindings
  mfd: tps65218.c: Add input voltage options

 .../devicetree/bindings/regulator/tps65218.txt     | 10 +++++
 drivers/mfd/tps65218.c                             | 46 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)

-- 
2.7.4

