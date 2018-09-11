Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E732CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB13920833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB13920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeIKRns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:43:48 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:20858 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbeIKRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:43:47 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id 4C/DD-27351-1B8B79B5; Tue, 11 Sep 2018 12:44:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleJIrShJLcpLzFFi42IJ73Q4rLt+x/R
  og4WdEhbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzdh8bitTwWeOitdnlBoYv7N3MXJxCAmsZZS4unI+kMMJ5FRIfL3ax
  wxi8wpESBz5u5INxOYUMJP4/mwOG0SNqcSNxVsZQWw2AR2JRzPXM4HYLAKqEruuvGIFsYUFYi
  V+fz4MVi8iECTx+NFZFpBlzAK7GSU+XDgAtUBQ4uTMJywgNrOAhMTBFy+YIRZoSZxbswpsgYS
  AvcT091eZIWx9iZdfNzJB2IYS32d9Y4GwzSW23l7NBmFbS1z/MIttAqPQLCQrZiFZsYCRaRWj
  RVJRZnpGSW5iZo6uoYGBrqGhka6hJRBbmOslVukm6qWW6panFpfoGuollhfrFVfmJuek6OWll
  mxiBEZJSsGB3TsY33elH2KU5GBSEuXdnDs9WogvKT+lMiOxOCO+qDQntfgQowwHh5IEb+B2oJ
  xgUWp6akVaZg4wXmHSEhw8SiK8iiBp3uKCxNzizHSI1ClGY45TzT2TmDn+vJ86iVmIJS8/L1V
  KnLccpFQApDSjNA9uECyNXGKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzJsFMoUnM68Ebt8r
  oFOYgE5Zd34KyCkliQgpqQZGb97ch9tSRXRmvk/8w+ycJVhYtoZL6GyBn1fS39A/ng+/pD5cN
  +nT5LzXP03+bNt0Ms20qSVZ/Zj9M/fMfcdZJov39wW4HtTecDOG17rsu+nkeYcrOhVSuTrfyu
  gzyV77UDfTOqjg6711ue7NK1e3iUrN57gVpfUpw+EB9+oq0wMNtR6NXJxKLMUZiYZazEXFiQB
  GduECHgMAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-3.tower-268.messagelabs.com!1536669871!7001141!1
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5074 invoked from network); 11 Sep 2018 12:44:31 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-3.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 11 Sep 2018 12:44:31 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Tue, 11 Sep 2018 14:44:31 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 316535F7FA; Tue, 11 Sep 2018 21:44:29 +0900 (KST)
Message-ID: <2a8a484d57346d435384ef2cd9b121a4991457bd.1536668286.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1536668286.git.Roy.Im@diasemi.com>
References: <cover.1536668286.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Tue, 11 Sep 2018 21:18:06 +0900
Subject: [PATCH V6 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 11.09.2018 11:03:00
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
end-of-patch for PATCH V6

