Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DC2C282C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83296218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Rghoq/JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfAZDkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:40:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44298 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbfAZDkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:40:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so5415934plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 19:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hzlq2tFDUYk9/Eai4Q/mwEmBcnhYQ0na7mF2KNolLy8=;
        b=Rghoq/JWmLSrrBS1WZp0kv5TMm/YjudymPqVOV0b5zlg71GLYG1dDD1PQT+YxNlAt5
         IOEZ4GeQS+OlKjLaDMjYzFzA/lx9Rz8D08ZJOgDuTZ60P42OVuDNhNx7hBgXcUYP6pBV
         du4ym3LFkcrjmkyHPt3t1osUXwEsZ0+mTMECtMLkcBY+X1Q/ZEVL3rVujIx8kb3/ThS3
         pza2Q3s1EsB8aSCiWitDeHb53pD1GV8HpjBU0vlynMhbScGHlEolZ76UQBEbVr45ekIM
         X9xfVZr43h1xqup7qeZEgxwFpvNnG/B1YUXNP2p2jlgUwHheTmcOjy++LegtBSwg7lwN
         TZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hzlq2tFDUYk9/Eai4Q/mwEmBcnhYQ0na7mF2KNolLy8=;
        b=ETj5FnSgWTyDM3FLMg2/HriWZ5EoI5ZD19rbgJ8MXYjeQraN/oe0gHKnNzvSEQdJqJ
         Rp7icB22y3OMReDbSpNUVPygpPArNrl7fKbH5j/9yFP4ePiAafVQd6raj+Qs9z3ciDRI
         QDnpYtS0VP1Yx/k+cjZNhW2yF53kc8T5Pfrx2GGP0rVFQ3jWHeEwRXpLHLBuNWFdDAPI
         4EBNeMhYRHenXuXDSHKOIFRN/GyIJ9Kx4ivBkDC7qKWySJkJwcciGvwCi2NZd/SOVI+H
         Z4WH1WxN95j+2fEBKwuu9Qz5Qh30oa8LSe3A2tQweBwUGnHGrSpbQCPeKdtQiIy/3SEg
         ZMVg==
X-Gm-Message-State: AJcUukfdxe0bO387ywDBVp0Wn5SyuwBaz9kKTlgwunX6ruiLCEtTdbMY
        D7oyC/SIu/+yWvN6bmC8lbqW2g==
X-Google-Smtp-Source: ALg8bN6ZxP7s+A5uC3RKNw4MFkVOXB/CumQIXvm3npPrZjYLNKoXXSmMGn/7Ns6wx4iuf0S7nUmm4w==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr13613249plb.256.1548474021496;
        Fri, 25 Jan 2019 19:40:21 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 24sm37460086pfr.75.2019.01.25.19.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 19:40:20 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        Daniel Jeong <gshark.jeong@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 8/8] regulator: lp8788-ldo: Constify lp8788_dldo_desc and lp8788_aldo_desc
Date:   Sat, 26 Jan 2019 11:39:07 +0800
Message-Id: <20190126033907.18427-8-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190126033907.18427-1-axel.lin@ingics.com>
References: <20190126033907.18427-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8788-ldo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 2ee22e7ea675..a2ef146e6b3a 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -186,7 +186,7 @@ static const struct regulator_ops lp8788_ldo_voltage_fixed_ops = {
 	.enable_time = lp8788_ldo_enable_time,
 };
 
-static struct regulator_desc lp8788_dldo_desc[] = {
+static const struct regulator_desc lp8788_dldo_desc[] = {
 	{
 		.name = "dldo1",
 		.id = DLDO1,
@@ -343,7 +343,7 @@ static struct regulator_desc lp8788_dldo_desc[] = {
 	},
 };
 
-static struct regulator_desc lp8788_aldo_desc[] = {
+static const struct regulator_desc lp8788_aldo_desc[] = {
 	{
 		.name = "aldo1",
 		.id = ALDO1,
-- 
2.17.1

