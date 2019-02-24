Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB58C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A644B20652
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 03:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="nf0yxn1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfBXDWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 22:22:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40369 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXDWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 22:22:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so2884963pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yfyZpEHjY9M1Jko0j2q6lNzimdLfD9MFN/TMstLdotM=;
        b=nf0yxn1HxTzcYbxcG6mWWB/6khZTLBvgm6sMA3D/5/KN3223Gq5N4Djf1+6ttskNnt
         KMLMMIGvdzLFVSOYBue7/K+MUQzdp14OIfje+K629lUJ+mQumrxFM9OSP393Kmm7eydk
         0dJHPtnb54TJP3xJlClhKVko8D++Pb15jvVcS5rdlzN10Z7CRELzPebYznNZHE+H2Co5
         D9e8MBXVXG3nknQtt1x7ItQD3LDk8SlysCGIIeiCMzkWwWm013b/rpXeejzKV0md7FpF
         IVBzpgyK2jsxEaeBsyx8NhtwmtzzylFthIMUKj2CiRRqHSkSABYnE6YeViUaC/uRIAWA
         WTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yfyZpEHjY9M1Jko0j2q6lNzimdLfD9MFN/TMstLdotM=;
        b=l2vDxNrYPE5Qkfsvshj+PlH3Nj3HBZbDTJ8weFpakDPQ/vMLyiwGjtU+KnEEXmH8no
         NGbkMCUIMsIUaxM0XKu76htUBLTlXWESI+B/FvL+MwDfNTzj7sgXNZc3qYE3VO1AfzPd
         6/rdH7jG81FlSN9dEA4odygQ9LPHsaWZSYqy5KKut3nz2JEISjsDPrKmJsL8lnRBtu5s
         QTp39aC2ggSij1w/8P3YmlMVGFVoj+KiWPePo5PCzI3Wez5lzzg+jQyESv8Mm+DksJgw
         Ufdhxwbri9/H9VZmTma2Jm23QiVHD2JytzzBCCFkEcenWjGX0xlwXdcOd1M+8gFTK3YX
         NCew==
X-Gm-Message-State: AHQUAuZwbm33sNjw12k9GAA0srZ7LG2K8UvCydsktnQSPxxjApwNqC1N
        +piH3wJyjhFhMdh3t23KMxy5Ig==
X-Google-Smtp-Source: AHgI3IamCg/eiiWP4WitEEBVa+FGe7xSsqG65dB4go+BO1PMKFbH3XPlAWWL2owpxGUMMAUHMCAXDQ==
X-Received: by 2002:a62:70c9:: with SMTP id l192mr12170059pfc.207.1550978523063;
        Sat, 23 Feb 2019 19:22:03 -0800 (PST)
Received: from localhost.localdomain (118-171-128-111.dynamic-ip.hinet.net. [118.171.128.111])
        by smtp.gmail.com with ESMTPSA id q75sm11417621pfa.38.2019.02.23.19.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 19:22:02 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: fan53555: Check pdata->slew_rate setting
Date:   Sun, 24 Feb 2019 11:21:46 +0800
Message-Id: <20190224032146.8244-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code does not really avoid array access out of bounds,
fix it by add checking for pdata->slew_rate.
If pdata->slew_rate is too big, it's a bug in pdata that needs fix.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53555.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index d7142352f6bc..771a06d1900d 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -490,11 +490,13 @@ static int fan53555_regulator_probe(struct i2c_client *client,
 	} else {
 		/* if no ramp constraint set, get the pdata ramp_delay */
 		if (!di->regulator->constraints.ramp_delay) {
-			int slew_idx = (pdata->slew_rate & 0x7)
-						? pdata->slew_rate : 0;
+			if (pdata->slew_rate >= ARRAY_SIZE(slew_rates)) {
+				dev_err(&client->dev, "Invalid slew_rate\n");
+				return -EINVAL;
+			}
 
 			di->regulator->constraints.ramp_delay
-						= slew_rates[slew_idx];
+					= slew_rates[pdata->slew_rate];
 		}
 
 		di->vendor = id->driver_data;
-- 
2.17.1

