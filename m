Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCACC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4516920883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jKe6fte8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfAIKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:47:49 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11869 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfAIKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:47:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c35d1430001>; Wed, 09 Jan 2019 02:47:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 02:47:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Jan 2019 02:47:48 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Jan
 2019 10:47:45 +0000
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190107105330.372621917@linuxfoundation.org>
 <20190108121905.GC3884@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c146718b-5fbc-aff5-9236-54037234bf88@nvidia.com>
Date:   Wed, 9 Jan 2019 10:47:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108121905.GC3884@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547030851; bh=q8AapqPTxAPvsg6ENx6SVkXViivykNfMHeAchfZ0r+0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jKe6fte8n4luSsflUO0BMwlj0zdLNA9MYh1TDXNwOIkSCdR87XbyWdt2xyWI2QUnh
         A2GHwW/2D1KO8Rm/DJwc99qwatRv8P8z2vQDv/5V3HHhXkDASd7nCQKUQR0ipb05Gq
         SsTyGQNK+oPQIvH2X6c7P1xR3GvUpp1N69TW5BkCX1QAxgb4XjWRUlch9J8+QSwC24
         F0xMwlMwN12U9k8MxLARRDNouLU7ub52yqJZ7i1o33Um+PyJWSD/0GdOW+dUW9eLPv
         y60xhtgxqXIvBUrDWGyKJyGVkD9mGVOuuWipOyeGOSrU2fR9Ms24L6siM1qZ/Xagx0
         PnnixoIKqhUwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/01/2019 12:19, Greg Kroah-Hartman wrote:
> On Mon, Jan 07, 2019 at 01:31:48PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.14.92 release.
>> There are 101 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc1.gz
> 
> -rc3 is out to hopefully fix the last reported build issue:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc3.gz

All tests are passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.14.92-rc3-gd679908
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
