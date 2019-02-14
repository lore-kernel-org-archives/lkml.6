Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C75C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFE8222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O9bM0ywd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437889AbfBNJiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:51 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43959 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437873AbfBNJio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:44 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214093842epoutp03ad8167977eaad08cc468479435ac5f01~DMYAVnsnc0713907139epoutp03D;
        Thu, 14 Feb 2019 09:38:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214093842epoutp03ad8167977eaad08cc468479435ac5f01~DMYAVnsnc0713907139epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137122;
        bh=J6H+Vy/rMx02aXMq9DQh06tQn/cC6LHTpLKn919N9e0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=O9bM0ywdvYQNtrbiE98bkqhRIj4kGY98E3HeTxy/J5/vCcDezHsJn6v3FLogx7hyr
         PkLH5iXWD5HdPvLqtNi7uU861c6YgUO6DGEbydSU/MiTDT+gWRZXzw6rJhR89vbvW7
         zGKFh6ojJ8R7I6VoXW+gK1Is+ZNxDhJXk9i9ZBVo=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190214093842epcas1p43261c10e6848cb87f7aa4c5e9f303de9~DMX-69sag0727007270epcas1p4L;
        Thu, 14 Feb 2019 09:38:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.14.04288.227356C5; Thu, 14 Feb 2019 18:38:42 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093842epcas1p154bd9c945a6897d5211c152aefabb32c~DMX-hwURB0747507475epcas1p1W;
        Thu, 14 Feb 2019 09:38:42 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-94-5c65372227e7
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 4B.F3.04015.127356C5; Thu, 14 Feb
        2019 18:38:42 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:41 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 07/13] ASoC: samsung: Specify DMA channel names
 through custom DMA config
Date:   Thu, 14 Feb 2019 10:37:41 +0100
Message-id: <20190214093747.2414-8-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCmga6SeWqMwZkJUhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8auY7NYClplKi4c7WBsYNwn3sXIySEhYCJxYN8/JhBbSGAHo8TV
        c+VdjFxA9ndGifUf2hhhihZP28gIkdjAKLF3xSMo5xejRP+JbSwgVWwChhK9R/vAOkQExCRu
        z+lkBiliFljJKLFl3yY2kISwQKrE344OsAYWAVWJF2dOgDXwClhJHJq+jBlinbzE6g0HwGxO
        AWuJmZu2Q53Rwybx4kI2hO0icX/dX6CZHEC2tMSlo7YQ4WqJXdu7wfZKCHQwSrRc2A4101ri
        8PGLrCA2swCfxLuvPawQvbwSHW1CECUeEg3HvrJBPNYH9P6JlWwTGCUWMDKsYhRLLSjOTU8t
        Niww0StOzC0uzUvXS87P3cQIjjItix2Me875HGIU4GBU4uGtEEqJEWJNLCuuzD3EKMHBrCTC
        e9EoNUaINyWxsiq1KD++qDQntfgQozQHi5I473oH5xghgfTEktTs1NSC1CKYLBMHp1QDo7vT
        jpcMy+4I3v/DnCDnqnxywaeNp6p046r0p8Y+Wq4lmLXVZEX304feRuHch3szjqhOV14e+Fss
        qdO44GLSlTexaY9qu0um7mPdtafTNvSKk/VMU738iY/lnr5uCNhzYGLe0Qpvjcizby0qtdQi
        JbOXCjZOuCe8cdPk35+9r22qdNxoWfxvlhJLcUaioRZzUXEiAIFyIUuuAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42I5/e+xoK6SeWqMwa5zjBZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8auY7NYClplKi4c7WBsYNwn3sXIySEhYCKxeNpGRhBbSGAdo8Sv
        w6pdjFxA9i9Gid8n5jGBJNgEDCV6j/aBFYkIiEncntPJDFLELLCSUeLI91VgCWGBVIm/HR0s
        IDaLgKrEizMnwOK8AlYSh6YvY4bYJi+xesMBMJtTwFpi5qbtQDUcQNusJNYdKp/AyLOAkWEV
        o2RqQXFuem6xUYFhXmq5XnFibnFpXrpecn7uJkZgEG07rNW3g/H+kvhDjAIcjEo8vAoCKTFC
        rIllxZW5hxglOJiVRHgvGqXGCPGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1
        tSC1CCbLxMEp1cCYp+lr0ZPixHksZs1K5ZT9r5bzaXRmqLAGT39x9ZWub8+t7skfpv6qDj1d
        9idawEdd79+97nQFa4XpyjKBc6+q/FVNms/68MaGdtblt5+bCc+9nbVOzDXV3WdHLsdu70d/
        BCKqqq78e1p2+VdDfNzP1+uPNIsfUObpt0hJ8Dj/+qWL+Po4ozlKLMUZiYZazEXFiQDW/ofJ
        HgIAAA==
