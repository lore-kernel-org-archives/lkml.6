Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F12AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1A8213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 11:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Vt0+q0xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfBYLYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 06:24:45 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4309 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfBYLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 06:24:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c73d07b0000>; Mon, 25 Feb 2019 03:24:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 Feb 2019 03:24:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 25 Feb 2019 03:24:43 -0800
Received: from [10.24.44.186] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 25 Feb
 2019 11:24:40 +0000
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
To:     Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20190225123615.49bce7cd@canb.auug.org.au>
 <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
 <s5hr2bw2k7m.wl-tiwai@suse.de>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
Date:   Mon, 25 Feb 2019 16:54:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <s5hr2bw2k7m.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551093883; bh=5mJlVutZickPb3wayRQJ3tHtItZi1JOaDRP+wYvtmgE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Vt0+q0xeGSsM7dbrIzkZ3oCTjajyLuVh/1PNS1pa93AOgYGxZmuyGYOyovVKEPEQq
         8UOU7WaknRv0ZMjkKPLatHMkZN/wRYH/aBoxmDaV9De9mwd3EmfeJiy94j97O50D4j
         W9sBZWcnz58CB/fyCNCImN+SgRjPWZUoqTodHb56WD4qhgKB9lwP2noi3MAOkC+yfx
         YHXZwYdKDZ5YZQbWQtEqF7Z8XTkq3QN7+VWts4wZ1yk1YSynR01NCpDtMyWfT6Fkdr
         JfSdl9lGfbhGnE7djeqd9nkGY3vcq7w8TdgulGNtINf0pAR1S1cQrWoUhxKOp7z5Qw
         JqR0oGLAhOL2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/2019 4:44 PM, Takashi Iwai wrote:
> On Mon, 25 Feb 2019 10:19:15 +0100,
> Arnd Bergmann wrote:
>> On Mon, Feb 25, 2019 at 2:36 AM Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>>> Hi Takashi,
>>>
>>> Today's linux-next merge of the sound tree got conflicts in:
>>>
>>>    arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>>>    arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>>>
>>> between commits:
>>>
>>>    5eef17ee764d ("arm64: tegra: p2972: Sort nodes properly")
>>>    be4f0dd347ad ("arm64: tegra: p2597: Sort nodes by unit-address")
>>>
>>> from the arm-soc tree and commit:
>>>
>>>    11ce4308307c ("arm64: tegra: custom name for hda sound card")
>>>
>>> from the sound tree.
>>>
>>> I fixed it up (see below - in tegra194-p2972-0000.dts. the line added
>>> just needed to be moved up a few lines) and can carry the fix as
>>> necessary. This is now fixed as far as linux-next is concerned, but any
>>> non trivial conflicts should be mentioned to your upstream maintainer
>>> when your tree is submitted for merging.  You may also want to consider
>>> cooperating with the maintainer of the conflicting tree to minimise any
>>> particularly complex conflicts.
>> The merge looks fine to me, but I wonder about that commit
>> in the alsa tree, why does the sound card need a board specific
>> name?
>>
>> I see this property being used in commit c0bde003a013 ("ALSA:
>> hda/tegra: sound card name from device tree"), which removes
>> a questionable use of the root compatible property, replacing
>> it with the new 'nvidia,model' property. We don't do this for any
>> other subsystem, so why does the sound subsystem export
>> information about the board as a string here?
> The sound subsystem exports merely some understandable name string
> for the given sound card object, and that was composed from the
> compatible string in the past, which turned out to be useless on some
> configs.
>
> But this kind of addition is an extremely bad manner, I'm fine to
> revert these (at best with a better alternative).  This isn't about
> any functionality but rather some readable information that isn't a
> part of API.
>
The motivation for adding custom sound card name is following,
1. When for boards, multiple HDMI/DP ports are exposed, it is sometimes
 =C2=A0=C2=A0 necessary to know the default port or any customization for t=
hat matter.
 =C2=A0=C2=A0 Audio userspace can distinguish based on the sound card names=
.
2. Multiple sound cards can coexist for a platform, the indication of=20
particular
 =C2=A0=C2=A0 audio path is useful.
3. It can help to customize audio paths.
 =C2=A0=C2=A0 Generally people use "*,model" property in DT to name the sou=
nd complex.
 =C2=A0=C2=A0 Ex: "samsung,model" [sound/soc/samsung/snow.c]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rockchip,model" [sound/soc/rockchip/=
rockchip_rt5645.c]

Thanks,
Sameer.
> thanks,
>
> Takashi
