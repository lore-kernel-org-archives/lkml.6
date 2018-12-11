Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1396C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757A92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vr/WM++u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757A92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeLKNre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:47:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33069 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeLKNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:47:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so14188598wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQbV8xwctzus4GInPuwAdRPCS5e1xGTqZIxHK4PJAeQ=;
        b=vr/WM++unIByFuYmx35Ag47K8iqwRV5tz8LdpOmob6gJNiyQRJYwuWHfyhz2yOLpwB
         G4DPa6ZsIgahgFSL3q/J60JFsBcpSB6dU39G7RSLafD+hKD+rTxdaDi1R0WMNBFfMKT0
         rEVLl03ge+K1REaLJN44Ycu3nclbYwZ9alWqJTqu2JTx/z6U8wvLN4o92OxaGbxKEylt
         SCvt2GNE1MEUIzbhCYP2w/CDfEj5VvT/tl3f/J2gzt+u1IIFgjLGFyQIQDghpdYfdCdv
         cRPvl0cjB0y1bPL0+W4fXdZ9lClnijgCVwuMOCgtr0sb2KCw0UqPEEpVG8IebTqS/YvC
         HIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQbV8xwctzus4GInPuwAdRPCS5e1xGTqZIxHK4PJAeQ=;
        b=l97l7Ee5a+qDNAAYfCamRWfnQ1vOBXBqKRoxpksfyRrVIxOr9TuxCkRlMWOxsdHacy
         imuqgYlRrIWYxJ2nROarcPQvvfY1QJAYs2WElwd8NtFYKkS9u6Uvun5Mj++6KPCtbXAQ
         UvQ9+mqLeUKk/D0Lo1ZT4sxdfErequWOXVwFl10oWnR0V8jB7wYUyQbW47i8w7XkpyR+
         QKVkq5kv1ydGB8ZHVhrDrgQJE2mq0JD34xJrWX9jlVPa54VGy9OgSK4KROzEq4FHcxNf
         B2B2Zh7P9LK8w60VTiEaeak6pCRviCuwZKE9WwpPUgCyz9o9eTvdIjdA+Hes8rLmSJs7
         bAtw==
X-Gm-Message-State: AA+aEWYMpNIc3RgVs+fF0cTLM1rVMSPdaokt4NendTWPz72YMrYuw2G/
        ++QJEiUYDT289oOKr/ijTNQqug==
X-Google-Smtp-Source: AFSGD/VhoV/RAh1KqwKaFK0mf3j/2xTJk2mW0viP3fZVcECzv2HhtTNgGxIfbtfyQGKQK3+a3kI4iA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr13929777wro.103.1544536051222;
        Tue, 11 Dec 2018 05:47:31 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 126sm113768wmd.1.2018.12.11.05.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 05:47:30 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 4/4] MAINTAINERS: Add Amlogic sound drivers entry
Date:   Tue, 11 Dec 2018 14:47:13 +0100
Message-Id: <20181211134713.4908-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211134713.4908-1-jbrunet@baylibre.com>
References: <20181211134713.4908-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sound/soc/meson drivers entry for Amlogic audio drivers.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fe120fc25fa..e8e79713a790 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,6 +1310,13 @@ F:	drivers/pinctrl/meson/
 F:	drivers/mmc/host/meson*
 N:	meson
 
+ARM/Amlogic Meson SoC Sound Drivers
+M:	Jerome Brunet <jbrunet@baylibre.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/meson/
+F:	Documentation/devicetree/bindings/sound/amlogic*
+
 ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 M:	Antoine Tenart <antoine.tenart@bootlin.com>
-- 
2.19.2

