Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AE8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9CE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RsIxt8yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9CE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeK1A1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:27:14 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8225 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeK1A1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:27:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bfd46b60000>; Tue, 27 Nov 2018 05:29:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 27 Nov 2018 05:29:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 27 Nov 2018 05:29:18 -0800
Received: from [10.26.11.97] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 27 Nov
 2018 13:29:15 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 4.4 00/70] 4.4.165-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181126105046.722096341@linuxfoundation.org>
Message-ID: <e41ee9fc-73f5-ff0c-e2d6-d23913c5581f@nvidia.com>
Date:   Tue, 27 Nov 2018 13:29:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543325367; bh=0pg0S814bx0/N6geUtnsxZeYVGohFUYVFe6auXsMdY0=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RsIxt8ySpQvVYXU1xG8RgurfCA7xXnEWLvr2nHD2WoZh6soJSRjiwDcf/d69unqoj
         +X5DRLaST9qqo2SuYKfJhi9pHxkBJHHx89WsDBbgNyjmLRLROZbPk1vKQekcP/aOmP
         ykQNCPHJtonLCjyJbb58yBdTWYSSlZdTCAvZuv4zEu2kks1AzRT1bYImzBSknf/MsJ
         NFPjlt/fk8DDHE4XRD+jqP9fp5WivZ7BpDl88BpObNTwhyMQaCIKjt8dGz8Z3eboZO
         yvhBaoHoRBfrx7i44gu3tX/5CrunkbZetTsSPc/5pyOCxMjWC1O11b1c1+woijWJCf
         gSe5hUT+ZIDfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/11/2018 10:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.165 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 28 10:50:16 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.165-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Looks like this has been updated to -rc2 now, but regardless, all tests
are passing for Tegra ...

Test results for stable-v4.4:
    6 builds:	6 pass, 0 fail
    12 boots:	12 pass, 0 fail
    12 tests:	12 pass, 0 fail

Linux version:	4.4.165-rc2-g4209bc7
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
