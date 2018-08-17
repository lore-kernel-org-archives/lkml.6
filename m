Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52952C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A6F208DC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 01:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A6F208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeHQEvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 00:51:12 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:44784 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbeHQEvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 00:51:12 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 21/E9-11008-AB9267B5; Fri, 17 Aug 2018 01:49:46 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleJIrShJLcpLzFFi42IJ73Q4rLtLsyz
  aoHm3gMX8I+dYLQ4vesFocfPTN1aLy7vmsFksvX6RyaJ17xF2BzaPNfPWMHrsnHWX3WPTqk42
  j8+b5AJYolgz85LyKxJYMz4tX8xUcJ+j4vu+GWwNjK/Zuxi5OIQE1jJKPH4+m6WLkQPIqZDY8
  E26i5GTg1cgQmLx/T2sIDangJnExA8tLCC2kICpxPHWq2BxNgEdiUcz1zOB2CwCqhKHWleDxY
  UFYiW6N74Bs0UEgiQePzrLArKLWWA3o8SHCweYIRYISpyc+QRsKLOAhMTBFy+YIRZoSZxbs4o
  RxJYQsJeY/v4qM4StL/Hy60YmCNtQ4vusb2A3SwiYS+xflQIRtpa4/mEW2wRGoVlINsxCsmEB
  I9MqRsukosz0jJLcxMwcXUMDA11DQ2NdMxCpl1ilm6SXWqqbnJpXUpQIlNVLLC/WK67MTc5J0
  ctLLdnECIwSBiDYwdgwL/UQoyQHk5IoL/vv0mghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKEryMwK
  gTEixKTU+tSMvMAcYrTFqCg0dJhPe8BlCat7ggMbc4Mx0idYrRmONUc88kZo4/76dOYhZiycv
  PS5US590NUioAUppRmgc3CJZGLjHKSgnzMgKdJsRTkFqUm1mCKv+KUZyDUUmYlxfkHp7MvBK4
  fa+ATmECOmWaQCnIKSWJCCmpBsZFF026Qp6ZfMut6d3dcO9dzwqjxU/bF70V3s0YNFssM2Sn4
  c+rYVxP1+5cZZP5xSH1xNYPh+/NffZj20xOYS+OUvO9JcsLT7QtFJ4kGx44kc3Fe1VcuZyKhP
  la7dmaZ2aejNSQu/2G1yvnY/NJ1RrXe84rKtMu7zif8OOFpNWk7YInuqb7dTArsRRnJBpqMRc
  VJwIARvryZR4DAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-3.tower-246.messagelabs.com!1534470584!4140884!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6467 invoked from network); 17 Aug 2018 01:49:46 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-3.tower-246.messagelabs.com with AES128-SHA encrypted SMTP; 17 Aug 2018 01:49:46 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Fri, 17 Aug 2018 03:49:43 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 EB0165F7F8; Fri, 17 Aug 2018 10:49:42 +0900 (KST)
Message-ID: <20726178ea918c9361e531fefdb4fa8a8dc2de34.1534468025.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1534468025.git.Roy.Im@diasemi.com>
References: <cover.1534468025.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Fri, 17 Aug 2018 10:07:04 +0900
Subject: [PATCH V2 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 16.08.2018 21:39:00
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
v2: No changes

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
end-of-patch for PATCH V2

