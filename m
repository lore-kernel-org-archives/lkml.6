Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1AAECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C192E2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiQLV67d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C192E2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388114AbeITXoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:44:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34525 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeITXoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:44:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so4708778plo.1;
        Thu, 20 Sep 2018 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l9o0Sy1bGvRkbDIdLy+Zzid1+PkJW3yl1pKPiGyiATk=;
        b=EiQLV67dkt+61R6RBVBAHxsVuy/nKdsS69zmEYj2uuRbT/3G+yUQIriWG9JzA3CvLq
         SliF0QUTOGV/KJ6b06N4X8CxuzDXQmGIwaLPf5nJjj8wag5CUlFQ06hey0npcQKpQF2J
         WcryNVVwxKyJyGvrTKYJd32Co/Y7O4At72og5SlotYcZzz2jap+Ukdzb/ydSV739iDa3
         p87IYNHmQPWwIOAuKo8DM/TJcYNUj3czUpMVNPd22h8LNW2wWX6g9h3N7K8S2Dj5WPm0
         AWwOV6Yq4vrmsrtMYZaZU5C+b0ATrS0JLNZsCa4kVWayw1QvfzuWw0Y8N/W5NmyyjYv2
         GuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l9o0Sy1bGvRkbDIdLy+Zzid1+PkJW3yl1pKPiGyiATk=;
        b=ekrGjyFvEBGItldopj6lyY4oxoejOQu9WJeIR1PI17fCFDZo592qAqD6/RAr+3apbO
         VV6Vh1Kum/KzFnkClOITCIjj1adXRawNGWyheniTOo2sfe7cXO2VUXIfo8tkkHbRqgGP
         l5+TKzdWMlBaNAgoXe6ET1Vzk59V4DoOY5MLsfKJn5OTawubjxtvcSUvG4pVwxCKS+ra
         XG/O4zcRFoRTSU7c+3h79/um0zhnovpz6Qj43mF+O/NC1Ldu72hJhRs0zUye63fGBTlz
         jQSGP+CL84Ua3JuPxN/FPYgkgZh8AjmlsfoYh2SCm7oEB7U1gygF7dIDLvIRMhlFxhUx
         BbKA==
X-Gm-Message-State: APzg51CUUmb6RzasUXtCUiLCbPM98NgWyZ5Q8rpIwKnyNtYW/ExLZ7W9
        MTUsrrYc3nejWVsQOwXloWQ=
X-Google-Smtp-Source: ANB0VdYeIKhJ8UyIowtqb+aIQO54vVOCcjYD4B1ghmIc7BUf89AxnTMMD9WynbzQqiICEM7vnT4y7w==
X-Received: by 2002:a17:902:900a:: with SMTP id a10-v6mr40494390plp.143.1537466375541;
        Thu, 20 Sep 2018 10:59:35 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:59:34 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv3 7/7] mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
Date:   Thu, 20 Sep 2018 17:58:26 +0000
Message-Id: <20180920175826.1284-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tuning for sdr and ddr timing for USH-I mode sdr104/sdr50/ddr50
for host controller.

CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
This patch is new to this series
---
 drivers/mmc/host/dw_mmc-exynos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index ab47b018716a..d46c3439b508 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -253,6 +253,8 @@ static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 	if (timing == MMC_TIMING_MMC_HS400) {
 		dqs |= DATA_STROBE_EN;
 		strobe = DQS_CTRL_RD_DELAY(strobe, priv->dqs_delay);
+	} else if (timing == MMC_TIMING_UHS_SDR104) {
+		dqs &= 0xffffff00;
 	} else {
 		dqs &= ~DATA_STROBE_EN;
 	}
@@ -312,6 +314,15 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 		if (ios->bus_width == MMC_BUS_WIDTH_8)
 			wanted <<= 1;
 		break;
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_SDR50:
+		clksel = (priv->sdr_timing & 0xfff8ffff) |
+			(priv->ciu_div << 16);
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		clksel = (priv->ddr_timing & 0xfff8ffff) |
+			(priv->ciu_div << 16);
+		break;
 	default:
 		clksel = priv->sdr_timing;
 	}
-- 
2.17.1

