Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8625ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEDC2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEDC2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387867AbeITWxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:53:08 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:52416
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387802AbeITWxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:53:07 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 32QWgzTT1sezk32QWg6OU5; Thu, 20 Sep 2018 10:07:40 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1g32QW-0002WN-5R; Thu, 20 Sep 2018 10:07:40 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next,3/3] hv_netvsc: Update document for LRO/RSC support
Date:   Thu, 20 Sep 2018 17:07:01 +0000
Message-Id: <20180920170701.9574-4-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
References: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfDIPtArKT8nzsEqb52WbfTrtBrwIQ6ec1/xcDfJfRFrzMCfORj+xANPtva5vvmyHkVg7EluQp6kSrDLvhTDS7a+tRGW312GAtjJ8pkxLsm9bHnCf91iw
 s8zXp4oEU87vktSIKeMfoM5120dKk5I/YgMr65+bP7wc7z1MQnoY2JuHqr6oDOzeqXP5LSnRUgw0RYquikxjGfB4EanbwLSRYdlY/M6bvJlrKstUdaESyjFo
 7O1r27BkOVJV2eV5sjl6SgBZsGdzI1x3AMjYIZ5YYlrqCmdx1kM8ohv8hO80stXRf+BVEmvkz/73Akd9mIjy5kxvwF+dDmDoFhk68oFJNYAOZ5Yw6aXUzd3I
 7NESPyq6QRzLTl4dSQKV74zbRFGawCpqwGsTmIb6bIwpOHWVi1xcvEuvFwKHXTW7ybtjJYL1SiOkLjGewZ+MWGvLduAh8wA9auMFgfvoesN7m+syOehDEU+p
 9sR4d2TFKbRItOXSa1aNDx9NwntM50D6BH5F9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Update document for LRO/RSC support, and the command line info to
change the setting.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Documentation/networking/netvsc.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/networking/netvsc.txt b/Documentation/networking/netvsc.txt
index 92f5b31392fa..3bfa635bbbd5 100644
--- a/Documentation/networking/netvsc.txt
+++ b/Documentation/networking/netvsc.txt
@@ -45,6 +45,15 @@ Features
   like packets and significantly reduces CPU usage under heavy Rx
   load.
 
+  Large Receive Offload (LRO), or Receive Side Coalescing (RSC)
+  -------------------------------------------------------------
+  The driver supports LRO/RSC in the vSwitch feature. It reduces the per packet
+  processing overhead by coalescing multiple TCP segments when possible. The
+  feature is enabled by default on VMs running on Windows Server 2019 and
+  later. It may be changed by ethtool command:
+	ethtool -K eth0 lro on
+	ethtool -K eth0 lro off
+
   SR-IOV support
   --------------
   Hyper-V supports SR-IOV as a hardware acceleration option. If SR-IOV
-- 
2.18.0

