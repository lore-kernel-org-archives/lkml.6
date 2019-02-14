Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E5F218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U3t7wRxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439428AbfBNPqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:46:14 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:23059 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbfBNPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:46:13 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214154608epoutp03c4517a423815f5c9f8fbf855caceede0~DRY0QG9ld0940009400epoutp03a;
        Thu, 14 Feb 2019 15:46:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214154608epoutp03c4517a423815f5c9f8fbf855caceede0~DRY0QG9ld0940009400epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550159168;
        bh=PVVfriQPAdoXB8pdklq7KPYZTUDaQ4ieNrobvdEOqcg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=U3t7wRxg9ljy2B60GXc6AdDm4/K78cbsco5r7QbKEfDJXywAQCuXLPloA39Pifz/F
         +1+HSrAzkom4lLjRtF3SfG2+aSNGxtr+nNmSdbBfTTz0k5GrhjMhEEb94cvrYiWLXM
         W5vh7zUq7FyhHe5gAI9vpqPYp2YxgJZI2m9pmo4E=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214154607epcas1p2422ecb0fb75834fe532cb464e087cc2d~DRYyveict1782617826epcas1p2L;
        Thu, 14 Feb 2019 15:46:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.00.04288.F3D856C5; Fri, 15 Feb 2019 00:46:07 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214154606epcas1p1dbff7d8d8ca175cbbce51aeb51f8e9aa~DRYySSH0p2725227252epcas1p1E;
        Thu, 14 Feb 2019 15:46:06 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-32-5c658d3f8ae5
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.B8.04015.E3D856C5; Fri, 15 Feb 2019 00:46:06 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMX00683AGLBK30@mmp1.samsung.com>; Fri, 15 Feb 2019
        00:46:06 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v4] ASoC: dmaengine: Remove unused
 SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
Date:   Thu, 14 Feb 2019 16:45:55 +0100
Message-id: <20190214154555.30107-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZdlhTT9e+NzXGYN9UfosrFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK2PS4hcsBffFK5pWN7E2MH4R7mLk5JAQMJH4+WMCexcjF4eQwA5G
        iT0drxghnO+MEi/Xv2OBqXr5th2qajejxPVFt9ggnF+MEo8vvmYFqWITMJToPdrHCGKLCIhJ
        3J7TyQxSxCywklFiy75NbCAJYYEUiftrQBo4OFgEVCX23IgDCfMKWEts+LefFWKbvMTqDQfA
        eiUEPrJKTN26kgki4SLx+tV9RpBeCQFpiUtHbSHC1RK7tndD1XcwSrRc2M4MkbCWOHz8IthQ
        ZgE+iXdfe1ghenklOtqEIEo8JD4+fcIOYgsJxEp8b21inMAovoCRYRWjWGpBcW56arFhgYle
        cWJucWleul5yfu4mRnA0aVnsYNxzzucQowAHoxIP74qM1Bgh1sSy4srcQ4wSHMxKIry5dUAh
        3pTEyqrUovz4otKc1OJDjNIcLErivOsdnGOEBNITS1KzU1MLUotgskwcnFINjIvbz+VzzBS8
        8PLEcU6mpVFL4yQ08+cLixawFW89f0N1t/6dKUbeeY/FBBmWJl2ftdI8dNkaRl2R4NPKswsD
        /uzdrbpb+eSbzBe9ZR+vVdp8jjlWuFnowt5Sq7i25Ll9hjoTq7/sUF9RraJY77j9Zdontp43
        X7UzZyQf3rtjWn2DJufWmZoy0UosxRmJhlrMRcWJAOCtDXuiAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCJMWRmVeSWpSXmKPExsVy+t9jAV273tQYg8Zv2hZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8akxS9YCu6LVzStbmJtYPwi3MXIySEhYCLx8m07excjF4eQwE5G
        iZY7G9ggnF+MEhteTWEFqWITMJToPdrHCGKLCIhJ3J7TyQxSxCywklHiyPdVYAlhgRSJ+2te
        AzVwcLAIqErsuREHEuYVsJbY8G8/K8Q2eYnVGw4wT2DkWsDIsIpRMrWgODc9t9iowDAvtVyv
        ODG3uDQvXS85P3cTIzAsth3W6tvBeH9J/CFGAQ5GJR7egLTUGCHWxLLiytxDjBIczEoivLl1
        QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8t/OORQoJpCeWpGanphakFsFkmTg4pRoY5wUekb0s
        8jHnl7vkFtaMn9vDlX7/bLAwWXS9ftXNve/Crqs/8qzmNOp443vs/LEjqd8Eo+uvcCayJ5p/
        Ft4Q8erT8ZpQCb6+bSkrl6od6jw4y8Ntc7lu4M7VC61UVQOWP1gX2fZ+zfkqQ5OjKvH7X0mt
        7j+y6OzjSf7dywNcy6et6JhnJLnGX4mlOCPRUIu5qDgRAMPrIP4HAgAA
X-CMS-MailID: 20190214154606epcas1p1dbff7d8d8ca175cbbce51aeb51f8e9aa
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214154606epcas1p1dbff7d8d8ca175cbbce51aeb51f8e9aa
References: <CGME20190214154606epcas1p1dbff7d8d8ca175cbbce51aeb51f8e9aa@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now no users of this flag so remove it together with
related code.  The chan_name field of snd_dmaengine_dai_dma_data
data structure is not removed as it is still in use by the PXA
platform.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changes since v3:
 - dropped removal of chan_name field.

 include/sound/dmaengine_pcm.h         |  4 ----
 sound/soc/soc-generic-dmaengine-pcm.c | 21 ++++-----------------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 2c4cfaa135a6..c679f6116580 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -99,10 +99,6 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
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

