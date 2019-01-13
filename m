Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00F4C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874F820675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHhYTRi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfAMPae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:30:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47097 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfAMPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:30:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so8969905ply.13;
        Sun, 13 Jan 2019 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yxtl4xAhD5jcWinVdYK9YK7xH7lUQQ4/XKSFL5L2mM0=;
        b=oHhYTRi7JNmPhsBKis+XD+K3QM+wiVEuKDRqRpv32qZdvxAVuQrNFq1jhAh9ez3c0M
         xH1YoxjRIOEpInNxhqBLJtNWMVj3cp4R92X1oOGw8LGhPIgUlNKV8AoXfHab1joolAd3
         0Z1QyMTyPV9qTDTijnT0uIwKnHJ5yvt7pmv8uE77dpF9rNnKgZvaFDuJS8Z74i6Nan/x
         FBjsg7qJeZghj/fZFRjUZTEaInBOVJyBWLPFlkxjUhyexdftFqu6zwByNc9kkF1y5kg8
         NZRqqVL1CC3mPHozuKChzgAxMjJfwrivvxFiblGswC8r7ycUZKGwGCOcv3gFSe+7RzT2
         jlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yxtl4xAhD5jcWinVdYK9YK7xH7lUQQ4/XKSFL5L2mM0=;
        b=EFw33+x6cWL+GwaO8XoAVLtA1ETvskgGC5yIX1bHDlVqUyBNQ4vQipnexfAXtV2JDP
         icXJvq0oJKSAVb7c0CJ1BB0VZEwyg8tYe5RsOueZIeblqPbOU2vfRgJyOwnJt8NKVrc2
         hSBPBgX7Ew1NEiJdyr/x1d5wMKscKu9StdxVD8l6oF2rhi/zFd/FzBBdY4sSgOMJ+nIT
         inHrgRjbY/BbiNrNQOlAwLGuMx0rt57Zmc74x9eQHiBVQBk6szHMPp65rtuR+i9ZzbwH
         ZbeXCMIpOW/w6fEXqgnLe+fnq7uA/Atkce3dn4WfOxTzA7nVtDSrNffjwCZ5E9Mbr88G
         Njqw==
X-Gm-Message-State: AJcUukfeBDmV69CFn9JfkKpabETAavwoAZNtCwEaEEYAE2S59wzMs47e
        q7KN7JSAeyZtV3fJKicbd35E2xle
X-Google-Smtp-Source: ALg8bN4ZzS45dTfO0vrp9LSOssKJOEmHnS09cR+HpEAGROLEZo1cRUyuXRVbhUr36hBOaxvG2UlSiQ==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr21525803pla.68.1547393432501;
        Sun, 13 Jan 2019 07:30:32 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.105])
        by smtp.gmail.com with ESMTPSA id r187sm265107745pfc.63.2019.01.13.07.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 07:30:31 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PatchV2 1/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed warning
Date:   Sun, 13 Jan 2019 15:30:21 +0000
Message-Id: <20190113153022.5040-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Override the dr_mode from "host" to "peripheral" for dwc2
usb_phy0->usb0 initilization of OTG Micro-B type.
Changes fix the below warning for phy poweron failed --> -22

Changes fix the initialization of c9000000.usb phy

[    1.203900] phy phy-c0000000.phy.0: USB ID detect failed!
[    1.208048] phy phy-c0000000.phy.0: phy poweron failed --> -22
[    1.213877] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
[    1.222953] Modules linked in:
[    1.225976] CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 5.0.0-rc1-xc2ml #3
[    1.232872] Hardware name: Hardkernel ODROID-C2 (DT)
[    1.237794] Workqueue: events deferred_probe_work_func
[    1.242878] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.247623] pc : _regulator_put.part.11+0xf0/0xf8
[    1.252280] lr : regulator_put+0x34/0x48
[    1.256159] sp : ffff00001176bb00
[    1.259437] x29: ffff00001176bb00 x28: 0000000000000000
[    1.264698] x27: ffff80007f31beb8 x26: ffff000010eeb7e0
[    1.269959] x25: 0000000000000000 x24: 0000000000000009
[    1.275220] x23: ffff00001176bbc8 x22: ffff80007ed9d500
[    1.280482] x21: ffff0000111bd6c8 x20: ffff80007ed9d700
[    1.285743] x19: ffff80007ed9d700 x18: 000000000000006f
[    1.291004] x17: 0000000000000000 x16: 0000000000000000
[    1.296265] x15: 0000000000000400 x14: 0000000000000400
[    1.301527] x13: ff00000000000000 x12: ffffffffffffffff
[    1.306788] x11: 0000000000000038 x10: 0000000000000040
[    1.312049] x9 : ffff0000111d58b0 x8 : ffff0000111d58a8
[    1.317310] x7 : ffff80007ed9db00 x6 : ffff80007ec21b00
[    1.322571] x5 : ffff80007f400248 x4 : ffff80007fba9b00
[    1.327833] x3 : ffff0000112d9eb8 x2 : ffff80007ec21b00
[    1.333094] x1 : 0000000000000000 x0 : 0000000000000001
[    1.338356] Call trace:
[    1.340773]  _regulator_put.part.11+0xf0/0xf8
[    1.345085]  regulator_put+0x34/0x48
[    1.348621]  regulator_bulk_free+0x30/0x50
[    1.352675]  devm_regulator_bulk_release+0x18/0x20
[    1.357421]  release_nodes+0x1b0/0x220
[    1.361127]  devres_release_all+0x34/0x50
[    1.365094]  really_probe+0xec/0x290
[    1.368630]  driver_probe_device+0x54/0xe8
[    1.372684]  __device_attach_driver+0xb8/0xe8
[    1.376997]  bus_for_each_drv+0x78/0xc8
[    1.380792]  __device_attach+0xd4/0x130
[    1.384587]  device_initial_probe+0x10/0x18
[    1.388727]  bus_probe_device+0x90/0x98
[    1.392522]  deferred_probe_work_func+0x6c/0xa0
[    1.397010]  process_one_work+0x1e0/0x318
[    1.400975]  worker_thread+0x228/0x428
[    1.404684]  kthread+0x124/0x128
[    1.407876]  ret_from_fork+0x10/0x18
[    1.411410] ---[ end trace de5fd1b262c1f56a ]---
[    1.416055] WARNING: CPU: 1 PID: 44 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
[    1.425123] Modules linked in:
[    1.428144] CPU: 1 PID: 44 Comm: kworker/1:1 Tainted: GW 5.0.0-rc1-xc2ml #3
[    1.436422] Hardware name: Hardkernel ODROID-C2 (DT)
[    1.441340] Workqueue: events deferred_probe_work_func

Fixes: 5a0803bd5ae (ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes)
Tested-by: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on Kevin's amlogic/v5.0/fixes branch
Changes from patch v1 [0] https://lore.kernel.org/patchwork/patch/1031243/
- Split the patch into two part
- Fix the commit message
- Added Tested by Kevin Hilman
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1cc9dc68ef00..25a36d117183 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -302,6 +302,7 @@
 
 &usb0 {
 	status = "okay";
+	dr_mode = "peripheral";
 };
 
 &usb1 {
-- 
2.20.1

