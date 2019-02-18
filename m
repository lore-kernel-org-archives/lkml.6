Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC98218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="pA3NpTck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfBRH7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:59:23 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11454 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfBRH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:59:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6a65de0001>; Sun, 17 Feb 2019 23:59:26 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 17 Feb 2019 23:59:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 17 Feb 2019 23:59:22 -0800
Received: from DRHQMAIL101.nvidia.com (10.27.9.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 07:59:22 +0000
Received: from [10.19.225.182] (172.20.13.39) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 07:59:19 +0000
Subject: Re: [PATCH v7 0/3] Fixes for Tegra soctherm
From:   Wei Ni <wni@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <rui.zhang@intel.com>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <28d197f9-9b72-78ad-0769-7514d329b3c4@nvidia.com>
 <1c0af72c-b8d5-9b2d-7bc1-86a2ae85c819@nvidia.com>
Message-ID: <df2493f3-4bbd-65d1-1205-073a30729a89@nvidia.com>
Date:   Mon, 18 Feb 2019 15:59:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1c0af72c-b8d5-9b2d-7bc1-86a2ae85c819@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 DRHQMAIL101.nvidia.com (10.27.9.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550476767; bh=uJat/7JMx9Nq5hyDJgu+7Nl224PkSzZM4UO0BhSsPyg=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pA3NpTckLP/uF26+j5jESONhWQ80zh0L0bX4LbEi7wN/kPjUXHE5V+U6Dl+9SQqQN
         GSMRBUK62Sucxzq4s5c4a2oZnO2s+SWAfLBhhCs1BOFunUKIZR+IujsXYd6a1d6BHz
         8uHa9xEfqps7MgdZN6DT8v6qd2zkk67KJvyM8ulFAJqck21Qr5TDFm4RuH8sLkJ8kz
         82Dczatfi1MLCQWPbTANb7UYgyue0B6PRlSqPsiKeEZTF54IIZ9THiW+tw62meH5Gz
         kdWs1Myx8jR8yDNRVIT1aOU23wCDiZlovhCWt6QcWYqzDNc8jRUI9rLj3MJwb2dGDs
         +d3jXZXfxHpRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui,
Will you take this serial?

Thanks.
Wei.

On 21/1/2019 5:17 PM, Wei Ni wrote:
> Does there have any comments?
> 
> Thanks.
> Wei.
> 
> On 11/1/2019 10:20 AM, Wei Ni wrote:
>> Hi Eduardo,
>> Do you have any more comments, will you take this serial?
>>
>> Thanks.
>> Wei.
>>
>> On 3/1/2019 6:12 PM, Wei Ni wrote:
>>> This series fixed some issues for Tegra soctherm,
>>> and add get_trend().
>>>
>>> Main changes from v6:
>>> 1. Per Eduardo's comment, we can remove the change:
>>> "thermal: tegra: parse sensor id before sensor register"
>>>
>>> Main changes from v5:
>>> 1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
>>> into this serial.
>>>
>>> Main changes from v4:
>>> 1. fixed for the parsing sensor id.
>>> 2. keep warning for missing critical trips.
>>>
>>> Main changes from v3:
>>> 1. updated codes for parsing sensor id, per Thierry's comments
>>>
>>> Main changes from v2:
>>> 1. add codes to parse sensor id to avoid registration
>>> failure.
>>>
>>> Main changes from v1:
>>> 1. Acked by Thierry Reding <treding@nvidia.com> for the patch
>>> "thermal: tegra: fix memory allocation".
>>> 2. Print out the sensor name when register failed.
>>> 2. Remove patch "thermal: tegra: fix coverity defect"
>>>
>>> Wei Ni (3):
>>>   thermal: tegra: remove unnecessary warnings
>>>   thermal: tegra: fix memory allocation
>>>   thermal: tegra: add get_trend ops
>>>
>>>  drivers/thermal/tegra/soctherm.c | 40 +++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 37 insertions(+), 3 deletions(-)
>>>
