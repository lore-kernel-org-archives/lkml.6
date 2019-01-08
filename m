Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D009C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363CE20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QvLDG0FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfAHPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:48:34 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15230 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAHPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:48:34 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c34c6430000>; Tue, 08 Jan 2019 07:48:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Jan 2019 07:48:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Jan 2019 07:48:31 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Jan
 2019 15:48:29 +0000
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name vs.
 of_node assignement
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-tegra@vger.kernel.org>, Matthias Reichl <hias@horus.com>,
        <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>
References: <20181018111829.27056-1-marcel@ziswiler.com>
 <20181018111829.27056-4-marcel@ziswiler.com>
 <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
 <20181021112301.GC8554@sirena.org.uk>
 <20181218174040.k7u26vnnoplllnwb@camel2.lan>
 <952471da-b355-6471-6c19-5120d6704f81@nvidia.com>
 <87lg3vuc7p.wl-kuninori.morimoto.gx@renesas.com>
 <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
 <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
Message-ID: <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
Date:   Tue, 8 Jan 2019 15:48:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546962499; bh=iXCE+1HWa/tqZThqjn80ZK5SXMjxJLxdtnnf3hL6UMA=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QvLDG0FNHrt9cJjx00SX4Y2C4sRcEEw1vFUIzSzaAwvmVFS3u0Dwaf/g2loRJ/OHo
         XQDXVAoev39CHcKccH1Yb6d8H9bhbaP6wLztx8/27+J2thPgIifIkGXX+CSCVfj0bq
         nHz3lcHzGKpB26/HcqFQyCvU0Zbb9YrKwhJF7uM5bmzy2EQ9ElH9UbBlkc+IX/Eqjn
         ++wpK3FcYsGUutl/zwHuzAdlURBZRFnkZ2eiMjbh2Y+Ii8zMxQrhZM0s31cogh3S7n
         /XTo6FHau2gi5kJXy7+R2BKHraPsVDMZjzXdQU6sTNpDaXtEscnLGBXhptdWnssV5r
         rTssk7xABA5vg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/01/2019 12:03, Jon Hunter wrote:
> 
> On 08/01/2019 10:50, Jon Hunter wrote:
>> Hi Kuninori,
>>
>> On 08/01/2019 02:25, Kuninori Morimoto wrote:
>>>
>>> Hi Jon
>>>
>>>> I have been looking at this again recently. I see this issue occurring
>>>> all the time when the sound drivers are built as kernel modules and
>>>> probing the sound card is deferred until the codec driver has been loaded.
>>>>
>>>> Commit daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for
>>>> platform") appears to introduce the problem because now we allocate the
>>>> 'snd_soc_dai_link_component' structure for the platform we attempt to
>>>> register the soundcard but we never clear the freed pointer on failure.
>>>> Therefore, we only actually allocate it the first time. There is no easy
>>>> way to clear this pointer for the memory allocated because this is done
>>>> before the dai-links have been added to the list of dai-links for the
>>>> soundcard.
>>>>
>>>> I don't see an easy solution that will be 100% robust unless you do opt
>>>> for copying all the dai-link info from the platform (but this is
>>>> probably not a trivial fix).
>>>>
>>>> Do you envision a fix any time soon, or should we be updating all the
>>>> machine drivers to populate the platform snd_soc_dai_link_component so
>>>> that it is handled by the machine drivers are not the core?
>>>
>>> Thank you for pointing it.
>>> Indeed it is mess.
>>> I think coping info is nice idea,
>>> but it is not easy so far, and it uses much memory...
>>>
>>> I didn't test this, but can below patch solve your issue ?
>>
>> I will give it a try and let you know.
> 
> Yes so this does workaround the problem. However, per my previous
> comments, I would like to explore whether it is necessary to allocate
> the platform link component or if it can be static.

To be specific, the following also works ...

---
 include/sound/simple_card_utils.h     |  2 +-
 include/sound/soc.h                   |  2 +-
 sound/soc/generic/audio-graph-card.c  |  4 +++-
 sound/soc/generic/simple-card-utils.c |  4 ++--
 sound/soc/generic/simple-card.c       |  6 ++++--
 sound/soc/soc-core.c                  | 18 +++++++-----------
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 6d69ed2bd7b1..78273b81ef82 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -75,7 +75,7 @@ void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai);
 				   &dai_link->codec_dai_name,			\
 				   list_name, cells_name, NULL)
 #define asoc_simple_card_parse_platform(node, dai_link, list_name, cells_name)	\
