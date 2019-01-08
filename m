Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3D620651
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IJllqTI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfAHMDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:03:30 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8269 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfAHMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:03:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3491810000>; Tue, 08 Jan 2019 04:03:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Jan 2019 04:03:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Jan 2019 04:03:29 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 8 Jan
 2019 12:03:27 +0000
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
Message-ID: <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
Date:   Tue, 8 Jan 2019 12:03:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546948993; bh=0fi8se1lvqJsCh7ZIheBx8IitL/cp4bxgHeXLMfF95c=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IJllqTI0fFwS8uw5zWYUFz8j34fz6MWzKgK1xWJIqEt3iR+DHT2X3/YMsK2aeqve8
         V+KahORbxLUgii3wgijQTe94VPbXvHtnLlkLSevUVdBaFOz6ihntmh3sF2gqqZ9dDc
         OCH7TVAYrBo6AzeJdE41i7Yfqqw4t491FOPUl6qcpXKeUc/v2QSLokhVurAW/M9LLU
         QH2mwzbBs3fISCeVYKppylfyaaibvo8jemsgeLWuBJBfjnUP2aV4hMiCa1oo+w9NUf
         XB3yXZ3jRLNR/W8MuU88bCzIiwxd2jEg3kXbCbNPeuxJnjfWFa1+VhB60FEBFq4nQz
         R8Q1AK/Dt6C4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/01/2019 10:50, Jon Hunter wrote:
> Hi Kuninori,
> 
> On 08/01/2019 02:25, Kuninori Morimoto wrote:
>>
>> Hi Jon
>>
>>> I have been looking at this again recently. I see this issue occurring
>>> all the time when the sound drivers are built as kernel modules and
>>> probing the sound card is deferred until the codec driver has been loaded.
>>>
>>> Commit daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for
>>> platform") appears to introduce the problem because now we allocate the
>>> 'snd_soc_dai_link_component' structure for the platform we attempt to
>>> register the soundcard but we never clear the freed pointer on failure.
>>> Therefore, we only actually allocate it the first time. There is no easy
>>> way to clear this pointer for the memory allocated because this is done
>>> before the dai-links have been added to the list of dai-links for the
>>> soundcard.
>>>
>>> I don't see an easy solution that will be 100% robust unless you do opt
>>> for copying all the dai-link info from the platform (but this is
>>> probably not a trivial fix).
>>>
>>> Do you envision a fix any time soon, or should we be updating all the
>>> machine drivers to populate the platform snd_soc_dai_link_component so
>>> that it is handled by the machine drivers are not the core?
>>
>> Thank you for pointing it.
>> Indeed it is mess.
>> I think coping info is nice idea,
>> but it is not easy so far, and it uses much memory...
>>
>> I didn't test this, but can below patch solve your issue ?
> 
> I will give it a try and let you know.

Yes so this does workaround the problem. However, per my previous
comments, I would like to explore whether it is necessary to allocate
the platform link component or if it can be static.

Cheers
Jon

-- 
nvpublic
