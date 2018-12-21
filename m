Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB588C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B11218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r+J7yOja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbeLUJ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:27:13 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18664 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbeLUJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:27:12 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1cb1e90000>; Fri, 21 Dec 2018 01:27:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Dec 2018 01:27:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Dec 2018 01:27:12 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 09:27:09 +0000
Subject: Re: [PATCH 4.14 00/72] 4.14.90-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181220085922.332225035@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <bb824156-2a6c-ab70-a685-ce7ac2ff63e5@nvidia.com>
Date:   Fri, 21 Dec 2018 09:27:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545384425; bh=h1zvMm1xTgwP9s0btvo6N/xrS7w8O7/W+wrDj3wWP6A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=r+J7yOjavl5GjuD/JSXlaG201Wtodc7C2u8aa2wov8pnMnJWF2FNWUPbzRZAZKIzM
         Kh6JY5UOHneSRzGcVpoxhPw9O3a+aiHFbI0MmbLzIV7buWAPLamM/h4lACHX4EWQoY
         pPHuEUiqy4lAGqgizPlv0c3GOzn7AQvkZa+XVk+DbZ2FXKI8gXoN780eoXnE84u++7
         NoHTCj1uxYvy6Aw73djx2SWaRgmhgYQ2JZyO5aW6EMcCfjecY/rTMfJAQBfH8OCDXg
         5yAJ+ZYqh69/fJT2LGAybMYfQlKi1i61n3HXnOXq11UTLEBFx90RQ6BFPKrKFUMPAu
         CKYamtSuFmbEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/12/2018 09:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.90 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:59:06 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.90-rc1.gz
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

Linux version:	4.14.90-rc1-gdafc7cb
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
