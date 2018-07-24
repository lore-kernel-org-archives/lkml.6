Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EADECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E1720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbrJu11S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E1720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbeGXOcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:32:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34537 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbeGXOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:32:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so4053472qth.1;
        Tue, 24 Jul 2018 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ct8x3E30AHH6EAGdxFhW39P6ckuCN8DkFYXBfUia9T8=;
        b=YbrJu11Smrp9Nrt7EMqtbE593yhkQ7yQLAbklkHmUkS8V1A7wSKuQlBjwJZijRu+Ts
         yLU8y4FhRabFCQlBAwlmsS8XDoOkxauN3l0bypNZ/IMj93cyuxQ1nFQaSZZz40zeJB/C
         tsnEKxIDTZg40yCcSpYzJGVa9ShSF59Qp18C+mje6CEZUgnCHO4C+3z3s2i8T/lkbbzy
         IRNxdHfpvTNHjwtZaP+JyV35jbLUk7HANXx+qZkRJSg9dmAghHqe2nE+Ox57bVNWXLKR
         wXEmruFaL+oige/jIi2PSwWnDBWaAR4mnW8BtIRy3u2jLbIcARhJRFQJ+3G1oMqluasS
         vOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ct8x3E30AHH6EAGdxFhW39P6ckuCN8DkFYXBfUia9T8=;
        b=FyYS/OwB0lY0WcAv87pclgddc7PDffh4ssnBk5N72PXJgCmKszrN7DjLNG6jTAkC/J
         zxZ4ty15lbBU3DJ4Yxy1DMqeOB5BLbnnj14CaAE5kQVgXTg3q1Nc8/P6IyhqEwPAv09N
         R+J+TYN0dm2kAaQBxqH8keKgsWSJEpLErqzkMLjsYH5vCdAe4e7DiislKpN+9JdKpHWS
         FS42iAMTJE43dyeUE7sdx/FKL9Ktu9RlA1+72c5ivj9kLJAhxlQlIhknjeeP5UV0ga5w
         nLkQ5rbaidEO2pMoFmBVfdFhmRWV4/xNKyW2NA35PSzdlC6/Dbgys7mEcTqSaAXoAFDU
         z4Fw==
X-Gm-Message-State: AOUpUlHZgnN7TrVHBNEVcYH4MZRup3EsRU4/DWWbnLhsjkwoy9+waEZw
        mb49yz0LNCMgK2jEZIcd+vU=
X-Google-Smtp-Source: AAOMgpcQvTNsCf+5kddY9f0xHFYWd/nmqPqtGb36Vor879nYHM683p6px+wJXWlhxRoVbd7w2C+VIw==
X-Received: by 2002:ac8:2734:: with SMTP id g49-v6mr15905292qtg.168.1532438762955;
        Tue, 24 Jul 2018 06:26:02 -0700 (PDT)
Received: from master-laptop.pgwipeout.duckdns.org (111.sub-174-204-1.myvzw.com. [174.204.1.111])
        by smtp.gmail.com with ESMTPSA id e20-v6sm16543346qkh.32.2018.07.24.06.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 06:26:02 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v3 1/2] Add sw2_sw4 voltage table to cpcap regulator.
Date:   Tue, 24 Jul 2018 09:25:40 -0400
Message-Id: <20180724132541.17039-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724132541.17039-1-pgwipeout@gmail.com>
References: <20180724132541.17039-1-pgwipeout@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW2 and SW4 use a shared table to provide voltage to the cpu core and
devices on Tegra hardware.
Added this table to the cpcap regulator driver as the first step to
supporting this device on Tegra.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/regulator/cpcap-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index bd910fe123d9..c0b1e04bd90f 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -271,6 +271,29 @@ static struct regulator_ops cpcap_regulator_ops = {
 };
 
 static const unsigned int unknown_val_tbl[] = { 0, };
+static const unsigned int sw2_sw4_val_tbl[] = { 612500, 625000, 637500,
+						650000, 662500, 675000,
+						687500, 700000, 712500,
+						725000, 737500, 750000,
+						762500, 775000, 787500,
+						800000, 812500, 825000,
+						837500, 850000, 862500,
+						875000, 887500, 900000,
+						912500, 925000, 937500,
+						950000, 962500, 975000,
+						987500, 1000000, 1012500,
+						1025000, 1037500, 1050000,
+						1062500, 1075000, 1087500,
+						1100000, 1112500, 1125000,
+						1137500, 1150000, 1162500,
+						1175000, 1187500, 1200000,
+						1212500, 1225000, 1237500,
+						1250000, 1262500, 1275000,
+						1287500, 1300000, 1312500,
+						1325000, 1337500, 1350000,
+						1362500, 1375000, 1387500,
+						1400000, 1412500, 1425000,
+						1437500, 1450000, 1462500, };
 static const unsigned int sw5_val_tbl[] = { 0, 5050000, };
 static const unsigned int vcam_val_tbl[] = { 2600000, 2700000, 2800000,
 					     2900000, };
-- 
2.17.1

