Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E628BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96F120827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96F120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbeKHP5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:57:33 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:59070 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbeKHP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:57:32 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id F4/28-08707-666D3EB5; Thu, 08 Nov 2018 06:23:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleJIrShJLcpLzFFi42IJ73Q4rJt27XG
  0wawvohbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzZh3vYmloIuz4t/NBywNjF0cXYxcHEICaxglFi3tY+9i5ARyKiReP
  XnPBmLzCkRIdO35DmZzCphJ9DdtYIaoMZW43XeGCcRmE9CReDRzPZjNIqAi8WzeJ7B6YYEUiU
  1rroLViwgESTx+dJYFZBmzwG5GiQ8XDjBDLBCUODnzCQuIzSwgIXHwxQuoBVoS59asYgSxJQT
  sJaa/hxgkIaAv8fLrRiYI21Di+6xvLBC2ucTCN81sELa1xPUPs9gmMArNQrJiFpIVCxiZVjFa
  JhVlpmeU5CZm5ugaGhjoGhoa6xrrGhkb6yVW6SbqpZbqJqfmlRQlAmX1EsuL9Yorc5NzUvTyU
  ks2MQIjJaWQ+eUOxu/N6YcYJTmYlER582Y/jhbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwSt7FS
  gnWJSanlqRlpkDjFmYtAQHj5IIrzJImre4IDG3ODMdInWKUZfj3YL/05mFWPLy81KlxHn9QIo
  EQIoySvPgRsDSxyVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwryZIFN4MvNK4Da9AjqCCeiI
  e7IPQI4oSURISTUw1m/pkwuOZ1r7aekhWTen43ci/pxrPbcr4OU31as1vpt68qo+O+4rPtjy1
  /Rq5cS/v/YU6x3pWJalaeBer3HbS4nfaX6a+lTvZe0PJtgdEfRQrW9hMVv26FBGSRPvJ9X7v1
  ZmLVfRWMO+/eiXCOubuzN8GJ9narfvKl1l0ho403Haih/bEpKSlViKMxINtZiLihMBMMAPDho
  DAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-11.tower-223.messagelabs.com!1541658213!1038966!3
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12089 invoked from network); 8 Nov 2018 06:23:34 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-11.tower-223.messagelabs.com with AES128-SHA256 encrypted SMTP; 8 Nov 2018 06:23:34 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 8 Nov 2018 07:23:33 +0100
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 51F375F7F9; Thu,  8 Nov 2018 15:23:31 +0900 (KST)
Message-ID: <07628815bca7ae5429504f1a11d629bd6fa7df9f.1541656450.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1541656450.git.Roy.Im@diasemi.com>
References: <cover.1541656450.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 8 Nov 2018 14:54:09 +0900
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
X-KSE-Antivirus-Info: Clean, bases: 08.11.2018 03:21:00
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

