Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC88C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23872217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOpKl39L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeLRW6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:58:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40371 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeLRW6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:58:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so8499865plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 14:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8I1CdbqiMUMTrQjUpztZHkA/ZZYSa4PAWKfSX0/YUz0=;
        b=LOpKl39LqedMXHlBQIH2JzT0HDP3T4oAxZbqqtHOncE1Nx6A3qQNp0NkrbuAPkU66n
         Qi51itT3hUwxSyT/xl5WL1Ja5GAN9ox+rdvr+RDZm/DEhM3Ty2dBRthmfpNH7JKBw+JG
         dMVgaqemSXuPfWaN9/kmDJI8qj9J0e+cgnAK9I/mFKcB2lg+HNDF8d9uWardnJemzJVp
         VEDN5n0S9HW7BWBI5xysxFeR9Vw3u9XyHHNJGKdlgovAaCp0aqMdWFZbGOz3PCG/c9sZ
         uSSacaiGHIU9sYjL5jaJlYe9ygdjv5hAysMq74qldGU1f6xxKMz8fSU0/zOrtjVHwcaS
         eRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8I1CdbqiMUMTrQjUpztZHkA/ZZYSa4PAWKfSX0/YUz0=;
        b=WxMLMy6e2x2mksrb8L8A3JY1w5L/gw8h5n3bI6pHLihBN7Lo+4T8HekL6qIBe3kBmt
         x4LQjzWz3AawjYxqrfxFrgBQnxkd2/PoEV/Lgz+epGCJJbpttDPCcR4xZB6z+y+y3ok9
         ESWGQ6T27uMymVMMuo8gO7claZ4jmWuAoyVqIJcEHVTQJbsz5sxkoe00mgU2AGa2u1iV
         8m6C+QRp/qvSv55sOE77bFsiuOer003VP3kBnl+4eqI1UYwjI5SP7CAGVYmkbSEdI5wk
         XHFhC91AwVAGddkqRvGqf6oN2oY82LEJlXZNzMbomcfLWQ1o6EG0FHvZAfJfSJbik2c8
         lcsA==
X-Gm-Message-State: AA+aEWYekIG0TY+/yUGUQMv68lulPVFrUz0Yi48qZQWzk80JXwRS2Snd
        uxIsQ7Ssq4Hm5y5COXyvf7k=
X-Google-Smtp-Source: AFSGD/Voxt2l+iTeoHOGkZ5u4kU9eQjaTD/7Jjez8YeqlLKM9EHxjjFy5y06CxOKeMcVYTmtFtZWQg==
X-Received: by 2002:a17:902:925:: with SMTP id 34mr17425069plm.14.1545173920688;
        Tue, 18 Dec 2018 14:58:40 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m65sm27207728pfg.180.2018.12.18.14.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 14:58:39 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: eukrea-tlv320: Do not enable on ARM64
Date:   Tue, 18 Dec 2018 14:58:24 -0800
Message-Id: <20181218225824.20974-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_MXC is also used by i.MX8/AArch64 SoC, building the driver for
that platform results in:

sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
 #include <asm/mach-types.h>
          ^~~~~~~~~~~~~~~~~~
compilation terminated.

Since the code in question doesn't seem to have any use on i.MX8,
disable it by adding a !ARM64 as a dependecy.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Sorry for the noise if this is fixed already.

Thanks,
Andrey Smirnov

 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6ec19fb4a934..2e75b5bc5f1d 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -221,7 +221,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
-	depends on ARCH_MXC && I2C
+	depends on ARCH_MXC && !ARM64 && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
-- 
2.19.1

