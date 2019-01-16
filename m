Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB17C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE40D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A4px1r/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403801AbfAPJYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:24:04 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8322 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391635AbfAPJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:24:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3ef8130000>; Wed, 16 Jan 2019 01:23:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Jan 2019 01:24:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Jan 2019 01:24:01 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 16 Jan
 2019 09:23:58 +0000
Subject: Re: [PATCH 4.9 00/16] 4.9.151-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190115154848.164648613@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <438d8109-fa21-c8b5-c7b1-3f730d0f5b90@nvidia.com>
Date:   Wed, 16 Jan 2019 09:23:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115154848.164648613@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547630611; bh=sBy1jHSIpct3i0ilmQf0Gp3o6pR82VMS6pKW0MkFLfg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A4px1r/KQJrpG8YuLaUhzyU1JqdjR3bRmrhW7ojgI/aU7IklrHExn4bbR5tOU4Khb
         bTgXwRu0ffnrORnhn9gPgBIPisejODyhicpBmjovuovcBwt5iNGVhLQ29HzHpoItdP
         dEoYAgXZlmoDwEff7Sfj3lt34mhSbMyYM/L/KDRKsp5NF0w2XLneg0BhUs9bSpXrxc
         Ja3r7nlIvHmkKf+Gz7TOjFKNvHi2JLsWlTLSb8PrCTzC+XW8NlL4jnjwVZgcvZ4i8r
         hCSW8qnj5UscwUSTGn1K8N0Vo1SASleKlyFPVVoFNMPj2SGnlfe3rgSNwdMSEM8AFT
         sWt54yqi6x95A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/01/2019 16:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.151 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:25 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
All tests are passing for Tegra ...

Test results for stable-v4.9:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.9.151-rc1-g1f10ba8
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
