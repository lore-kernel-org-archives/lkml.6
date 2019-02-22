Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D548C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED97E20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kV7p4zSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfBVIMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:12:42 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1700 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:12:42 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6faf020000>; Fri, 22 Feb 2019 00:12:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2019 00:12:41 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Feb 2019 00:12:41 -0800
Received: from [10.26.11.239] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 08:12:37 +0000
Subject: Re: [PATCH 4.4 00/20] 4.4.176-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190221141946.772985220@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b8e390cf-0331-ac32-4ff3-8b2efb303162@nvidia.com>
Date:   Fri, 22 Feb 2019 08:12:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221141946.772985220@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550823170; bh=b1/QgfMQDNX+pGJHKG9XpJcK2l19G+IbystAktEx0uM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kV7p4zSRoCuxRD0lC4llQgsMd5U77OBElMx1jsfB7d19dGBD+O8eVFDjsDBLoqX/X
         dKNtBP4+8/LNrLhSqOsfUJujUCwIkgcS98Fyz55chYyud8W5ZXKAe9OOto1BBo0AZx
         4DP7sVkbeRzRu1RIZcE6Q3IkJ+S8ZiZ5FE3P3I6kT6tMeyhqa1UW3wmNjhtHL6SF/I
         lXGZOgrYUgcGTg5bFqJf1jN5VGSiVZYcpgzUJ+d9r/pI+HFWu2fVug0JY850fpt8AF
         TfcGyuHpEK2qYMVOawI9HceLRmXW3/VfYN5bRH2Cwn/VJWZR20DE4yaITBXdYz3RyQ
         bGg13MPvrBYrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/02/2019 14:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.176 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 14:19:37 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
All tests are passing for Tegra ...

Test results for stable-v4.4:
    6 builds:	6 pass, 0 fail
    12 boots:	12 pass, 0 fail
    10 tests:	10 pass, 0 fail

Linux version:	4.4.176-rc1-g451afda
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
