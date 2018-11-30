Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B451AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781642145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f0an6cYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781642145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeLAAxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:53:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33596 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeLAAwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:52:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so5365044wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSoaClJe2VwJrVf3BYX56JymGMy95DbVg8e+WAGVJ14=;
        b=f0an6cYGq1iPZp4oIws9G77BregI9k+0nmvJwA2K6wIWrTeYLEyHfrH95QNeWM6u/a
         dGvZnptAR39l7x/NxAMnm+d//Zxt6+K6i7lhfLay6inMslpPM97rRgVImMj/LQxKH2rP
         7z9iZGxL4qWS0po/A01To3whKfN0POiocKtBh8TRD/BvwWYUQq/fllJq0nkeph2Ik0NW
         alLMEvcKyd/qX47AY+w8iChCa7D/X4rIkezV07o6clIKQ0DqnyvoCIddSR6ErtGlK93I
         /sfCHI3/c6Qzkee12CDDR7Is6sZ2/m2bH2p8cZs7dY7WGdasHiSAGcYsXQN8147Q/emZ
         WEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSoaClJe2VwJrVf3BYX56JymGMy95DbVg8e+WAGVJ14=;
        b=dT/2vHBPXOIJpnpHvsMRTqSrbto+dIbz/N1OVcu5wsFcto79HZipsmQv7FM/I025Lv
         TezT4qZEmY4gpHK8/2q/ApsWKbPwqcVDT3e3IvcZ1HkLL8DkyNI5Cgu/Ue+56BseX6UC
         tD3KTgLZCsJa08sRHRyzO2HKbOLkrBlkt8uioPruVxkVTlycIi+/byAeqFvibGPZokrK
         FmBpiN+k5ZGAHqPnd75psWaf+6RnDOjWreNps+SKDEWDRS6LMX/Eb1ktMSdRkj8lgS9y
         UWj5YXIi2guqN7b+h43+/EC9IjBw0oD6rRjc3LvUdlwek+xyXIGMq5eoTveRGnfuEgQx
         vy9w==
X-Gm-Message-State: AA+aEWY/LlUjn7fbld++97+5nINihi2IKwqK6kFKGwh7tIIBuikvaDpa
        Xuq2wBzTfp+C/melfd3/rcIzUg==
X-Google-Smtp-Source: AFSGD/XMOjIFvJp5titmU+bmuir/auYOcVAWltP7EIdXNZVFnsJfO0vV+kvNF5mey6Gm5EYhwUoJgg==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr5357968wrx.221.1543585387856;
        Fri, 30 Nov 2018 05:43:07 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 125sm6864898wml.35.2018.11.30.05.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 05:43:07 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 3/8] drm/meson: add support for HDMI2.0 2160p modes
Date:   Fri, 30 Nov 2018 14:42:56 +0100
Message-Id: <20181130134301.17963-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130134301.17963-1-narmstrong@baylibre.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we support the TMDS Clock > 3.4GHz and support the SCDC Control
operation in the DW-HDMI Controller, we can enable support for the
HDMI2.0 3840x2160@60/50 RGB444 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 0ba04f6813e6..66d73a932d19 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -848,6 +848,8 @@ struct meson_hdmi_venc_vic_mode {
 	{ 93, &meson_hdmi_encp_mode_2160p24 },
 	{ 94, &meson_hdmi_encp_mode_2160p25 },
 	{ 95, &meson_hdmi_encp_mode_2160p30 },
+	{ 96, &meson_hdmi_encp_mode_2160p25 },
+	{ 97, &meson_hdmi_encp_mode_2160p30 },
 	{ 0, NULL}, /* sentinel */
 };
 
-- 
2.19.2

