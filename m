Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437C321738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfBSUAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:00:42 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:49358 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbfBSUAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:39 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 19 Feb
 2019 21:00:08 +0100
Received: from localhost (94.234.42.81) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Feb 2019 21:00:14
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <mario.limonciello@dell.com>, <dvhart@infradead.org>,
        <andy@infradead.org>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/8] platform/x86: dell-smbios-wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
Date:   Tue, 19 Feb 2019 20:59:51 +0100
Message-ID: <d91d57dc44b6ca5f922a555bd0023dbede4d4b50.1550603967.git.2pi@mok.nu>
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
Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/dell-smbios-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell-smbios-wmi.c
index cf2229ece9ff..c3ed3c8c17b9 100644
--- a/drivers/platform/x86/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell-smbios-wmi.c
@@ -277,4 +277,4 @@ void exit_dell_smbios_wmi(void)
 	wmi_driver_unregister(&dell_smbios_wmi_driver);
 }
 
-MODULE_ALIAS("wmi:" DELL_WMI_SMBIOS_GUID);
+MODULE_DEVICE_TABLE(wmi, dell_smbios_wmi_id_table);
-- 
2.20.1

