Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1154020844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DBErMbCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfBELiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:38:20 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9697 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfBELiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:38:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c59758a0002>; Tue, 05 Feb 2019 03:37:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 03:38:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Feb 2019 03:38:17 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 11:38:15 +0000
Subject: Re: [PATCH 4.9 00/30] 4.9.155-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20190204103605.271746870@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3b4f09d6-3b9f-5bf6-dc87-b8bc000ff537@nvidia.com>
Date:   Tue, 5 Feb 2019 11:38:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549366667; bh=FHO5nSMvZbxaIh1/+DTKi6sy79KxE6Er/6RXmp/hCb0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DBErMbCiFiG6nqrid7Ftu8aI1cbK3Pq0WRSnZiwtCbQhxIBGDmXpo+bgQgwZUfjhN
         /m+iiuHSrfji8gT1Jmk0j1oS5EZvtsO/D/KjSjBzQ+BkrYFLpn7IKxiY0wxkMxiehy
         kvKId/yaSP2ivdLXI2MShWAnM5tcOChva1jnSfPt2gh2bIay8PIgel21ydxBJYr+Gi
         wefSbA0Tbjj17hiugFV+wxBGoYgwOM33OoneRbj5Y6Yg0n2a0S9+3fb4TIhO2POVVo
         1C0zLDZGgWncxXfC7tzHsafFzj7Ekrp6GPUIqiWQabFeLWSC8hLNPXr6yU7Z+4hKGW
         fymFsc+i1xcYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/02/2019 10:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.155 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:37 UTC 2019.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.155-rc1.gz
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

Linux version:	4.9.155-rc1-g09c6f7d
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
