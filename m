Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0645BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA44B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mgo7nYPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfAWJHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:07:39 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9387 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWJHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:07:38 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c482ec10000>; Wed, 23 Jan 2019 01:07:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 23 Jan 2019 01:07:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 23 Jan 2019 01:07:37 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 23 Jan
 2019 09:07:35 +0000
Subject: Re: [PATCH 4.14 00/59] 4.14.95-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>
References: <20190121122456.529172919@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <514faa89-bfed-1741-3a93-930f20177259@nvidia.com>
Date:   Wed, 23 Jan 2019 09:07:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548234433; bh=5mXLkBjwHAod2aXk8RxXfpH1eelEH/FpwZQV6nSbynE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mgo7nYPcE5vCGkRugWf3hgsT8KRH20BoORiuygR1Pz1S7FMWBXe9gJnjs53JGm/Iw
         j39zcn2NK3rK+encz9ahYClzFkri65NDfa1OebZoGpc+HlwgzWjZRjxHp6mxvLuDMK
         dbnkpsJ5opj+0FhDfyc+SIieQIxikHVUBq13kAc6vqf6xgpnTQhuidTQ+v4sl/yAyA
         32I/dnVIaIdADafPnswNw4l1A9OcJRbSWnH2BSaUNIV8SfvGdfw1sD6l7FFwUh0Fpd
         pFyStx7LoFvXW8EdvDbWnc9XRpqR3OAyOIEZ+vv15QVy9HChKSo/F5ESGM9VjOQZGL
         KN57WwGS8/OvA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/01/2019 13:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.95 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jan 23 12:23:55 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.95-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
All tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.14.95-rc1-gb18179b9
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
