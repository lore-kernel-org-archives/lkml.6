Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC4C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18EC204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYoqmiXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18EC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIMXRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:17:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43239 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeIMXRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:17:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so3098094pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8GR756oMPzkgi0jaNNzmFs58kYiZa/AVR98KWjBKvlE=;
        b=XYoqmiXu03cT6iyfSLsIMUKfM8cZ2rZtwRGnI+M6bm0ytEbjrZf9owv0FTNxC3tNr2
         ksjIaBL/E8NI5PbJos5Ebtam9KQfn4RVq8Hvc24Weyu9zQMNmcbySc+j6WfjMhYpGpOM
         WQoM17rBNVj9JjeNTZzz4E0GbfJC/gvY87AkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8GR756oMPzkgi0jaNNzmFs58kYiZa/AVR98KWjBKvlE=;
        b=pkdKEl//TFwGSOqfHehkG0V94nU/eU+fN00vzBIeaQrrcunYVs61cdaBA0U3GuxFiO
         meXsEVsV99ePc0DJHO30+Ag+mZ0IdN39kF2DPrQtTDvRo7xjypfLsEoTGNhcrop38rSh
         J62sWB/n/OltbxVcaiOGEYoBu88qfThjcqKx9P22AbE7RwCn8PRC8pUVpziSrIv25zYz
         v7xocrsQfFelS36JavrbI80MUvYXlWOP9cMGd2QZ+I7aEeFdRWyZszaknz6kx1NraDtL
         O1KH0hZXXLACzOcKp1PdH+dhzdPQMR8a0PAJJz6egtgnd1cdg8FAYC344b++ONH4EMrn
         OyhQ==
X-Gm-Message-State: APzg51CIFe8jL1AKew9X18HxbiB/bQ8r8lk3jEK63FwkRUDsAyFxvxns
        FuDuLGrQB45gu1eFnK1R+QHT
X-Google-Smtp-Source: ANB0VdYUyO9ESGPdXUgr4960v/e0DkQvswTxph0vSKhP2eR3IvyMaebd28O50x/K0zdwQ5fW+SMx/g==
X-Received: by 2002:a62:90d4:: with SMTP id q81-v6mr8558264pfk.37.1536861998084;
        Thu, 13 Sep 2018 11:06:38 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6115:a36e:955b:f94d:4607:e9b9])
        by smtp.gmail.com with ESMTPSA id u184-v6sm8856802pgd.46.2018.09.13.11.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:06:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 4/4] arm64: dts: rockchip: Enable SD card detection for Rock960 boards
Date:   Thu, 13 Sep 2018 23:35:45 +0530
Message-Id: <20180913180545.29756-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For proper working of SD cards, let's add the Card Detect GPIO property
to the common devicetree for Rock960 family boards.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
index cc9c373f3a37..6c8c4ab044aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
@@ -439,6 +439,7 @@
 	cap-sd-highspeed;
 	clock-frequency = <100000000>;
 	clock-freq-min-max = <100000 100000000>;
+	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	sd-uhs-sdr104;
 	vqmmc-supply = <&vcc_sd>;
-- 
2.17.1

