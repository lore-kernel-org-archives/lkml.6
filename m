Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5421C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93484222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f+qpv7oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405898AbfBMSnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:43:31 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30931 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405886AbfBMSn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:43:29 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213184327epoutp02ad4e79567203418c79b92fbb830f53bf~DAKVzyzMo0221402214epoutp02C;
        Wed, 13 Feb 2019 18:43:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213184327epoutp02ad4e79567203418c79b92fbb830f53bf~DAKVzyzMo0221402214epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083407;
        bh=hE+X8z3qdk71D0LxrGPVgTUUa5zoHoXIy316WRLsK/k=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=f+qpv7ojGD9y1CFmBb2lDlSYWLzdxNF0ArwBMwUCMO8L7GFpzWguoaFzHSpwD2ejO
         j8oqtxoMHOGkTqUo0Pw/Djy82jvO5CkF5OfGh9rYJDBd7UeHCsUbM5tfSK+1o7yZ7t
         xwkIuqYcBdCIMY6KrI4wxsNEY1I9r5cL6hilbdbY=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190213184326epcas1p21f62fb468c2b495a376e68ba00a526f5~DAKUojtNE2581225812epcas1p2E;
        Wed, 13 Feb 2019 18:43:26 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.20.04074.D45646C5; Thu, 14 Feb 2019 03:43:25 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190213184324epcas1p4d5d9d8896938f7a5230372381627340e~DAKTZY9ID0477004770epcas1p4E;
        Wed, 13 Feb 2019 18:43:24 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-09-5c64654dc30b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 88.CE.04015.C45646C5; Thu, 14 Feb
        2019 03:43:24 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:43:24 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 09/13] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date:   Wed, 13 Feb 2019 19:42:08 +0100
Message-id: <20190213184212.5473-10-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCmnq5vakqMwdtX5hZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M1d/+MRU8k664+3ILWwPjVPEuRk4O
        CQETiWOnXrB3MXJxCAnsYJS4cXsGlPOdUWLx5xfMMFVXTy5ghEhsYJTY9G0ylPOLUeLJ0zdM
        IFVsAoYSvUf7GEFsEQExidtzOplBipgFWpgk5sxdCjZKWCBLYuHUA6wgNouAqsTOBfdZQGxe
        AWuJjqf/WSHWyUus3nAArJ4TKP5v7XN2iPgSNon3i7QgbBeJl+/uAC3mALKlJS4dtYUIV0vs
        2t4NtldCoINRouXCdqgXrCUOH78INp9ZgE/i3dceVoheXomONiGIEg+JS0u/ga0SEuhjlPi+
        MHYCo8QCRoZVjGKpBcW56anFhgWGesWJucWleel6yfm5mxjBMahluoNxyjmfQ4wCHIxKPLwV
        QikxQqyJZcWVuYcYJTiYlUR49aKAQrwpiZVVqUX58UWlOanFhxilOViUxHnXOzjHCAmkJ5ak
        ZqemFqQWwWSZODilGhhVb+RkJneE9fhIXVZNEEvtlxPuUnnetOCzko+vXIbPPTH2BDY1F559
        WvsktE249i265Ofe0/r+ZDzjtM9GO1lXZ1Rwrp3fd8jz8m69fgYP1/drQlTkLBZME9KSmBPn
        HVb9bpvKqUCZLzOWXn7b9Tsy0njN89sVp6PuqeWbnIx8vErLsKZnixJLcUaioRZzUXEiAIaV
        ja69AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQV2f1JQYg+lftSyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZq7/9Yyp4Jl1x9+UWtgbGqeJdjJwc
        EgImEldPLmDsYuTiEBJYxyixeOdKZpCEkMAvRonGJaIgNpuAoUTv0T5GEFtEQEzi9pxOZpAG
        ZoEmJoldty+ygySEBbIkFk49wApiswioSuxccJ8FxOYVsJboePqfFWKbvMTqDQfAFnACxf+t
        fc4OscxKYuKHS8wTGHkWMDKsYpRMLSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIDLJth7X6
        djDeXxJ/iFGAg1GJh1dBICVGiDWxrLgy9xCjBAezkgivXhRQiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkaH6ZKXK523+TDeXfEl/vrzMBEfHv7u8L+G
        sXv0n17eX7H/E4/g0b/CbrsY69fs/n+2untVLttKVb4l98+WdUe+6e2uy1n/TEh3+V3lpqgJ
        R17azy1cG6j2jXn6wc1RBwoex+bv0DBbd9U8QWDy6tJg5yiWnIJOb67Ew6tVyuw/q6xefC3h
        XZ8SS3FGoqEWc1FxIgCkJtIMLgIAAA==
