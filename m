Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4C9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856F2205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bzh8smSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856F2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503079AbeKWUm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:42:59 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13199 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbeKWUm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:42:58 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf7cf650000>; Fri, 23 Nov 2018 01:59:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 23 Nov 2018 01:59:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 23 Nov 2018 01:59:23 -0800
Received: from [10.26.11.175] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 23 Nov
 2018 09:59:20 +0000
Subject: Re: [PATCH 4.14 00/21] 4.14.83-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181121183422.103826775@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c9502514-6533-f7ed-4111-f46501e237ab@nvidia.com>
Date:   Fri, 23 Nov 2018 09:59:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542967141; bh=D54gnBtAiJqgAr6UPcoJiSRFE2lRq3dZAuRlg/lO87E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bzh8smSDG7AlNKMRVvPAgVThtYZY6iW9lVRhL5k1oyiPqCCa4eW2XW8GoQvsXz130
         k29xUZ+qk33LT2XjdGvuwARvz81HfMvV+Fu1tAN7ye0e/nDJf8eC8Ts79LVMYsuwbr
         /ov9jV4x2TaMkY4XdMGVZdahEqeszedluqCF3fcGipv8ucXqpryJZeSIRJnGuyp1mM
         H4J/+1raKZDIUefGtWGGqAtoa1OAu0wcA9hH+Eb1ivxkYbPPOJEewlXH43KRz88m1T
         dkqujK+jyVoxJd8xPG+8dZISwCYtx3YwtEk1UN04ge+UwoqPqBOQ3Kr01UdC+siebY
         kCCgtfHqZqkwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/11/2018 19:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.83 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Nov 23 18:34:13 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.83-rc1.gz
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

Linux version:	4.14.83-rc1-gaa2838d
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
