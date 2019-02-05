Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AAAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6200E2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ORx0Bhyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfBEKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:17:49 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2784 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfBEKRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:17:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5962ad0000>; Tue, 05 Feb 2019 02:17:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 02:17:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Feb 2019 02:17:48 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 10:17:46 +0000
Subject: Re: [PATCH 4.4 00/65] 4.4.173-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190204103610.583715954@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <c14f4932-b62f-9767-c684-9ca71fe6c87a@nvidia.com>
Date:   Tue, 5 Feb 2019 10:17:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549361837; bh=5hU7mMusxBRolnPK3uQuWtJCiK8cNaSSmtOHR05hpsQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ORx0BhycQzvIZTiB1KEvQYq/Wm+Tqi5K1svdqILUOMpViA2vVMY5k9ICsitee0VAS
         z3Tss6s2m8AFKN7s7nkLek/xF4sZzrGZxZDj4BSnzt0a0/IUVw8OxsiYuasrCNnHCX
         jFU4p4XFnQdULkmf/Zybax8wH6aZCgHzfhADJQZqQ5B7pNKRyk0ca/BckF1iNkVpAv
         jBiMnV8yoRj+5cSlYygvSvKyRaKU9kz5jSNm0zAYGg/y1y9KxPh1NvBVdyez7ARadT
         8XewOsYR3/uoIKyZ1kViISb72VL5bH4DowpMedpwwuhKTB22IeVMmRmREkz8LL8xcO
         egH8NCac1+vCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/02/2019 10:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.173 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:30 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.173-rc1.gz
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

Linux version:	4.4.173-rc2-g256c5e4
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon
-- 
nvpublic
