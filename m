Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AACC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C51A20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1LDd12hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfAOMdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:33:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36515 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbfAOMd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:33:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so2780873wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpVvc4cxqC3ayWkZN0dkgRpLIy6RZ4ccQ+3oekZQGTI=;
        b=1LDd12hjCVpOIfI8AVplQD6FWhG0ubYYyY7PTvIX2V1Hgce5Nusby60ke42mOM6cLp
         1c5YBW5zPn9UIrPYMGkyMfw8S+wslw9GxxSywpn7Yk5j4HKOss15xWyyr2S5cT1xVMJA
         mFsNvq7BV4+zoPvuRVhn6nlCEJ66eVQOZAhcToS2L7F2gz8vclkXj9xCSk7Yf07v8IwH
         44MajIicDCpsSQKJDe0T4TlyADWUcvwyb9zQ2RquuWV8tZbTWQ1WkNR+nQ+Irn/RMcUQ
         /jXCmmMQ/0n6iCJ4z9060gzHw0OlinGgJkiRoZNhTXgCTGQjW+ziWPrW1DAWZ1ka34dC
         3SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpVvc4cxqC3ayWkZN0dkgRpLIy6RZ4ccQ+3oekZQGTI=;
        b=lD96jQ2WUszdEAUgygwDhUGtBgrTmnEPXG0uZhb3rMI0fIbxvkh/4va+1gXA9WCHcd
         AVglCj143htiYYsBfcEbKkJYMSD3VX7CaRfZP9c15y1aShRopiPQl3aDrYMJpPpAzQGZ
         a5abgPDfgTG+dufejTAIOHKvh2AC9jSC+uVeEYv1rQRdlIMTWZ7SIcHLkOP9GMDtLOGK
         2tsahXTt+4Dv1SzO06yQ5/dn7V5sA9k/8VWKoMz/7d7UyH69HshuKaPXAwZXoXvQRMNh
         XKsQXTRAcdRcedwGII/jczeSdVShkiA9Ob/U+rWzxhQcsTzoR115cj86XOnlyphOItxi
         /1DQ==
X-Gm-Message-State: AJcUukdQIgN4u5SEqSqn2g823SneVgTlTGONLHw8OFtYipQqEMEt156X
        979qhLQ1aVGbdDon5e3diElR6A==
X-Google-Smtp-Source: ALg8bN6PQQnNlB7PgRuVdZQ24LStXWxprznAVANtZajshjeIzeeK/QSfgzluKSB8aZu0L7Y+KwpG5w==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr2921990wrc.0.1547555607480;
        Tue, 15 Jan 2019 04:33:27 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x15sm75658842wrs.27.2019.01.15.04.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jan 2019 04:33:26 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Tue, 15 Jan 2019 13:33:13 +0100
Message-Id: <20190115123315.11069-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115123315.11069-1-narmstrong@baylibre.com>
References: <20190115123315.11069-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index bd564ffdf18b..b6987d97f892 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2612,6 +2612,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
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
index 2e797f782c51..3768265d7a5f 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -128,6 +128,7 @@ struct dw_hdmi_plat_data {
 					   const struct drm_display_mode *mode);
 	unsigned long input_bus_format;
 	unsigned long input_bus_encoding;
+	bool ycbcr_420_allowed;
 
 	/* Vendor PHY support */
 	const struct dw_hdmi_phy_ops *phy_ops;
-- 
2.20.1

