Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D97AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FB0217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Aq49E1qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfAILDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:03:50 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12683 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfAILDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:03:50 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c35d5030000>; Wed, 09 Jan 2019 03:03:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 03:03:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Jan 2019 03:03:48 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Jan
 2019 11:03:45 +0000
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
 <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
 <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
 <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
 <87k1je38w7.wl-kuninori.morimoto.gx@renesas.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
Date:   Wed, 9 Jan 2019 11:03:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87k1je38w7.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547031811; bh=vHQqbMlKCgJOgORFtj1eu32GAEWoDPx5q7JT7DekCwM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Aq49E1qi3qmMQMMZJrgdP09P+U5jwqTZNTYX10rAZsKJSvHwt4zY+Ue9q4Gw2qiqz
         yWui2OAVw6xwKtXMXUhoJx8d21L/mySHRcCyVoKbZLCR/kLuj3L8aWxcNJ3ZZ+FiLS
         2h+RLJZar/ScMviu/azcMUOFT7DSY6EseGxAZhI+7+jJQOo+/ahsbl2Fm8KtRw77GN
         1j6zP4aMfytDDgw7oeLhCRv0rhrKgQiTJ4WGokdIvyEkg7m5GNfFSkqKEpcYFMum3s
         AZput/+rejj7AyzFotIsIqGBIBqh5x89PvgSZBDlyJ4P8Tyx/V8QDixn7/BZoKSUeq
         N8VCdYqnid9JQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/01/2019 01:51, Kuninori Morimoto wrote:
> 
> Hi Jon
> 
> Thank you for your help
> 
>>> Yes so this does workaround the problem. However, per my previous
>>> comments, I would like to explore whether it is necessary to allocate
>>> the platform link component or if it can be static.
> 
> OK, thanks.
> It *will* be static, but not yet.
> Thank you for your patch.
> I guess you worry about allocated memory leak when failed case ?
> It is using devm_kzalloc(), so all allocated memory will be automatically
> freed when card was detached.
> But indeed if driver gots -EPROBE_DEFER many times,
> it will allocate many unused platform.

No. Offline you had suggested using kmalloc and not devm_kzalloc and so
I was worried in that case about a memory leak. Right now I am only
concerned about an invalid pointer that is not being handled correctly.

> Here is the background of snd_soc_init_platform.
> 
> Legacy dai_link was xxx_name/xxx_of_node style,
> but multi codec support starts to use snd_soc_dai_link_component style.
> OTOH Lars-Petter is thinking that current ALSA SoC is not good match
> for modern sound device.
> I guess, we need "multi xxx" support as 1st step for modern sound device.
> "multi codec" is already supported,
> "multi cpu"   patch was posted, but not yet accepted (or rejected ??).
> "multi platform" is no plan (?).

I would like someone to explain what multi-platform means? Even if a
soundcard supports multiple platforms, there is only one platform you
are using at any time so ...

> These want to use snd_soc_dai_link_component style,
> because it is nice for multi xxx support style, I think.
> I think no one is planing for "multi platform" so far, thus,
> I posted snd_soc_dai_link_component style for it.
> # Maybe it should have num_platform, too.
> # all driver will have .num_platform = 1, thus I didn't added.
> # maybe it was my fault...

... I don't understand why you would ever need a 'num_platform' as the
machine driver just needs to understand which platform is using it at
any given time. Right?

> The reason why platform/codec is allocating/copying by snd_soc_init_xxx
> so far is that it is glue for
> xxx_name/xxx_of_node (legacy style) <-> snd_soc_init_platform (modern style).
> 
> I want to which to modern style immediately and remove legacy style.
> But as you know, we have too many ALSA SoC drivers now.
> So, if I posted "switch legacy style to modern style" patch
> for each (= for codec, for platform, for cpu), it will be patch-bomb,
> and Lars-Petter/Mark don't like it.
> Thus, I'm waiting "multi CPU" support patch.

Sorry, I still don't understand the dependency on the multi CPU and why
we need to wait.

> If CPU/Codec/Platform can be snd_soc_init_platform style,
> then, we can switch to modern style for all drivers.
> Then, all driver will have *static* platform.
> 
> # So, I guess if your driver can switch to use
> # snd_soc_init_platform style directly, your problem can gone ?

Yes that is an alternative and I can convert all the Tegra machine
drivers to use this now. However, that will not solve the problem for
non-Tegra devices and everyone will have to do this.

Cheers
Jon

-- 
nvpublic
