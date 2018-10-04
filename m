Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82264C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514E32098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514E32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJDO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:29:14 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:28070 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbeJDO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:29:06 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 8F/41-09077-623C5BB5; Thu, 04 Oct 2018 07:37:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleJIrShJLcpLzFFi42IJ73Q4rKt2eGu
  0waU2fov5R86xWhxe9ILR4uanb6wWl3fNYbNYev0ik0Xr3iPsDmwea+atYfTYOesuu8emVZ1s
  Hp83yQWwRLFm5iXlVySwZmxecIa9oJmzYs65G8wNjC0cXYxcHEICaxglnvWeZOli5ARyKiTuf
  trKBmLzCkRIPP7axghicwqYSRzacpwJosZUYsH3N2D1bAI6Eo9mrgeKc3CwCKhIfJskDxIWFo
  iV+P1jGSuILSIQJPH40VkWkF3MArsZJT5cOMAMMV9Q4uTMJ2BzmAUkJA6+eMEMMV9L4tyaVWB
  7JQTsJaa/v8oMYetLvPy6kQnCNpT4PusbC4RtLnHy/Vso21ri+odZbBMYhWYhWTELyYoFjEyr
  GC2SijLTM0pyEzNzdA0NDHQNDY10DS3NdY1MDfUSq3ST9FJLdctTi0t0gdzyYr3iytzknBS9v
  NSSTYzAKEkpOPp7B+OERemHGCU5mJREeWdO3hotxJeUn1KZkVicEV9UmpNafIhRhoNDSYLX9h
  BQTrAoNT21Ii0zBxivMGkJDh4lEV5nkDRvcUFibnFmOkTqFKMux7sF/6czC7Hk5eelSolDFAm
  AFGWU5sGNgKWOS4yyUsK8jAwMDEI8BalFuZklqPKvGMU5GJWEIabwZOaVwG16BXQEE9AR8jlb
  QI4oSURISTUwdmjPvBfIsMx8q5daw6lCj76NpW6+wZGtEiXy198fXiDwfrtGYXxowUZ+pf7Fa
  tzpR6U0m3TNvcuO/Zhyec9NwcCUbafLLzPYZhZ6BXg1ulzWnnj9Z7NqQUpjADPLy0wxjqjtW0
  /O8TW7d+hmP+/3rY1mOgLn7s0NS5taJ7pD5IZo65lD5w4rsRRnJBpqMRcVJwIAJgYk/xgDAAA
  =
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-8.tower-288.messagelabs.com!1538638629!227578!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4997 invoked from network); 4 Oct 2018 07:37:10 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-8.tower-288.messagelabs.com with AES128-SHA encrypted SMTP; 4 Oct 2018 07:37:10 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 4 Oct 2018 09:37:09 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 09AF35F7F9; Thu,  4 Oct 2018 16:37:08 +0900 (KST)
Message-ID: <34b6c8586bf56c2449290cc46b144e3b0a9faa02.1538635541.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1538635541.git.Roy.Im@diasemi.com>
References: <cover.1538635541.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 4 Oct 2018 15:45:41 +0900
Subject: [PATCH V7 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 04.10.2018 05:19:00
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
end-of-patch for PATCH V7

