Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248AEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE553206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4TsEiG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE553206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeLEKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbeLEJlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:00 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B882084C;
        Wed,  5 Dec 2018 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002860;
        bh=JAN29/KFpKsDaCkiQLyC9yTIRecNGXcNSk+IRCHRiKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4TsEiG8tTh9mpUDNpXcvd1G9RZ4xgCT78bZKABJ1d0q6brPFzk3xvrpwFZANRPvW
         DSRFCSY6lWITcqJBRSrfa2L5sXPceBZ1QtHOAOzfexbz8xA8WFtVGhDeUlOfWcsYoo
         GnIW2FsBHaJTTFKrYVYJCmnaRkJfJ9aNsSlXXLYA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hui Wang <hui.wang@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 090/123] ALSA: usb-audio: Add vendor and product name for Dell WD19 Dock
Date:   Wed,  5 Dec 2018 04:35:22 -0500
Message-Id: <20181205093555.5386-90-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit 8159a6a4a7d2a092d5375f695ecfca22b4562b5f ]

Like the Dell WD15 Dock, the WD19 Dock (0bda:402e) doens't provide
useful string for the vendor and product names too. In order to share
the UCM with WD15, here we keep the profile_name same as the WD15.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks-table.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 08aa78007020..1c73b9ed44a6 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3387,5 +3387,15 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 		.ifnum = QUIRK_NO_INTERFACE
 	}
 },
+/* Dell WD19 Dock */
+{
+	USB_DEVICE(0x0bda, 0x402e),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "Dell",
+		.product_name = "WD19 Dock",
+		.profile_name = "Dell-WD15-Dock",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
 
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.17.1

