Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D2FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ECB2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0r0g4nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ECB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeGQVXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:23:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34762 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeGQVXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:23:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so2162204ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TEYLHn3Em3F8lMdklBwGwg4oTVeokHET29KN89ga/S4=;
        b=V0r0g4nvHThLDB1BUWIDZKU/78FtREFTmrLBcVE4a37GL/w+l7cgFm6qG0lT2gbdQ3
         fK8Z7M+W5jswuUYsrkenKoxKkZDRAaavjR618Oi0BT+Jo/rzIpMdalHLu//7i1kxEg3T
         PbW+9OtuhJ1+72uszeG0Q5oR4uVer+jv7KERE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TEYLHn3Em3F8lMdklBwGwg4oTVeokHET29KN89ga/S4=;
        b=tIZXg9jFgJ1qr+B7bYlTfYFbZHoBCUaQfBTvHAHgnw4q8nfy1dEvcH4cyNu/meJvF7
         r6I5OVquwlvHd5JfOsOcuHC+6FUAc+2U35mVTTbwXk1LGsz4Xq3nd+Wre2DvcIZMnTZs
         V8pGOG6tCw1OzpgW/OP4gkleO2h2fbXCdaaRyBNTd6fs/biCNgglQ48Wi8tAgAb56vYb
         1M6Oo9mUTFhGTcfiuMxkpNccWr1ddBx00diCyiB7lep33ub8t6OSighi34EFS0p3Tdgw
         GRevcsYqYKjgpixht/VeQ2Hxw6bwrzNCTxhIn0fro1E96eOaRvKYfDfc7sJyu5dP5cK3
         6gbA==
X-Gm-Message-State: AOUpUlHd/P7sOJbnTjDhNS7qpn4hKN42iG1xdAdRJTy1LE9hN39zrhYz
        BfTppavwVLsQFe4ZFDBqfEvrPg==
X-Google-Smtp-Source: AAOMgpcIagOELfYPFjTBz/CH63RH8msZI6XwxYL76cWTrgcIsPVoU9P+x9HfBA/QN3EDaZF+f7+rpA==
X-Received: by 2002:a2e:1609:: with SMTP id w9-v6mr2464771ljd.120.1531860526222;
        Tue, 17 Jul 2018 13:48:46 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id a16-v6sm310820ljj.28.2018.07.17.13.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:48:45 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ilia Lin <ilia.lin@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-kryo: Silently error out on EPROBE_DEFER
Date:   Tue, 17 Jul 2018 22:48:21 +0200
Message-Id: <20180717204821.15987-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_nvmem_cell_get() fails due to probe deferal, we shouldn't print an
error message. Just be silent in this case.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 29389accf3e9..b8d1e6875f16 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -109,8 +109,9 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 	of_node_put(np);
 	if (IS_ERR(speedbin_nvmem)) {
-		dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
-			PTR_ERR(speedbin_nvmem));
+		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
+			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
+				PTR_ERR(speedbin_nvmem));
 		return PTR_ERR(speedbin_nvmem);
 	}
 
-- 
2.17.1

