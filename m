Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8BFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019292177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jyH0m92B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfAJK4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:56:40 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10109 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAJK4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:56:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3724d50000>; Thu, 10 Jan 2019 02:56:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 02:56:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 10 Jan 2019 02:56:39 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 10:56:37 +0000
Subject: Re: [alsa-devel] [PATCH v1 3/3] ASoC: soc-core: fix platform name vs.
 of_node assignement
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-tegra@vger.kernel.org>,
        Matthias Reichl <hias@horus.com>,
        <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>
References: <20181218174040.k7u26vnnoplllnwb@camel2.lan>
 <952471da-b355-6471-6c19-5120d6704f81@nvidia.com>
 <87lg3vuc7p.wl-kuninori.morimoto.gx@renesas.com>
 <b5164c93-8be8-1c3d-9415-c895da6ad622@nvidia.com>
 <d1e41ed2-da7c-b46c-bc6d-64cf3e536771@nvidia.com>
 <865d2a3e-bf6b-1f30-1179-7e922c0d0641@nvidia.com>
 <87k1je38w7.wl-kuninori.morimoto.gx@renesas.com>
 <0660a471-3698-2059-4494-ad146518a4ed@nvidia.com>
 <20190109125340.GD10405@sirena.org.uk>
 <52f5f2cf-9260-f9c5-f73d-3c3d5debc86b@nvidia.com>
 <20190109141439.GE10405@sirena.org.uk>
 <875zuxb9uy.wl-kuninori.morimoto.gx@renesas.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a2068291-e554-cc4f-9af9-0022f3c4de34@nvidia.com>
Date:   Thu, 10 Jan 2019 10:56:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <875zuxb9uy.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547117781; bh=j//TMwjSKzY2Aan2YwqJW8hR5guLjV9iJNrcK6jvCwU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jyH0m92BMIG1W6gmvbQ1pZwNRNyDOhbbzn/uZz24LoTltIWkQsevv/AR2J0DD/Zsi
         20PCjDpCbipHuyNAl9q6tQ7PtrI4T8BR/OIZXjoHxkJPMQWJJ2W+6gV9GYJ9LA3892
         UlIANDLeVdXGRdqKcWWTktOv7/vUdMzN171mzQQYoo49YtPKgVIzQ4awWasdducCom
         a/Ip4pSsCG6b0qz8PdSz+LB+WuQ1+VIW4voZivUWGxl/kckT+hYJAFONztrDTJ82iD
         ZeLUY0cMmr3+aBxe1vZE736TSblnt+f+GzGXsvpDC0Cx2/tq5ricYWtL5AgdneDRwq
         B5QSCntZ07WDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/01/2019 01:16, Kuninori Morimoto wrote:

...

> As I mentioned above, I think we have same issue on codec side too.

Actually no. Looking at snd_soc_init_multicodec() it always allocates
memory if any of the 'legacy' codec members
(codec_name/codec_of_node/codec_dai_name) are populated. However, this
looks quite fragile to me and is susceptible to leaking memory if the
user/machine driver already incorrectly allocated the memory as well as
populating these legacy codec members.

My concern about all of this is it is not fool proof and hard to detect
if a machine driver is doing something bad that it should not.

> exchanging *platform to platform doesn't solve all issues.
> And we need to exchange all driver again if we had multi-platform
> support in the future (I don't know when it can happen though...)
> 
> My posted quick-patch can solve "dirty pointer" issue,
> but it can't solve "memory leak" issue.
> This issue will be solved if all driver can switch to
> modern style, but it needs more time.
> Are these correct ?
> 
> So, how about this ?

It is still fragile. Again the machine driver could have incorrectly set
these 'allocated_platform/codecs' members as they are exposed to the
machine driver. You have no way to determine if the machine driver is
doing the correct thing or not. The problem becomes more complex with
probe deferral.

Cheers
Jon

-- 
nvpublic
