Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D261C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342AA2150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342AA2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbeIVAMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:12:01 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:52026
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390076AbeIVAMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:12:00 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 3Q2xgIB7gsezk3Q2xgLbU0; Fri, 21 Sep 2018 11:20:55 -0700
x-originating-ip: 107.180.71.197
Received: from haiyangz by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <haiyangz@linuxonhyperv2.linuxonhyperv.com>)
        id 1g3Q2x-0002dV-AO; Fri, 21 Sep 2018 11:20:55 -0700
From:   Haiyang Zhang <haiyangz@linuxonhyperv.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next,v2,3/3] hv_netvsc: Update document for LRO/RSC support
Date:   Fri, 21 Sep 2018 18:20:37 +0000
Message-Id: <20180921182037.10077-4-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
References: <20180921182037.10077-1-haiyangz@linuxonhyperv.com>
Reply-To: haiyangz@microsoft.com
X-CMAE-Envelope: MS4wfMrxfshpxdjlVyMTCobUoh0RTwDTgRbfq2m768pDrs8QfQ+QWOztnpKgUqEGwo4xyeMzKPLI9EzWIr0gyTqHK7RfXADOM6cI9R3apkzJ6OOzDllwS0z4
 v264LtWDsaJa4XK5b5q2Cdf9Nd75NzNaadN3ytw1Y1X34STu+9dJNKNsT8e8H6Tfr/JA/3ixhY3tVoydYsbixk/+drK0Ek2a50i2cYmd9IQs51pm9R9n7CnG
 X26MmwhhFwKkFsZpehS2f/R0XcOOkHHv3sgEr7c1mvHbn2AUrZ9+WSu+5T9iE+zUFNG3IjBLF5VAhNA88L+Po/bkIKOiijtcvDwuywO5EDgYK3AOEyT4IK0G
 ZwgD6nNVs3gL+XqHS1MXW6i92Rr5CkCwB5wHhrO3N4LPjEoYaV8YlJ2qYwBxg6GCRIITvETXGX3Ul/PP/1BQlWGLgDIo7VqBoiAjVTq6yf+hiXSOIkKfr6Gx
 rlnTxK88h4seTlSRpkysuiGUEzR0az/GHTdvgA==
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

