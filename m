Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E648C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5997C2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Cz3h1057"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5997C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeK3OR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:17:59 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14080 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3OR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:17:59 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c00aa160000>; Thu, 29 Nov 2018 19:10:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 29 Nov 2018 19:10:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 29 Nov 2018 19:10:12 -0800
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Nov
 2018 03:10:10 +0000
Subject: Re: [PATCH v3 3/3] thermal: tegra: parse sensor id before sensor
 register
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <edubezval@gmail.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <1543383877-20555-1-git-send-email-wni@nvidia.com>
 <1543383877-20555-4-git-send-email-wni@nvidia.com>
 <20181128102520.GC20723@ulmo>
 <9c373693-1d3c-cd02-4972-dde338651c0e@nvidia.com>
 <20181129171304.GB18128@ulmo>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <9beaf6ea-14bb-1944-2372-eb615f04f9e3@nvidia.com>
Date:   Fri, 30 Nov 2018 11:10:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129171304.GB18128@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543547415; bh=KmXv8UHXJWEGQpuB29G2q13uYSH5NBMF4sdTfQz5whI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Cz3h1057CKIwNxXO3Sy3EI/6EUhxHS+2JE2MTyhQSzpdPGzAw/LAEaL2gdQjdZw7t
         4mfY06tFOq/xWWf4sItVUeeI52JtjnS8hrze85rRa3mlzdmV8S6DLs/13AqHAwj4gr
         dhpwyEzo7EDABZCe0jnEYVp6i1xTrbinQnnKDwrlcOX2DWj3WymY1fcqSlM8tGPBSg
         NoWqtdonYVYHy1QcMoJA1n0TzdoS0vmp/LtLM9VpG3SV4GC7d+xnKIQ9QoktvTozJ7
         WePyuxnZ9sUM8TWEuP2P3LD7AtFMWkqmFRi/tc9waacISiSiVu4VtpwB8WZuj+D5Xa
         Udz96TyRIWfrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2018 1:13 AM, Thierry Reding wrote:
> On Thu, Nov 29, 2018 at 01:55:02PM +0800, Wei Ni wrote:
>> On 28/11/2018 6:25 PM, Thierry Reding wrote:
>>> On Wed, Nov 28, 2018 at 01:44:37PM +0800, Wei Ni wrote:
> [...]
>>>> +	bool ret = false;
>>>> +	struct of_phandle_args sensor_specs;
>>>> +	struct device_node *np, *sensor_np;
>>>> +
>>>> +	np = of_find_node_by_name(NULL, "thermal-zones");
>>>> +	if (!np)
>>>> +		return ret;
>>>> +
>>>> +	sensor_np = of_get_next_child(np, NULL);
>>>> +	for_each_available_child_of_node(np, sensor_np) {
>>>
>>> Aren't we leaking np here? I think we need of_node_put() after
>>> of_get_next_child() to make sure the reference to the "thermal-zones"
>>> node is properly released.
>>
>> No, we will not leak np here. Because the
>> for_each_available_child_of_node will call
>> of_get_next_available_child(), which will call of_node_put(prev) to
>> decrease refcount of the prev node. So we just need to of_node_put the
>> last node after break from this for block.
> 
> Okay, looks like I misinterpreted what you were doing there. I thought
> that for_each_available_child_of_node() took the child as first argument
> and the parent as second and therefore np would be overwritten by the
> first assignment in the macro.
> 
> But looking at this more closely I think there's something else wrong
> here. for_each_available_child_of_node() is defined as:
> 
> 	for_each_available_child_of_node(parent, child)
> 
> so in the above, np will be the parent and sensor_np the child. Why do
> you have to do
> 
> 	sensor_np = of_get_next_child(np, NULL);
> 
> ? That's already done as part of the loop in the macro, right? So does
> that not mean we get two references and we leak the first one? Can the
> above not simply been dropped?

It's so sorry, it's my mistake, we should remove this line, it was my
develop code, forgot to remove it.
Will fix it in next version.

Thanks.

> 
> Thierry
> 
