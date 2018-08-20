Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BBDC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4232121473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4232121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeHTJWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:22:08 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:29315 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbeHTJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:22:08 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id C8/70-12616-3BA5A7B5; Mon, 20 Aug 2018 06:07:47 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileJIrShJLcpLzFFi42IJ73Q4rLs5qir
  aYGe7ssX8I+dYLQ4vesFocfPTN1aLy7vmsFksvX6RyaJ17xF2BzaPNfPWMHrsnHWX3WPTqk42
  j8+b5AJYolgz85LyKxJYM1ouXmUv+MRRseDSJbYGxp/sXYxcHEICaxklZvz/y9zFyAnkVEi8W
  rWXFcTmFYiQWPP7HxOIzSlgJtG8bQuQzQFUYyrx4XQ4SJhNQEfi0cz1YCUsAqoS0378ZwGxhQ
  ViJdZdXgo2RkQgSOLxo7MsILuYBXYzSny4cIAZYr6gxMmZT8AamAUkJA6+eAF1g5bEuTWrGEF
  sCQF7ienvrzJD2PoSL79uZIKwDSW+z/rGAmGbS0yZtpEdwraWuP5hFtsERqFZSFbMQrJiASPT
  KkbzpKLM9IyS3MTMHF1DAwNdQ0MjXUNLY10jY73EKt1EvdRS3fLU4hJdQ73E8mK94src5JwUv
  bzUkk2MwBhhAIIdjGe+JR9ilORgUhLl1TatihbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwbsmEi
  gnWJSanlqRlpkDjFaYtAQHj5II736QNG9xQWJucWY6ROoUozHHqeaeScwcf95PncQsxJKXn5c
  qJc67DqRUAKQ0ozQPbhAsiVxilJUS5mUEOk2IpyC1KDezBFX+FaM4B6OSMO8RkCk8mXklcPte
  AZ3CBHQKO1slyCkliQgpqQbGXSt61ytdLkl/8kJ731y7+TcbfhSsa1n4qHCVr+31nct1HNhc1
  2/vfK32+sf89glXpru0KRY3pJT/fTBHcF50wMR3fAekOKq/bMjffPFvzOngJ4bL9P5c19V/5n
  dU6EZGrMTsjlz/qzJLr0yZ+1WxQbTWZt1K5o+P4xWONpyw9N64wLx5ke5mJiWW4oxEQy3mouJ
  EAEY61UodAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-10.tower-268.messagelabs.com!1534745267!5703828!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10497 invoked from network); 20 Aug 2018 06:07:47 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-10.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 20 Aug 2018 06:07:47 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Mon, 20 Aug 2018 08:07:46 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 1F1065F7F8; Mon, 20 Aug 2018 15:07:45 +0900 (KST)
Message-ID: <89b4d3be632fd212788cb607f0730b296c1e89f0.1534743380.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1534743380.git.Roy.Im@diasemi.com>
References: <cover.1534743380.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Mon, 20 Aug 2018 14:36:20 +0900
Subject: [PATCH V3 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 20.08.2018 03:16:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roy Im <roy.im.opensource@diasemi.com>

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
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
end-of-patch for PATCH V3

