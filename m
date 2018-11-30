Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3833BC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06322146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dLSQoDfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06322146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeLAAwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:52:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40844 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeLAAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:52:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so5332005wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTv4CerWuDunGxPcJq8t4rU36qCRkw5Gv7Vxxq0kkcI=;
        b=dLSQoDfzw2raLIuoVW+ovYnFaiHm2DI3L9tCMWb3MOJqWEAjHbpnKDtsCbHRWJMT7y
         vhHro28SmoDMluTyWcRAzydBtnOKlCZkxa9wcQOHYPx7PvZrQr/P8GlsIvJOWmmLn3rX
         lmozit7dx5BcumG4+6zrbfqhLv8PwgTONIn3Bdfo/z8bYKC/lY4nJa6U4WT53/3QmonZ
         VjSjoW7fEbSJnuOmnRh9j//hepcBAnhyophtDPCvy+oAF1eIFL9dpVb3praLdbU0yDcC
         +xAtJFu1urjjUQTjNMD01ClGeuJLnEc0DszbhvaySbUS8l59Gzb0chXabghXALmfTQ6h
         OvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTv4CerWuDunGxPcJq8t4rU36qCRkw5Gv7Vxxq0kkcI=;
        b=MH0sedPTaAtEXyTItRdBpEbFNItC9bKLyJrwk1n1mz7U5HsyXkx4vCk6J2Ae7SO1sH
         bnYSdpvoFSIkDLKkUjCC8Nv+MSbo3kftSt+ny87PqOAT+1ChzEOp+iKVKGsmsmchjBDw
         +7VChOWmydz3E/zn2sreg76QfzDqp+hdRyY8QzJCw1PYMBXegOpZ9bRpEzNsLMKRbMbk
         LeKieQpHG7YWGI2G4P5JUzyk0qAnyOHa15Vu5+sn/guDjOtKNp6fh/4aViX52jeJnNjA
         cjKjRTmJ4u2FHdcc9NcY1lVbLMidWBpvg0XPiMlK0MS7oIJFnlVKgfGZCWXlkHpj7f94
         VYSw==
X-Gm-Message-State: AA+aEWY4jgBaTqixilgcDS3K3RzCUgeqIM/yBcgR1a84ra/HDFieOHMW
        CY/A9sVlQFQSn4CnZ5bCMK5fgK5P7Hzidw==
X-Google-Smtp-Source: AFSGD/WgkJwJgEnEFW5peSmOfGXjSVsCz6oJ++TjtWKjLFJzzNKhHa8FfoHVKYbP9kPQyIQdQjiBQw==
X-Received: by 2002:adf:e383:: with SMTP id e3mr4882121wrm.31.1543585391526;
        Fri, 30 Nov 2018 05:43:11 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 125sm6864898wml.35.2018.11.30.05.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 05:43:10 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        maxime.ripard@bootlin.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 6/8] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Fri, 30 Nov 2018 14:42:59 +0100
Message-Id: <20181130134301.17963-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130134301.17963-1-narmstrong@baylibre.com>
References: <20181130134301.17963-1-narmstrong@baylibre.com>
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
2.19.2

