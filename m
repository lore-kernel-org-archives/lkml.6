Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F781C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD9120896
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swFYHZlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfAMSSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 13:18:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45651 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfAMSS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 13:18:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so8470640pgc.12;
        Sun, 13 Jan 2019 10:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qh1Vvz9nFt0zbkJ37Q8bDQfJww+y6baj77fJu8mv98I=;
        b=swFYHZlfdSg6jCEkobODwgnPuE6nEjJPb3gCppvr+w/wWhlYMhNhkpdli0TsuPs1xU
         LiPfvXrWVD1YZenmBCRbBIUcU1NlxKLj6noaSmaDDwGEay1PQS82tug/nRt3b5ySrrib
         JhQKHQI43TFPHc26H7D99Jyos/romqrC0+XSFier8LOeAasMYNDbUDjCNhVa6x0dow96
         3aeCwoGWgnwlVFQ8xb/nTEd5B0kfJ3pq8t2W8BO+waZg/pvzoQ916HYusyXU6idwrx8q
         nY1OMC/wh0r7BpKC1hLlyPmx4pJFx0r7h8epi8w8h6HnDQHHTO8nrzvp3eqbUvvOv/ey
         ycKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qh1Vvz9nFt0zbkJ37Q8bDQfJww+y6baj77fJu8mv98I=;
        b=D8Wk9wzOZNZR63ZWAaM2WA/N/KWthjJpbZ+yTXbEtxq/iMYk//LqYt0pIGOAxxyhNY
         rXFTQOHCmyoEl/QwGo9uqRnX0cYGr4Tv2h1DhTz/LI4x3Qic2DZOhCHo1Mbvrt6nEEWs
         CoDTt3tS8KW91UOjqipUbYEoombVPSCHsKjGa7VCN3UE//Q5/AzXockMCgb01O6ycC7b
         KETmn7FKbKm+Z8+jhOCYKxpqBg0+zBfYqqhqd8r02VGTZxVwGbdCRoSTBnAe9w5Iv6mL
         YdkwUqY90WBL5GKSp5ZveMLlpo6MDbWomCI/2oZD0bxGqDMjL6CxcuBGjRIlC89mQZsj
         jV6g==
X-Gm-Message-State: AJcUukc+p2777uOvHb16ba1TAKuDK8T+AvUelN173ABdSfs+CqnsrghP
        y/PZrcuW/kPSMLrMi6eYuXaFuJFd
X-Google-Smtp-Source: ALg8bN5zH9qH94ZZJjYOfVGfLt2TvQIJ/wKbeMQOEPYGeoGwZN29QJ8K9d3ZnoCFHJQyGixOX2BN9A==
X-Received: by 2002:a63:9b11:: with SMTP id r17mr20476965pgd.416.1547403508296;
        Sun, 13 Jan 2019 10:18:28 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.105])
        by smtp.gmail.com with ESMTPSA id i193sm157504416pgc.22.2019.01.13.10.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 10:18:27 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Subject: [PATCH 2/2] ARM: dts: meson8b: odroidc1: Fix usb phy regulator power failed warning
Date:   Sun, 13 Jan 2019 18:18:08 +0000
Message-Id: <20190113181808.5768-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190113181808.5768-1-linux.amoon@gmail.com>
References: <20190113181808.5768-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Override the dr_mode from "host" to "peripheral" for dwc2
usb_phy0->usb0 initialization of OTG Micro-B type.
Changes fix the below warning for phy poweron failed --> -22

This fix the initialization of c9040000.usb phy.

