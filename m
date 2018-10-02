Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7667C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4CA20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ic30rvzU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bpectid+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4CA20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeJBWOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:14:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJBWOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:14:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 128E660BE3; Tue,  2 Oct 2018 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538494218;
        bh=9vd8EC7ote16UQGv5mOp++0wUJJ2DzeGDUV8jUBJD/0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ic30rvzUOAq+WJwtFWnjs7wFyE1ySjqu2iZrwjaAub9+6XNoKl/ixkl3yIZDyHkg9
         Ye3ZootsZdGt0w/qVdndrVWQk4VCEU5+jOLKQ5GTSIMRbUjqa+VM11DkAUZFK8+hJK
         N3+Lfo9bJhOidlyvRfVdaifa3pv1LB5kcJgSgO9I=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBAC860242;
        Tue,  2 Oct 2018 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538494217;
        bh=9vd8EC7ote16UQGv5mOp++0wUJJ2DzeGDUV8jUBJD/0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bpectid+o5ixaAmD3Qlh3Ny2enrt2FxbbRHn3FHJJ7LNjQt1onDNynSTfiATtahDO
         dhwWBIeFq4JnWAZ3j1WsOToo1pZxs45q4Xp/JemVd1TI21APJlc7O4rLWCm6GXPUHy
         cn/G3ruedxZYNzMvfmxPTQ9ByTUw/phbDlgF4+wQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBAC860242
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 2/2] ACPI/PPTT: Handle architecturally unknown cache
 types
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, vkilari@codeaurora.org
References: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org>
 <1538103477-15513-3-git-send-email-jhugo@codeaurora.org>
 <20181002105705.GB1086@e107155-lin>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <84bcc957-6833-a7be-21e2-42014a7e0fd1@codeaurora.org>
Date:   Tue, 2 Oct 2018 09:30:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002105705.GB1086@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2018 4:57 AM, Sudeep Holla wrote:
> On Thu, Sep 27, 2018 at 08:57:57PM -0600, Jeffrey Hugo wrote:
>> The type of a cache might not be specified by architectural mechanisms (ie
>> system registers), but its type might be specified in the PPTT.  In this
>> case, we should populate the type of the cache, rather than leave it
>> undefined.
>>
>> This fixes the issue where the cacheinfo driver will not populate sysfs
>> for such caches, resulting in the information missing from utilities like
>> lstopo and lscpu, thus degrading the user experience.
>>
>> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology Table parsing)
>> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   drivers/acpi/pptt.c | 30 +++++++++++++-----------------
>>   1 file changed, 13 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index d1e26cb..38ac30e 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -357,25 +357,15 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>   				    struct acpi_pptt_cache *found_cache,
>>   				    struct acpi_pptt_processor *cpu_node)
>>   {
>> -	int valid_flags = 0;
>> -
>>   	this_leaf->fw_token = cpu_node;
>> -	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
>>   		this_leaf->size = found_cache->size;
>> -		valid_flags++;
>> -	}
>> -	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
>>   		this_leaf->coherency_line_size = found_cache->line_size;
>> -		valid_flags++;
>> -	}
>> -	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_NUMBER_OF_SETS_VALID)
>>   		this_leaf->number_of_sets = found_cache->number_of_sets;
>> -		valid_flags++;
>> -	}
>> -	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID) {
>> +	if (found_cache->flags & ACPI_PPTT_ASSOCIATIVITY_VALID)
>>   		this_leaf->ways_of_associativity = found_cache->associativity;
>> -		valid_flags++;
>> -	}
>>   	if (found_cache->flags & ACPI_PPTT_WRITE_POLICY_VALID) {
>>   		switch (found_cache->attributes & ACPI_PPTT_MASK_WRITE_POLICY) {
>>   		case ACPI_PPTT_CACHE_POLICY_WT:
>> @@ -402,11 +392,17 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>   		}
>>   	}
>>   	/*
>> -	 * If the above flags are valid, and the cache type is NOCACHE
>> -	 * update the cache type as well.
>> +	 * If cache type is NOCACHE, then the cache hasn't been specified
>> +	 * via other mechanisms.  Update the type if a cache type has been
>> +	 * provided.
>> +	 *
>> +	 * Note, we assume such caches are unified based on conventional system
>> +	 * design and known examples.  Significant work is required elsewhere to
>> +	 * fully support data/instruction only type caches which are only
>> +	 * specified in PPTT.
>>   	 */
>>   	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
>> -	    valid_flags == PPTT_CHECKED_ATTRIBUTES)
> 
> I don't think we use PPTT_CHECKED_ATTRIBUTES elsewhere.
> If so, can we drop that ?
> 
> Other than that:
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Whoops, you are right.  For some reason I thought that came from the 
standard ACPICA definitions.  Let me drop that.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
