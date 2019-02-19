Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468FE21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfBSUAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:00:48 -0500
Received: from route-level1.fsdata.se ([89.221.252.216]:49358 "EHLO
        route-level1.fsdata.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbfBSUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:44 -0500
Received: from DAG01.HMC.local (192.168.46.11) by EDGE01LEVEL1.hmc.local
 (192.168.46.33) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 19 Feb
 2019 21:00:14 +0100
Received: from localhost (94.234.42.81) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Feb 2019 21:00:21
 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <dvhart@infradead.org>, <andy@infradead.org>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/8] platform/x86: huawei-wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()
Date:   Tue, 19 Feb 2019 20:59:54 +0100
Message-ID: <9ff0634026ad398bf0338915d9b8c7b5f32066ba.1550603967.git.2pi@mok.nu>
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
 drivers/platform/x86/huawei-wmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 59872f87b741..52fcac5b393a 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -201,8 +201,7 @@ static struct wmi_driver huawei_wmi_driver = {
 
 module_wmi_driver(huawei_wmi_driver);
 
-MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
-MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
+MODULE_DEVICE_TABLE(wmi, huawei_wmi_id_table);
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI hotkeys");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

