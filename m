Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4243C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BDF2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N2/qPHuu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KCvq4Lvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BDF2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeILVbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:31:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeILVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:31:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2A2D060594; Wed, 12 Sep 2018 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536769549;
        bh=Hyz0pOHpYlkY/Vw4GcyWXk8H6I7s/HJkxPX5Si14ebE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N2/qPHuumfFR4YCwfz9HGHFkZuEPNbUilXpZNCIOY4GN/jje5fMrowOHyemtjM2R4
         DmfT9EmG1xpwRzcH7RhJp6KOjPPyQ7khQTirChI+8IK7Ha4iUSbzPugoNu08ceXVxH
         M9tcLXetdpwMrhxJrMMfz+L57DraEUrh4LwYn9zA=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B7A560213;
        Wed, 12 Sep 2018 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536769548;
        bh=Hyz0pOHpYlkY/Vw4GcyWXk8H6I7s/HJkxPX5Si14ebE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KCvq4LvbgrQLO0fV7tCJnManOgTqish+kIJ+Vf4F1/D1Bjxq1ySCW2yw6RSmSXaNA
         c1YpQfgqpI4mXRx+gdV9ZVpL6O+Hjar/Drk5Hkf2TC37csWcFXPliEMQUMJQx39l7t
         9wgYC80jI1gJoKn649CSqNECIS+tl1DTe/fcL3/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B7A560213
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
 <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
 <af280111-5dec-a4e1-7dfd-20f38a9fd8ab@arm.com>
 <2873c62f-1bf9-5aa0-b3a2-07980ef61d35@arm.com>
 <c835027a-9e3e-221b-01da-0e1930c4e58f@codeaurora.org>
 <20180912161509.GA24181@e107155-lin>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <960c5f0d-9494-9a87-2797-3f10fc140ab5@codeaurora.org>
Date:   Wed, 12 Sep 2018 10:25:47 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912161509.GA24181@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2018 10:15 AM, Sudeep Holla wrote:
> On Wed, Sep 12, 2018 at 09:57:14AM -0600, Jeffrey Hugo wrote:
>> On 9/12/2018 9:38 AM, Sudeep Holla wrote:
>>>
>>>
>>> On 12/09/18 16:27, Sudeep Holla wrote:
>>>>
>>>>
>>>> On 12/09/18 15:41, Jeffrey Hugo wrote:
>>>
>>> [...]
>>>
>>>>>
>>>>> Correct.  However, what if you have a NOCACHE (not architecturally
>>>>> specified), that is fully described in PPTT, as a non-unified cache
>>>>> (data only)?  Unlikely?  Maybe.  Still seem possible though, therefore I
>>>>> feel this assumption is suspect.
>>>>>
>>>>
>>>> Yes, we have other issues if the architecturally not specified cache is
>>>> not unified irrespective of what PPTT says. So we may need to review and
>>>> see if that assumption is removed everywhere.
>>>>
>>>> Until then why can't a simple change fix the issue you have:
>>>>
>>>> -->8
>>>>
>>>> diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
>>>> index d1e26cb599bf..f74131201f5e 100644
>>>> --- i/drivers/acpi/pptt.c
>>>> +++ w/drivers/acpi/pptt.c
>>>> @@ -406,7 +406,8 @@ static void update_cache_properties(struct cacheinfo
>>>> *this_leaf,
>>>>           * update the cache type as well.
>>>>           */
>>>>          if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>>>> -           valid_flags == PPTT_CHECKED_ATTRIBUTES)
>>>> +           (valid_flags == PPTT_CHECKED_ATTRIBUTES ||
>>>> +            found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID))
>>>
>>> Looking at this again, if we are supporting just presence of cache type
>>> and size(may be), then we can drop the whole valid_flags thing here.
>>>
>>>>                  this_leaf->type = CACHE_TYPE_UNIFIED;
>>>>   }
>>>>
>>
>> Yes, this change fixes my usecase.  I think it invalidates the comment, and
>> really, the comment should probably mention that we assume unified type
>> because there are other issues in supporting architecturally not specified
>> inst/data only caches.
>>
> 
> Agreed.
> 
>> Do you want a V2 with this?  If so, do you want the fixes tag removed since
>> you seem to view this as not a bug?
>>
> 
> Yes please, I am fine to retain fixes tag but that's my opinion.
> 
>> I don't think I clearly understand the purpose of the valid flags, therefore
>> I feel as though I'm not sure if it can be dropped or not.  Is it fair to
>> say that what the valid flags is accomplishing is identifying if we have a
>> sufficient level of information to support this cache?  If not, then should
>> the cacheinfo driver not expose any sysfs information about the cache?
>>
> 
> I don't see the use of the flag if we *have to* support the case where
> all the cache geometry is not present but just cache type (and maybe
> size?) is present. If that's the case we can drop valid flags entirely.
> I really don't like the idea of supporting that, but I don't have strong
> reasons to defend my idea, so I am fine with that.
> 
> Further, I think in your case with NOCACHE type set, sysfs dir shouldn't
> have been created at the first place ideally. I think we need something
> like below to fix that.
> 
> -->8
> 
> diff --git i/drivers/base/cacheinfo.c w/drivers/base/cacheinfo.c
> index 5d5b5988e88b..cf78fa6d470d 100644
> --- i/drivers/base/cacheinfo.c
> +++ w/drivers/base/cacheinfo.c
> @@ -615,6 +615,8 @@ static int cache_add_dev(unsigned int cpu)
>   		this_leaf = this_cpu_ci->info_list + i;
>   		if (this_leaf->disable_sysfs)
>   			continue;
> +		if (this_leaf->type == CACHE_TYPE_NOCACHE)
> +			break;
>   		cache_groups = cache_get_attribute_groups(this_leaf);
>   		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
>   					   "index%1u", i);
> 

Ok, let me test this out, and send out a v2.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
