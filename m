Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F6C04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F26B20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B6X/d97z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F26B20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504662AbeKXArC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:47:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52091 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504597AbeKXArB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:47:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id j207so4917848wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJh0HkLYwhx8RN9DWitgmjtOM+AmvRphG9ewtpY4jrk=;
        b=B6X/d97zilEFV2nfUiWgCP/ynqmdTvHEuiLvu5MNgh83La7yGqwrtdwW4jfL8I+yQm
         NXNmj9SmXzE8geGUm24KLC2/DAJXvZaOija5UDwybxNuA8FvxHMAHFeBsFpyAJ+OVUtV
         F+lDjNRey1T+2Vh7WFkUd3Vi4ELCG5va2qWIybXApGQwB0vazVf8Zv8j/kZVNw2gUAHt
         jGwhzfPfPXXKASaIkagBjBWCQefcVQslozTilXNpBgMfE6AoAI9OEQA9yXt/FUcXmMq3
         zXB9utBF+MxGEQBJWd4SVIwI4u3lMQIXGk6tHkUnRLgj5OYFSl5NlAU+DH8oGtjnExqf
         xzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJh0HkLYwhx8RN9DWitgmjtOM+AmvRphG9ewtpY4jrk=;
        b=TPK6XVyFZ2ljBiP4ntW0/Oi/uhghvf74thAZAfY54zjfsL+W2dgpjgxECcpMoAcpUD
         qpePGsYFhjpkN7EJSWIVuGBwVSJjD2I5QMcC83B27gs+AawW5XbxVt8I3CZoKIFalzdl
         MpyAr+wU5OEedEk40z2c81phRJr76ZNHt44V3AaVr2UBLZ8Iu6PCfJgayWs4Dreso99E
         519Unu8seBs7kaRtSDE2a46joyR5RB0T3rXYww1hYGoUhUAHSs48PMwiYH3p/5QpFwlU
         HJYs7SfmMRYLnF18vK71tlCn2tpZCXDuK639R595E1jTCofevpAn0rPYJspKJvnfvf6i
         Tw0A==
X-Gm-Message-State: AA+aEWbVS+tCn2+q8NuzKey8x74XWW5AgXIUij6pRHXaqsB2wZdjIxJQ
        PIDGm1jrE6gyakj0mTFMv/VuOA==
X-Google-Smtp-Source: AJdET5cQzuGL1Y+nzPCvrLIjQFCqjgS9HPF0FGBm1adwpm1Lx6Kq9DjhRnbk4hjg4l/q1/s+xmTpYg==
X-Received: by 2002:a1c:c2d4:: with SMTP id s203mr13967030wmf.3.1542981760236;
        Fri, 23 Nov 2018 06:02:40 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm15172185wrd.53.2018.11.23.06.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 06:02:38 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 6/8] drm/bridge: dw-hdmi: allow ycbcr420 modes for >= 0x200a
Date:   Fri, 23 Nov 2018 15:02:19 +0100
Message-Id: <20181123140221.15700-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123140221.15700-1-narmstrong@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
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
index b38ec1d775aa..9b0b157dc5ab 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2564,6 +2564,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
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
index 27f9cce66b6a..c04f497a919b 100644
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
2.19.1

