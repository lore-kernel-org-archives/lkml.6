Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3BFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D9E21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FOP6xLF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfBGRCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:02:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:10925 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfBGRB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:01:58 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190207170156epoutp0414a065d9435af0416cfd5b70fc1d2c68~BI5-imwo32868228682epoutp04Y;
        Thu,  7 Feb 2019 17:01:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190207170156epoutp0414a065d9435af0416cfd5b70fc1d2c68~BI5-imwo32868228682epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558916;
        bh=d1QdZW54N39Z367Kilg9uJNunzzoarzixDx+XjVp7dU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=FOP6xLF+eEY19tT6ZdJwwQWdXkNKp8ZULPzATG2glxtxRs7x5GnxXbgiDjOPZQZR7
         1kTc0wiySqZR0UbOUBzXfKuLVaP1JNFzcms7eAAKd2GbOFRcQFHD7G43+4CtRjbPeu
         EA0A7cYG3tYAUvRM0zA0GSckedYAdPGKIFlNcK7Q=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170156epcas1p330f0f7cb567f9fc9ae14d7599b3b6b84~BI5-USzIl2640626406epcas1p3C;
        Thu,  7 Feb 2019 17:01:56 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.B3.04074.4846C5C5; Fri,  8 Feb 2019 02:01:56 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170155epcas1p42ba30c540d35290c010b5bfa4645e3b1~BI5-FNFPH1738517385epcas1p4V;
        Thu,  7 Feb 2019 17:01:55 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-93-5c5c6484d60f
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.D8.04015.3846C5C5; Fri,  8 Feb 2019 02:01:55 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:01:55 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 20/22] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date:   Thu, 07 Feb 2019 18:00:28 +0100
Message-id: <20190207170028.720-21-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170028.720-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmnm5LSkyMweSjLBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MGdPesRVsla74/LSVpYHxpVgXIyeH
        hICJRMOdM6xdjFwcQgI7GCUmvf7GBOF8Z5To2nGeBaaqp+c3O0RiN6PEvfP72SCcX4wSP09M
        YQepYhMwlOg92scIYosIiEncntPJDFLELNDCJDFn7lJmkISwQLrE9u5HYDaLgKrEup7ZQA0c
        HLwCVhJ35iVDbJOXON+7DmwmJ1D41v4dYFfwCghK/Jh8D8xmBqo5eOU5C8h8CYEjbBIP5p5i
        hWh2kTj6bx0byEwJAWmJS0dtIcLVEru2dzND1HcwSrRc2M4MkbCWOHz8IivEUD6Jd197WCF6
        eSU62oQgSjwkLm74zAzxcC+jxMd1PxgnMErNQnLTLCQ3LWBkWsUollpQnJueWmxYYKhXnJhb
        XJqXrpecn7uJERzlWqY7GKec8znEKMDBqMTDq6EXEyPEmlhWXJl7iFGCg1lJhFc2ASjEm5JY
        WZValB9fVJqTWnyIUZqDRUmcd72Dc4yQQHpiSWp2ampBahFMlomDU6qBUTHTn01ZJrDAPmaG
        45n7Vn8fnV/eXTnl5mmzV8u/z/lTtPN7rOubmZtnzGL+vcTR90vwhosLzPyuqJUmuSkeeVnu
        7fWSYau7RdaUN8UGj5ZIVL+8Pke5fO2nG0cDC67E8zKc/LnmhNmeV1/DDl7kitJSuu14t6yy
        zSWLr3Gyh3ry/WUKs9OWb1ViKc5INNRiLipOBABjE1nA7gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd3mlJgYg5f7TC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZM6a9YyvYKl3x+WkrSwPjS7EuRk4O
        CQETiZ6e3+xdjFwcQgI7GSW6Ti5ggnB+MUo0bn7NDFLFJmAo0Xu0jxHEFhEQk7g9p5MZpIhZ
        oIlJYtfti+wgCWGBdInt3Y/AGlgEVCXW9cwGauDg4BWwkrgzLxlim7zE+d51YOWcQOFb+3ew
        gNhCApYSHyY0sYLYvAKCEj8m3wOLMwPVH7zynGUCI98sJKlZSFILGJlWMUqmFhTnpucWGxUY
        5qWW6xUn5haX5qXrJefnbmIEBvG2w1p9OxjvL4k/xCjAwajEw3tBOyZGiDWxrLgy9xCjBAez
        kgivbAJQiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsaU
        gM9JpfElKrafzyy7L6Zwq8naz+xf5oa7j2pLJ/sn35/n/E9ZxUToVMnzTV+sF8gnHnX9smt9
        b3RHiUmq+Utvzsxph/nPphfn8dlY7Y+dGVf1aqFQYeiz9nnruhS2z7/OrW1ckxDvv+LZE/vN
        nFd71G+K1vZO6vX7xvbxslrNIblLXq/n/FZiKc5INNRiLipOBABNTmiEXgIAAA==
X-CMS-MailID: 20190207170155epcas1p42ba30c540d35290c010b5bfa4645e3b1
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170155epcas1p42ba30c540d35290c010b5bfa4645e3b1
References: <20190207170028.720-1-s.nawrocki@samsung.com>
        <CGME20190207170155epcas1p42ba30c540d35290c010b5bfa4645e3b1@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now no users of this flag so remove it together with related
data structure field.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
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

