Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9854EC43613
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D082085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QYthVx2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfAOMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:33:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37101 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729461AbfAOMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:33:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so2775265wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1W+lbP0SbjGIMhxY+ggbwt4nGlITxeB1OhuVLZxhZ14=;
        b=QYthVx2LP2RKJHMt/0LEdagK5t8SoOriABnSaL84/UTRxp/dVjCaKaKYXxzB6V59ma
         No514ZSY/Eg3bga3v/ueyNefKKPoRkV/RdAW2sMXaAobJohGoc9VixMAVYFsm5Qwbiku
         aUsoMa1lpxuyNqhSI3ktUBR0m/m+3kDQCEDr0l4GpNpLs+QltrU6mzVDhuiX/ZtbZ7eG
         1/LBbR0SStGa24hEbaIhv7+6yI5jKkpZGNT0UNk0caYxGzcHKpMvvF9uEtdQROapV98g
         ZowsON7IPVduodv+7vyFaY2d4Eji7yNfEytfaKrrrXlP7HCmNoUsyxCxcpmBai2c+zYT
         Q/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1W+lbP0SbjGIMhxY+ggbwt4nGlITxeB1OhuVLZxhZ14=;
        b=AV7nPiy2nrcX6FUUT4JhTxuE4cLDcaC7hmTCHtEgbQn81K/VD9E65VpAl81JH1kHBo
         sTqtN4/v30ryvp5/CsTHabZfYlFpeKLxi8+XyN7cwhJPIC9u4DRXtchOKFxSiipJrNn0
         3j1sWxJ62w3G0B6M2553hAgk4ZcGSHRI9FlTwhyOG1LeCqwTwulrdjWgJmS/TS1vDy8m
         kERV8BgAQei1RBNTAvRbYTz3QlYAp1oNYJbSsSIO0nEeNT34tdjZIqtdl4K43QupE+GW
         Nis50/BIiGFWnj1E9JeHRluFXBO4r+5XQYDeDDQlBuy6MF0VvYzLz/ZJZAj6gw/WWTDs
         IAqA==
X-Gm-Message-State: AJcUukeYpQbn7DOdFFirtqC+925Z+0yDH6JBGFlkICIerB4UneTuy9J3
        rWzdzkSMp7q9v/6srgrBXue4iA==
X-Google-Smtp-Source: ALg8bN7OsDHasv+8VVuqmmtrBH0Aa8tMLeqgL9ao4RCNk9LnYdYKvcDKknGt7btAKWwQqs+bLcTLbQ==
X-Received: by 2002:a5d:5409:: with SMTP id g9mr3058434wrv.88.1547555603725;
        Tue, 15 Jan 2019 04:33:23 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x15sm75658842wrs.27.2019.01.15.04.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 04:33:22 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] drm/meson: add support for HDMI2.0 2160p modes
Date:   Tue, 15 Jan 2019 13:33:10 +0100
Message-Id: <20190115123315.11069-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115123315.11069-1-narmstrong@baylibre.com>
References: <20190115123315.11069-1-narmstrong@baylibre.com>
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
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
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
2.20.1

