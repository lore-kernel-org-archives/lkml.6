Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E121C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C322177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="xyrkfUUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfBSNbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:31:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35605 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfBSNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:31:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so5751343pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PCB2oui0ibioi9ssGtuMLt+AjTEDWAW4fz4hqaogVfs=;
        b=xyrkfUUc5FNMArassUXLkw3DVBhvTSbPzQ5phh9VNlSudMql77cVVoDNikrjW1C65d
         pC3aX8BjAH6pCmcJXhUd2/biQssHxHNpkcpfnzOsAdAisDAIO9QNIIPs5awvd6EqWtXI
         1sxTyPrxU/+Nq8kSHQ4a7AR0oF3Vin+NxO5K4ECcweU0/UMFEPAFBuNJRoY6+O23g3oB
         Ey4/kBXRMGWIlclAi/aeDRuxWyKAC0Rj5t9HrHAXJtjltzW1JJk8e/v1GRfl7tPUIwuk
         sYgxYzJr1T3jeX8r2Ixot+ajzCAWgxf18/+SRbNPInHCVwiMKS58pXCudgNEsId9GbPi
         c7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PCB2oui0ibioi9ssGtuMLt+AjTEDWAW4fz4hqaogVfs=;
        b=JdotAqEGe8PQCFuE7fwr61uWtuqPW3NLzBsjZ/OKKCaIzLS2YABV4mDrRIAPFHq17h
         xAb7QBY52r7eaXv1QgCScUlDwK05sfTeNZfk1poB3ksiOG6g2nl2aWJ6gXIHEPLfcVkC
         rTiuUWg4Kkv04weNeQKVttEFP+ZQfzETWngt/bpUVLA0Fd2Wuz4JeYVaEP6AphwsrH5K
         Qx9R9hQEs1GHJKy2Sfxd8pd1Q/m98dnsLuc//6CfPeEUKqv3aLQEVdmz7NCNRmATePen
         vVT3Y4mHOmUxKRMM7EUQpUkLVdBqAgO30ASzZm7n++IpEL1JTo5pShYGggZoh0Q8tddl
         RC2g==
X-Gm-Message-State: AHQUAubPsH/jgV1hSzBF7SvhBvvOYPxOwoQ/TvSCBPG64HCVqDj2r1m+
        CjG/uiHSbaygD0J5UsfKgz0nHw==
X-Google-Smtp-Source: AHgI3Ib6DBrXDPPpD3sCwuG85NXRihp75MuHafe8g269KyUAVMeTvL29L8KmHsxK3MRI2ZOsr5VUCw==
X-Received: by 2002:a63:4e1a:: with SMTP id c26mr23842716pgb.175.1550583091426;
        Tue, 19 Feb 2019 05:31:31 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id 128sm24150238pfx.7.2019.02.19.05.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 05:31:30 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Krystian Garbaciak <krystian.garbaciak@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: da9063: Select maximum current in specific range for set_current_limit
Date:   Tue, 19 Feb 2019 21:31:01 +0800
Message-Id: <20190219133101.20892-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219133101.20892-1-axel.lin@ingics.com>
References: <20190219133101.20892-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting the minimal value is only true for voltage regulators.
For current regulators the maximum in the given range should be
selected instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/da9063-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 85c45577bad1..a83bbd3dbc37 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -167,7 +167,7 @@ static int da9063_set_current_limit(struct regulator_dev *rdev,
 	const struct da9063_regulator_info *rinfo = regl->info;
 	int n, tval;
 
-	for (n = 0; n < rinfo->n_current_limits; n++) {
+	for (n = rinfo->n_current_limits - 1; n >= 0; n--) {
 		tval = rinfo->current_limits[n];
 		if (tval >= min_uA && tval <= max_uA)
 			return regmap_field_write(regl->ilimit, n);
-- 
2.17.1

