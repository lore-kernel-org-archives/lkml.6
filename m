Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA09C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4D920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JUkqHfD6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WoEftxTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4D920882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeILTxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:53:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:53:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1AA1C60AFF; Wed, 12 Sep 2018 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536763705;
        bh=3IdmViWb+lpItkHGNUpX0/6DFbQ0HGkxyMS68jlD5nw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JUkqHfD6o/EgAq8UTbi3X5SWk+8EeIxyuBPx3aKJlF09cpmV6AD+W4bmMWdnSHhbz
         6x5I1IfQKb+OF6okXKp8fqOTrakmzICtXWoGU2DSp5Ie9+l2VjvcHq+2lQS/5ZZ6Uc
         vqvLD7IphUbFuwybIIqHC22SQvIJYTEpFmFmItDM=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 545D8609D1;
        Wed, 12 Sep 2018 14:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536763703;
        bh=3IdmViWb+lpItkHGNUpX0/6DFbQ0HGkxyMS68jlD5nw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WoEftxTL2R9n7PpBTy0rjSu9Ry5omxQddvGydQ+hZhWBrr610yXEGULAU5XXfiq6w
         +B5GJFnmwuknnqkfxmI/awuaY1BaV1t10E9DU5wLtgjOkNcGRPms5/s41TMD1InwHS
         l+WxhoiCosgWlyn6+udsbKT9BC6rAtHeJitbKDkY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 545D8609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <337ef641-e645-137a-3d7f-d457264d94d5@codeaurora.org>
Date:   Wed, 12 Sep 2018 08:48:21 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2018 4:49 AM, Sudeep Holla wrote:
> 
> 
> On 11/09/18 21:38, Jeffrey Hugo wrote:
>> On 9/11/2018 2:16 PM, Jeremy Linton wrote:
>>> Hi Jeffrey,
>>>
>>> (+Sudeep)
>>>
> 
> [..]
> 
>>>
>>> If you look at the next line of code following this comment its going
>>> to update the cache type for fully populated PPTT nodes. Although with
>>> the suggested change its only going to activate if someone completely
>>> fills out the node and fails to set the valid flag on the cache type.
>>
>> Yes, however that case doesn't apply to the scenario we are concerned
>> about, doesn't seem to be fully following the PPTT spec, and seems odd
>> that Linux just assumes that a "fully specified" cache is unified.
>>
> 
> Agreed, but adding code that will never get used is also not so good.
> Do you have systems where this is needed ?

Yes.

> 
>>> What I suspect is happening in the reported case is that the nodes in
>>> the PPTT table are missing fields we consider to be important. Since
>>> that data isn't being filled out anywhere else, so we leave the cache
>>> type alone too. This has the effect of hiding sysfs nodes with
>>> incomplete information.
>>>
>>> Also, the lack of the DATA/INST fields is based on the assumption that
>>> the only nodes which need their type field updated are outside of the
>>> CPU core itself so they are pretty much guaranteed to be UNIFIED. Are
>>> you hitting this case?
>>>
>>
>> Yes.  Without this change, we hit the lscpu error in the commit message,
>> and get zero output about the system.  We don't even get information
>> about the caches which are architecturally specified or how many cpus
>> are present.  With this change, we get what we expect out of lscpu (and
>> also lstopo) including the cache(s) which are not architecturally
>> specified.
>>
> 
> lscpu and lstopo are so broken. They just assume everything on CPU0.
> If you hotplug them out, you start seeing issues. So reading and file
> that doesn't exist and then bail out on other essential info though they
> are present, hmmm ...

lscpu/lstopo being broken seems orthogonal to me.
The kernel is not providing the type file because the kernel thinks the 
type is NOCACHE, despite PPTT providing a type.  In an ideal world, I 
think the kernel should be fixed (this change), and any deficiencies or 
bad assumptions in lscpu/lstopo should also be fixed.

> 
>> I guess I still don't understand why its important for PPTT to list, for
>> example, the sets/ways of a cache in all scenarios.  In the case of a
>> "transparent" cache (implementation defined as not reported per section
>> D3.4.2 of the ARM ARM where the cache cannot be managed by SW), there
>> may not be valid values for sets/ways.  I would argue its better to not
>> report that information, rather than provide bogus information just to
>> make Linux happy, which may break other OSes and provide means for which
>> a user to hang themselves.
>>
> 
> While I agree presenting wrong info is not good, but one of the reasons
> the cache info is present is to provide those info for some applications
> to do optimization based on that(I am told so and not sure if just type
> and size will be good enough) and you seem to agree with that below.

Yes, but if its not entirely clear, on my system, we have the 
information but its not being presented.  This change fixes that.  I'm 
willing to discuss an alternative fix, but to ignore the issue is not 
viable in my opinion.

What do we need to move forward here?

> 
>> However, in the case of a transparent cache, the size/type/level/write
>> policy/etc (whatever the firmware provider deems relevant) might be
>> valuable information for the OS to make scheduling decisions, and is
>> certainly valuable for user space utilities for cross-machine/data
>> center level job scheduling.
>>
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
