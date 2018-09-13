Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2ACC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D144206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kVDWN2F8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X9XLHgd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D144206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeIMUU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 16:20:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeIMUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 16:20:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FDC56053B; Thu, 13 Sep 2018 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536851430;
        bh=qdbApEMcnroGTfP56crK9lQk47iwyjWlI25kdfkM3WU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kVDWN2F8LU+nFydtQfFHCiSMZHuq2xXa7GUCpCue/ZLgD2xLqlVOoDIZ0FSy/chig
         Gg56HJ/kWcZmvsGhqZZcRBwQKkY0T05kx+br2Fk5EvpfpvdEzZAIOU+bf95/1d5uPi
         Haam3z3bsqxVo9iXNet9W29svGb9zv3aI3MFAcQ4=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 910186053B;
        Thu, 13 Sep 2018 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536851429;
        bh=qdbApEMcnroGTfP56crK9lQk47iwyjWlI25kdfkM3WU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X9XLHgd/Cp/HbqOJh1w2fUAo2CxF29gbBUpiIHKFPpcB0wVFVgtlU/Sy5t/W4d8DZ
         qT7TUoCydgo+OATKEf+MENtAFDMKJ1yM873zTkHrzdOeaNUNN+31nmuaeghp1Ur/2K
         UY9pL6olFj+azac3yQkC6WPjPAkgsNMny4lFzf8A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 910186053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Brice Goglin <brice.goglin@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        James Morse <james.morse@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
 <4f253bf4-ef2d-849f-b793-9b0530e72aab@gmail.com>
 <c7e74980-eb5d-1b2a-8ebb-7210b4f507a2@arm.com>
 <20180913103525.GA7777@e107155-lin>
 <0f23136a-cfb7-8def-702a-87e02705f0d6@gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <0e77c310-178e-6bf8-1583-c583cdeb7eaf@codeaurora.org>
Date:   Thu, 13 Sep 2018 09:10:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0f23136a-cfb7-8def-702a-87e02705f0d6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 5:53 AM, Brice Goglin wrote:
> Le 13/09/2018 à 11:35, Sudeep Holla a écrit :
>> On Thu, Sep 13, 2018 at 10:39:10AM +0100, James Morse wrote:
>>> Hi Brice,
>>>
>>> On 13/09/18 06:51, Brice Goglin wrote:
>>>> Le 12/09/2018 à 11:49, Sudeep Holla a écrit :
>>>>>> Yes.  Without this change, we hit the lscpu error in the commit message,
>>>>>> and get zero output about the system.  We don't even get information
>>>>>> about the caches which are architecturally specified or how many cpus
>>>>>> are present.  With this change, we get what we expect out of lscpu (and
>>>>>> also lstopo) including the cache(s) which are not architecturally
>>>>>> specified.
>>>>>>
>>>>> lscpu and lstopo are so broken. They just assume everything on CPU0.
>>>>> If you hotplug them out, you start seeing issues. So reading and file
>>>>> that doesn't exist and then bail out on other essential info though they
>>>>> are present, hmmm ...
>>>> Can you elaborate?
>>>>
>>>> I am not sure cpu0 is supposed to be offlineable on Linux. There's no
>>>> "online" file in /sys/devices/system/cpu/cpu0. That's why former lstopo
>>>> doesn't like CPU0 being hotplugged out. We are actually making that case
>>>> work for another non-standard corner case. But offlining "cpu0" this is
>>>> considered "normal", somebody must add that missing "online" sysfs
>>>> attribute for "cpu0" (change
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/base/cpu.c#L375).
>>> On x86 you can't normally offline CPU0, its something to do with certain
>>> interrupts always being routed to CPU0, (oh, and hibernate).
>>> You should be able to enable this behaviour with 'cpu0_hotplug' on the kernel
>>> command line.
>>>
>>> (Kconfig's CONFIG_BOOTPARAM_HOTPLUG_CPU0 and CONFIG_DEBUG_HOTPLUG_CPU0 are also
>>> worth a look)
>>>
>>> On arm64 at least, cpu0 is just like the others, and can be offlined.
>>>
>> Thanks James, for providing all the details.
>>
>> To add to the issues I spotted with lscpu/lstopo around topology, it ignores
>> the updates to topology sibling masks when CPUs are hotplugged in and out.
>>
>> We have following in lscpu:
>> 	add_summary_n(tb, _("Core(s) per socket:"),
>> 			cores_per_socket ?: desc->ncores / desc->nsockets);
>>
>> Now when cores_per_socket = 1, (i.e when we don't have procfs entry),
>> if ncores = (ncores_max - few_cpus_hotplugged_out), core(s) per socket
>> will get computed as less than the actual number.
>>
>> IMO lscpu should be used only when all CPUs are online and it should have
>> a warning when all cores are not online.
>>
>>>> By the way, did anybody actually see an error with lstopo when there's
>>>> no "type" attribute for L3? I can't reproduce any issue, we just skip
>>>> that specific cache entirely, but everything else appears. If you guys
>>>> want to make that "no_cache" cache appear, I'll make it a Unified cache
>>>> unless you tell me what to show :)
>> IIUC, Jeffrey Hugo did see error as per his initial message:
>> "
>> This fixes the following lscpu issue where only the cache type sysfs file
>> is missing which results in no output providing a poor user experience in
>> the above system configuration.
>> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
>> file or directory
>> "
>>
> 
> I don't know about lscpu (it's a different project), but lstopo
> shouldn't have any such problem.
> 
> If you see an issue with lstopo, I'd be interesting in getting the
> tarball generated by hwloc-gather-topology (it dumps useful files from
> procfs and sysfs so that we may debug offline).

No error was reported with lstopo, but we don't see the cache as 
expected.  Fixing the type results in the expected lstopo output.  This 
seems consistent with your expectations.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
