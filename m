Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E61C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FA920851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FA920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbeHWMny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:43:54 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:45603 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728440AbeHWMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:43:54 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 9F/99-18884-91B7E7B5; Thu, 23 Aug 2018 09:15:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleJIrShJLcpLzFFi42IJ73Q4rCtRXRd
  tcPiyocX8I+dYLQ4vesFocfPTN1aLy7vmsFksvX6RyaJ17xF2BzaPNfPWMHrsnHWX3WPTqk42
  j8+b5AJYolgz85LyKxJYM45sucFYcJmjYs3X7awNjHfZuxi5OIQE1jJKrHm5g7WLkRPIqZBYs
  HUOG4jNKxAh0bDtMAuIzSlgJnFw9gQWiBpTieZfV8FsNgEdiUcz1zOB2CwCqhJdf6eD2cICsR
  Lreq+DzRQRCJJ4/OgsC8gyZoHdjBIfLhxghlggKHFy5hOwQcwCEhIHX7xghligJXFuzSpGEFt
  CwF5i+vurzBC2vsTLrxuZIGxDie+zvrFA2OYSvcc3sUHY1hLXP8xim8AoNAvJillIVixgZFrF
  aJlUlJmeUZKbmJmja2hgoGtoaKxrqGtoaqKXWKWbqJdaqpucmldSlAiU1UssL9YrrsxNzknRy
  0st2cQIjBQGINjBuGRO6iFGSQ4mJVHez/610UJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeI9W1k
  ULCRalpqdWpGXmAGMWJi3BwaMkwvsQJM1bXJCYW5yZDpE6xWjMcaq5ZxIzx5/3UycxC7Hk5ee
  lSonzXgIpFQApzSjNgxsESyWXGGWlhHkZgU4T4ilILcrNLEGVf8UozsGoJMz7CGQKT2ZeCdy+
  V0CnMAGdwspcC3JKSSJCSqqBcYK22GyBQjnr89bHr387LLSi984dx2X/GPIFDW8dfNgs+CL72
  Wy76iCuhbynzmspy/ycvu7QbC1VwS1756xcZ6Q9O+1aoTTTan7HvV/81/UvFuEUuDlVWVxhkk
  D4e7UWAdsps3/ZSqf8j83vuGwkq1rfLVJZbl3Zlf/j4cPfrT8+LOt7+DdqpRJLcUaioRZzUXE
  iAPYM0c4gAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-9.tower-229.messagelabs.com!1535015703!4525460!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24906 invoked from network); 23 Aug 2018 09:15:04 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-9.tower-229.messagelabs.com with AES128-SHA encrypted SMTP; 23 Aug 2018 09:15:04 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 23 Aug 2018 11:15:04 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 ECE395F7F8; Thu, 23 Aug 2018 18:15:02 +0900 (KST)
Message-ID: <97d54f27fac799f6f58f274e83c981b99238ca65.1534830272.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1534830272.git.Roy.Im@diasemi.com>
References: <cover.1534830272.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 21 Aug 2018 14:44:31 +0900
Subject: [PATCH V4 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 23.08.2018 07:55:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
end-of-patch for PATCH V4

