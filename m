Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73461C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BEA2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ljZXcLs6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ljZXcLs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BEA2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJCUgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:36:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:36:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D656B607DC; Wed,  3 Oct 2018 13:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574458;
        bh=4yteKoHmPv1Uu2fR7kcXEbFALqTvJRaOsZUxpzjpYsA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ljZXcLs6ozw8X2UzmCDQXEPtYmrUOMq/T7NWQJ3+gVvriX1aGAKE13gaHyjc75HAB
         qw4eq/+nkFYzjFQpGkKSNUWnllv8YBvBDhMnnSpP7NShRL5Gf0X1RxnmKU5WuRVUck
         0BUeQHOd9sJkaLcu3CPAOTjaKQGgH8w/lhE2TjAU=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00308601D4;
        Wed,  3 Oct 2018 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538574458;
        bh=4yteKoHmPv1Uu2fR7kcXEbFALqTvJRaOsZUxpzjpYsA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ljZXcLs6ozw8X2UzmCDQXEPtYmrUOMq/T7NWQJ3+gVvriX1aGAKE13gaHyjc75HAB
         qw4eq/+nkFYzjFQpGkKSNUWnllv8YBvBDhMnnSpP7NShRL5Gf0X1RxnmKU5WuRVUck
         0BUeQHOd9sJkaLcu3CPAOTjaKQGgH8w/lhE2TjAU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00308601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 1/2] drivers: base: cacheinfo: Do not populate sysfs
 for unknown cache types
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, vkilari@codeaurora.org
References: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org>
 <1538103477-15513-2-git-send-email-jhugo@codeaurora.org>
 <256435083.TFCBfdESsY@aspire.rjw.lan>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <6f773f89-326f-1b27-455d-9cb4bf0892e4@codeaurora.org>
Date:   Wed, 3 Oct 2018 07:47:37 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <256435083.TFCBfdESsY@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/2018 3:35 AM, Rafael J. Wysocki wrote:
> On Friday, September 28, 2018 4:57:56 AM CEST Jeffrey Hugo wrote:
>> If a cache has an unknown type because neither the hardware nor the
>> firmware told us, an entry in the sysfs tree will be made, but the type
>> file will not be present.  lscpu depends on the type file being present
>> for every entry, and will error out without printing system information
>> if lscpu cannot open the type file.
>>
>> Presenting information about a cache without indicating its type is not
>> useful, therefore if we hit a cache with an unknown type, stop populating
>> sysfs so that userspace has the maximum amount of useful information.
>>
>> This addresses the following lscpu error, which prevents any output.
>> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
>> file or directory
>>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/base/cacheinfo.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index 5d5b598..cf78fa6 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -615,6 +615,8 @@ static int cache_add_dev(unsigned int cpu)
>>   		this_leaf = this_cpu_ci->info_list + i;
>>   		if (this_leaf->disable_sysfs)
>>   			continue;
>> +		if (this_leaf->type == CACHE_TYPE_NOCACHE)
>> +			break;
>>   		cache_groups = cache_get_attribute_groups(this_leaf);
>>   		ci_dev = cpu_device_create(parent, this_leaf, cache_groups,
>>   					   "index%1u", i);
>>
> 
> Can you please resend this patch with all tags collected so far?

Will do.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
