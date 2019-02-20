Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C171EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8935D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="c9V5t7rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfBTImW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:42:22 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9849 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTImW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:42:22 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6d12ec0000>; Wed, 20 Feb 2019 00:42:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 00:42:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 00:42:21 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 08:42:19 +0000
Subject: Re: [PATCH v7 0/3] Fixes for Tegra soctherm
To:     Zhang Rui <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <28d197f9-9b72-78ad-0769-7514d329b3c4@nvidia.com>
 <1c0af72c-b8d5-9b2d-7bc1-86a2ae85c819@nvidia.com>
 <df2493f3-4bbd-65d1-1205-073a30729a89@nvidia.com>
 <1550628841.3372.1.camel@intel.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <99723bba-61f9-ae2e-b3c0-408e021b2a97@nvidia.com>
Date:   Wed, 20 Feb 2019 16:42:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550628841.3372.1.camel@intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550652140; bh=RFgq633Qr2gPzNvG7eZsC6l6s3krJNswHsXUUuLkHXM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=c9V5t7rr6JP2Zbb/XkXHMXoxFUtCTaJQ98p3DM99KBlah7lWIBE0xKM2L3dc8Xu/a
         /pZmT0G2KS/xZV+0BgHpfKUBF1q0DKLHRrzsBjDaOcUN/1CUcMa83IUOo7tpLYjdos
         my5IfRGRZXx0rKZwDVIuG5iGCs3aDL6DSyHbMIdj9ZjwyxFbvqPLK5bPG9UybK4T9W
         wBLx93x/oOdwIyTWtSxvkMvLi0+bTqiVRmKVSzX5m8K9PACBzjwDu+a57yzxUOa/4h
         xERiqMspbDIuhl4SEfCG0gWg0wCbtCgTqk1A7xQvMOCDU1grE0+q68TbwWQ4gykEO7
         Y6snMKEO6BVsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/2/2019 10:14 AM, Zhang Rui wrote:
> On =E4=B8=80, 2019-02-18 at 15:59 +0800, Wei Ni wrote:
>> Rui,
>> Will you take this serial?
>>
> it is already in my tree.
> I missed -rc6, thus I will queue them for 5.1-rc1.

Thanks.
I updated v8 patch per Daniel Lezcano's comment.
Please check it.

Wei.

>=20
> thanks,
> rui
>=20
>> Thanks.
>> Wei.
>>
>> On 21/1/2019 5:17 PM, Wei Ni wrote:
>>>
>>> Does there have any comments?
>>>
>>> Thanks.
>>> Wei.
>>>
>>> On 11/1/2019 10:20 AM, Wei Ni wrote:
>>>>
>>>> Hi Eduardo,
>>>> Do you have any more comments, will you take this serial?
>>>>
>>>> Thanks.
>>>> Wei.
>>>>
>>>> On 3/1/2019 6:12 PM, Wei Ni wrote:
>>>>>
>>>>> This series fixed some issues for Tegra soctherm,
>>>>> and add get_trend().
>>>>>
>>>>> Main changes from v6:
>>>>> 1. Per Eduardo's comment, we can remove the change:
>>>>> "thermal: tegra: parse sensor id before sensor register"
>>>>>
>>>>> Main changes from v5:
>>>>> 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/
>>>>> 643
>>>>> into this serial.
>>>>>
>>>>> Main changes from v4:
>>>>> 1. fixed for the parsing sensor id.
>>>>> 2. keep warning for missing critical trips.
>>>>>
>>>>> Main changes from v3:
>>>>> 1. updated codes for parsing sensor id, per Thierry's comments
>>>>>
>>>>> Main changes from v2:
>>>>> 1. add codes to parse sensor id to avoid registration
>>>>> failure.
>>>>>
>>>>> Main changes from v1:
>>>>> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
>>>>> "thermal: tegra: fix memory allocation".
>>>>> 2. Print out the sensor name when register failed.
>>>>> 2. Remove patch "thermal: tegra: fix coverity defect"
>>>>>
>>>>> Wei Ni (3):
>>>>> =C2=A0 thermal: tegra: remove unnecessary warnings
>>>>> =C2=A0 thermal: tegra: fix memory allocation
>>>>> =C2=A0 thermal: tegra: add get_trend ops
>>>>>
>>>>> =C2=A0drivers/thermal/tegra/soctherm.c | 40
>>>>> +++++++++++++++++++++++++++++++++++++---
>>>>> =C2=A01 file changed, 37 insertions(+), 3 deletions(-)
>>>>>
