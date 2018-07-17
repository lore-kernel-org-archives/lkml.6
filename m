Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10886ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B299920C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSUcmB81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B299920C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeGQKo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:44:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43673 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeGQKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:44:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id j26-v6so276429pfi.10;
        Tue, 17 Jul 2018 03:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LvI39NNzL1X0bWmbiL4Cgp7ymv34gQ44t/BWbN2XE4M=;
        b=lSUcmB817LeVxfQWnltVY8ttwPCbYAt4dAAkn3rjspYIpO6cL8QONna46Lgj3vZQYJ
         AlRXjCogn24jojLF/F6kflToa0k6F+Vw4cipqGVHKx2L0FoD1t5FvCA64ndUt2QZgttm
         cJdiuScQzV3Jbhjw8tJhzJHUQyOmeSE4LEvd8kSaq7eyqhEVF7evcoQb2yUquQJ1l3D9
         nCCGb9sZZNQG4yPFLlXUHtzMttd22rOJ/3V6YEqAwoaEQgf9+LpbsDBcmYjGShXt0YpZ
         eFS4ZX2dK1QZxslPWGubGLO7qa0GIZEjGVK+ybVv1lK9td2haTGOg2QhG3bW1jkfeG16
         S1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LvI39NNzL1X0bWmbiL4Cgp7ymv34gQ44t/BWbN2XE4M=;
        b=HtBHMcW8PNdUdVnWTRd1Qvaisa5M+dMK/6CC7mlIVod/rsLSjV9wgAELCPgAcr7K2N
         lni7BNynfmxkTfjqjP/eH4X1nSTaPPxw4kusOm+sWf8i+Hz00IZwiKLRghvjQXd5BMY0
         7K7By+creqppsc6FJM9gcbsXSuV7KSATVrSA2guytm/3UCZh8VM5Dnr0ZfQXcjXoa/pE
         EdCRKVZadis4uMj/OUEQzC6f23Z3ZRBZraZFTYOKmkQL2WeT+VhTXj7C9jSoUVeSPRma
         VwmdfACRcV3RKGCKIwRSGQ9yGualKjNH4I/BtOItNn5vdvWs1BEMFWdkjCfD+oGkchyI
         cMgA==
X-Gm-Message-State: AOUpUlGFWtbNUw9caOtS/iJn7xvw90JLdu2CCAtR8Fet9EPgKA20rA1c
        Wl92FkEWWacPrVsxvkJZjN8=
X-Google-Smtp-Source: AAOMgpcXXX9ZlaACLowvfH0t4g0D5oUUEpU7Nmer9Neg8Hvu8hjh6UQd+vG9dR0tTzv7/vcqxbwN6g==
X-Received: by 2002:a65:62ce:: with SMTP id m14-v6mr961335pgv.407.1531822383780;
        Tue, 17 Jul 2018 03:13:03 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.210])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2809963pgb.14.2018.07.17.03.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 03:13:03 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 3/5] thermal: exynos: increase the number of trips for exynos542x
Date:   Tue, 17 Jul 2018 10:12:20 +0000
Message-Id: <1531822342-4293-3-git-send-email-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

increase the number of trips to support more polling modes,
changes help supress following warning.

[    4.231731] thermal thermal_zone0: failed to read out thermal zone (-22)
[    4.237190] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
[    4.244661] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
[    4.254821] thermal thermal_zone1: failed to read out thermal zone (-22)
[    4.260370] exynos-tmu 10064000.tmu: More trip points than supported by this TMU.
[    4.267631] exynos-tmu 10064000.tmu: 2 trip points should be configured in polling mode.
[    4.277551] thermal thermal_zone2: failed to read out thermal zone (-22)
[    4.283090] exynos-tmu 10068000.tmu: More trip points than supported by this TMU.
[    4.290438] exynos-tmu 10068000.tmu: 2 trip points should be configured in polling mode.
[    4.300280] thermal thermal_zone3: failed to read out thermal zone (-22)
[    4.305711] exynos-tmu 1006c000.tmu: More trip points than supported by this TMU.
[    4.313171] exynos-tmu 1006c000.tmu: 2 trip points should be configured in polling mode.
[    4.323002] thermal thermal_zone4: failed to read out thermal zone (-22)

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 2dbde97..4a2733c 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -935,7 +935,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->tmu_read = exynos4412_tmu_read;
 		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
 		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
-		data->ntrip = 4;
+		data->ntrip = 8;
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
-- 
2.7.4

