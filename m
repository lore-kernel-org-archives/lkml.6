Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A8CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B102098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KRBBgZP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B102098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeJLPXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:23:35 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15706 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeJLPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:23:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc052ad0000>; Fri, 12 Oct 2018 00:52:13 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 00:52:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 00:52:23 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 07:52:21 +0000
Subject: Re: [PATCH 4.4 00/27] 4.4.161-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <ben.hutchings@codethink.co.uk>, <lkft-triage@lists.linaro.org>,
        <stable@vger.kernel.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <20181011152534.014964888@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <12f82602-d3e0-cc1f-879c-ad8168609d2c@nvidia.com>
Date:   Fri, 12 Oct 2018 08:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539330733; bh=AjK8L2zdVHPgj/Q11TlKccwdjht1rJk08dGbSX4X+Qc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KRBBgZP4lZDvog7aiMG/pemYEQqDLHvZG48mXCKPCWwMR6HaBuuJdsq7yXc6ATshD
         w7pFyuHhKpZi30tfa6mXus7SKkIHcOKWTGJy3XfFq7rhgjfgCoUsZySXv9Q0k5X5Cv
         bOkUNhz4QgFpAQqhKr1PvDY7m6U36PorcHDXhRfudlUMZCsGDeB5I18zD47IMM3E9I
         pr5xuTXHkSaqYEpPs0IhglF/ZWjahztuIH0+Fz3J9ebkx2E5t2e1bhku0lSeHJSbZx
         rkgSc/on8zolmfqn8HWN6qJqt5a+SvYmTNKrHS74l5/t7DheacOEGYSqr9+0P/uJ3h
         ZR3eVYtACHUAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/18 16:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.161 release.
> There are 27 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:23 UTC 2018.
> Anything received after that time might be too late.
All tests are passing for Tegra ...

Test results for stable-v4.4:
    6 builds:	6 pass, 0 fail
    12 boots:	12 pass, 0 fail

Linux version:	4.4.161-rc1-gb3522afc
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra30-cardhu-a04

Cheers
Jon

-- 
nvpublic
