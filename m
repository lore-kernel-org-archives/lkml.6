Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01615C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF055222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MaUDkOPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406192AbfBNJjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:39:31 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:23877 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437865AbfBNJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:43 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190214093840epoutp01ea49c853f1413b6a1870fd3f38eb7835~DMX97gNsi0518605186epoutp01U;
        Thu, 14 Feb 2019 09:38:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190214093840epoutp01ea49c853f1413b6a1870fd3f38eb7835~DMX97gNsi0518605186epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137120;
        bh=Lloc17coHXXtqiANsKzhHW0cVZNS2ka3G/t6w/A7ymg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=MaUDkOPzek9QZKTbZYUv/FU9UQG+AqKJoElaJXHSihYFmihI6odKFg1Gr6OYxaBMP
         p9CiMQrSdO6453ID2g609lOEbYzAwXlfu8/qvJZj7HtkQFbTONpc3mpIOTMsNb6jyu
         LQy3VR7h4qKufSuxP2XBvyfuFV0anaXYuSWHMKMc=
Received: from epsmges2p2.samsung.com (unknown [182.195.42.70]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190214093839epcas2p3259fa750e79cd06603c27a7e712628cf~DMX9lNQm32485224852epcas2p37;
        Thu, 14 Feb 2019 09:38:39 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.F0.04136.F17356C5; Thu, 14 Feb 2019 18:38:39 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190214093839epcas2p2609ddf53eb48143ff2160d6a30dad615~DMX9BqGP81576215762epcas2p2p;
        Thu, 14 Feb 2019 09:38:39 +0000 (GMT)
X-AuditID: b6c32a46-2a7ff70000001028-1a-5c65371f49f2
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 9C.52.03689.F17356C5; Thu, 14 Feb
        2019 18:38:39 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:39 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 06/13] ASoC: samsung: odroid: Add support for
 secondary CPU DAI
Date:   Thu, 14 Feb 2019 10:37:40 +0100
Message-id: <20190214093747.2414-7-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCmqa68eWqMwdETZhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8a0ycIF38wqFs87xdbA2K3bxcjJISFgIrG1awdbFyMXh5DADkaJ
        fYufMEI43xklNv2/wwhTtfz0TyaIxAZGiT3XTzFDOL8YJQ7f38kMUsUmYCjRe7QPrENEQEzi
        9pxOsCJmgZWMElv2bWIDSQgLREvMObyFBcRmEVCVOP3xGVgDr4CVxJQ3j1kh1slLrN5wAGwo
        p4C1xMxN28FukhDoYZPo/7yeCaLIReLQzjPsELa0xLNVG6FurZbYtb2bGaKhg1Gi5cJ2ZoiE
        tcTh4xfBNjAL8El0HP4L1MwBFOeV6GgTgjA9JJqnG0B81sco8edHD9MERokFjAyrGMVSC4pz
        01OLjQqM9IoTc4tL89L1kvNzNzGC40zLbQfjknM+hxgFOBiVeHgrhFJihFgTy4orcw8xSnAw
        K4nwXjRKjRHiTUmsrEotyo8vKs1JLT7EKM3BoiTO+1B6brSQQHpiSWp2ampBahFMlomDU6qB
        0f788eeeQnPbFpamPL9zavbv1ytOXrBIm10zZ6mA2j7VeOMvTaY6R+barPl7683TXenFnb/d
        HB6K2BhyRJg0ZDDHMMqybf5qtPzrH1nnbYG763yecr6OyWyRLmPw4z/tcGN1iZIvJ1NfsLHt
        k6JQSdeDHQdY9wayX7aYw9bPcWZFXhz7InULJZbijERDLeai4kQAf58w7a8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmluLIzCtJLcpLzFFi42I5/e+xoK68eWqMwZpJQhZXLh5ispj68Amb
        xfnzG9gtvl3pYLK4vGsOm8XhN+2sFhdXfGFyYPfY8LmJzWPnrLvsHptWdbJ59G1ZxejxeZNc
        AGsUl01Kak5mWWqRvl0CV8a0ycIF38wqFs87xdbA2K3bxcjJISFgIrH89E+mLkYuDiGBdYwS
        26d/ZYRwfjFKXP66jAWkik3AUKL3aB8jiC0iICZxe04nM0gRs8BKRokj31eBJYQFoiXmHN4C
        1sAioCpx+uMzsDivgJXElDePWSHWyUus3nCAGcTmFLCWmLlpO1ANB9A2K4l1h8onMPIsYGRY
        xSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGETbDmv172B8vCT+EKMAB6MSD2+FUEqM
        EGtiWXFl7iFGCQ5mJRHei0apMUK8KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGan
        phakFsFkmTg4pRoYRU0cd8Y8dTykcEnqUnRdfP7G7zwq77gl98umnlsRsZjJuNS3uMDHuDrR
        wWfeF7dszVUL7R9euugl/uIQW8s1T9c/D6VyQp6Gs1+fcu35gRV/7jl9+Xd3YZWRyvZdKhLd
        qtbN727/S9KRqauburzIWNKtr9FFPWOmQ9qFnclCOz+oi4QEZZ5WYinOSDTUYi4qTgQAtyjf
        tB4CAAA=
