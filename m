Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF17BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A5421479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789126;
	bh=qlgmvhl+PV6ymqkGSImwu1D9kZbiJw/BsBNnYJKfrU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RT8oQP6NwvKWCjs7097r7gWXzDiTFrzye6M9V7OXMRgi8RKI/F6NBnSDeLjm0z8TB
	 zrlt8My/m5nmKJNu+XH42iCglEAI+2747hEDLWE+c7FBrW9KxYOknv/S/F87I+qjJJ
	 m9OtTwpRwrF3HyST9VqJrsUz2KTF8DVzMHOGquGY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A5421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbeLNMFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730686AbeLNMFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2594621479;
        Fri, 14 Dec 2018 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789122;
        bh=qlgmvhl+PV6ymqkGSImwu1D9kZbiJw/BsBNnYJKfrU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iU5jBbb2d8lZcqmzDcuDmHy4arx5JxswLLnK71TNfli/0K4sejHoY3OR1qlUuJIZ1
         PDGG7MhzMmbPtN9bTDpKsvbFfTet8s6tK6bW3PVBwxfTUBxh31SW1zOWPLA+RiMaNb
         GC2kina6hK4AP3XBSrO3dhzTamDAcc6/lQo4tBds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 103/142] ALSA: usb-audio: Add vendor and product name for Dell WD19 Dock
Date:   Fri, 14 Dec 2018 12:59:48 +0100
Message-Id: <20181214115751.177402492@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