-	asoc_simple_card_parse_dai(node, dai_link->platform,					\
+	asoc_simple_card_parse_dai(node, &dai_link->platform,					\
 		&dai_link->platform_of_node,					\
 		NULL, list_name, cells_name, NULL)
 int asoc_simple_card_parse_dai(struct device_node *node,
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec1de856ee7..8b7ffc60006a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -925,7 +925,7 @@ struct snd_soc_dai_link {
 	 */
 	const char *platform_name;
 	struct device_node *platform_of_node;
-	struct snd_soc_dai_link_component *platform;
+	struct snd_soc_dai_link_component platform;
 
 	int id;	/* optional ID for machine driver link identification */
 
diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 3ec96cdc683b..e961d45ce141 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -687,7 +687,9 @@ static int graph_probe(struct platform_device *pdev)
 	for (i = 0; i < li.link; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
-		dai_link[i].platform	= &dai_props[i].platform;
+		dai_link[i].platform.name = dai_props[i].platform.name;
+		dai_link[i].platform.of_node = dai_props[i].platform.of_node;
+		dai_link[i].platform.dai_name = dai_props[i].platform.dai_name;
 	}
 
 	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 336895f7fd1e..74910c7841ec 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -397,8 +397,8 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
 int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
-	if (!dai_link->platform->of_node)
-		dai_link->platform->of_node = dai_link->cpu_of_node;
+	if (!dai_link->platform.of_node)
+		dai_link->platform.of_node = dai_link->cpu_of_node;
 
 	return 0;
 
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 479de236e694..b6402e09bba2 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -732,7 +732,9 @@ static int simple_probe(struct platform_device *pdev)
 	for (i = 0; i < li.link; i++) {
 		dai_link[i].codecs	= &dai_props[i].codecs;
 		dai_link[i].num_codecs	= 1;
-		dai_link[i].platform	= &dai_props[i].platform;
+		dai_link[i].platform.name = dai_props[i].platform.name;
+		dai_link[i].platform.of_node = dai_props[i].platform.of_node;
+		dai_link[i].platform.dai_name = dai_props[i].platform.dai_name;
 	}
 
 	priv->dai_props		= dai_props;
@@ -782,7 +784,7 @@ static int simple_probe(struct platform_device *pdev)
 		codecs->name		= cinfo->codec;
 		codecs->dai_name	= cinfo->codec_dai.name;
 
-		platform		= dai_link->platform;
+		platform		= &dai_link->platform;
 		platform->name		= cinfo->platform;
 
 		card->name		= (cinfo->card) ? cinfo->card : cinfo->name;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..466099995e44 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -915,7 +915,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	/* find one from the set of registered platforms */
 	for_each_component(component) {
-		if (!snd_soc_is_matching_component(dai_link->platform,
+		if (!snd_soc_is_matching_component(&dai_link->platform,
 						   component))
 			continue;
 
@@ -1026,7 +1026,7 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 static int snd_soc_init_platform(struct snd_soc_card *card,
 				 struct snd_soc_dai_link *dai_link)
 {
-	struct snd_soc_dai_link_component *platform = dai_link->platform;
+	struct snd_soc_dai_link_component *platform = &dai_link->platform;
 
 	/*
 	 * FIXME
@@ -1034,14 +1034,10 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	 * this function should be removed in the future
 	 */
 	/* convert Legacy platform link */
-	if (!platform) {
-		platform = devm_kzalloc(card->dev,
-				sizeof(struct snd_soc_dai_link_component),
-				GFP_KERNEL);
-		if (!platform)
-			return -ENOMEM;
+	if (dai_link->platform_name || dai_link->platform_of_node) {
+		dev_dbg(card->dev,
+			"ASoC: Defaulting to legacy platform data!\n");
 
-		dai_link->platform	= platform;
 		platform->name		= dai_link->platform_name;
 		platform->of_node	= dai_link->platform_of_node;
 		platform->dai_name	= NULL;
@@ -1123,7 +1119,7 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 	 * Platform may be specified by either name or OF node, but
 	 * can be left unspecified, and a dummy platform will be used.
 	 */
-	if (link->platform->name && link->platform->of_node) {
+	if (link->platform.name && link->platform.of_node) {
 		dev_err(card->dev,
 			"ASoC: Both platform name/of_node are set for %s\n",
 			link->name);
@@ -1921,7 +1917,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 				dev_err(card->dev, "init platform error");
 				continue;
 			}
-			dai_link->platform->name = component->name;
+			dai_link->platform.name = component->name;
 
 			/* convert non BE into BE */
 			dai_link->no_pcm = 1;
-- 
2.7.4

-- 
nvpublic
