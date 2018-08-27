Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC02C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43537208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Wi9qZzsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43537208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeH0SCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:02:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46523 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0SCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:02:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so7491327pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Px3fLNoTUuByIFKK1jTLxiUL1sfpD4HRXsT5D33Cm4M=;
        b=Wi9qZzsPFBdY5Bdb9tHiA65DOJS5F+E3uF6cEOV0kTAQCi7BNbqkJ05Ak5KLS3eE52
         n219BLhV/qf+nvAt0yTvqJzdEDVmek1Fjjo16HZeJ2s0fxfex1pC/zxCP2HYYgz55JoF
         TcZeFeQ9q8VshHg5FsgECuqMA3Vw8ZZaaLnlfTJusVlFemXuuuShKbhL6B95fsaVCM0c
         UxeixkICeljvQsbEbXQSv54o8zIZv+yuQ4dWPvmdNkx/VFk7GMPtioh0eBuvP9ZnpLJC
         UVL3z8+HV3gdjbU+Kx8bz/pwgV9Ichv1kE+gA7E/VtfdAKRtja7L8EXHe0GyRZXn+CeT
         nSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Px3fLNoTUuByIFKK1jTLxiUL1sfpD4HRXsT5D33Cm4M=;
        b=pBRaT3XRcQ2nAijuyZ0AaNJhH31IFSunu/7kyAapBGuO8v91B+24r1Ogou/URLu3mK
         ztu/Its9TlgMVLrpt8b4ogcBgEtxFTPVU3LZpjvkGfe6sMCDX2e4Ou7ILIh1XmBfqMdh
         WJEn59gq+yRieY5+bfMf8l3jj1rXNyFj6hO/A6qj3vsFxRGgqOWhH8T6Lae66EN9VwhH
         Zzk/wLDD9rm2ssWUkdL0SpDwQ0ijj1sK3H1jK+wKh560QhyCXL2ueyICQYWnUmggin0G
         oesGa06VYWZXg1BFGalIem2UYvnHpqI5+RSbNpFq9AzHfFQ4zNDDCXkZY9qhcKoWsKL5
         ZpGg==
X-Gm-Message-State: APzg51AnvBrtbkHtvZxlpffh/cZHElgFmIEv8K7w+7/gCwMDnija96u/
        Ke/kK8ON4hZUyIHNhR48ld+VWg==
X-Google-Smtp-Source: ANB0VdZf7CPC3CaDltgQQX/07k0OYjr52oVCjnTORA1XhJsuaxHeVqzBexgyRIfZLjAARVYmMTyIiQ==
X-Received: by 2002:a63:ad07:: with SMTP id g7-v6mr12562696pgf.19.1535379332207;
        Mon, 27 Aug 2018 07:15:32 -0700 (PDT)
Received: from localhost.localdomain (36-239-209-175.dynamic-ip.hinet.net. [36.239.209.175])
        by smtp.gmail.com with ESMTPSA id x82-v6sm27795461pfe.129.2018.08.27.07.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 07:15:31 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: isl9305: Add missing .owner field in regulator_desc
Date:   Mon, 27 Aug 2018 22:15:21 +0800
Message-Id: <20180827141521.30941-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/isl9305.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index 257c1943e753..9c2607e912cf 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -84,6 +84,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_DCD1_EN,
 		.supply_name =	"VINDCD1",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 	[ISL9305_DCD2] = {
 		.name =		"DCD2",
@@ -98,6 +99,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_DCD2_EN,
 		.supply_name =	"VINDCD2",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 	[ISL9305_LDO1] = {
 		.name =		"LDO1",
@@ -112,6 +114,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_LDO1_EN,
 		.supply_name =	"VINLDO1",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 	[ISL9305_LDO2] = {
 		.name =		"LDO2",
@@ -126,6 +129,7 @@ static const struct regulator_desc isl9305_regulators[] = {
 		.enable_mask =	ISL9305_LDO2_EN,
 		.supply_name =	"VINLDO2",
 		.ops =		&isl9305_ops,
+		.owner =	THIS_MODULE,
 	},
 };
 
-- 
2.17.1

