Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0871EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDC821738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BLvuPrKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfBSJb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:31:29 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16327 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfBSJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:31:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6bccf70000>; Tue, 19 Feb 2019 01:31:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 Feb 2019 01:31:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 Feb 2019 01:31:28 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Feb
 2019 09:31:25 +0000
Subject: Re: [PATCH 4.9 00/58] 4.9.159-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190218133508.567416115@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <eef6ee27-85c4-dc40-9525-d0d6be6ac14b@nvidia.com>
Date:   Tue, 19 Feb 2019 09:31:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550568695; bh=SjeE0AhZE8YOHd3z/e6OKB3Ts7UFuCWADeDuoQG1Hfs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BLvuPrKL7NwlBusQuRwaKycRuKK9bh1jE1SeCt0eHMiQSozIV34Y6dzZnxFtFrSgX
         wIag4eqeG6Hh5149UARo5k6fjnkXpmtsyJ/ecB9q46MKzZkHyJfcfh2HABjFfvK19i
         yQ1JZX9NFaGUwRd6DVjIIoF2rsy7wC3D7sNyy4txwQ1mqMWNd7Unlt8+Nu/fRSpfTm
         /PdZARAOlPTi8OAoR5ghzyJVHdbaq7VI+F31yu0gwRw2OfQCoG1MdUNm09K4dyOVyX
         1qvilR+OIKetuyxJcQEp83mreSYlB+VHccPfzYJDPKVYlFwYdZtPzrveT3300Z5ZBf
         S81kXHl4pir7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/02/2019 13:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.159 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 20 13:34:40 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.159-rc1.gz
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

Linux version:	4.9.159-rc1-gfe5f19a
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
