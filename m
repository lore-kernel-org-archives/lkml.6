Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E057D21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rav/VNHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBGRAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:00:53 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10761 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:00:52 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170049epoutp041ea4ce93b98be29dc12f6cec12cb3579~BI5BH5q5j0210902109epoutp04U;
        Thu,  7 Feb 2019 17:00:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170049epoutp041ea4ce93b98be29dc12f6cec12cb3579~BI5BH5q5j0210902109epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558849;
        bh=gGqXDjg8EoDzsbQ/KrZNphjC4zmgqj6Okx70I+0Rr0c=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=rav/VNHjpDjiy3ksAE90bHp/5c1Bn/uExlIh9tKI312TijqTKMq7IqIQhWruiXvBr
         EfZ2SAqllfNeVZXnViUfeo5i5nj6oskyBM5bYIuLFlnXz8J8R04IJfzQr4h8LOb46Z
         g0jnO1pAugHFZ2x9DlN35GtJanjeY1TCbJLR7Vis=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190207170049epcas1p1a6d596368a87d7c0da822ebeedf56f67~BI5A42McB1636416364epcas1p1K;
        Thu,  7 Feb 2019 17:00:49 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.C9.04173.0446C5C5; Fri,  8 Feb 2019 02:00:49 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170047epcas1p42d7ec4acfd976871c676efa5aecb33bc~BI4-y1_GT1456614566epcas1p4K;
        Thu,  7 Feb 2019 17:00:47 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-f2-5c5c6440d8d9
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.C8.04015.F346C5C5; Fri,  8 Feb 2019 02:00:47 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:00:47 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 01/22] ASoC: dmaengine: Improve of_node test in
 dmaengine_pcm_request_chan_of()
Date:   Thu, 07 Feb 2019 18:00:09 +0100
Message-id: <20190207170028.720-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmrq5jSkyMwbYmJosrFw8xWWycsZ7V
        YurDJ2wW589vYLf4dqWDyeLyrjlsFjPO72OyWHvkLrvF4TftrBYXV3xhcuDy2PC5ic1j56y7
        7B6bVnWyefRtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfG9mO3WAp2clTs2KLTwNjD3sXIySEh
        YCKx9chcxi5GLg4hgR2MEpMe34VyvjNKXHr/ghGm6u6dPUwQid2MEgeubWCHcH4xSmxvX8cC
        UsUmYCjRe7QPrENEQEzi9pxOZpAiZoEWJok5c5cygySEBRIluj7dAytiEVCV2HUW4hBeAUuJ
        d4ueQR0lL3G+dx2YzSlgJXFr/w4WiBpBiR+T74HZzEA1B688ZwFZICGwg01i8aWbULe6SLx8
        cwHI5gCypSUuHbWFCFdL7NrezQxR38Eo0XJhOzNEwlri8PGLrBBD+STefe1hhejllehoE4Io
        8ZBYse4TC8THvYwSO9ZNYZ3AKDULyU2zkNy0gJFpFaNYakFxbnpqsWGBkV5xYm5xaV66XnJ+
        7iZGcJRrme1gXHTO5xCjAAejEg+vhl5MjBBrYllxZe4hRgkOZiURXtkEoBBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHe9Q7OMUIC6YklqdmpqQWpRTBZJg5OqQZGvWfrPuZJfZ5j/+PI+gdtM4yT
        tQ6eDbK58NGD0SroUtDyiZ69dQnKR28JccVZM5SqGike3/citjb7ZOPmrqmPRRTeLVdx2Hsz
        MPZYpLzAb/8t+X3qP4+Xqzg8yz+k1sm1wvXxPwfVgvfvFk2fOevaStZdz6Uq7+0+8I3rm+H2
        dU9uaq3vz45hUmIpzkg01GIuKk4EAGMePsnuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAV37lJgYgx2f9SyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ24/dYinYyVGxY4tOA2MPexcjJ4eE
        gInE3Tt7mLoYuTiEBHYySqx4dZUNwvnFKDH1/1awKjYBQ4neo32MILaIgJjE7TmdzCBFzAJN
        TBK7bl8EKxIWSJTo+nQPrIhFQFVi11mIFbwClhLvFj2DWicvcb53HZjNKWAlcWv/DhYQWwio
        5sOEJlaIekGJH5PvgcWZgeoPXnnOMoGRbxaS1CwkqQWMTKsYJVMLinPTc4uNCgzzUsv1ihNz
        i0vz0vWS83M3MQKDeNthrb4djPeXxB9iFOBgVOLhvaAdEyPEmlhWXJl7iFGCg1lJhFc2ASjE
        m5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDo9CEBc2H7qWJ
        rbVbtvKD7aEIY4tnOawz59gldniEhz98K9D09tgJ/3uCtqWzt+7glZOyt1+1LpvZXzSacc+2
        +3UPA9zONdfOYji29n9dQ2PHhx3b/iedsXp4OrXksfsEl+QzOutWTAlyDWUO02T47XeG+ZT9
        12NNzi/Dar+/Pr1k8opKhV1TipVYijMSDbWYi4oTAacxVpxeAgAA
X-CMS-MailID: 20190207170047epcas1p42d7ec4acfd976871c676efa5aecb33bc
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170047epcas1p42d7ec4acfd976871c676efa5aecb33bc
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170047epcas1p42d7ec4acfd976871c676efa5aecb33bc@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when of_node of the "PCM" device is null
dmaengine_pcm_request_chan_of() function will bail out, including cases
when custom DMA device is intended to be used.  To have the channels
properly requested when custom DMA device is provided extend the of_node
test to also consider dma_dev->of_node.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 30e791a53352..6d7638c1233d 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -415,7 +415,8 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 
 	if ((pcm->flags & (SND_DMAENGINE_PCM_FLAG_NO_DT |
 			   SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME)) ||
-	    !dev->of_node)
+	     (!dev->of_node && !(config && config->dma_dev &&
+				config->dma_dev->of_node)))
 		return 0;
 
 	if (config && config->dma_dev) {
-- 
2.20.1

