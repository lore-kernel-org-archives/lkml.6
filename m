Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE91CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D79D21920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KkNDYPij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404692AbfBOMFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 07:05:02 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:60413 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732769AbfBOMFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 07:05:01 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190215120458epoutp02c1c4ebfb602d9ab423f3d9d8843a215f~DiA-8OB9_2859428594epoutp02C;
        Fri, 15 Feb 2019 12:04:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190215120458epoutp02c1c4ebfb602d9ab423f3d9d8843a215f~DiA-8OB9_2859428594epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550232299;
        bh=Uwaa1rjbJZ0Om2UnYtRndIlKJF2ZcCeQFOuh4ONLdeQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=KkNDYPijEjymdjR0ccjhVo9Fhe5uJ9Y7pww+6yo1AY+Fovm1zphgNAXqRWcW9xcLt
         yjoO7HzM09l9nnpUMqXAM/IaDQ3oobdDqGIe5E7uu+dqa3lXXk9JJSk946Y0LkytaF
         mZAGudMainv8jW9FluRkSCCkBPuA5sgyvHm9Bo5c=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190215120457epcas2p3a7e6a6e225ec02439642795053947fa0~DiA_koNN12648926489epcas2p3z;
        Fri, 15 Feb 2019 12:04:57 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.35.04136.9EAA66C5; Fri, 15 Feb 2019 21:04:57 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648~DiA_M0MlO2650226502epcas2p3m;
        Fri, 15 Feb 2019 12:04:57 +0000 (GMT)
X-AuditID: b6c32a46-2bfff70000001028-63-5c66aae99413
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 75.32.03689.8EAA66C5; Fri, 15 Feb
        2019 21:04:56 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMY00C45UVSQ530@mmp2.samsung.com>; Fri, 15 Feb 2019
        21:04:56 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: odroid: Add missing DAPM routes
Date:   Fri, 15 Feb 2019 13:04:22 +0100
Message-id: <20190215120422.22907-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCmme7LVWkxBst+yFpcuXiIyWLqwyds
        FufPb2C3+Halg8ni8q45bBZrj9xltzj8pp3V4uKKL0wOHB4bPjexeeycdZfdY9OqTjaPvi2r
        GD0+b5ILYI3isklJzcksSy3St0vgyuhbupO1YC5fxdODr5gaGA9ydzFyckgImEg0H3/F1MXI
        xSEksINR4v/XJawQzndGiV+XQDIQVe9OvYOq2sAoseroSWaQhJDAL0aJKwdNQWw2AUOJ3qN9
        jCC2iICYxO05ncwgDcwChxklDt5pYQdJCAvYS2yfd4QVxGYRUJV4eOgyUJyDg1fAWmLOa2uI
        ZfISqzccAOuVEPjJKjFr1RRWiISLxMOL21kgbGmJZ6s2MkLY1RK7tndDNXQwSrRc2M4MkbCW
        OHz8IlgzswCfRMfhv2DLJAR4JTrahCBKPCRafp9gh3gmVmLOmSamCYziCxgZVjGKpRYU56an
        FhsVGOkVJ+YWl+al6yXn525iBMeVltsOxiXnfA4xCnAwKvHwrshIjRFiTSwrrsw9xCjBwawk
        wiuxPC1GiDclsbIqtSg/vqg0J7X4EKM0B4uSOO9D6bnRQgLpiSWp2ampBalFMFkmDk6pBsaZ
        nF82m1+Xe36jryb01pLPl/ut4mYE/bpy7Ldd2arNx5I1b6QnBIkUs9gnCVWqMlToq94y2Hyv
        a/LcWVvFA1/XndnI93sX27p45rP1H1c+f/epl63zsqN729pJm9807zC++7f4MWvzFo54NcM5
        39lmiPnx3fi7dhKnTE7gWsZ60QkzXsUvXhWqxFKckWioxVxUnAgAd+ukdKcCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsVy+t9jQd0Xq9JiDKadtbG4cvEQk8XUh0/Y
        LM6f38Bu8e1KB5PF5V1z2CzWHrnLbnH4TTurxcUVX5gcODw2fG5i89g56y67x6ZVnWwefVtW
        MXp83iQXwBrFZZOSmpNZllqkb5fAldG3dCdrwVy+iqcHXzE1MB7k7mLk5JAQMJF4d+odUxcj
        F4eQwDpGibMrm1kgnF+MEn/2nGcHqWITMJToPdrHCGKLCIhJ3J7TyQxiMwscZpS4uCIIxBYW
        sJfYPu8IK4jNIqAq8fDQZaBeDg5eAWuJOa+tIZbJS6zecIB5AiPXAkaGVYySqQXFuem5xUYF
        Rnmp5XrFibnFpXnpesn5uZsYgeGx7bBW/w7Gx0viDzEKcDAq8fCuyEiNEWJNLCuuzD3EKMHB
        rCTCK7E8LUaINyWxsiq1KD++qDQntfgQozQHi5I4L3/+sUghgfTEktTs1NSC1CKYLBMHp1QD
        Y2p4JcOLzEVvGVoWnRFs/RrbunKHtTyX/IYWV97WH4pBP46dEfnscG7RP6ep27lOHtBUzO9J
        cQy2vK+g9X/p9a7kQ2wtEuaKrfzteslfN6nLr800YEi/qGl1SNC5oVNr25bpPnMzJN3qtP8v
        MMpSnr80RsLvW23AlzlvlzE5K+u+Ol0mM79ciaU4I9FQi7moOBEAbO6x1wsCAAA=
X-CMS-MailID: 20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648
CMS-TYPE: 102P
X-CMS-RootMailID: 20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648
References: <CGME20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With old DTS there will be missing DAPM routes linking BE with CODECs.
Add those routes in the card driver so sound works properly on Odroid
XU3/4 also without DTS updates enabling the secondary PCM.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
This patch might require my previous patch
"ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM"
to apply cleanly.
---
 sound/soc/samsung/odroid.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 941e8c3f67a4..5b2bcd1d3450 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -149,6 +149,12 @@ static const struct snd_soc_ops odroid_card_be_ops = {
 	.trigger = odroid_card_be_trigger,
 };
 
+/* DAPM routes for backward compatibility with old DTS */
+static const struct snd_soc_dapm_route odroid_dapm_routes[] = {
+	{ "I2S Playback", NULL, "Mixer DAI TX" },
+	{ "HiFi Playback", NULL, "Mixer DAI TX" },
+};
+
 static struct snd_soc_dai_link odroid_card_dais[] = {
 	{
 		/* Primary FE <-> BE link */
@@ -237,11 +243,15 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	/*
 	 * For backwards compatibility create the secondary CPU DAI link only
 	 * if there are 2 CPU DAI entries in the cpu sound-dai property in DT.
+	 * Also add required DAPM routes not available in old DTS.
 	 */
 	num_pcms = of_count_phandle_with_args(cpu, "sound-dai",
 					      "#sound-dai-cells");
-	if (num_pcms == 1)
+	if (num_pcms == 1) {
+		card->dapm_routes = odroid_dapm_routes;
+		card->num_dapm_routes = ARRAY_SIZE(odroid_dapm_routes);
 		card->num_links--;
+	}
 
 	for (i = 0; i < num_pcms; i++, link += 2) {
 		ret = of_parse_phandle_with_args(cpu, "sound-dai",
-- 
2.17.1

