Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A903FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FB82229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oZwu9T5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406085AbfBNJjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:39:17 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:44095 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392553AbfBNJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:51 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214093848epoutp034c0096651d08647ccd0e506fb3d8218b~DMYFuY34a0834508345epoutp03d;
        Thu, 14 Feb 2019 09:38:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214093848epoutp034c0096651d08647ccd0e506fb3d8218b~DMYFuY34a0834508345epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137128;
        bh=hE+X8z3qdk71D0LxrGPVgTUUa5zoHoXIy316WRLsK/k=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=oZwu9T5T57sD4TX73K2nFv6Lm4NmGOsq9kgODMqsPJ3ZKEsgz1b3ztLiYXuSulZfK
         4A4eeBhzvnJ/gaKpNzNpnGzhiVuVVgU6DYCjOpB2j87dCr8PMobk+jW6Rd5xyMjs2X
         upxAip6zLRK8jEk1sRydUO7tUcj4Knzkwh/XE53c=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093848epcas2p2b4bd3c35348e9745f9fdeb6c44bec4d3~DMYFTBufe1576715767epcas2p2t;
        Thu, 14 Feb 2019 09:38:48 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.2D.04134.827356C5; Thu, 14 Feb 2019 18:38:48 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4~DMYE-X7ew2279822798epcas2p1x;
        Thu, 14 Feb 2019 09:38:47 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-81-5c65372801a4
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id BD.52.03689.727356C5; Thu, 14 Feb
        2019 18:38:47 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:47 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 09/13] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date:   Thu, 14 Feb 2019 10:37:43 +0100
Message-id: <20190214093747.2414-10-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCmma6GeWqMweZ1nBZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8bqb/+YCp5JV9x9uYWtgXGqeBcjJ4eEgInEmTVHGbsYuTiEBHYw
        SlxZtYsFwvnOKPF9xSZWmKrHS59CVW1glLi7+xAzhPOLUaLj2XU2kCo2AUOJ3qN9jCC2iICY
        xO05nWBFzAIrGSW27NsEViQsUCix4mAPE4jNIqAqsf/qGzCbV8Ba4vn/Q2wQ6+QlVm84wAxi
        cwLFZ27aDrZaQqCHTWLF+j9QN7lI7Pg9mwXClpZ4tmojI4RdLbFrezczREMHo0TLhe3MEAlr
        icPHL4I1MwvwSXQc/svexcgBFOeV6GgTgjA9JGb0uUF81sco8fvXZbYJjBILGBlWMYqlFhTn
        pqcWGxUY6xUn5haX5qXrJefnbmIER5qW+w7Gbed8DjEKcDAq8fBWCKXECLEmlhVX5h5ilOBg
        VhLhvWiUGiPEm5JYWZValB9fVJqTWnyIUZqDRUmc96H03GghgfTEktTs1NSC1CKYLBMHp1QD
        o5PsEVfNL7IXfyo3famcqZRa18E037RB/O+RC/vP+YUa5zySE9j9mTWgzLr2397Eh7F713w0
        FxIp/iw2d3XTDleplgnzFsq8b/o32c9N03W5H0PTgautzY2M9zObVn2+sPvjUnfF58oZP/yq
        5gmEb2/cnTX/1ln9+F0Tq3Ye3RzB77Nl+i+bG0osxRmJhlrMRcWJABUG/TSwAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xoK66eWqMwYVGA4srFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK2P1t39MBc+kK+6+3MLWwDhVvIuRk0NCwETi8dKnjF2MXBxCAusY
        JeZ1H2GBcH4xSsw83MMKUsUmYCjRe7SPEcQWERCTuD2nkxmkiFlgJaPEke+rwBLCAoUSKw72
        MIHYLAKqEvuvvgGzeQWsJZ7/P8QGsU5eYvWGA8wgNidQfOam7UC9HEDbrCTWHSqfwMizgJFh
        FaNkakFxbnpusVGBUV5quV5xYm5xaV66XnJ+7iZGYBhtO6zVv4Px8ZL4Q4wCHIxKPLwVQikx
        QqyJZcWVuYcYJTiYlUR4LxqlxgjxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5Ykpqd
        mlqQWgSTZeLglGpgnFvRVLCR9f3s2JTI+7ZKClzr7/3eNCWI07nlMfOJa9M8vx/YwLxy/ZN3
        zG0RLzWL4h8lJj9+w/D187zdMwTn/O/majkcrLOEmeHfv6Tq86+MK4OfyN1WNjRsrJt1Zp5n
        h2hf5CGGRNupvA6ndI16H+7QieW8OKH7TO+F37mtsz4wrN9ixqlwWImlOCPRUIu5qDgRAP7R
        jesfAgAA
X-CMS-MailID: 20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093847epcas2p1056c7371ba485f375a9d408ea45078e4@epcas2p1.samsung.com>
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

