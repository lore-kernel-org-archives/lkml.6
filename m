Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF37C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D3520834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gqqYZg1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D3520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLCLi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:38:58 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17184 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLCLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:38:58 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c0515a80000>; Mon, 03 Dec 2018 03:38:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Dec 2018 03:38:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Dec 2018 03:38:16 -0800
Received: from [10.26.11.194] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 3 Dec
 2018 11:38:13 +0000
Subject: Re: [PATCH 4.14 000/100] 4.14.85-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181129140058.768942700@linuxfoundation.org>
 <20181130152948.GB31416@kroah.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b5b29547-b091-b29f-55c2-7729d7ada10f@nvidia.com>
Date:   Mon, 3 Dec 2018 11:38:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130152948.GB31416@kroah.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543837096; bh=YRc8QonKLQrAiP3+2XS7X9tF97F1DDpztGTd7mpiBvc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gqqYZg1VJn52lYH48AxzlmK32Q5g30k6mVrL7+MCp3l4XYihZLFEBxBSJAa2iUOGR
         BOyY+PhS0bQaLnV3gQWI4GSU8MMP6eW5Xesd3bXEIk0mV2NvekDCPfuirWnPbtbDV2
         pO9IDxcVdQmy8ZlSKg1UTeSL1oqKucgYwe9MnaWcGcTYYSuOIbxzLrdVfrF1vqm568
         auzv9ohLLZ7/L0cbgz/PE3YV0xmCCPUF/SaxWt3WiUWyAL2t4aCLgwhmuD2Ts01sHv
         nSmAG7CkdvVj4y7uVoR8YcchcutKUp6b0fZusRHQXLG2fz0xr+V78rv2pjCmXLaSth
         ods0e/ue5kxDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/11/2018 15:29, Greg Kroah-Hartman wrote:
> On Thu, Nov 29, 2018 at 03:11:30PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.14.85 release.
>> There are 100 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat Dec  1 14:00:29 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.85-rc1.gz
> 
> I have released a -rc2:
> 	ttps://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.85-rc2.gz
> to resolve some reported issues.

Sorry this is late, but all tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.14.85-rc2-gce3bc71
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
