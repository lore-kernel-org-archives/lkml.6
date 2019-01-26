Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97805C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6454B218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j+M6F6d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfAZMIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:08:43 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11331 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:08:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4c4da50000>; Sat, 26 Jan 2019 04:08:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 26 Jan 2019 04:08:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 26 Jan 2019 04:08:42 -0800
Received: from [10.26.11.168] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 26 Jan
 2019 12:08:35 +0000
Subject: Re: [PATCH 4.14 00/63] 4.14.96-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190124190155.176570028@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3d03dd6f-bd66-3480-5120-19f108c69374@nvidia.com>
Date:   Sat, 26 Jan 2019 12:08:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548504485; bh=apLLv24Kb4DVrU3fGVLEzxE3DEC8U2/A76L3i7AWC88=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=j+M6F6d4paa6MV73KowDH/kJFFDlhD3Q2/Q+ol8t8/tAXhjcl3l5on94q1NbdFmLK
         iJMZdkM5+FMcl4x8d7s0Fa4niXmJdeWS7O0E6T53ognaeWt6/GWVCufLcyC+3rojhj
         Yq0H1Kxn9iMJ0JAqXZfmBPkmhB8A6i3YqtX/k8AKYxuBBNL1CzCUTxEEUovnXFHDx5
         yeCqAELiF/Ck9yc1VhIwSSjTaf944smuepGolySwTMCS4mkMgzroHPw91nDV6K+9jQ
         Ku8rdt9wyjhVU7U2E7PvhWu76oe3lxmbyHQytd9gB/92qOPNamrED+fP7TLKpiIg5p
         Pwg6atmSQ80LA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/01/2019 19:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.96 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:15 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
All tests are passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.14.96-rc1-g32c758d
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
