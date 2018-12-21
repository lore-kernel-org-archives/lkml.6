Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2320C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE702190B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545355160;
	bh=yjKr0QNuXVXPhhwUxHOutcUPeaYi/akaYIULtharxqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hTQTS6LLe/tJCFrhP56CKzQI1lUzsj3hLJl36s7hZj01XDVRBZlTgtcXDmWfYS7jg
	 1CA8Mak2tYskeDINNSdtzjkJq6fK9luIoQGKHOilbiczDAHdUM3FI0JcM15sS8qle+
	 cZutEMKyT/ak+Eu2KVo28nBJAYEXmo29ugSeiodY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390636AbeLUBSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390455AbeLUBSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:18:30 -0500
Received: from mail.kernel.org (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EBC4218E0;
        Fri, 21 Dec 2018 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545355109;
        bh=yjKr0QNuXVXPhhwUxHOutcUPeaYi/akaYIULtharxqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmmXEmzBDupDZ2so6Ow4gxm9NY7SBONV1dANf7nC7JxTzXH1TOPZH6RyaA9Hq1GCo
         kEE9InjHhQSAkxjMJRoYjkpFKGp+10/0qczrZFU0Bjx5E+kAmsyUnl5wX5Kd5JKC82
         n7zcsnvljK1FpG0YUMDxKp1ybuYZfYXG+O0OAuSg=
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, linux-bluetooth@vger.kernel.org,
        linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 09/14] media: wl128x-radio: load firmware from ti-connectivity/
Date:   Fri, 21 Dec 2018 02:17:47 +0100
Message-Id: <20181221011752.25627-10-sre@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221011752.25627-1-sre@kernel.org>
References: <20181221011752.25627-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

All TI WiLink firmware files are loaded from the ti-connectivity
subdirectory, so let's also move the FM firmware.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index 3f189d093eeb..d584ca970556 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -1347,7 +1347,7 @@ static int fm_power_up(struct fmdev *fmdev, u8 mode)
 	fmdbg("ASIC ID: 0x%x , ASIC Version: %d\n",
 		be16_to_cpu(asic_id), be16_to_cpu(asic_ver));
 
-	sprintf(fw_name, "%s_%x.%d.bts", FM_FMC_FW_FILE_START,
+	sprintf(fw_name, "ti-connectivity/%s_%x.%d.bts", FM_FMC_FW_FILE_START,
 		be16_to_cpu(asic_id), be16_to_cpu(asic_ver));
 
 	ret = fm_download_firmware(fmdev, fw_name);
@@ -1355,7 +1355,7 @@ static int fm_power_up(struct fmdev *fmdev, u8 mode)
 		fmdbg("Failed to download firmware file %s\n", fw_name);
 		goto rel;
 	}
-	sprintf(fw_name, "%s_%x.%d.bts", (mode == FM_MODE_RX) ?
+	sprintf(fw_name, "ti-connectivity/%s_%x.%d.bts", (mode == FM_MODE_RX) ?
 			FM_RX_FW_FILE_START : FM_TX_FW_FILE_START,
 			be16_to_cpu(asic_id), be16_to_cpu(asic_ver));
 
-- 
2.19.2

