Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C6E2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZmzM3V+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbfACQmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:42:39 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3126 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfACQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:42:38 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2e3b700000>; Thu, 03 Jan 2019 08:42:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Jan 2019 08:42:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 03 Jan 2019 08:42:38 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 3 Jan
 2019 16:42:35 +0000
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name vs.
 of_node assignement
To:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-tegra@vger.kernel.org>
References: <20181018111829.27056-1-marcel@ziswiler.com>
 <20181018111829.27056-4-marcel@ziswiler.com>
 <e25a7463-9ce0-d7f9-e77b-2bbaab2e0b25@nvidia.com>
 <20181021112301.GC8554@sirena.org.uk>
 <20181218174040.k7u26vnnoplllnwb@camel2.lan>
CC:     Matthias Reichl <hias@horus.com>, <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <952471da-b355-6471-6c19-5120d6704f81@nvidia.com>
Date:   Thu, 3 Jan 2019 16:42:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218174040.k7u26vnnoplllnwb@camel2.lan>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546533744; bh=mwYbw4oijfgFZRk2m0bHM+sdL2WEUaN0wjrZSKcbN2I=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZmzM3V+bUbs8akSZWUNDSXkBOYhjkeJn1POcBUvCu0/TVUJPw+JXuPCsJYy6b+hQs
         OLINFgvL2PcinO5Ix+Jj2Lumr1dTwLLVmGvxaD2sXpv7a4i1U/XWr9NdRAseDbsCtS
         lWCCTpIjoCj7JSOW9jQr4MaqF0ljkOzPGXnvTODN7x6VnkpqyLj1bqtAxpFME0Rj10
         bxBe3CWP5wvyE5PHxg2ANJ69xaRmunJNMr0e5aot0zkedAS9bom8XTduq3SY66Sg5K
         hSU9NGmjwkLEC37PTnHs47MOZLYUEvt3iZUfSJSJ1/4POf1o1+T4Jq9YFTrEs9M7UC
         JqvJG9rX/Hvag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Kuninori

On 18/12/2018 17:40, Matthias Reichl wrote:
> Hi Mark,
> 
> On Sun, Oct 21, 2018 at 12:23:01PM +0100, Mark Brown wrote:
>> On Fri, Oct 19, 2018 at 11:22:46AM +0100, Jon Hunter wrote:
>>
>>> Looking at snd_soc_init_platform(), it seems that the platform pointer
>>> can be allocated by the machine driver and so if it is not allocated by
>>> the core, then I don't think we should clear it here. Seems we need a
>>> way to determine if this was allocated by the core.
>>
>> Indeed, this is a bit of a mess.  We probably shouldn't be modifying the
>> data that the drivers passed in, otherwise we get into trouble like
>> this.   That suggests that we should copy the data, probably all of it.
>> I will try to have a proper look at this next week.
> 
> did you find the time to look into this?
> 
> The downstream Raspberry Pi kernel contains a bunch of machine drivers
> that are implemented in a similar way as the tegra_sgtl5000 driver
> (static card and dai link structs, dai_link->platform_of_node filled
> in from device tree) which are breaking in 4.20 on deferred probing.
> 
> Switching these drivers to dynamically allocated dai link structs,
> like 76836fd35492 "ASoC: omap-abe-twl6040: Fix missing audio card
> caused by deferred probing" would be a possibility, but if there's
> some solution on the horizon that doesn't require changes to the
> driver code it'd be easier to wait for that.
> 
> so long,
> 
> Hias
> 
>>> Furthermore, it seems that it is possible that there is more than one
>>> link that might be to be cleared.
>>
>> Yes, that's an issue as well.

I have been looking at this again recently. I see this issue occurring
all the time when the sound drivers are built as kernel modules and
probing the sound card is deferred until the codec driver has been loaded.

Commit daecf46ee0e5 ("ASoC: soc-core: use snd_soc_dai_link_component for
platform") appears to introduce the problem because now we allocate the
'snd_soc_dai_link_component' structure for the platform we attempt to
register the soundcard but we never clear the freed pointer on failure.
Therefore, we only actually allocate it the first time. There is no easy
way to clear this pointer for the memory allocated because this is done
before the dai-links have been added to the list of dai-links for the
soundcard.

I don't see an easy solution that will be 100% robust unless you do opt
for copying all the dai-link info from the platform (but this is
probably not a trivial fix).

Do you envision a fix any time soon, or should we be updating all the
machine drivers to populate the platform snd_soc_dai_link_component so
that it is handled by the machine drivers are not the core?

Cheers
Jon

-- 
nvpublic
