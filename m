Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6205FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1C32084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IF5wBfrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1C32084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeLJTqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:46:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43659 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeLJTqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:46:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so11729321wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=0sMlq1ZVgB9mUrKfhXxJybI3Y9tjdLmadM5P4z7CzM8=;
        b=IF5wBfrQmlx+kjWX4pkmtYz32fM5NnXfyNfKRJES+ashdepLKfDXo4FCaKPnbjsjVr
         Gtzl0daljEqB0t56bifsx5msRz6DxxZrDsXTYysTGcT3hEQxpda3g9cTTbg1odSGUt2b
         nw01tw/DWrxgppCHeaYiYG0QT0B3ITnBIEIQdv7iYNrlVRvpzMLlf7G+HQZwRf5/5eA2
         0wh85rNfOMI94cCWIjpkFzeuxmLE1/zITUq91k2ErMpNaqDf9/Rw7Uj7Lmhzs6reVG8K
         tRAOiOcf/euxWnsEWMVpV4b550iIccWJzIUtzFJK2vjB6TCXSvfNHhFFPGdzN8k4RVFr
         fvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0sMlq1ZVgB9mUrKfhXxJybI3Y9tjdLmadM5P4z7CzM8=;
        b=PcXteskoucOoC7GPNf0bGck1jMKgkI4gPBRJZHPdgxcFUlwdu3PhIMOIAK+HY6/+si
         GaLR6CmfUDlXovk6x3imBly1dcwK+6hdEqnTJHDkmliBa+t+peshZmRqGmP5p9fLVLQj
         faO3Yhofk9/pT9Dqs4KatkDb9/GEGQRpKZSUSMHvartL62SQSnVBGrMJp+8kc0TiXFkK
         fzAeI89rftMKbHrnrbOQPd3gZccG67S8ZUnvF85dFY+Tm9jW0o3a4Ym6+7vte8tfYRUg
         zoPDMA0geBya1dY5rHaCElNDHP/V/KX3s4A8K0UuvSrVDQWGgSYnD3gqLw5XGlw7fPMr
         RVhg==
X-Gm-Message-State: AA+aEWb4tSkPaspeXk3IxMRIUddJpcBHVnya2NMESgmqTBq5xC7LZ79k
        QkZhi3iG915tYk7hL/mm+yeERA==
X-Google-Smtp-Source: AFSGD/UEUmJDncf/0mo8+ksCiPcscN/JAxkq2bfPfBsipzRPJkhQoNzuXzgaCG/cYAp8wL7ryxOniA==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr10270543wre.94.1544471162825;
        Mon, 10 Dec 2018 11:46:02 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm18808915wmt.8.2018.12.10.11.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:46:02 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] MAINTAINERS: add driver/soc/amlogic/ to amlogic list
Date:   Mon, 10 Dec 2018 19:45:54 +0000
Message-Id: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While sending a patch for drivers/soc/amlogic/Kconfig, I saw that getmaintainer.pl give nobody for it.
This patchs adds drivers/soc/amlogic/ to amlogic maintainers.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f5c634..f2a5397 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1314,6 +1314,7 @@ F:	arch/arm/boot/dts/meson*
 F:	arch/arm64/boot/dts/amlogic/
 F:	drivers/pinctrl/meson/
 F:	drivers/mmc/host/meson*
+F:	drivers/soc/amlogic/
 N:	meson
 
 ARM/Annapurna Labs ALPINE ARCHITECTURE
-- 
2.7.4

