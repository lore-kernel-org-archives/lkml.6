Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C19C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE55C20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D7Iey46c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE55C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeLEIbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:31:31 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11015 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeLEIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:31:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c078ce10000>; Wed, 05 Dec 2018 00:31:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Dec 2018 00:31:30 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Dec 2018 00:31:30 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 08:31:28 +0000
Subject: Re: [PATCH v5 0/3] Fixes for Tegra soctherm
To:     <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-tegra@vger.kernel.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1543816523-10525-1-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <56fd1fc8-f70f-2d86-6a05-799a7bd0ff7e@nvidia.com>
Date:   Wed, 5 Dec 2018 16:31:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543816523-10525-1-git-send-email-wni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543998689; bh=LSfUt2hmqqARPcn9B4yq9M2NSzpoIlIjl2lxx+rjf6c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=D7Iey46cEqd6DKXAbdC4yf1d+fd3WS4GkX8BgeV2/HOxpUKPbte/k+//IwOBZAoYw
         fP+VRi+A2nMGur4GL1d1PqCx0eiU5mFRQNRA0HvVwyxJLzAtfaq4qH708df0+OiKEL
         3toi4IXHJ3YKfDXkRyvfgFPA2MDvDZyeAMWVPK7YPqgV6i2CHs6kSrV7i6AMxJH4ST
         mSKgWLvnYE32u72lnneCF7lnxo0BlnNOFR0PF3Lhd+RIJtyKmOgLTC4ZV+jaPbwzFS
         NTk+rVoXFxOpc6lsNHxa/L0Cb9F23kKVsnDewdulQmeirEqzHNpYBoUFwhDefOWDO1
         3bNtjs+eXePgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Does there have any comments on this serial?

Thanks.
Wei.

On 3/12/2018 1:55 PM, Wei Ni wrote:
> This series fixed some issues for Tegra soctherm
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
> Wei Ni (3):
>   thermal: tegra: remove unnecessary warnings
>   thermal: tegra: fix memory allocation
>   thermal: tegra: parse sensor id before sensor register
> 
>  drivers/thermal/tegra/soctherm.c | 51 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 5 deletions(-)
> 
