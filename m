Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B499218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j1SwkFtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbfBAMIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:08:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39367 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfBAMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:08:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so5929515wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VBMrKAKVDCcYyoO1zNr+tcBtFeROASvMyA7RWb6h7Lk=;
        b=j1SwkFtSRo7zQ/oCPgBS9O8DAQNtjdzKmnJQ6TCUdAT77FGEKg/H2+Cn26Hfbv2SoB
         tf+i4ZzsCce9CKkAdd+4oyT2e6mSzi7VtsjGgY9oRHZBUbNInaN7E54D46RZgRv/0i/7
         5FXZfW+upURut7dda4nQEIY/C1FO8fdkkcetZmpyHdOouxaF32Y6yRiP9gV3jJh/pse3
         XBGelMpNVjaX5Gvg8ck9rQpUHq1ZYA0xzTnUdWbmwI6WSJN1RM5o9wh6tp+dEutPB9va
         mXjaam/G8n8cxRseIRa19NyEnfbs1e2iV2iR1RKqDEJWGoGejbmgy54sZP2qQiMa/NO4
         I9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VBMrKAKVDCcYyoO1zNr+tcBtFeROASvMyA7RWb6h7Lk=;
        b=p2Cxfwi5pfCJ7p9NHKDm1LiOm8H7+be2CzFBicoF4MOlrsryp3v5y3W159k5oEf0ft
         AWxYTM3fOf1zfEof2ig+b9siADg/xtewvitz2PLnRzHNzgUiSPfWyZyB9RGL/uzJ/NZU
         xVRp8I/HHywIgzCSY/TrsxkH9Skbk8Gef/70UoWqayw4Hs8dGuCyeG4B2cnn4QQi5e7y
         vRXCZWdQLP3arfx0h8kV0vCXJtCYsleE0VPfTEW1MiTy0weRIs50/GQY/qj6oDPFqyZ7
         sTGbixUPTtafd/YADl4UEpCC5+jI/oCqbVbJFmE6S86mfoYjuPz2RgvIXmh1LuNbpray
         1mNg==
X-Gm-Message-State: AHQUAuZbsyLo6Qco0lMwn98XMjNVJZqbuH5297SPa142KoRH6ASKU1PJ
        NuePRTycCzfMgm2Zg6VrVc9I6w==
X-Google-Smtp-Source: AHgI3Ia29IEHIxxUXtm2jeHXZPnTINwHP/Y1rIZyykt4Y1HPNFKrORuAqug49+209P7PqDh4KQlsHA==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr2092245wma.91.1549022882192;
        Fri, 01 Feb 2019 04:08:02 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id m13sm2577103wmd.6.2019.02.01.04.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 04:08:01 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Fri,  1 Feb 2019 12:07:51 +0000
Message-Id: <1549022873-40549-7-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the DW-HDMI Controller supports the HDMI2.0 modes, enable support
for these modes in the connector if the platform supports them.
We limit these modes to DW-HDMI IP version >= 0x200a which
are designed to support HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 ++++++
 include/drm/bridge/dw_hdmi.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 3634bbd..f1b352d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2609,6 +2609,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
 	if (hdmi->phy.ops->setup_hpd)
 		hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
 
+	if (hdmi->version >= 0x200a)
+		hdmi->connector.ycbcr_420_allowed =
+			hdmi->plat_data->ycbcr_420_allowed;
+	else
+		hdmi->connector.ycbcr_420_allowed = false;
+
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent = dev;
 	pdevinfo.id = PLATFORM_DEVID_AUTO;
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index d506df2..ede8bff 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -130,6 +130,7 @@ struct dw_hdmi_plat_data {
 					   const struct drm_display_mode *mode);
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
+	bool ycbcr_420_allowed;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.7.4

