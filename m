Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0344AC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1503218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XIgVHiQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfAZMHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:07:31 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14860 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZMHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:07:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4c4d810000>; Sat, 26 Jan 2019 04:07:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 26 Jan 2019 04:07:29 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 26 Jan 2019 04:07:29 -0800
Received: from [10.26.11.168] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 26 Jan
 2019 12:07:26 +0000
Subject: Re: [PATCH 4.9 00/39] 4.9.153-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190124190448.232316246@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <371eae2c-ecad-dda1-2404-b09fe93b8c6b@nvidia.com>
Date:   Sat, 26 Jan 2019 12:07:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548504449; bh=H54ZHDaqbYsKn+M5ALX9Sx3kQq6b2SRx8mQjGmVKqxA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XIgVHiQXeu7vFAlDXbO2IzUu24s4Lx7pmjqjafJDI1Ti5MV9gTsgCHjrVESzSATm1
         XJfKwq8gJGgpDh9z1zhtK7LkHuGcZaVT/OzaiiDAGbXCUtGnwK0p10yJf1mC5DyKDB
         W+gYxJjQqD8uVq8E9yD/vS14GbgJXjR9V6wNyEjHaeYRZ5Q5bI4QoOVr0DW1tTBSbT
         nj4fNIh2pqQxqMy1bmqDqrejagjZwOndwllFoPqUS6m8Lu0hzxtSouxNIZ6eKeyJhI
         ASowPDG98Q6CFHxkQrm2vSYbxl+gVg5QlqocCvoxFTo3nRCk6VQWnTI3mzNqTmJgKw
         mNluXu/lMCSRg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/01/2019 19:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.153 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:04:38 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.153-rc1.gz
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

Linux version:	4.9.153-rc1-gc5e65ad
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
