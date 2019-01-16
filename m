Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B023A20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Uafgb3GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfAPRij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:38:39 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9001 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAPRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:38:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3f6c0f0000>; Wed, 16 Jan 2019 09:38:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Jan 2019 09:38:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Jan 2019 09:38:38 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 16 Jan
 2019 17:38:36 +0000
Subject: Re: [PATCH 4.14 00/27] 4.14.94-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <akpm@linux-foundation.org>, <linux@roeck-us.net>,
        <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190115154901.189747728@linuxfoundation.org>
 <794339d5-a1f8-7ae1-8c8c-fbef141cc81d@nvidia.com>
 <20190116160252.GB4594@kroah.com>
 <26826b67-6a6b-dc79-84de-4ce48212203e@nvidia.com>
 <20190116171153.GA10164@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f2e8bd8a-90f1-c7a8-1157-36e9c19eb384@nvidia.com>
Date:   Wed, 16 Jan 2019 17:38:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116171153.GA10164@kroah.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547660303; bh=9gK63o23a8wLRyIDSybeS24Dy1YXF1g47573fwHKKZs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Uafgb3GQFWFkEk14u7l6vFwQ80VJW9Rk/nY4NLwo+X6dWVz7DipYQeH1KthgXDIsG
         3KdaQD5lkW+Yi/2q3yWJOE2iApGHxAzz1XJli3NVenoLYnGi1/tY4ds2doczrB+1up
         alDOM42plHyXk3+R/TfhtFOyi2zP21387wiklDD/Rvb+IXFbRCJ8cEqEp5Q5GI1glw
         bcv9LumJ2H4Bdr43AOjeaHL4kxQ5XsFEqxBtYKVg7WBCRNzZCDPn7U4tX0SIATYQ3N
         8AaafOXTJn/i2nJigKgAOAn70OtzrPD9jFAIYn74rq7nMtd2HDZJw1IBb51krrkztf
         UKmrMzzU98l4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/01/2019 17:11, Greg Kroah-Hartman wrote:
> On Wed, Jan 16, 2019 at 04:56:08PM +0000, Jon Hunter wrote:
>>
>> On 16/01/2019 16:02, Greg Kroah-Hartman wrote:
>>> On Wed, Jan 16, 2019 at 09:25:12AM +0000, Jon Hunter wrote:
>>>>
>>>> On 15/01/2019 16:35, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 4.14.94 release.
>>>>> There are 27 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Thu Jan 17 15:48:28 UTC 2019.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.94-rc1.gz
>>>>> or in the git tree and branch at:
>>>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
>>>>> and the diffstat can be found below.
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>> All tests are passing for Tegra ...
>>>>
>>>> Test results for stable-v4.14:
>>>>     8 builds:	8 pass, 0 fail
>>>>     16 boots:	16 pass, 0 fail
>>>>     14 tests:	14 pass, 0 fail
>>>>
>>>> Linux version:	4.14.94-rc1-gec31b1a
>>>> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>>>>                 tegra210-p2371-2180, tegra30-cardhu-a04
>>>
>>> Thanks for testing two of these.
>>>
>>> How about 4.19 and 4.20?  Does modern kernels work on this hardware as
>>> well?  :)
>>
>> We are not that advanced yet ;-)
> 
> So not everything for those platforms is upstream?  :(

No sorry! I really was joking. We have enough upstream to test all these
platforms (plus a couple more) today :-)

>> Only joking, absolutely and in fact we have more devices/boards
>> supported in newer kernels so it would make sense. We are also testing
>> mainline and -next.
>>
>> Unfortunately, it is a bit of a process to add new branches at the
>> moment simply because we are piggy backing on existing infrastructure
>> for testing that I personally do not own and so it needs to be approved.
>> However, nonetheless it is doable.
>>
>> We were talking about adding v4.19 and then v4.20 popped up. I am not
>> sure if you have any ideas yet about the EOL for v4.20? I was just
>> wondering if we should prioritise v4.20 now over v4.19?
> 
> I was just curious, if everything was upstream (like the boards that
> linaro tests for), then running 4.19 should be just the same as 4.20.
> But if you have big out-of-tree patchsets, that's a totally different
> story.

Yes testing stable-v4.19/v4.20 is straight forward and will work today.
I just need to go through the process of setting it up and requesting
this. However, while you were asking, I was curious if you had any idea
of the projected EOL for stable-v4.20 yet?

Cheers!
Jon

-- 
nvpublic