X-CMS-MailID: 20190213184324epcas1p4d5d9d8896938f7a5230372381627340e
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184324epcas1p4d5d9d8896938f7a5230372381627340e
References: <20190213184212.5473-1-s.nawrocki@samsung.com>
        <CGME20190213184324epcas1p4d5d9d8896938f7a5230372381627340e@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now no users of this flag so remove it together with related
data structure field.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/sound/dmaengine_pcm.h         |  6 ------
 sound/soc/soc-generic-dmaengine-pcm.c | 21 ++++-----------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 2c4cfaa135a6..764c787928a4 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -63,7 +63,6 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
  * @slave_id: Slave requester id for the DMA channel.
  * @filter_data: Custom DMA channel filter data, this will usually be used when
  * requesting the DMA channel.
- * @chan_name: Custom channel name to use when requesting DMA channel.
  * @fifo_size: FIFO size of the DAI controller in bytes
  * @flags: PCM_DAI flags, only SND_DMAENGINE_PCM_DAI_FLAG_PACK for now
  */
@@ -73,7 +72,6 @@ struct snd_dmaengine_dai_dma_data {
 	u32 maxburst;
 	unsigned int slave_id;
 	void *filter_data;
-	const char *chan_name;
 	unsigned int fifo_size;
 	unsigned int flags;
 };
@@ -99,10 +97,6 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  * playback.
  */
 #define SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX BIT(3)
-/*
- * The PCM streams have custom channel names specified.
- */
-#define SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME BIT(4)
 
 /**
  * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 1b44e363c50c..f1ab6285a085 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -265,7 +265,6 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct dmaengine_pcm *pcm = soc_component_to_pcm(component);
 	const struct snd_dmaengine_pcm_config *config = pcm->config;
 	struct device *dev = component->dev;
-	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct snd_pcm_substream *substream;
 	size_t prealloc_buffer_size;
 	size_t max_buffer_size;
@@ -285,19 +284,9 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (!substream)
 			continue;
 
-		dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
-
-		if (!pcm->chan[i] &&
-		    ((pcm->flags & SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME) ||
-		     (config && config->chan_names[i]))) {
-			const char *chan_name = dma_data->chan_name;
-
-			if (config && config->chan_names[i])
-				chan_name = config->chan_names[i];
-
+		if (!pcm->chan[i] && config && config->chan_names[i])
 			pcm->chan[i] = dma_request_slave_channel(dev,
-				chan_name);
-		}
+				config->chan_names[i]);
 
 		if (!pcm->chan[i] && (pcm->flags & SND_DMAENGINE_PCM_FLAG_COMPAT)) {
 			pcm->chan[i] = dmaengine_pcm_compat_request_channel(rtd,
@@ -420,10 +409,8 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 	const char *name;
 	struct dma_chan *chan;
 
-	if ((pcm->flags & (SND_DMAENGINE_PCM_FLAG_NO_DT |
-			   SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME)) ||
-	     (!dev->of_node && !(config && config->dma_dev &&
-				config->dma_dev->of_node)))
+	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_DT) || (!dev->of_node &&
+	    !(config && config->dma_dev && config->dma_dev->of_node)))
 		return 0;
 
 	if (config && config->dma_dev) {
-- 
2.17.1

