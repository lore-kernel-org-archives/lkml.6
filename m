Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FCDC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560C420879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BUDbXUif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560C420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeLNJyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:54:55 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10860 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNJyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:54:55 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c137deb0000>; Fri, 14 Dec 2018 01:54:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Dec 2018 01:54:54 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Dec 2018 01:54:54 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Dec
 2018 09:54:52 +0000
Subject: Re: [PATCH v6 0/4] Fixes for Tegra soctherm
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <74e77548-d10c-fd00-48c5-2b611529eaf5@nvidia.com>
Date:   Fri, 14 Dec 2018 17:54:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544780993-20744-1-git-send-email-wni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544781291; bh=b2zxk8v71zNikr2kg6FG3pBRqcKDXDvN/3PMXg9opXw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BUDbXUifLVPZRgzp2Uf5EKuw0Y8F1ckeKKIVuvlmqTZsKQt415TXrFn21QlG9eyqO
         AwYK4VQxL5IGKK0lkzNRIia05LaPXaf4TeOUiFqFiYOXYqGyFU1C4Qj1UBO+QBeYmI
         /d1t2IxGUEUdx1i4SNqnP1oEdvJXxDHgoUhqcqL9xkX3ANLyeJ0pr3IAUaXwuEAk04
         VMNVkmZRyvArN1b3lEn55IAr23BBq/UW4ZONzr0+L0gcrD1BxinxHc2QP00eZBo/39
         68iExR5ONcjZCOPQLZ6dt2fIzEs1XcUHQP476Nawf1j1Kw8EIPscZS0rop7DlPnqA2
         Ii+T2ruMQsQBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,
I moved get_trend() patch https://lkml.org/lkml/2018/11/20/643 in this
serial.
Since no more comments on these patches, will you take them?

Thanks.
Wei.

On 14/12/2018 5:49 PM, Wei Ni wrote:
> This series fixed some issues for Tegra soctherm,
> and add get_trend().
> 
> Main changes from v5:
> 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
> into this serial.
> 
> Main changes from v4:
> 1. fixed for the parsing sensor id.
> 2. keep warning for missing critical trips.
> 
> Main changes from v3:
> 1. updated codes for parsing sensor id, per Thierry's comments
> 
> Main changes from v2:
> 1. add codes to parse sensor id to avoid registration
> failure.
> 
> Main changes from v1:
> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
> "thermal: tegra: fix memory allocation".
> 2. Print out the sensor name when register failed.
> 2. Remove patch "thermal: tegra: fix coverity defect"
> 
> Wei Ni (4):
>   thermal: tegra: remove unnecessary warnings
>   thermal: tegra: fix memory allocation
>   thermal: tegra: parse sensor id before sensor register
>   thermal: tegra: add get_trend ops
> 
>  drivers/thermal/tegra/soctherm.c | 85 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 80 insertions(+), 5 deletions(-)
> 
