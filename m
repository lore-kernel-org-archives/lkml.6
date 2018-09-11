Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97667C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9AB20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aE/tpuMj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vl94xPr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9AB20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeILBjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:39:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41606 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeILBjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:39:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63F6560600; Tue, 11 Sep 2018 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536698322;
        bh=JFhrdmAZ+QUy3QCGnCUZBOierD3els5z4QtWlxNHobs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aE/tpuMjeVdAgi1AmGEypEi+1knNEXs6ZwbmW4pH3IKvUTSJpR6cof5E/EE9WTOD+
         e4Q6lQlFWswpylmiV1nBJyLzeZubTQFvbu6qoq0j/OjIAKFcOfAi36W5J/wneHA7LN
         1rKzqgP/0j2q9HEUw5ET3ADtvJH2d3hNXj58LWcI=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05A6F60600;
        Tue, 11 Sep 2018 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536698321;
        bh=JFhrdmAZ+QUy3QCGnCUZBOierD3els5z4QtWlxNHobs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vl94xPr/53fR+reHlFXuvhQ6byK3IwmdigL+c0Hb+EqmHbtVO2M7oSHBNcsfmfkQi
         qbOTt66AhHoeYK91m0lU82xzqJ8Y7I7VyzsrhlFTf/aZxlcXbnY50PpHO5LrZ3+ePd
         HH5NQQcRAXfPUE7mACsN07gMv66M64xw6fdMGb8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05A6F60600
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
Date:   Tue, 11 Sep 2018 14:38:40 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 2:16 PM, Jeremy Linton wrote:
> Hi Jeffrey,
> 
> (+Sudeep)
> 
> On 09/11/2018 02:32 PM, Jeffrey Hugo wrote:
>> The type of a cache might not be specified by architectural mechanisms 
>> (ie
>> system registers), but its type might be specified in the PPTT.  In this
>> case, following the PPTT specification, we should identify the cache as
>> the type specified by PPTT.
>>
>> This fixes the following lscpu issue where only the cache type sysfs file
>> is missing which results in no output providing a poor user experience in
>> the above system configuration-
>> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No 
>> such
>> file or directory
>>
>> Fixes: 2bd00bcd73e5 (ACPI/PPTT: Add Processor Properties Topology 
>> Table parsing)
>> Reported-by: Vijaya Kumar K <vkilari@codeaurora.org>
>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>> ---
>>   drivers/acpi/pptt.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index d1e26cb..3c6db09 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -401,6 +401,21 @@ static void update_cache_properties(struct 
>> cacheinfo *this_leaf,
>>               break;
>>           }
>>       }
>> +    if ((this_leaf->type == CACHE_TYPE_NOCACHE) &&
>> +        (found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)) {
>> +        switch (found_cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) {
>> +        case ACPI_PPTT_CACHE_TYPE_DATA:
>> +            this_leaf->type = CACHE_TYPE_DATA;
>> +            break;
>> +        case ACPI_PPTT_CACHE_TYPE_INSTR:
>> +            this_leaf->type = CACHE_TYPE_INST;
>> +            break;
>> +        case ACPI_PPTT_CACHE_TYPE_UNIFIED:
>> +        case ACPI_PPTT_CACHE_TYPE_UNIFIED_ALT:
>> +            this_leaf->type = CACHE_TYPE_UNIFIED;
>> +            break;
>> +        }
>> +    }
>>       /*
>>        * If the above flags are valid, and the cache type is NOCACHE
>>        * update the cache type as well.
>>
> 
> If you look at the next line of code following this comment its going to 
> update the cache type for fully populated PPTT nodes. Although with the 
> suggested change its only going to activate if someone completely fills 
> out the node and fails to set the valid flag on the cache type. 

Yes, however that case doesn't apply to the scenario we are concerned 
about, doesn't seem to be fully following the PPTT spec, and seems odd 
that Linux just assumes that a "fully specified" cache is unified.

> What I suspect is happening in the reported case is that the nodes in 
> the PPTT table are missing fields we consider to be important. Since 
> that data isn't being filled out anywhere else, so we leave the cache 
> type alone too. This has the effect of hiding sysfs nodes with 
> incomplete information.
> 
> Also, the lack of the DATA/INST fields is based on the assumption that 
> the only nodes which need their type field updated are outside of the 
> CPU core itself so they are pretty much guaranteed to be UNIFIED. Are 
> you hitting this case?
> 

Yes.  Without this change, we hit the lscpu error in the commit message, 
and get zero output about the system.  We don't even get information 
about the caches which are architecturally specified or how many cpus 
are present.  With this change, we get what we expect out of lscpu (and 
also lstopo) including the cache(s) which are not architecturally specified.

I guess I still don't understand why its important for PPTT to list, for 
example, the sets/ways of a cache in all scenarios.  In the case of a 
"transparent" cache (implementation defined as not reported per section 
D3.4.2 of the ARM ARM where the cache cannot be managed by SW), there 
may not be valid values for sets/ways.  I would argue its better to not 
report that information, rather than provide bogus information just to 
make Linux happy, which may break other OSes and provide means for which 
a user to hang themselves.

However, in the case of a transparent cache, the size/type/level/write 
policy/etc (whatever the firmware provider deems relevant) might be 
valuable information for the OS to make scheduling decisions, and is 
certainly valuable for user space utilities for cross-machine/data 
center level job scheduling.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
