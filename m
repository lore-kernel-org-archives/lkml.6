Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B96C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F92720A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F92720A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbeHPFv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:51:26 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:13396 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387842AbeHPFvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:51:25 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id E2/1A-12616-9C7E47B5; Thu, 16 Aug 2018 02:56:09 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleJIrShJLcpLzFFi42IJ73Q4rHvyeUm
  0wY1V6hbzj5xjtTi86AWjxc1P31gtLu+aw2ax9PpFJovWvUfYHdg81sxbw+ixc9Zddo9NqzrZ
  PD5vkgtgiWLNzEvKr0hgzXgw+zhzwQWOismPbrM1MN5n72Lk4hASWMsocWT7NpYuRg4gp0Li8
  6/cLkZODl6BCIm+O7dYQcKcAmYSr1cVQVSYSkxYbQBSwSagI/Fo5nomEJtFQFVi8rqXzCAlwg
  KxEi/fVIGERQSCJB4/OssCsohZYDejxIcLB5ghpgtKnJz5hAXEZhaQkDj44gVYXEhAS+LcmlW
  MILaEgL3E9PdXmSFsfYmXXzcyQdiGEt9nfWOBsM0lFt+ZAWVbS1z/MIttAqPQLCQrZiFZsYCR
  aRWjRVJRZnpGSW5iZo6uoYGBrqGhka6hJQgb6CVW6SbqpZbqlqcWl+ga6iWWF+sVV+Ym56To5
  aWWbGIExgcDEOxgXH8h+RCjJAeTkiivfnVxtBBfUn5KZUZicUZ8UWlOavEhRhkODiUJXjVgvA
  kJFqWmp1akZeYAIxUmLcHBoyTCGwuS5i0uSMwtzkyHSJ1iNOY41dwziZnjz/upk5iFWPLy81K
  lxHlFQEoFQEozSvPgBsESyCVGWSlhXkag04R4ClKLcjNLUOVfMYpzMCoJ8yqCTOHJzCuB2/cK
  6BQmoFOSRQpBTilJREhJNTDuCtlc9ymr4NalbZX7c73Y5DYH+XNd1zkVMGHb6QkWLDLt0ccVn
  zIpra1S6AhInb4mUv/OFOcjqnIcKlfmLvJ+bFL5w+X16oczf/27fvzjE8PNFSWZk9ZaZEtNMN
  ilW3Bo/91I/ZivRY6v+WOU7xjwGrVKi6z/w7yq/Qvr7Jvvgjh9py5bc6ZPiaU4I9FQi7moOBE
  A9pIzLxsDAAA=
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-8.tower-268.messagelabs.com!1534388168!5525239!2
X-Originating-IP: [87.137.64.195]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4211 invoked from network); 16 Aug 2018 02:56:09 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (87.137.64.195)
  by server-8.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 16 Aug 2018 02:56:09 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.382.0; Thu, 16 Aug 2018 04:56:08 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 6F69E5F7F8; Thu, 16 Aug 2018 11:56:07 +0900 (KST)
Message-ID: <2d84d78e375cb6cb14f8ff0fa795def9a66f496e.1534384964.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1534384964.git.Roy.Im@diasemi.com>
References: <cover.1534384964.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Thu, 16 Aug 2018 11:02:44 +0900
Subject: [PATCH V1 1/3] MAINTAINERS: da7280 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 16.08.2018 00:48:00
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
end-of-patch for PATCH V1

