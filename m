Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C065FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4832206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="iPwEJ/ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4832206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeLEJaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:30:23 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14387 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEJaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:30:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c079aa90000>; Wed, 05 Dec 2018 01:30:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Dec 2018 01:30:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Dec 2018 01:30:21 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 09:30:19 +0000
Subject: Re: [PATCH 4.9 00/50] 4.9.143-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181204103714.485546262@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2b42720e-5ea5-9655-2dfe-2fc6926b4092@nvidia.com>
Date:   Wed, 5 Dec 2018 09:30:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544002217; bh=27ikz3H0p8m+rsxLIAI7F01LTBejpoFH42Z/HVNG6YQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=iPwEJ/ejkJCLZnEJQoCgeCiu9sG3CNIYpOdIfSrhVmu7EKL7S3uhQpxYecKANH1R8
         L7rSVPyR+auAkXN2X0yFobnfq9Wqdavt0VVyyUR9ANtFgKEC1neYtZR9k1qZbeXUqA
         C8VaYHegNxPt6LNPBxc4z4rHttVyIwarUdf/T8qt0yI3/hQuDceZgkGnHryRvcfupR
         ZYB960hIvMk+eyatg+Ny1XzSbJkn8IPLUTYgm0PYO73UOkzRQbcoRDYr0ofI1a4riD
         Rf/5Yf9oT7RCe/kHEAu/DX626tgUl93ainm1lWEMpUOkznygfIX1BtHb04nI7MqZC7
         sMB0OSWQL9O9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/12/2018 10:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.143 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Dec  6 10:36:59 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.143-rc1.gz
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

Linux version:	4.9.143-rc1-gd453b65
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
