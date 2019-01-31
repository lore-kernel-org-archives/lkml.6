Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EA2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666C2218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Seqp0enQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfAaKPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:15:43 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13899 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAaKPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:15:43 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c52cab20000>; Thu, 31 Jan 2019 02:15:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 02:15:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 31 Jan 2019 02:15:42 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 10:15:39 +0000
Subject: Re: [PATCH 4.9 00/44] 4.9.154-stable review
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190129113139.826927690@linuxfoundation.org>
 <f2d2a32f-68c9-8bfe-54c7-93b617ee2eb3@nvidia.com>
Message-ID: <28e5a819-1cce-c255-2db5-229a5bbd5f60@nvidia.com>
Date:   Thu, 31 Jan 2019 10:15:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f2d2a32f-68c9-8bfe-54c7-93b617ee2eb3@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548929714; bh=m3uf1dO5OIlZr2BhTKLMOm5YlkIp8/MbxBCxLd/RRp0=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Seqp0enQb0IzMhAA2mIk00NjQZjBiiIWn3XI8twBn9S+m2lDdDJnLz+bRESGoJWzH
         JzuEvaRkk9ERNFdLhhHigj4+6hbjc/tCXjA993txGZQzo+wfQkDH/ffsGAzu83itOK
         90m4QjfD0d5ZwMyYayhyXYiDpo0CpNdkMy3ERC976lz55V497t7L/dHe1ir/5XGFVm
         rC5I/Z8RPhAdIj010pMTkqkAkauKzLY4x7eXStNjq4B3wo3lnE4+y7PCT4cIvc+Hut
         3FGZHyEikgN8ZwkUMl6LF/uP+ro4acJZdpulKSFIyNbCNuhOLaFk8N4JEuQR1g8Zpe
         D0tZIaueQeEGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/01/2019 12:50, Jon Hunter wrote:
> 
> On 29/01/2019 11:35, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.9.154 release.
>> There are 44 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Jan 31 11:31:22 UTC 2019.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.154-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> I see you have posted a rc2, but for rc1 all tests are passing for
> Tegra. Should have results for rc2 tonight.
> 
> Test results for stable-v4.9:
>     8 builds:	8 pass, 0 fail
>     16 boots:	16 pass, 0 fail
>     14 tests:	14 pass, 0 fail
> 
> Linux version:	4.9.154-rc1-g5c2f707
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

To confirm, rc2 looks fine as well ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.9.154-rc2-g6674590
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
