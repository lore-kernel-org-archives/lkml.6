Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D10C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF3214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kPJmW3pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfAKIlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:41:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10466 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfAKIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:41:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3856980000>; Fri, 11 Jan 2019 00:40:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 11 Jan 2019 00:41:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 11 Jan 2019 00:41:13 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 08:41:11 +0000
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
 <a2068291-e554-cc4f-9af9-0022f3c4de34@nvidia.com>
 <871s5kqb43.wl-kuninori.morimoto.gx@renesas.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <dfdc497f-9e52-99d7-208c-d8eef31fe61d@nvidia.com>
Date:   Fri, 11 Jan 2019 08:41:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <871s5kqb43.wl-kuninori.morimoto.gx@renesas.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547196056; bh=LgtefTK8s9Viu6sufDOP1X+30zG4OWHG1gshPkfqYEM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kPJmW3pq7v86dRPw9h6wE2oS3hVQTPmoBIfPsbTl2hiM98i9O25J5ftKqa8YorPEw
         OO0uuN3Ln3ew+ZlTV5teeKxsxzvGkjj0N5cZqGVSi2smvKACpSVxtmrGMy9dnUcbOO
         4hOn5bY+0Iugr+qMuWcK2ms2xVmc8VzzgC84hwuTNdd0WHJ4cJjhkndp2iXUuaTzKL
         ot0ZauQooIWyvJi4Q8ISb/OHXBFDx4HQeesFSUZpzmhaJNVcIyiertOhQrTJAaeKtM
         THKn+1gUFTc30YSyB6CLL3LnnogLGvXMRUPmu6vanKbxu7T8ESKvjdGMJwE9zOS1NA
         q38IWqBB6nM6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/01/2019 00:52, Kuninori Morimoto wrote:

...

>> It is still fragile. Again the machine driver could have incorrectly set
>> these 'allocated_platform/codecs' members as they are exposed to the
>> machine driver. You have no way to determine if the machine driver is
>> doing the correct thing or not. The problem becomes more complex with
>> probe deferral.
> 
> Indeed there is such case so far, but my understanding is that current
> driver should select "legacy style" or "modern style".
> If driver setup it as "legacy", but access to "modern" member,
> it is driver side bug, right ?

Yes absolutely it is a driver bug, but looking at the snd_soc_dai_link
structure today it is not clear what the driver should be setting and
what is 'modern' and what is 'legacy'. You need to dig through the git
history and code to figure this out. So you could say it is not very
well documented/commented from a soc-core perspective and could be easy
for a driver writer to get themselves in a pickle/mess. Anyway, that is
easy to fix and we could add some comments to clear it up.

Cheers
Jon

-- 
nvpublic
