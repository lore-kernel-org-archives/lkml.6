Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A7C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137CC21773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iDCa5/2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfAIKqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:46:50 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11791 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfAIKqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:46:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c35d1080000>; Wed, 09 Jan 2019 02:46:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 02:46:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Jan 2019 02:46:49 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Jan
 2019 10:46:46 +0000
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190107105330.280153213@linuxfoundation.org>
 <20190108121822.GB3884@kroah.com> <20190108121925.GD3884@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5fafb2d8-04db-4a9f-0af6-1b1aa014da80@nvidia.com>
Date:   Wed, 9 Jan 2019 10:46:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108121925.GD3884@kroah.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547030792; bh=FjNUAigK5aXB33qYkWqwhdTOtDu7dR8QOGXgqgJ5iNY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iDCa5/2I6dlalT9QV5CVMBZJZLQ24R7+36E8n+nqIphlMImPuXbgB5om/jghDyB69
         aAgJgaHr4nVtF+tws+VZqsLzCEjh53ttjmP5RopuOAoQGF5IJLcAl9/ncQ7diWNQOi
         xrnrq+nWIrifXtzxZAlHmT76XqLSN+Ag/OBnskJfk9IGSs6LUSwge32woK6J/M+kBT
         Vd4ZJJ2/hkmCxPTSAVRec7ewlaVsYAqJpWwqndn3muA5DhuinpdzKVX2pwdYmTrjBP
         YExv+G2k1otuiCzhUiGDKcNwPoK11/WDrfSEnbrlaXL05Kve94QTche37M1oD4xPKa
         znqmsidCK9dYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/01/2019 12:19, Greg Kroah-Hartman wrote:
> On Tue, Jan 08, 2019 at 01:18:22PM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Jan 07, 2019 at 01:32:29PM +0100, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.9.149 release.
>>> There are 71 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed Jan  9 10:53:04 UTC 2019.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc1.gz
>>
>> -rc4 is now out, hopefully this is the last one...
>>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc1.gz
> 
> And here's the real url:
> 
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.149-rc4.gz

All tests are passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.9.149-rc4-g8af94cd
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
