Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6EC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D311A2064E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n1wuq0k+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D311A2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeJVVWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:22:25 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9766 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVVWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:22:24 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bcdcab10000>; Mon, 22 Oct 2018 06:03:45 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Oct 2018 06:03:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 22 Oct 2018 06:03:54 -0700
Received: from [10.26.11.135] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Oct
 2018 13:03:52 +0000
Subject: Re: [PATCH 4.14 00/41] 4.14.78-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181018175416.718399607@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d70c9d02-d184-c9e0-0492-f40eebeada3e@nvidia.com>
Date:   Mon, 22 Oct 2018 14:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540213425; bh=7LXS/m3kmmh/fu6FczMO4+erczr60EnK5MMteH9wEGE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=n1wuq0k+EQ5K+Eg8I6mzeANiDKwRfoGlcVUSnCEpG4jyDTD9LSeTtAfsA7PokL/fG
         cNf5ap0MCNvAIzXgUyAgbjanDu5t16lVoG36zqnAfPdZ90l8nd1yWbXZFa6qPmQ2FQ
         tTybcDNUky11OYV6G25vcFcwTfcU9XO571J/b0AtNCXf1Fw0/Z3lKLujIt73tzVN1L
         xNcwC7GnJYaUAH5UvgfKpdjwECljDNags3Cn++mcs2yMZl7h/wHXCGm2MBfFUrZvyP
         3fyHP1v+81JDHciNrnjWwqrMWEdMFpFldG+MKOgKCtHAfR6awLLoJTwwlD9n0O9qxa
         RVzt0KXFlMoZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/10/2018 18:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.78 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:53:55 UTC 2018.
> Anything received after that time might be too late.
Sorry its late, but FWIW all tests passing for Tegra ...

Test results for stable-v4.14:
    8 builds:	8 pass, 0 fail
    16 boots:	16 pass, 0 fail
    14 tests:	14 pass, 0 fail

Linux version:	4.14.78-rc1-g901b7ab
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
