Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A09C4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4010218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WCCN9xuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfBAMIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:08:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36082 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfBAMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:08:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so5954240wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3YdCNSUKBtHOG5LFF9zYYGs+CVv8TlhyA2FzgjXbzq8=;
        b=WCCN9xuLwBTaNzdv8NR04MIAT7pWcmItyO8QPXjOXcFQtF0Hl/a+gK5NZoNByo7aC2
         yvuF4hda1fpabDl3ftWB0MnuYpkzM3VSYuBn9kRAuUxTLBjE4/Hhogs8HksARMXvVrX6
         J5Y+pDKsSa5b5HwS2yB21cejOaGcQIexfSiTjrsQLdfoENnvhBGAnS6Rg4MXsw6a2H9J
         ZHmgfcZWxcvl5WEHiQMv0AgNAGcSRllarKZHUxMYkVL38x72RsT1CKptK/yZs3hWUP46
         ONoq4QDSbJT9by/GGxZbFYU77s3AitEtM3MS5qPmA2LVT8pv41oXObHn0dvJdHm6G9Vj
         LDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3YdCNSUKBtHOG5LFF9zYYGs+CVv8TlhyA2FzgjXbzq8=;
        b=iGzH3WttkGn1jc8BO4Y9KRdgXtIYpkgKsUmAw+3ZhtodLFPu9WKtF8zCaNzVx+s2Ux
         4MBLrWM9V2H4rXB1+sWPFD6CrLmEq5UW7tHwzGDcMntuZj79VXTuKPRbu+94tPp8rRFW
         IDRi2PwIjwiVCV5zXnVknCbu1u/7Q49s7RftDObLHPa2ZuunkSInBSitp/H79LgDqAXp
         ztl+f//kp0BNiE9EuyK3i6syxrjfwguuoqNtrqriBE2FTT4Ij2gCJTC/TfQkDjgGnmEt
         8iNLYrCxYR9q5GY96R6CSUVLF3EVaD5e1esFnMsXLFarWTEpWNjLptjGYcZozwJD6Vid
         jKDQ==
X-Gm-Message-State: AHQUAuYUmgFHihL50yjHDsI2gNgDohlyYfPtGL79nG1lpZTYhAjkfG1X
        9kw7Vx2rjZOnB0j2DBERR+8Y4A==
X-Google-Smtp-Source: AHgI3IZbCxskQWVVo1IZckLkCdMnCKjiYibX7bRjSxi2TDNBAlaCutd5qcIe2udtSKAHBsMgtlxskg==
X-Received: by 2002:a1c:7a16:: with SMTP id v22mr1997032wmc.131.1549022879098;
        Fri, 01 Feb 2019 04:07:59 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id m13sm2577103wmd.6.2019.02.01.04.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Feb 2019 04:07:58 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        p.zabel@pengutronix.de, Sandy Huang <hjc@rock-chips.com>,
        heiko@sntech.de, maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] drm/meson: add support for HDMI2.0 2160p modes
Date:   Fri,  1 Feb 2019 12:07:48 +0000
Message-Id: <1549022873-40549-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
References: <1549022873-40549-1-git-send-email-narmstrong@baylibre.com>
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
index 0ba04f6..66d73a9 100644
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
2.7.4

