Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE8C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA92084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Pr+GuZZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfAUJRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:17:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2687 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAUJRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:17:13 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c458e080000>; Mon, 21 Jan 2019 01:16:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 21 Jan 2019 01:17:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 21 Jan 2019 01:17:12 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 21 Jan
 2019 09:17:10 +0000
Subject: Re: [PATCH v7 0/3] Fixes for Tegra soctherm
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <28d197f9-9b72-78ad-0769-7514d329b3c4@nvidia.com>
Message-ID: <1c0af72c-b8d5-9b2d-7bc1-86a2ae85c819@nvidia.com>
Date:   Mon, 21 Jan 2019 17:17:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <28d197f9-9b72-78ad-0769-7514d329b3c4@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548062216; bh=gNghU5Nmt+8cf49lya6gNJr3PTkq6JMQGYQwmi6XdUk=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Pr+GuZZ/ci1KNUAVn+yup1ViXfNnkO0nB88R/gl3FJ25WsCyUF1UjsgJkIZi3Q3Ey
         SxeaPl8NHq4QrE2ITX4OlBuVNb38svmGnHd1sFq49yXWwC7sVYH8Z6GQGNy3SNET3c
         iVjU18fSW3SqK2uqpVumhEmMcPjeEPqSoaF9t5fuY/LnV2nIYOL9r2Oa8nmbtlI1it
         Mjs9lK5BH1M2SXb3MKlnBcLD/Uls4dEw5+iV9y5/PfN0BOsX/gLHzuZtwFlnHVjALD
         qmgWXVGZs0rWE38ft5HBPUNCpQT+jcMxM8KAhGirZ95ttrayqkxHOKTn3zeXZRkRQy
         f63tnQhiBitHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does there have any comments?

Thanks.
Wei.

On 11/1/2019 10:20 AM, Wei Ni wrote:
> Hi Eduardo,
> Do you have any more comments, will you take this serial?
> 
> Thanks.
> Wei.
> 
> On 3/1/2019 6:12 PM, Wei Ni wrote:
>> This series fixed some issues for Tegra soctherm,
>> and add get_trend().
>>
>> Main changes from v6:
>> 1. Per Eduardo's comment, we can remove the change:
>> "thermal: tegra: parse sensor id before sensor register"
>>
>> Main changes from v5:
>> 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
>> into this serial.
>>
>> Main changes from v4:
>> 1. fixed for the parsing sensor id.
>> 2. keep warning for missing critical trips.
>>
>> Main changes from v3:
>> 1. updated codes for parsing sensor id, per Thierry's comments
>>
>> Main changes from v2:
>> 1. add codes to parse sensor id to avoid registration
>> failure.
>>
>> Main changes from v1:
>> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
>> "thermal: tegra: fix memory allocation".
>> 2. Print out the sensor name when register failed.
>> 2. Remove patch "thermal: tegra: fix coverity defect"
>>
>> Wei Ni (3):
>>   thermal: tegra: remove unnecessary warnings
>>   thermal: tegra: fix memory allocation
>>   thermal: tegra: add get_trend ops
>>
>>  drivers/thermal/tegra/soctherm.c | 40 +++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>
