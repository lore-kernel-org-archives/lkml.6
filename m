Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8386C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA3F208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA3F208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeH0M3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:29:11 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:4984 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727159AbeH0M3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:29:10 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 34/02-19860-BA9B38B5; Mon, 27 Aug 2018 08:43:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileJIrShJLcpLzFFi42IJ73Q4rLt6Z3O
  0wZwvOhbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzbj9diVjwWOOiq8Pu1kbGF+xdzFycQgJrGWU2LnwC1sXIyeQUyGxZ
  MN/ZhCbVyBCYu/tJywgNqeAmcS0/nbWLkYOoBpTiTuXpUHCbAI6Eo9mrmcCsVkEVCW6Jl4BGy
  MsECtxcMkzsFYRgSCJx4/OsoDsYhbYzSjx4cIBqPmCEidnQsxnFpCQOPjiBTPEDVoS59asYgS
  xJQTsJaa/v8oMYetLvPy6kQnCNpT4PusbC8g9EgLmEkc+FUCErSWuf5jFNoFRaBaSDbOQbFjA
  yLSK0SKpKDM9oyQ3MTNH19DAQNfQ0EjX0NJS19DCTC+xSjdJL7VUtzy1uETXUC+xvFivuDI3O
  SdFLy+1ZBMjMEYYgGAH48YLyYcYJTmYlER5H1k1RQvxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4G
  UDxpyQYFFqempFWmYOMFph0hIcPEoivC47gNK8xQWJucWZ6RCpU4zGHKeaeyYxc/x5P3USsxB
  LXn5eqpQ471KQUgGQ0ozSPLhBsCRyiVFWSpiXEeg0IZ6C1KLczBJU+VeM4hyMSsK83CD38GTm
  lcDtewV0ChPQKTNeNYCcUpKIkJJqYOxZxxnhYrFT/22ARYSbRHjU3oLEBWkCt9wvT1NqP/ao5
  J+P7rE9Yn94vv4/1j7xmY1W4oFNdeyLz0j2HbWZt/uJdFk/R1z+nc7mezU3J7vWeP9370+sTA
  gJ6/b7+G7D2pOb1rEsN2Tb5fxo3/RYF92WhfNlFVxsptjuWid5dmbf5SlsS2bcLlBiKc5INNR
  iLipOBAD7ced2HQMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-19.tower-282.messagelabs.com!1535359403!5991626!3
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28712 invoked from network); 27 Aug 2018 08:43:23 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-19.tower-282.messagelabs.com with AES128-SHA encrypted SMTP; 27 Aug 2018 08:43:23 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 27 Aug 2018 10:43:22 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 231855F7F9; Mon, 27 Aug 2018 17:43:21 +0900 (KST)
Message-ID: <2a986b1aac44ad34c40510043102e73ef0ce72b3.1535358095.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1535358095.git.Roy.Im@diasemi.com>
References: <cover.1535358095.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 27 Aug 2018 17:21:35 +0900
Subject: [PATCH V5 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>,
        <devicetree@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 27.08.2018 03:30:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac8..720f9fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4221,6 +4221,7 @@ S:	Supported
 F:	Documentation/hwmon/da90??
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
@@ -4229,6 +4230,7 @@ F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
-- 
end-of-patch for PATCH V5

