Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB1121738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfBSUBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:54 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:49358 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbfBSUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:46 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 19 Feb
 2019 21:00:16 +0100
Received: from localhost (94.234.42.81) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Feb 2019 21:00:23
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <mario.limonciello@dell.com>, <dvhart@infradead.org>,
        <andy@infradead.org>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/8] platform/x86: intel-wmi-thunderbolt: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
Date:   Tue, 19 Feb 2019 20:59:55 +0100
Message-ID: <1974b47402bfb029532c00a9a2cc805e1cf0bd84.1550603967.git.2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550603967.git.2pi@mok.nu>
References: <cover.1550603967.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.42.81]
X-ClientProxiedBy: PROXY05.HMC.local (192.168.46.55) To DAG01.HMC.local
 (192.168.46.11)
Received-SPF: Neutral (EDGE01LEVEL1.hmc.local: 192.168.46.11 is neither
 permitted nor denied by domain of 2pi@mok.nu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WMI drivers can if they have specified an array of struct wmi_device_id
use the MODULE_DEVICE_TABLE() macro to automatically generate the
appropriate MODULE_ALIAS() output. Thus avoiding to keep both the array
of struct wmi_device_id and the MODULE_ALIAS() declaration(s) in sync.

Change driver to use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS().

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 drivers/platform/x86/intel-wmi-thunderbolt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel-wmi-thunderbolt.c
index 9ded8e2af312..4dfa61434a76 100644
--- a/drivers/platform/x86/intel-wmi-thunderbolt.c
+++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
@@ -88,7 +88,7 @@ static struct wmi_driver intel_wmi_thunderbolt_driver = {
 
 module_wmi_driver(intel_wmi_thunderbolt_driver);
 
-MODULE_ALIAS("wmi:" INTEL_WMI_THUNDERBOLT_GUID);
+MODULE_DEVICE_TABLE(wmi, intel_wmi_thunderbolt_id_table);
 MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
 MODULE_DESCRIPTION("Intel WMI Thunderbolt force power driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

