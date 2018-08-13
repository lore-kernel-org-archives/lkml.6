Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF979C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4B921709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4B921709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeHNBUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:20:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56822 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNBUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:20:07 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M8G1e-1g2DNh1vve-00vxaj; Tue, 14 Aug 2018 00:35:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rfkill-gpio: include linux/mod_devicetable.h
Date:   Tue, 14 Aug 2018 00:35:24 +0200
Message-Id: <20180813223528.991144-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:ITOXqODs5fJ9xnHVl2y11jt5fDBsYCbBP03qlkbpHdTtETmxpq6
 QOv1rBaNLnc+WAZ3Z64KSEJAVOo8ewUA0h7KwXXdq6kXmeZNS+DSt9Jlka2A+h91sZvsNaK
 8fwP4l3P4Q6tKmOLSf3OURSH1CYwDofqGjzkAVNkUhwMYHzNcODMcnYNJnGMf7fCDUc1cAC
 bdN55ujQOrxMiHV2d5T4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X978U5346LE=:QI8dK5G9mOanmV2qOs0FAB
 kpBKhRGlwEnmnnk/LOq7Jm2LFPLMJJdwm5oq14YGC8gKa1iiyGKWYSatv0o8lQWVsrqYbfAKk
 poSwtAEKe3W1DOUJu2v4FUjz6mzRQgq6TAdT1sKT1X+tsIzlsJVjkQk2dy9f6dkpwkhMnuXGy
 /Uuyjq/NewHlGVNQD00iW/rWxTy6RMPgsYwCMAFpkeEswzdlFvoLXKt0flBQ2Qq+haxLPoTFa
 5ij2BYYfoIc/pzurh9OXCHOo7osaUxqZXdf6XWi6MtybQ6oSF0fJWoQyFF5R/eNNE1xal2zV7
 Mh6jUGKXRmMYuqMukWOSSt/Brey4JDVXIebJpGyl4zGs6A1eTelOCQjuHiju+JnzeST9AVQaS
 c346i2QIknWlvMNEJd0tcs7yI+Gb8EhfkG+ztPLeFNpkSYHX8EIusML6BwlvQLkpQ4AN3TNtK
 Vi0cgo+sv+eenDRdYQyfEn6Til514kuNg/Ud0ZfrbE4HotuMJnr9iI6PZYyR5RaDVP5bTwdjv
 kxW+7wg3/XXXkZ8wScmqhpgU4uM2ITwZmk/+lQDD5CvxB2o46kpLForUE8OcX0CcSylCwhGlh
 nVQwJirbqnfA5vN/zaiwO0eQCJ2tT3nmgzknRUaJrwjSBDZvk6saeitKvIp0bQBB8VdnXLDRa
 XfbfGCIf6OmycvXsUoNLf/Oju3T08gs0/AQyZiaC6uHWy4QwIPtlw2agLAvMq5u1ItgA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One more driver is apparently broken by the recent change
to linux/platform_device.h:

net/rfkill/rfkill-gpio.c: In function 'rfkill_gpio_acpi_probe':
net/rfkill/rfkill-gpio.c:82:29: error: dereferencing pointer to incomplete type 'const struct acpi_device_id'

Include linux/mod_devicetable.h to get the definition of the
acpi_device_id structure.

Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/rfkill/rfkill-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 00192a996be0..0f8465852254 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/rfkill.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
-- 
2.18.0