X-CMS-MailID: 20190214093839epcas2p2609ddf53eb48143ff2160d6a30dad615
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214093839epcas2p2609ddf53eb48143ff2160d6a30dad615
References: <20190214093747.2414-1-s.nawrocki@samsung.com>
        <CGME20190214093839epcas2p2609ddf53eb48143ff2160d6a30dad615@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DPCM links in order to support the secondary I2S interface.
For the secondary PCM interface to be actually available one more entry
should be added to the sound-dai property in sound/cpu node in DT.
The changes in driver are done in a way so we are backwards compatible
with existing DTS/DTB, i.e. if the cpu sound-dai property contains only
one entry only one PCM will be registered.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/samsung/odroid.c | 131 +++++++++++++++++++++++++++----------
 1 file changed, 95 insertions(+), 36 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index e7b371b07230..18bb3bfe0300 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/module.h>
@@ -17,21 +18,24 @@
 
 struct odroid_priv {
 	struct snd_soc_card card;
-	struct snd_soc_dai_link dai_link;
-
 	struct clk *clk_i2s_bus;
 	struct clk *sclk_i2s;
 };
 
-static int odroid_card_startup(struct snd_pcm_substream *substream)
+static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
 	snd_pcm_hw_constraint_single(runtime, SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+
 	return 0;
 }
 
