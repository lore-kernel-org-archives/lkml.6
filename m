Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E60C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF2A2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Zvc+a3rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF2A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeKESwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:52:03 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4941 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbeKESwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:52:02 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5be00e600000>; Mon, 05 Nov 2018 01:33:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 05 Nov 2018 01:33:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 05 Nov 2018 01:33:12 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 09:33:12 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Mon, 5 Nov 2018 09:33:12 +0000
Received: from niwei-ubuntu.nvidia.com (Not Verified[10.19.225.182]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5be00e560000>; Mon, 05 Nov 2018 01:33:12 -0800
From:   Wei Ni <wni@nvidia.com>
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <linux-kernel@vger.kernel.org>, Wei Ni <wni@nvidia.com>
Subject: [PATCH v1 4/4] thermal: tegra: fix coverity defect
Date:   Mon, 5 Nov 2018 17:32:34 +0800
Message-ID: <1541410354-19090-5-git-send-email-wni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541410354-19090-1-git-send-email-wni@nvidia.com>
References: <1541410354-19090-1-git-send-email-wni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541410401; bh=Q5lgwwI271wuGc9mM0mSl/fwyPck+Gs4fTtsLWe1/L4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Zvc+a3rMj0JGdW8jMbfYV9cuCTRbNaRsVXIZm8OmTVpdN/iKCkZ6uYQ3zamtqunJe
         SXpaARrVzKHfp25/b+5sW1hkqPd5O2poTIv7zijyDY24vEkTeEBZujpQNil6taUwBk
         TTl4kf2ex10OQtS82QErTzAQQFlgHdz6Q+RLunUQLxmm4SwNQxJsvtt4qw54SX74FB
         DBKEktTD/xQDQtHyDkp9lMYG99humDfilDvtBogGor2Q+e9cI6rY6ZWEX0KURneJ13
         yyGRfYcXPw9f5vgvCWDV1xbDDjDdyE64+dbreFUXVYEQzfpxpl9XsRNfRl2w8A0UhG
         qq3wNiBdpyeMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dereference dev before null check.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 3042837364e8..96527df91f2a 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -397,7 +397,7 @@ static int throttrip_program(struct device *dev,
 			     struct soctherm_throt_cfg *stc,
 			     int trip_temp)
 {
-	struct tegra_soctherm *ts = dev_get_drvdata(dev);
+	struct tegra_soctherm *ts;
 	int temp, cpu_throt, gpu_throt;
 	unsigned int throt;
 	u32 r, reg_off;
@@ -405,6 +405,8 @@ static int throttrip_program(struct device *dev,
 	if (!sg || !stc || !stc->init)
 		return -EINVAL;
 
+	ts = dev_get_drvdata(dev);
+
 	temp = enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grain;
 
 	/* Hardcode LIGHT on LEVEL1 and HEAVY on LEVEL2 */
-- 
2.7.4

