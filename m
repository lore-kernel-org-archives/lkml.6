Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C365DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9240521906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b2ftWzVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbeLUJZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:25:44 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18475 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731852AbeLUJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:25:43 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1cb1900000>; Fri, 21 Dec 2018 01:25:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Dec 2018 01:25:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Dec 2018 01:25:43 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Dec
 2018 09:25:40 +0000
Subject: Re: [PATCH 4.9 00/61] 4.9.147-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181220085843.743900603@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <979c4bfa-6eeb-6629-9aa8-ebe6dece471a@nvidia.com>
Date:   Fri, 21 Dec 2018 09:25:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545384336; bh=rOi/f6QDwfx1synMmky5WY6/wDjTf/JSuHeaA80gAW4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=b2ftWzVWWZ8lGfQBxuYa9SW4+sUcVJtOrHYRvnrhR7q/qKctavNddL767U+jAP/bC
         s9M7xNpG4SEBX7lOjaAOBUHEvW8uOSr3ljvQHto1zRHIXpFQqtdWYUUbzzgR3/F6AS
         9wlQ25fIJp/Ehsowq32axRsiaksXuQD5Kk/3GnC54NHVixKVqZgy378aaJvGpBune4
         dPOMNJacodikU1K+nNXutwBivGUhbR1EST4gJv79C9Gxpfz9kdvs3PiBhMiL1smAV1
         Tfr+buH1yZGELxWqQFEob3iej1ssdMnymTGCEqJa6kVaZ+5TieKxY34Xzv1/cctax+
         ODBcoCJz/rGkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/12/2018 09:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.147 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec 22 08:58:31 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.147-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
All tests passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.9.147-rc1-g2758b13
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon
-- 
nvpublic
