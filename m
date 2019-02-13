Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12708C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9ED20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FxMI4+H7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392195AbfBMSv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:51:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30941 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405841AbfBMSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:34 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213184332epoutp02dc682acb2c1781825d18d832e4db1aff~DAKanzKIL0217602176epoutp02W;
        Wed, 13 Feb 2019 18:43:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213184332epoutp02dc682acb2c1781825d18d832e4db1aff~DAKanzKIL0217602176epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083412;
        bh=IfSSyIr9CaOn8GHvv9qjZ4tl/nS8IqPtKE/s5FiFoO8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=FxMI4+H7jAmcf9RYUzs+jl6pZ0Q14DZ97g6aoQdvKWLMwgWq8Hr1EGbHCSeFu1gk7
         3CTpXxY035F+GKDxAmGH8jUtOneP+WQt5/34reYOgmpXaT5Nfu0apPv6rrx8WmRuIi
         xUM5i2UJTz8IKwRFq0ZZrDHaUNL86vPdXbNQDhgo=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190213184332epcas1p3701958fe44241947184a2ad26bf0dc41~DAKaOTDAO0824508245epcas1p3W;
        Wed, 13 Feb 2019 18:43:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.B1.04173.355646C5; Thu, 14 Feb 2019 03:43:32 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213184331epcas1p1651b43c8fe68d537a4f39ddfa91a38b1~DAKaAjF7q0131801318epcas1p1T;
        Wed, 13 Feb 2019 18:43:31 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-48-5c64655332d8
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 59.CE.04015.355646C5; Thu, 14 Feb
        2019 03:43:31 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:31 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 11/13] ASoC: samsung: i2s: Change indentation in
 SAMSUNG_I2S_FMTS definition
Date:   Wed, 13 Feb 2019 19:42:10 +0100
Message-id: <20190213184212.5473-12-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCmvm5IakqMwadIiysXDzFZbJyxntVi
        6sMnbBbnz29gt/h2pYPJ4vKuOWwWM87vY7JYe+Quu8XhN+2sFhdXfGFy4PLY8LmJzWPnrLvs
        HptWdbJ59G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV0bPlZ1sBTvZKyavWsHUwLiUrYuRk0NC
        wERiy7MtrF2MXBxCAjsYJb4tu8QC4XxnlHj5cjkLTFXL7ulsEIkNjBKXZreAJYQEfjFKnP4c
        BGKzCRhK9B7tYwSxRQTEJG7P6WQGaWAWaGGSmDN3KTNIQlggUWJr004mEJtFQFWi+8oTdhCb
        V8BaYuWaRnaIbfISqzccAKvnBIr/W/ucHWSQhMACNon1zXOAmjmAHBeJP+8jIUxpiUtHbSFa
        qyV2be9mhijvYJRoubCdGSJhLXH4+EVWEJtZgE/i3dceVoheXomONiGIEg+JBz+6GSGe7GOU
        2PZsGesERokFjAyrGMVSC4pz01OLDQuM9IoTc4tL89L1kvNzNzGCI1DLbAfjonM+hxgFOBiV
        eHgrhFJihFgTy4orcw8xSnAwK4nw6kUBhXhTEiurUovy44tKc1KLDzFKc7AoifOud3COERJI
        TyxJzU5NLUgtgskycXBKNTB2ewe87l9wf/mOJZOLc/59D3O1bp0/Ycq1jw/zI1mUH3JY7ZUI
        7Jl7akLLrWmhf38Grln7SD1ySV7wVo6/HHFLpGp/zD6edU0/po9p5vvlaYee7bMvmPfzWkKO
        pnbm1evhRTc63/nezJlW8y3y8+Fb55u3zfkwa8U1t8kr6v4zX3x9wnKJysTkECWW4oxEQy3m
        ouJEAOsL+um8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsVy+t9jQd3g1JQYg2MfdC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZPVd2shXsZK+YvGoFUwPjUrYuRk4O
        CQETiZbd04FsLg4hgXWMEv3/djFBOL8YJf5sPcUKUsUmYCjRe7SPEcQWERCTuD2nkxmkiFmg
        iUli1+2L7CAJYYFEia1NO5lAbBYBVYnuK0/A4rwC1hIr1zSyQ6yTl1i94QAziM0JFP+39jlY
        XEjASmLih0vMExh5FjAyrGKUTC0ozk3PLTYqMMxLLdcrTswtLs1L10vOz93ECAyzbYe1+nYw
        3l8Sf4hRgINRiYdXQSAlRog1say4MvcQowQHs5IIr14UUIg3JbGyKrUoP76oNCe1+BCjNAeL
        kjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQbGzpmVh/Zoy/H98I/I1lvLlnOGXzm1umqxS6zn
        b+bkxL+/mXtK+f0CJ55zjfO0fvM7KkVgp6QL212F5KjTPb4v4z/NvRUs6O8tFLz79m62aKGf
        bdxfQlZUtzafWj2xn/2QVvrU0BaeKNaL08Jnr9jWtN1X5hPDzvVWXyMczdnK57ELcn9Pr1Zi
        Kc5INNRiLipOBACw08ycLwIAAA==
X-CMS-MailID: 20190213184331epcas1p1651b43c8fe68d537a4f39ddfa91a38b1
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184331epcas1p1651b43c8fe68d537a4f39ddfa91a38b1
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184331epcas1p1651b43c8fe68d537a4f39ddfa91a38b1@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change indentation so this macro definition spans 2 rows, it looks
more consistent with surrounding code.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 4f15b6af8268..e0c151843f9e 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1150,9 +1150,8 @@ static const struct snd_soc_component_driver samsung_i2s_component = {
 	.num_dapm_routes = ARRAY_SIZE(samsung_i2s_dapm_routes),
 };
 
-#define SAMSUNG_I2S_FMTS	(SNDRV_PCM_FMTBIT_S8 | \
-					SNDRV_PCM_FMTBIT_S16_LE | \
-					SNDRV_PCM_FMTBIT_S24_LE)
+#define SAMSUNG_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+			  SNDRV_PCM_FMTBIT_S24_LE)
 
 static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 			  const struct samsung_i2s_dai_data *i2s_dai_data,
-- 
2.17.1

