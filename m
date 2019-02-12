Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD2C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEDB2229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T4iCwCBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfBLSFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:38 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40196 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731753AbfBLSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:35 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212180533epoutp01128dcf8e8af8577af71a92a39db7d84a~Cr-_J2i3G1898118981epoutp01s;
        Tue, 12 Feb 2019 18:05:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212180533epoutp01128dcf8e8af8577af71a92a39db7d84a~Cr-_J2i3G1898118981epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994733;
        bh=DCp4oOvDn8DBezFZRqPxhE/nL/MNMFGTgv5tjZCBKCE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=T4iCwCBrDnYthmSjWZermauXwJDfb2fXdtcWc4aXi5yRnHwUErrsC/ilct47Lwo1W
         Ea/0bmVhlH5lWJX3YGvzCtfOUiR0RKT4kKbywQEuoo5nTa1b2WRZTDMhLOKfMlpjQT
         3ntoIWYbgk8wM+midIUNn/OGDYqO5ZHaETZwBJAM=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190212180533epcas1p499418d6c8da90a6bff9b6b2d5c489fb7~Cr-9jKEdI0414104141epcas1p4S;
        Tue, 12 Feb 2019 18:05:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.8E.04206.DEA036C5; Wed, 13 Feb 2019 03:05:33 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180532epcas1p1d0c276b25c26205a6493cbabfccd74ef~Cr-8dKT_b0083100831epcas1p1Y;
        Tue, 12 Feb 2019 18:05:32 +0000 (GMT)
X-AuditID: b6c32a39-d65ff7000000106e-31-5c630aeda1cb
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 95.11.04015.BEA036C5; Wed, 13 Feb
        2019 03:05:31 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:31 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 15/21] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date:   Tue, 12 Feb 2019 19:03:36 +0100
Message-id: <20190212180342.32040-16-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCmvu5bruQYg9v/OCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZLcvusRc8k66YP+UVewPjVPEuRg4O
        CQETiV2PiroYuTiEBHYwSlxrusYE4XxnlNjd+Iy5i5ETrGhbdyc7RGIDo8SuxfOZIZxfjBIN
        azezg1SxCRhK9B7tYwSxRQTEJG7P6QQrYhZoYZKYM3cp2ChhgSyJlsXnmEF2swioSrxeaAsS
        5hWwkfj3r5sNYpu8xPnedWAzOYHizxZ+Y4GoEZT4MfkemM0MVHPwynMWkPkSAgfYJJY872KH
        +MdF4vQmRwhTWuLSUVuIkdUSu7Z3M0OUdzBKtFzYDvWZtcTh4xdZIWbySbz72sMK0csr0dEm
        BFHiIdG5ehsbxL/9jBLTdm1insAoNQvJSbOQnLSAkWkVo1hqQXFuemqxYYGpXnFibnFpXrpe
        cn7uJkZwhGtZ7mA8ds7nEKMAB6MSD++Ko0kxQqyJZcWVuYcYJTiYlUR405iTY4R4UxIrq1KL
        8uOLSnNSiw8xSnOwKInzrndwjhESSE8sSc1OTS1ILYLJMnFwSjUwiuhdvnqsK/Xk+RMLfu6t
        lL3ByhWt+1yHne+k0jnvLJM3EUvi2idwRdjZSOs3v1RlXVywXrjJj2d2c72/3+PzNzyNFOep
        5LCt6lp29uy+tza6UQ8OzbIxUd8X250k1DVnb71fWvLOr1Kqh1qvBd3Y5ptZUhguFvP1wcuM
        5rjlTj+rbpwNavquxFKckWioxVxUnAgAvpCeeewCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd3XXMkxBrceWVpcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyWpbdYy94Jl0xf8or9gbGqeJdjJwc
        EgImEtu6O9m7GLk4hATWMUqcf3AJyvnFKHHm5V9WkCo2AUOJ3qN9jCC2iICYxO05ncwgRcwC
        TUwSu25fZAdJCAtkSbQsPgeU4OBgEVCVeL3QFiTMK2Aj8e9fNxvENnmJ873rwMo5geLPFn5j
        ASkXErCWuLIJqlxQ4sfkeywgNjNQ+cErz1kmMPLNQpKahSS1gJFpFaNkakFxbnpusVGBYV5q
        uV5xYm5xaV66XnJ+7iZGYAhvO6zVt4Px/pL4Q4wCHIxKPLwrjibFCLEmlhVX5h5ilOBgVhLh
        TWNOjhHiTUmsrEotyo8vKs1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qB0Z//
        5mtJn0v3+xmvqXE7eJXr/fhsuC3R4dexT8YaF+pm8xkcjY9L3LE+7GvGcwFOi8lJnfJvpU6o
        TFl4adtiEa8s/9mvm5k//F5z4LX+A5Gd+8V40loUlzh4+Le6KMw+rHYuPrnXVzPD68SFUMZb
        d//HNbHZn3/9dNcBqaSAWWptX/5lM39/ocRSnJFoqMVcVJwIAFZ9zp9dAgAA
X-CMS-MailID: 20190212180532epcas1p1d0c276b25c26205a6493cbabfccd74ef
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180532epcas1p1d0c276b25c26205a6493cbabfccd74ef
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180532epcas1p1d0c276b25c26205a6493cbabfccd74ef@epcas1p1.samsung.com>
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
2.20.1

