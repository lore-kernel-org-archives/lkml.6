Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D0BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55BC20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq2VjW7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55BC20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbeGQKpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:45:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43679 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeGQKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:45:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id j26-v6so276523pfi.10;
        Tue, 17 Jul 2018 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCRS90iDj+umT3k388GQjKhiMKmkdwkS3WxFEVMZyvc=;
        b=pq2VjW7j/j/hrWpljvC4n6gisBMDBAz1quhlefYcklNUNi/jOncq1Jac0TJ//pc03Q
         M/it0gY4jqz3LOV36FLHdr8puxEY3chkXftPyRwZxOtORWSslweGIURQlHpBHShln9Hk
         rAd0WFEhvAWsVVacCcpzUS8bS7MHApxLTXlXkfI/MTKq9N22xsYOzogXXpXztJVba7h9
         InL0jJOc3TpLdbBPlkGd2uyM9LOFx8UpYPqV66WhqLuCEwHwbXrzqLZf8XSEWVfDbZsd
         W+zSO+nWKa5ixHrGXInm+2Ose1zzSei2uSxZacEWUbPgBFSSyWbIPQWQguw6UCmL4Pxd
         FxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCRS90iDj+umT3k388GQjKhiMKmkdwkS3WxFEVMZyvc=;
        b=RIn4ozRi5Zf/uM4LItJCMSN+98291JkmbplEHtAc6w1M86Vl5QeLVFx+Sn6OnS2XeD
         671AjuSeFHHiK/tKXkCBlYknT69Baa7yeJBvo62BHwHGNtQ/lH3AuM4xlCRD9a0Rs0AY
         TvnoKiJWykS87DuejFT8Ir77VXm57zTgwYBFHKQDmQycBJhOm4D5kw60vQ04bSHAvySd
         JCGbwwuVVxwuWCri/isukurQrG6P1T0jMjbKp26RaYuQpQH7+XEwIsurLvqyHIrDxFDw
         be2Sv7cwiOYrfB4rCg8QRmc1JvcOsBJiJRi+uirJWHit+mw236nprkCVAeCg80wNWpwM
         Jrww==
X-Gm-Message-State: AOUpUlH1nx0WZAUh2uzvX6daGcz04ubJnksfHUXnH9PzeefM1di51xkv
        mrR7EdkeMTG98WzAyzOOdno=
X-Google-Smtp-Source: AAOMgpekmsXfi2MWlBbtcbF0Q1s04hzrdqKSrZPeOIvMsWS69Edt3e1Igum9ThWEowzKYr03q4PG8A==
X-Received: by 2002:a63:5b0d:: with SMTP id p13-v6mr1010449pgb.202.1531822388217;
        Tue, 17 Jul 2018 03:13:08 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.210])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2809963pgb.14.2018.07.17.03.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 03:13:07 -0700 (PDT)
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
Subject: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for exynos5422
Date:   Tue, 17 Jul 2018 10:12:21 +0000
Message-Id: <1531822342-4293-4-git-send-email-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e-fuse range min~max range is 16~76. if e-fuse value is out of
this range, then thermal sensor may not sense thermal data properly.

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 4a2733c..6481d91 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -940,11 +940,13 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
-		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
+		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO) {
+			data->min_efuse_value = 16;
+			data->max_efuse_value = 76;
+		} else {
 			data->min_efuse_value = 40;
-		else
-			data->min_efuse_value = 0;
-		data->max_efuse_value = 100;
+			data->max_efuse_value = 100;
+		}
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
-- 
2.7.4

