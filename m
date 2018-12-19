Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD165C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9961D218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jw3Z9rOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeLSDO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:14:28 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9524 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeLSDO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:14:27 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c19b7890000>; Tue, 18 Dec 2018 19:14:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Dec 2018 19:14:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 19:14:26 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 03:14:24 +0000
Subject: Re: [PATCH v6 0/4] Fixes for Tegra soctherm
To:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <74e77548-d10c-fd00-48c5-2b611529eaf5@nvidia.com>
 <1545104154.2052.2.camel@intel.com>
 <20181218213126.GA8850@localhost.localdomain>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <18672c34-86f3-082e-ad2d-278819e0b075@nvidia.com>
Date:   Wed, 19 Dec 2018 11:14:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218213126.GA8850@localhost.localdomain>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545189258; bh=VqLDfhBe6Zp813kO9hDppR3YQCp0H0lUbMuXj1cuCDg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jw3Z9rOk/6+eC0shI5MO6IfVLMn44O2zncbyb53n0KNtpq3yGyFBz3Jva1DspP3dp
         jFaMyxzGn/WY8hCK8fDtIp2zkTvIOhzDJamiM9OfY97EE2/LURpOBXZyBUgaraOHPD
         83znlpYJDW9Wfg8Ct+pfj7FfILHiyDvA5dFm7fRoGQmUMILAlRj9RCL/TE3G3xYkcd
         Rrc0u++xUVNJluZk7YQJ44B1V66lLYile3oGyCdNs+gd52Tp7sMQTp3e50dDC4hFJ9
         XGIINudXvG5DXv3VPQ/EsQhjqKKaWa7TpEEx+VnjblElmJleamyYzVZy56Ifd/8XGk
         S2PTwG9M84jAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2018 5:31 AM, Eduardo Valentin wrote:
> On Tue, Dec 18, 2018 at 11:35:54AM +0800, Zhang Rui wrote:
>> On =E4=BA=94, 2018-12-14 at 17:54 +0800, Wei Ni wrote:
>>> Hi Rui,
>>> I moved get_trend() patch https://lkml.org/lkml/2018/11/20/643 in
>>> this
>>> serial.
>>> Since no more comments on these patches, will you take them?
>>>
>> I think Eduardo will take care of this patch series.
>=20
> Yes, I will take a look on this series.
>=20
> But, please, next time you send a series of patches on thermal, copy the
> linux-pm@vger.kernel.org mailing list. This way we can track your
> patches on patchwork.

Sure, will do it.

Thanks.
Wei.

>=20
>>
>> thanks,
>> rui
>>> Thanks.
>>> Wei.
>>>
>>> On 14/12/2018 5:49 PM, Wei Ni wrote:
>>>>
>>>> This series fixed some issues for Tegra soctherm,
>>>> and add get_trend().
>>>>
>>>> Main changes from v5:
>>>> 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
>>>> into this serial.
>>>>
>>>> Main changes from v4:
>>>> 1. fixed for the parsing sensor id.
>>>> 2. keep warning for missing critical trips.
>>>>
>>>> Main changes from v3:
>>>> 1. updated codes for parsing sensor id, per Thierry's comments
>>>>
>>>> Main changes from v2:
>>>> 1. add codes to parse sensor id to avoid registration
>>>> failure.
>>>>
>>>> Main changes from v1:
>>>> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
>>>> "thermal: tegra: fix memory allocation".
>>>> 2. Print out the sensor name when register failed.
>>>> 2. Remove patch "thermal: tegra: fix coverity defect"
>>>>
>>>> Wei Ni (4):
>>>> =C2=A0 thermal: tegra: remove unnecessary warnings
>>>> =C2=A0 thermal: tegra: fix memory allocation
>>>> =C2=A0 thermal: tegra: parse sensor id before sensor register
>>>> =C2=A0 thermal: tegra: add get_trend ops
>>>>
>>>> =C2=A0drivers/thermal/tegra/soctherm.c | 85
>>>> +++++++++++++++++++++++++++++++++++++---
>>>> =C2=A01 file changed, 80 insertions(+), 5 deletions(-)
>>>>
