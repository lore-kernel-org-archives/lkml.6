Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3693C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB93020652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JzTPx6ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB93020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeJVVXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:23:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9205 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeJVVXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:23:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bcdcb070001>; Mon, 22 Oct 2018 06:05:11 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Oct 2018 06:05:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Oct 2018 06:05:06 -0700
Received: from [10.26.11.135] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Oct
 2018 13:05:03 +0000
Subject: Re: [PATCH 4.4 00/48] 4.4.162-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181018175427.133690306@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <6f7a509f-19bf-f335-c874-457836485b75@nvidia.com>
Date:   Mon, 22 Oct 2018 14:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540213511; bh=yUGZwc6iSAFBq1RkEWy7Eh+kh9kbHL+hCWgDpCkSVN8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JzTPx6ldFYVxH88O9/wI8a+5pDhIPr8ViRuduYdfWiUVdUMZ8+g+L1NGir8erYduq
         aM2XjELOKmMXROlKrbw/lqhMhBtH6Zu2Y6Mt9NRpYQdnZiKbCT4t51S2ON2Zq0nLiB
         VSXHPfME8j7p1Djlbr+DMqZxX+ftcmXYFalFIS45lcEjqYiVUsNu4ZGLipCNynI84y
         uD3gLjjhgq3TzMM4tJ1Rk7UpgTzTAvTlNoWCUU71Tvn2sJKbk82VaN2M3eojSoebqb
         XeMnZombVjeKnJczCzlH67y3/PlNHrPXJo5+5TLBCLIQvZV+uCiMI5OY7hWywQWdR2
         +EcVJdHPMsFqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/10/2018 18:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.162 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:54:03 UTC 2018.
> Anything received after that time might be too late.
Sorry its late, but FWIW all tests passing for Tegra ...

Test results for stable-v4.4:
    6 builds:	6 pass, 0 fail
    12 boots:	12 pass, 0 fail

Linux version:	4.4.162-rc1-g3918330
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
