Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1AEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EB420837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdimOYrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EB420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeH3TsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:48:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41642 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeH3TsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:48:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so8504322wrb.8;
        Thu, 30 Aug 2018 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uKaqCBtqbdCV/0TVjaETReatm7uuORq7A9AVhZo/H2k=;
        b=MdimOYrvBalJQGow12JrkZb9Z+nFDifixx/09VVtkcHjKWHMmHdAWPWvYtddt+tC7b
         L8M8//VrgxJa9o2Zl04ghmXhnT5ZbOv2dPrUtj+1eWmAfP6I9lq4kv2vK0fsRx9Mqx1F
         HSF4x7K5B5ByCAHPKcDnEmOTJmeoQL/74NTXfBBAFx5MsnUV4w0sqRcgc15lqH2gOA3S
         KA4ij8MwsUxPr7AJTrCLQ+yzQSjsiriYMqMPQb0ilQE8K8hkSD01HvOD09DOG59MnJLe
         pzhBhO3ycAG6LAVnr8S86ctgppJMCRc3xnUJlcGh5zZEET/Zfxw6/YDtJOKJfWzBCQyX
         KBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uKaqCBtqbdCV/0TVjaETReatm7uuORq7A9AVhZo/H2k=;
        b=c/ztCFPW3DAWYEF8W2nV2d4GQcjFFuPd9uUZUdYhLkcrBQoxAqeyIxkkN0G82c/xA6
         UkMKCbS72dOcRisuq3COZv5w7sEmm9mMkbCrWX5d8z4yDTWjBxw6i/Z8jn6CrUYlScQp
         97T8i4j17bnj/hgJSoff2b06yukVydN0SE8TtZqpAsi37c7svUGqpVwy7nrhcdiyXO2V
         3QfFclve+tteSkbAaqjoWRgouoSlOa6uE36hQZvi4sCi+UTgIhVvBGKx+64LuFbQaknD
         XTX5UOdhCATKjx6wvzIZmsfJJ9FxLELlD1/AvMQkp8XrE5Jh1vVKIC7GwbtA4Ns8f01C
         J1cA==
X-Gm-Message-State: APzg51Dj8jNM8cBcShFbu89zYPSXy68xxatJWYr/c/4XCV6zjRWppG7W
        XmCKhEFHozESA+oSrNQ8W9U=
X-Google-Smtp-Source: ANB0VdZBgvThGOX3zWlLEdEaVRf+EF4fwRTyq3QBhWWN/DWfFzj8me3ReeFRerAT2PSj6ch7wyRT2g==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr3501604wrs.137.1535643920777;
        Thu, 30 Aug 2018 08:45:20 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id j20-v6sm1362759wmh.9.2018.08.30.08.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:45:20 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 01/30] mfd: Makefile: Remove build option for MFD:sun4i-gpadc
Date:   Thu, 30 Aug 2018 17:44:49 +0200
Message-Id: <20180830154518.29507-2-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are merging the mfd driver into the sun4i-gpadc driver we need
to remove the build options for the sun4i-gpadc driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/mfd/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e9fd20dba18d..c680994db988 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -220,7 +220,6 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
-obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
-- 
2.11.0

