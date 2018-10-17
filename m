Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10320C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0E7214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0E7214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJQJa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:30:26 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:10158 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbeJQJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:30:25 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id DE/6B-08991-64296CB5; Wed, 17 Oct 2018 01:37:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleJIrShJLcpLzFFi42IJ73Q4rOs26Vi
  0wdnrvBbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzZh3vYmloIuz4t/NBywNjF0cXYxcHEICaxkl/p44wdLFyAnkVEgcO
  /0ezOYViJBoOnidCcTmFDCTmL9+MjtEjanE5ne72EBsNgEdiUcz14PVsAioSux5tA7MFhZIkd
  i05ioziC0iECTx+NFZFpBlzAK7GSU+XDjADLFAUOLkzCdgy5gFJCQOvnjBDLFAS+LcmlWMILa
  EgL3E9PcQgyQE9CVeft3IBGEbSnyf9Y0FwjaXWPXpNBuEbS1x/cMstgmMQrOQrJiFZMUCRqZV
  jBZJRZnpGSW5iZk5uoYGBrqGhka6hpZmuoYmxnqJVbpJeqmluuWpxSW6hnqJ5cV6xZW5yTkpe
  nmpJZsYgXGSUnCkfwfjs+XphxglOZiURHlr245FC/El5adUZiQWZ8QXleakFh9ilOHgUJLgfT
  QBKCdYlJqeWpGWmQOMWJi0BAePkgjviX6gNG9xQWJucWY6ROoUoy7HuwX/pzMLseTl56VKifN
  +AZkhAFKUUZoHNwKWPC4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuY9DDKFJzOvBG7TK6Aj
  mICOcLc9AnJESSJCSqqBkV+45KRyZLmQ/93gZef1Nk105/WquddXzqsd23ol1MGt5vf/w9aPX
  0zatL0/unBqwd0VobJWgY+q2LdPcnwicuOm6/RlRbtNC4zPC+w+E8bK7fiAW9D1iECrGdtqWQ
  4t0Z0PYrUDxY/3+R5o3eRQX1aT/2zuhor1aglBmt6mLR4vpK7GHTNQYinOSDTUYi4qTgQAKZi
  BRhkDAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-20.tower-288.messagelabs.com!1539740229!556224!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17706 invoked from network); 17 Oct 2018 01:37:10 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-20.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 17 Oct 2018 01:37:10 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 17 Oct 2018 03:37:08 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 1EAE55F7FB; Wed, 17 Oct 2018 10:37:07 +0900 (KST)
Message-ID: <28bb25a8b7df07b845eed1a5dd5524a4b6f7b9e8.1539737877.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1539737877.git.Roy.Im@diasemi.com>
References: <cover.1539737877.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 17 Oct 2018 09:57:56 +0900
Subject: [RESEND PATCH V7 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 16.10.2018 22:03:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b22e7fd..1af587f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4313,6 +4313,7 @@ S:	Supported
 F:	Documentation/hwmon/da90??
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
@@ -4321,6 +4322,7 @@ F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
-- 
end-of-patch for RESEND PATCH V7

