Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C5AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043D726245
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="esVJIsxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043D726245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964888AbeF0Mku (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:40:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46352 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbeF0Mkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:40:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so907912pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YdErNj3lOHnGrfs7Yk3xb2ouLxgpJuOY+XeOSd79u88=;
        b=esVJIsxuUKP/5gUurQ+QBrWgqx884K9mihxDulXYw1KaaZW6vGZqTPqpgGkNQliTgd
         71lM0rzVctAX7WdcqR+zSwXXLsIOpCHh80QtIrkKaxOL6VMhSaM1q8gsj7QRgQU+SlhP
         7t/RENvhMOZN4P+XyGt0rEJVZ99H1uSRzAMVXdRaFsWOHcfMGktk+Z0cReZ2rS/8m3WW
         oV8ZJV0XMCEtSIxh1rQhXTeDufBDc8gZCFqODX4LG827Ztli10LapoNhE5YqRnU+sq2B
         yWJMdDXq4UFDknfSqpFouG7GwVGf1p9OiQvq3MTFhynsF1ITcDXWYhEIxonL5llWReYl
         Zvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YdErNj3lOHnGrfs7Yk3xb2ouLxgpJuOY+XeOSd79u88=;
        b=DGaoe74NkrgtYZK1iM+CHsB/qMB7kImhP5TROT6klSy2ypXO8zMG+gG2AHLhbCwH+S
         CT6pNaLKDTKMiyrt0N1WaRsQtYreeCYCbyk5oXfgNA/CvXxtSKq49u4+5eWTZZ7UrV8o
         yQ9qYDPf4OqvWPwY/RIwVFYITCEnaj6IOlufMULISJfawT85fZi0b5S/hdoft3YD2qD6
         zQq/1HoPDFWUJUD2q/dIHloO9tBoRNrhe+Ly+jz7WoO0YTwYiEtq7USXGatAaNxqHDFz
         KXhPQ6jxE2eyOzmbo2wl+sVWjipj51LvyWgppPw9gWKyrcB1ZWfo1OnQpRdAuESTfiVp
         s4XQ==
X-Gm-Message-State: APt69E21lHdgUAHHwM6cefsNfsaiyvyMl6e/EB6OaFaEy5Tdg5alZyPv
        iaTunMb3zUkyh78m1Hh+Dewss83o
X-Google-Smtp-Source: AAOMgpcFmWYHUSheQ74o+iAwGV26QlCt4BBszpMQ7YPqX9ggriNsc1dHmn1wHr4EJ95/EDhasNLPTA==
X-Received: by 2002:aa7:8148:: with SMTP id d8-v6mr5724772pfn.78.1530103246322;
        Wed, 27 Jun 2018 05:40:46 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id e5-v6sm5560019pgs.59.2018.06.27.05.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 05:40:45 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: bd71837: Simplify bd71837_set_voltage_sel_restricted implementation
Date:   Wed, 27 Jun 2018 20:40:14 +0800
Message-Id: <20180627124014.30615-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627124014.30615-1-axel.lin@ingics.com>
References: <20180627124014.30615-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd71837-regulator.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/bd71837-regulator.c b/drivers/regulator/bd71837-regulator.c
index 403b45de1262..f57f42ed7160 100644
--- a/drivers/regulator/bd71837-regulator.c
+++ b/drivers/regulator/bd71837-regulator.c
@@ -73,14 +73,10 @@ static int bd71837_buck1234_set_ramp_delay(struct regulator_dev *rdev,
 static int bd71837_set_voltage_sel_restricted(struct regulator_dev *rdev,
 						    unsigned int sel)
 {
-	int ret;
-
-	ret = regulator_is_enabled_regmap(rdev);
-	if (!ret)
-		ret = regulator_set_voltage_sel_regmap(rdev, sel);
-	else if (ret == 1)
-		ret = -EBUSY;
-	return ret;
+	if (regulator_is_enabled_regmap(rdev))
+		return -EBUSY;
+
+	return regulator_set_voltage_sel_regmap(rdev, sel);
 }
 
 static struct regulator_ops bd71837_ldo_regulator_ops = {
-- 
2.14.1

