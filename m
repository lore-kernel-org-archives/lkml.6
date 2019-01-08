Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCF52087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GhvYSs02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfAHKu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:50:27 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2165 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:50:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c34805e0000>; Tue, 08 Jan 2019 02:50:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Jan 2019 02:50:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Jan 2019 02:50:23 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Jan
 2019 10:50:20 +0000
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name vs.
 of_node assignement
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
Date:   Tue, 8 Jan 2019 10:50:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87lg3vuc7p.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546944606; bh=1aKVJz2AArf2tgbPOGDLD2w3ccIZRNB3HPlcGVh61ao=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GhvYSs02Rj6jrbQS4J5Ow0DUz5qlpF3x4GgAK3AjGYVt8xcOOojRKxMmo3jL/GoRF
         g755MgUU4hHqLidCW2r7+3tfJJPLEQAKus2mvLdOnCwlnPPLQcWR1VQ/DmHIuUMypW
         sCP4xB7WWolnYL4EyuLZQpzGJrqdSDZwRfIQCLCNAoe1EEDPKdbg8xuVeJ7mhqcmb8
         bOvNvcyss8+9/XEYQtoW5o3jHsUB33is4XYm6z3c/uVQm36+dBFX1tkgTsIL806pZG
         UmV8Hn7MXK0pj1T4oqXWjU47foRXcsm5Nawb1D6KiZ367GzD8+sKbK/Q35x+N4aDYr
         NqfJobvoGHzMA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuninori,

On 08/01/2019 02:25, Kuninori Morimoto wrote:
> 
> Hi Jon
> 
>> I have been looking at this again recently. I see this issue occurring
>> all the time when the sound drivers are built as kernel modules and
>> probing the sound card is deferred until the codec driver has been loaded.
>>
>> Commit daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for
>> platform") appears to introduce the problem because now we allocate the
>> 'snd_soc_dai_link_component' structure for the platform we attempt to
>> register the soundcard but we never clear the freed pointer on failure.
>> Therefore, we only actually allocate it the first time. There is no easy
>> way to clear this pointer for the memory allocated because this is done
>> before the dai-links have been added to the list of dai-links for the
>> soundcard.
>>
>> I don't see an easy solution that will be 100% robust unless you do opt
>> for copying all the dai-link info from the platform (but this is
>> probably not a trivial fix).
>>
>> Do you envision a fix any time soon, or should we be updating all the
>> machine drivers to populate the platform snd_soc_dai_link_component so
>> that it is handled by the machine drivers are not the core?
> 
> Thank you for pointing it.
> Indeed it is mess.
> I think coping info is nice idea,
> but it is not easy so far, and it uses much memory...
> 
> I didn't test this, but can below patch solve your issue ?

I will give it a try and let you know.

> I think same issue happen on codec side too, so it cares it too.
> 
> ---------------
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 8ec1de8..49ac5a8 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -985,6 +985,10 @@ struct snd_soc_dai_link {
>  	/* Do not create a PCM for this DAI link (Backend link) */
>  	unsigned int ignore:1;
>  
> +	/* allocated dai_link_comonent. These should be removed in the future */
> +	unsigned int allocated_platform:1;
> +	unsigned int allocated_codecs:1;
> +

You should add a comment here to state that these should not be modified
by the machine driver and are private to the sound core.

>  	struct list_head list; /* DAI link list of the soc card */
>  	struct snd_soc_dobj dobj; /* For topology */
>  };
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 0462b3e..49ccea3 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1023,6 +1023,25 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
>  	}
>  }
>  
> +static void snd_soc_init_dai_link_component(struct snd_soc_card *card)
> +{
> +	struct snd_soc_dai_link *dai_link;
> +	int i;
> +
> +	/*
> +	 * FIXME
> +	 *
> +	 * this function should be removed in the future
> +	 */
> +	for_each_card_prelinks(card, i, dai_link) {
> +		/* see snd_soc_init_platform */
> +		if (dai_link->allocated_platform)
> +			dai_link->platform = NULL;
> +		if (dai_link->allocated_codecs)
> +			dai_link->codecs = NULL;
> +	}
> +}
> +

It is still a little fragile because there is nothing to prevent a
machine driver doing the wrong thing and setting these when they should
not.

>  static int snd_soc_init_platform(struct snd_soc_card *card,
>  				 struct snd_soc_dai_link *dai_link)
>  {
> @@ -1042,6 +1061,8 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
>  			return -ENOMEM;
>  
>  		dai_link->platform	= platform;
> +		dai_link->allocated_platform	= 1;
> +
>  		platform->name		= dai_link->platform_name;
>  		platform->of_node	= dai_link->platform_of_node;
>  		platform->dai_name	= NULL;
> @@ -1069,6 +1090,8 @@ static int snd_soc_init_multicodec(struct snd_soc_card *card,
>  		if (!dai_link->codecs)
>  			return -ENOMEM;
>  
> +		dai_link->allocated_codecs = 1;
> +
>  		dai_link->codecs[0].name = dai_link->codec_name;
>  		dai_link->codecs[0].of_node = dai_link->codec_of_node;
>  		dai_link->codecs[0].dai_name = dai_link->codec_dai_name;
> @@ -2739,6 +2762,8 @@ int snd_soc_register_card(struct snd_soc_card *card)
>  	if (!card->name || !card->dev)
>  		return -EINVAL;
>  
> +	snd_soc_init_dai_link_component(card);
> +
>  	for_each_card_prelinks(card, i, link) {
>  
>  		ret = soc_init_dai_link(card, link);
I still question if the platform link component needs to be allocated
and why it cannot be in the DAI link structure? If it was static, then ...

1. If the dai_link->platform_name or dai_link->platform_of_node are
   populated and the platform->name/of_node are not populated then use
   platform_name/of_node as the platform->name/of_node.

2. If the dai_link->platform_name or dai_link->platform_of_node are not
   populated and the platform->name/of_node are populated then there is
   nothing to do, just use platform->name/of_node.

3. If the dai_link->platform_name or dai_link->platform_of_node are
   populated and the platform->name/of_node are populated then WARN and
   default to the platform_name/of_node as the platform->name/of_node.

Could this work?

Cheers
Jon

-- 
nvpublic