X-CMS-MailID: 20190214093842epcas1p154bd9c945a6897d5211c152aefabb32c
CMS-TYPE: 101P
X-CMS-RootMailID: 20190214093842epcas1p154bd9c945a6897d5211c152aefabb32c
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093842epcas1p154bd9c945a6897d5211c152aefabb32c@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part of conversion of Samsung platforms to use the custom DMA
config for specifying DMA channel names, in addition to passing custom
DMA device for the secondary CPU DAI's "PCM" component for some variants
of the I2S controller.

We also don't set the SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME any more
as setting it wouldn't allow to specify DMA channels through the custom
DMA config.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/dmaengine.c   | 12 ++++--------
 sound/soc/samsung/i2s.c         |  2 +-
 sound/soc/samsung/s3c2412-i2s.c |  2 +-
 sound/soc/samsung/s3c24xx-i2s.c |  2 +-
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/samsung/dmaengine.c b/sound/soc/samsung/dmaengine.c
index 84601fa9aa46..302871974cb3 100644
--- a/sound/soc/samsung/dmaengine.c
+++ b/sound/soc/samsung/dmaengine.c
@@ -28,7 +28,6 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 				       const char *tx, const char *rx,
 				       struct device *dma_dev)
 {
-	unsigned int flags = SND_DMAENGINE_PCM_FLAG_COMPAT;
 	struct snd_dmaengine_pcm_config *pcm_conf;
 
 	pcm_conf = devm_kzalloc(dev, sizeof(*pcm_conf), GFP_KERNEL);
@@ -39,14 +38,11 @@ int samsung_asoc_dma_platform_register(struct device *dev, dma_filter_fn filter,
 	pcm_conf->compat_filter_fn = filter;
 	pcm_conf->dma_dev = dma_dev;
 
-	if (dev->of_node) {
-		pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
-		pcm_conf->chan_names[SNDRV_PCM_STREAM_CAPTURE] = rx;
-	} else {
-		flags |= SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME;
-	}
+	pcm_conf->chan_names[SNDRV_PCM_STREAM_PLAYBACK] = tx;
+	pcm_conf->chan_names[SNDRV_PCM_STREAM_CAPTURE] = rx;
 
-	return devm_snd_dmaengine_pcm_register(dev, pcm_conf, flags);
+	return devm_snd_dmaengine_pcm_register(dev, pcm_conf,
+				SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 EXPORT_SYMBOL_GPL(samsung_asoc_dma_platform_register);
 
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 692a752b194c..6ab99e38e6dd 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1460,7 +1460,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 		pri_dai->drv->playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
-						 NULL, NULL, NULL);
+						 "tx", "rx", NULL);
 	if (ret < 0)
 		goto err_disable_clk;
 
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 67dfa27ae321..c08638b0e458 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -177,7 +177,7 @@ static int s3c2412_iis_dev_probe(struct platform_device *pdev)
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev,
 						 pdata->dma_filter,
-						 NULL, NULL, NULL);
+						 "tx", "rx", NULL);
 	if (ret) {
 		pr_err("failed to register the DMA: %d\n", ret);
 		return ret;
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index ba0f2b94f8d4..a8026b640c95 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -446,7 +446,7 @@ static int s3c24xx_iis_dev_probe(struct platform_device *pdev)
 	s3c24xx_i2s_pcm_stereo_in.addr = res->start + S3C2410_IISFIFO;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL,
-						 NULL, NULL, NULL);
+						 "tx", "rx", NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register the DMA: %d\n", ret);
 		return ret;
-- 
2.17.1

