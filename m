Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0379C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D07F2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D07F2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeISQ4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 12:56:08 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:28159 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730967AbeISQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 12:56:08 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 41/FB-27351-F8032AB5; Wed, 19 Sep 2018 11:18:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleJIrShJLcpLzFFi42IJ73Q4rNtnsCj
  a4NJ6S4v5R86xWhxe9ILR4uanb6wWl3fNYbNYev0ik0Xr3iPsDmwea+atYfTYOesuu8emVZ1s
  Hp83yQWwRLFm5iXlVySwZvRe2slc8Iuj4vg/1QbGv+xdjFwcQgJrGSVOTGpm6mLkBHIqJD78n
  MgGYvMKREisW7KfGcTmFDCT+D7zJ1SNqcTfJwsZQWw2AR2JRzPXg8VZBFQljjd8YgGxhQVSJE
  6cawarEREIknj86CwLyDJmgd2MEh8uHGCGWCAocXLmE7AGZgEJiYMvXjBDLNCSOLdmFVizhIC
  9xPT3V5khbH2Jl183MkHYhhLfZ31jgbDNJXZPPwZVYy1x/cMstgmMQrOQrJiFZMUCRqZVjBZJ
  RZnpGSW5iZk5uoYGBrqGhka6hpbGukYmBnqJVbqJeqmluuWpxSW6hnqJ5cV6xZW5yTkpenmpJ
  ZsYgVGSUnDwww7GhS3phxglOZiURHmZZi2MFuJLyk+pzEgszogvKs1JLT7EKMPBoSTB26q/KF
  pIsCg1PbUiLTMHGK8waQkOHiUR3tkgad7igsTc4sx0iNQpRmOOU809k5g5/ryfOolZiCUvPy9
  VSpy3C6RUAKQ0ozQPbhAsjVxilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMx7C2QKT2ZeCdy+
  V0CnMAGd8nnpApBTShIRUlINjBMCszu/yRjaeijNSLZ3DrRe6X58XVA2z0oDluSJN7xnlJwUc
  tW02JU5/9kbwcn619KtPcPeLH4is+3YT+l7pzSbDEN3zAnYmPTimPNEaTbl4L7A3QoNSzbwnn
  iw8+Cas0J7UwqDBWdLLvVKOuW2bvFCveDj3/eJlP27FV4xnd9Yb37B+uSeQiWW4oxEQy3mouJ
  EAB5wPB0eAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-19.tower-268.messagelabs.com!1537355918!4205199!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22847 invoked from network); 19 Sep 2018 11:18:38 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-19.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 19 Sep 2018 11:18:38 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Wed, 19 Sep 2018 13:18:38 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 9DAE45F7F8; Wed, 19 Sep 2018 20:18:36 +0900 (KST)
Message-ID: <4a7f9f7c97298c88a99fdfed02b82db9b83115d8.1537353304.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1537353304.git.Roy.Im@diasemi.com>
References: <cover.1537353304.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Wed, 19 Sep 2018 19:35:04 +0900
Subject: [RESEND PATCH V6 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 19.09.2018 10:15:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb5..6244a7d 100644
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
end-of-patch for RESEND PATCH V6

