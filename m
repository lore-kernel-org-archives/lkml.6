Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6812C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4942082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MQtyTEsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4942082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeJDTgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:36:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19593 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeJDTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:36:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb60aaf0000>; Thu, 04 Oct 2018 05:42:25 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Oct 2018 05:42:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Oct 2018 05:42:54 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 4 Oct
 2018 12:42:50 +0000
Subject: Re: [PATCH 4.14 000/137] 4.14.74-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181002132458.446916963@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <424795e5-7ef6-63ff-7908-babf1b34ff58@nvidia.com>
Date:   Thu, 4 Oct 2018 13:42:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538656945; bh=t1j9cp2gJSEIc4p9W9AqPZXZHVbTvrk5e7dP0fvCkKg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=MQtyTEsj6fxUSOdEhBgYSL3yi80lG8cMoiPAMsyVwqjhItakGvDMWO6yAoMLb7EyB
         vG6Wj2RT3dh6GtsuQkH1E1w6J1iL5bSr4t4DHU4qOHk50/LWviNiEFHGl7suy8Ggs9
         9b1CDDcpi1BEob4LhnoiBMAgK+fYOS8nQN4Jc4aN+TQUlKdDTTMAlrBH+ft0jsiEpL
         z3+hiFr5gjCx4ccuclcx3i7ltTUDZ9D85a7wFQillGuCqfP5uGEWcERY9d06fN4VG8
         0sjh8DUxwX333H2l9Ixk7zuCJMH4MxWIzi49ENmRNsYRG3xQm29OUr4pQoYbQvoE99
         HYj3+gBUV8DXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/10/18 14:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.74 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:18 UTC 2018.
> Anything received after that time might be too late.

All tests are passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    8 boots:	8 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version: 4.14.74-rc1-g3fa7781
Boards tested: tegra124-jetson-tk1, tegra20-ventana,
               tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
