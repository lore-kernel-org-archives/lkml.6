Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1353C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75022214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dPrZRBWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75022214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeKVBZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:25:42 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16401 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKVBZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:25:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf570da0000>; Wed, 21 Nov 2018 06:51:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Nov 2018 06:50:57 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Nov 2018 06:50:57 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 21 Nov
 2018 14:50:56 +0000
Subject: Re: [PATCH] soc/tegra: refactor soc_is_tegra()
To:     Frank Lee <tiny.windzz@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181121141204.22819-1-tiny.windzz@gmail.com>
 <2d534bbb-7b75-8521-bf88-36b52c918d19@nvidia.com>
 <20181121144320.GA6446@ulmo>
 <CAEExFWswqoObtnjezRf-3u1ssJ04cwDaggg_HLXju72mannZ6w@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bb47ae0d-3607-f396-b9e4-77e25777d6c2@nvidia.com>
Date:   Wed, 21 Nov 2018 14:50:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWswqoObtnjezRf-3u1ssJ04cwDaggg_HLXju72mannZ6w@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542811866; bh=6VazzTqeSfEs2AaT9Hu5nIkDrWgi+ldjY7k9jEGWMFU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dPrZRBWsX4OUbFbX0xJb/Yq6/bbTncZEpz3/QsZWiK3s75vnquiVbWz+xPev1cEv5
         mJbS/a4blq7mJ6EIgbBqzcQHIiKlWR3bndOmAU+/3QATwHrHBl9Giq9TFEnZwvAO5u
         sPK2wg0E2OoSCCrekGZqTzBYHLaj9uvFrbNfg74f/gFuiEzx+8AJWRjFYZWkPJB0tT
         UhAIm+mZhUq6Rd3PvDj8Ya+YT7x6TZnKVZyq+31JaE3uRJJ9DWEcEqKqrVV1N1DDZm
         Zg0TonE94V8HOJISt77tus0n6UnWjQqxQzdrs4CDc8baOb3cTJCbFcBDYBQi9yH48y
         +lxSc2SmtaFiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/11/2018 14:47, Frank Lee wrote:
> On Wed, Nov 21, 2018 at 10:43 PM Thierry Reding
> <thierry.reding@gmail.com> wrote:
>>
>> On Wed, Nov 21, 2018 at 02:34:57PM +0000, Jon Hunter wrote:
>>>
>>> On 21/11/2018 14:12, Yangtao Li wrote:
>>>> of_find_node_by_path() acquires a reference to the node returned by
>>>> it and that reference needs to be dropped by its caller.soc_is_tegra()
>>>> doesn't do that, so fix it.Call of_machine_is_compatible() to refactor
>>>> soc_is_tegra() whcih automatically manages the reference count.
>>>>
>>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>>>> ---
>>>>  drivers/soc/tegra/common.c | 12 +++++++-----
>>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
>>>> index cd8f41351add..0b40700b672a 100644
>>>> --- a/drivers/soc/tegra/common.c
>>>> +++ b/drivers/soc/tegra/common.c
>>>> @@ -22,11 +22,13 @@ static const struct of_device_id tegra_machine_mat=
ch[] =3D {
>>>>
>>>>  bool soc_is_tegra(void)
>>>>  {
>>>> -   struct device_node *root;
>>>> +   struct of_device_id *match =3D tegra_machine_match;
>>>>
>>>> -   root =3D of_find_node_by_path("/");
>>>> -   if (!root)
>>>> -           return false;
>>>> +   while(match->compatible){
>>>> +           if(of_machine_is_compatible(match->compatible))
>>>> +                   return true;
>>>> +           match++;
>>>> +   }
>>>>
>>>> -   return of_match_node(tegra_machine_match, root) !=3D NULL;
>>>> +   return false;
>>>>  }
>>>
>>> Ugh ... sorry, I thought that of_machine_is_compatible() looped through
>>> the matches. OK, let's stick with your initial fix.
>>
>> Actually I prefer this one. Even if it is slightly more verbose, I think
>> it's much clearer what's actually going on. Also this hides all of the
>> OF node reference counting in a core function, so it's worth the extra
>> line, in my opinion.
>>
>> Thierry
> Hi Jon=EF=BC=9A
>=20
> I like both, how aboout you?

Yes fine with me too. However, looks like there is some formatting that
needs to be fixed up above. Please make sure you run checkpatch.pl on
your patches. Otherwise ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thierry, pick up this version if you prefer.

Cheers
Jon

--=20
nvpublic
