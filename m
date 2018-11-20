Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0CAC04EBB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4482087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O2vN0PH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4482087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeKTVVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:21:37 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18512 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbeKTVVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:21:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3e79a0000>; Tue, 20 Nov 2018 02:53:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 02:53:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 02:53:05 -0800
Received: from [10.26.11.164] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 10:53:01 +0000
Subject: Re: [PATCH 4.4 000/160] 4.4.164-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181119162630.031306128@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a8263b72-850e-2add-ea0c-4949cb458865@nvidia.com>
Date:   Tue, 20 Nov 2018 10:52:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542711194; bh=CjSU76L2+K5rDu66ccKvoVcxXa9FS6MMcGTn6am7VMs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=O2vN0PH9O2aRn5ME/COp7ATpC84RRHODupvn7J4yQyeWmbu9baa0nvqGDsr7zwA0b
         xWdM2cuHLawOoIfFWb/BO3RuPUITlR662nHxwbqoGpK7y1uSsTSLjIJ/rMLyFvr2nF
         4FvO0B8Rgxj1Y5PdQ9YWVopLiSDhjgr1R0Px9vU7V39sVCotHc5ckkj8cQ2OISDNys
         mjHDBcR4ltFMGSuTxEEK3aEQHxdklkCv+NkLt6TvrQyJDsc4/U+fdzi/pMG9qCTvB5
         raT5Zm6uCVOqsSPC6QGElpe1p17RnQ8D5cRm30iDKfV8gvH6QyxBpPtbl7HrpG0bIn
         MNE+bwGGzvkNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/11/2018 16:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.164 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 21 16:25:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.164-rc1.gz
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

Linux version:	4.4.164-rc1-g6c17c03
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
