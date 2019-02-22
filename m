Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C792086D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r0tL7qmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfBVINW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:13:22 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1747 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVINU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:13:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6faf280000>; Fri, 22 Feb 2019 00:13:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Feb 2019 00:13:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Feb 2019 00:13:20 -0800
Received: from [10.26.11.239] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 22 Feb
 2019 08:13:15 +0000
Subject: Re: [PATCH 4.9 00/20] 4.9.160-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190221125242.153179182@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d3aa37c6-4e4a-e3b9-ad8a-626e3f228e69@nvidia.com>
Date:   Fri, 22 Feb 2019 08:13:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221125242.153179182@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550823208; bh=yBeXdiC1PrZ7f4oRTMSuQTsOHwY0j1KoUv2kOoNGhfk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=r0tL7qmcDF9yKlRtoDAWym6zV2e8zEvU1KZ6k9AknwTDGpoiiFjts5BP9MDEhhHae
         0369fBg7nSKE9zF8ru64KdqFSDWl4gEwJiU2A8wXv7g/wxbka/e9orXmZVrZqYLYqM
         kbJTLshdOEKS7WuxJSuepGc1M/yFBJNFtLt9R261prCrcd+6PVpVQ5Z9Jbik5q++yS
         JTet3Hfi4bTFCVVlu3pdH9ac1XBmCElsnnjG1dBGcdWTELWnUckty9dNx9+KdJUPVA
         izSsZNf08dsXgi+dGlatQAJxAB6kbSFOt+ma4dxua1kpoBUQEtKfm2g1bouFR70W32
         y4vla8C2Gu4AQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/02/2019 14:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.160 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:16 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.160-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
All tests are passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.9.160-rc1-g53ba7e5
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