[    1.639706] phy phy-c1108800.phy.0: USB ID detect failed!
[    1.643850] phy phy-c1108800.phy.0: phy poweron failed --> -22
[    1.649706] ------------[ cut here ]------------
[    1.654273] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
[    1.663400] Modules linked in:
[    1.666439] CPU: 0 PID: 29 Comm: kworker/0:1 Not tainted 4.20.0-xc1ml #11
[    1.673192] Hardware name: Amlogic Meson platform
[    1.677894] Workqueue: events deferred_probe_work_func
[    1.683027] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
[    1.690746] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
[    1.697953] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
[    1.705418] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
[    1.713579] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
[    1.722437] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
[    1.730859] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
[    1.739112] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
[    1.747537] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
[    1.755350] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
[    1.763599] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
[    1.772110] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
[    1.780359] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
[    1.788522] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
[    1.797470] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
[    1.806585] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
[    1.814748] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
[    1.822128] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    1.829331] Exception stack(0xee0ebfb0 to 0xee0ebff8)
[    1.834369] bfa0:                                     00000000 00000000 00000000 00000000
[    1.842534] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.850695] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.857311] ---[ end trace e28bbc26874282a4 ]---
[    1.861984] ------------[ cut here ]------------
[    1.866524] WARNING: CPU: 0 PID: 29 at drivers/regulator/core.c:2054 _regulator_put.part.8+0xf8/0xfc
[    1.875629] Modules linked in:
[    1.878658] CPU: 0 PID: 29 Comm: kworker/0:1 Tainted: GW         4.20.0-xc1ml #11
[    1.886817] Hardware name: Amlogic Meson platform
[    1.891513] Workqueue: events deferred_probe_work_func
[    1.896641] [<c0312204>] (unwind_backtrace) from [<c030cb8c>] (show_stack+0x10/0x14)
[    1.904366] [<c030cb8c>] (show_stack) from [<c0e223b8>] (dump_stack+0x8c/0xa0)
[    1.911573] [<c0e223b8>] (dump_stack) from [<c0346334>] (__warn.part.3+0xbc/0xd8)
[    1.919041] [<c0346334>] (__warn.part.3) from [<c03464b0>] (warn_slowpath_null+0x44/0x4c)
[    1.927203] [<c03464b0>] (warn_slowpath_null) from [<c07df6b8>] (_regulator_put.part.8+0xf8/0xfc)
[    1.936060] [<c07df6b8>] (_regulator_put.part.8) from [<c07df6e4>] (regulator_put+0x28/0x38)
[    1.944483] [<c07df6e4>] (regulator_put) from [<c07df71c>] (regulator_bulk_free+0x28/0x38)
[    1.952734] [<c07df71c>] (regulator_bulk_free) from [<c0943858>] (release_nodes+0x1bc/0x200)
[    1.961159] [<c0943858>] (release_nodes) from [<c093f82c>] (really_probe+0x110/0x2cc)
[    1.968974] [<c093f82c>] (really_probe) from [<c093fb4c>] (driver_probe_device+0x60/0x16c)
[    1.977224] [<c093fb4c>] (driver_probe_device) from [<c093dcd4>] (bus_for_each_drv+0x80/0xc4)
[    1.985734] [<c093dcd4>] (bus_for_each_drv) from [<c093f6ac>] (__device_attach+0xd0/0x138)
[    1.993984] [<c093f6ac>] (__device_attach) from [<c093eae4>] (bus_probe_device+0x84/0x8c)
[    2.002147] [<c093eae4>] (bus_probe_device) from [<c093ef80>] (deferred_probe_work_func+0x60/0x8c)
[    2.011092] [<c093ef80>] (deferred_probe_work_func) from [<c035fdb8>] (process_one_work+0x218/0x504)
[    2.020209] [<c035fdb8>] (process_one_work) from [<c0360ea8>] (worker_thread+0x2a8/0x5bc)
[    2.028371] [<c0360ea8>] (worker_thread) from [<c0365a18>] (kthread+0x14c/0x154)
[    2.035752] [<c0365a18>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    2.042955] Exception stack(0xee0ebfb0 to 0xee0ebff8)
[    2.047993] bfa0:                                     00000000 00000000 00000000 00000000
[    2.056158] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.064320] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.070934] ---[ end trace e28bbc26874282a5 ]---

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on Kevin's amlogic/v5.0/fixes branch
Note the warning is not getting produced on the latest kernel.
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index a49a8509b288..9d7f725cfe35 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -318,6 +318,7 @@
 
 &usb0 {
 	status = "okay";
+	dr_mode = "peripheral";
 };
 
 &usb1 {
-- 
2.20.1