-static int odroid_card_hw_params(struct snd_pcm_substream *substream,
+static const struct snd_soc_ops odroid_card_fe_ops = {
+	.startup = odroid_card_fe_startup,
+};
+
+static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -86,19 +90,55 @@ static int odroid_card_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_soc_ops odroid_card_ops = {
-	.startup = odroid_card_startup,
-	.hw_params = odroid_card_hw_params,
+static const struct snd_soc_ops odroid_card_be_ops = {
+	.hw_params = odroid_card_be_hw_params,
+};
+
+static struct snd_soc_dai_link odroid_card_dais[] = {
+	{
+		/* Primary FE <-> BE link */
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.ops = &odroid_card_fe_ops,
+		.name = "Primary",
+		.stream_name = "Primary",
+		.platform_name = "3830000.i2s",
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	}, {
+		/* BE <-> CODECs link */
+		.name = "I2S Mixer",
+		.cpu_name = "snd-soc-dummy",
+		.cpu_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "snd-soc-dummy",
+		.ops = &odroid_card_be_ops,
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBS_CFS,
+	}, {
+		/* Secondary FE <-> BE link */
+		.playback_only = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.ops = &odroid_card_fe_ops,
+		.name = "Secondary",
+		.stream_name = "Secondary",
+		.platform_name = "samsung-i2s-sec",
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	}
 };
 
 static int odroid_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *cpu, *codec;
+	struct device_node *cpu, *cpu_dai, *codec;
 	struct odroid_priv *priv;
-	struct snd_soc_dai_link *link;
 	struct snd_soc_card *card;
-	int ret;
+	struct snd_soc_dai_link *link, *codec_link;
+	int num_pcms, ret, i;
+	struct of_phandle_args args = {};
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -130,45 +170,67 @@ static int odroid_audio_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	link = &priv->dai_link;
-
-	link->ops = &odroid_card_ops;
-	link->dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS;
-
-	card->dai_link = &priv->dai_link;
-	card->num_links = 1;
+	card->dai_link = odroid_card_dais;
+	card->num_links = ARRAY_SIZE(odroid_card_dais);
 
 	cpu = of_get_child_by_name(dev->of_node, "cpu");
 	codec = of_get_child_by_name(dev->of_node, "codec");
+	link = card->dai_link;
+	codec_link = &card->dai_link[1];
 
-	link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
-	if (!link->cpu_of_node) {
-		dev_err(dev, "Failed parsing cpu/sound-dai property\n");
-		return -EINVAL;
+	/*
+	 * For backwards compatibility create the secondary CPU DAI link only
+	 * if there are 2 CPU DAI entries in the cpu sound-dai property in DT.
+	 */
+	num_pcms = of_count_phandle_with_args(cpu, "sound-dai",
+					      "#sound-dai-cells");
+	if (num_pcms == 1)
+		card->num_links--;
+
+	for (i = 0; i < num_pcms; i++, link += 2) {
+		ret = of_parse_phandle_with_args(cpu, "sound-dai",
+						 "#sound-dai-cells", i, &args);
+		if (ret < 0)
+			return ret;
+
+		if (!args.np) {
+			dev_err(dev, "sound-dai property parse error: %d\n", ret);
+			return -EINVAL;
+		}
+
+		ret = snd_soc_get_dai_name(&args, &link->cpu_dai_name);
+		of_node_put(args.np);
+
+		if (ret < 0)
+			return ret;
 	}
 
-	ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+	cpu_dai = of_parse_phandle(cpu, "sound-dai", 0);
+	of_node_put(cpu);
+	of_node_put(codec);
+
+	ret = snd_soc_of_get_dai_link_codecs(dev, codec, codec_link);
 	if (ret < 0)
 		goto err_put_codec_n;
 
-	link->platform_of_node = link->cpu_of_node;
-
-	link->name = "Primary";
-	link->stream_name = link->name;
-
+	/* Set capture capability only for boards with the MAX98090 CODEC */
+	if (codec_link->num_codecs > 1) {
+		card->dai_link[0].dpcm_capture = 1;
+		card->dai_link[1].dpcm_capture = 1;
+	}
 
-	priv->sclk_i2s = of_clk_get_by_name(link->cpu_of_node, "i2s_opclk1");
+	priv->sclk_i2s = of_clk_get_by_name(cpu_dai, "i2s_opclk1");
 	if (IS_ERR(priv->sclk_i2s)) {
 		ret = PTR_ERR(priv->sclk_i2s);
-		goto err_put_i2s_n;
+		goto err_put_codec_n;
 	}
 
-	priv->clk_i2s_bus = of_clk_get_by_name(link->cpu_of_node, "iis");
+	priv->clk_i2s_bus = of_clk_get_by_name(cpu_dai, "iis");
 	if (IS_ERR(priv->clk_i2s_bus)) {
 		ret = PTR_ERR(priv->clk_i2s_bus);
 		goto err_put_sclk;
 	}
+	of_node_put(cpu_dai);
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0) {
@@ -182,10 +244,8 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	clk_put(priv->clk_i2s_bus);
 err_put_sclk:
 	clk_put(priv->sclk_i2s);
-err_put_i2s_n:
-	of_node_put(link->cpu_of_node);
 err_put_codec_n:
-	snd_soc_of_put_dai_link_codecs(link);
+	snd_soc_of_put_dai_link_codecs(codec_link);
 	return ret;
 }
 
@@ -193,8 +253,7 @@ static int odroid_audio_remove(struct platform_device *pdev)
 {
 	struct odroid_priv *priv = platform_get_drvdata(pdev);
 
-	of_node_put(priv->dai_link.cpu_of_node);
-	snd_soc_of_put_dai_link_codecs(&priv->dai_link);
+	snd_soc_of_put_dai_link_codecs(&priv->card.dai_link[1]);
 	clk_put(priv->sclk_i2s);
 	clk_put(priv->clk_i2s_bus);
 
-- 
2.17.1

