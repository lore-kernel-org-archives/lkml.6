Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D58C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0067120861
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0067120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIMRCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 13:02:24 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:45221
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726919AbeIMRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 13:02:24 -0400
X-IronPort-AV: E=Sophos;i="5.53,368,1531778400"; 
   d="scan'208";a="278749449"
Received: from 155-88-168-194.static.virginm.net (HELO [10.151.103.231]) ([194.168.88.155])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES128-SHA; 13 Sep 2018 13:53:12 +0200
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Sudeep Holla <sudeep.holla@arm.com>,
        James Morse <james.morse@arm.com>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <f8dc2958-a7c7-a633-3a06-97fed7c3510b@arm.com>
 <4f253bf4-ef2d-849f-b793-9b0530e72aab@gmail.com>
 <c7e74980-eb5d-1b2a-8ebb-7210b4f507a2@arm.com>
 <20180913103525.GA7777@e107155-lin>
From:   Brice Goglin <brice.goglin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=brice.goglin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0f23136a-cfb7-8def-702a-87e02705f0d6@gmail.com>
Date:   Thu, 13 Sep 2018 12:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913103525.GA7777@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/09/2018 à 11:35, Sudeep Holla a écrit :
> On Thu, Sep 13, 2018 at 10:39:10AM +0100, James Morse wrote:
>> Hi Brice,
>>
>> On 13/09/18 06:51, Brice Goglin wrote:
>>> Le 12/09/2018 à 11:49, Sudeep Holla a écrit :
>>>>> Yes.  Without this change, we hit the lscpu error in the commit message,
>>>>> and get zero output about the system.  We don't even get information
>>>>> about the caches which are architecturally specified or how many cpus
>>>>> are present.  With this change, we get what we expect out of lscpu (and
>>>>> also lstopo) including the cache(s) which are not architecturally
>>>>> specified.
>>>>>
>>>> lscpu and lstopo are so broken. They just assume everything on CPU0.
>>>> If you hotplug them out, you start seeing issues. So reading and file
>>>> that doesn't exist and then bail out on other essential info though they
>>>> are present, hmmm ...
>>> Can you elaborate?
>>>
>>> I am not sure cpu0 is supposed to be offlineable on Linux. There's no
>>> "online" file in /sys/devices/system/cpu/cpu0. That's why former lstopo
>>> doesn't like CPU0 being hotplugged out. We are actually making that case
>>> work for another non-standard corner case. But offlining "cpu0" this is
>>> considered "normal", somebody must add that missing "online" sysfs
>>> attribute for "cpu0" (change
>>> https://elixir.bootlin.com/linux/latest/source/drivers/base/cpu.c#L375).
>> On x86 you can't normally offline CPU0, its something to do with certain
>> interrupts always being routed to CPU0, (oh, and hibernate).
>> You should be able to enable this behaviour with 'cpu0_hotplug' on the kernel
>> command line.
>>
>> (Kconfig's CONFIG_BOOTPARAM_HOTPLUG_CPU0 and CONFIG_DEBUG_HOTPLUG_CPU0 are also
>> worth a look)
>>
>> On arm64 at least, cpu0 is just like the others, and can be offlined.
>>
> Thanks James, for providing all the details.
>
> To add to the issues I spotted with lscpu/lstopo around topology, it ignores
> the updates to topology sibling masks when CPUs are hotplugged in and out.
>
> We have following in lscpu:
> 	add_summary_n(tb, _("Core(s) per socket:"),
> 			cores_per_socket ?: desc->ncores / desc->nsockets);
>
> Now when cores_per_socket = 1, (i.e when we don't have procfs entry),
> if ncores = (ncores_max - few_cpus_hotplugged_out), core(s) per socket
> will get computed as less than the actual number.
>
> IMO lscpu should be used only when all CPUs are online and it should have
> a warning when all cores are not online.
>
>>> By the way, did anybody actually see an error with lstopo when there's
>>> no "type" attribute for L3? I can't reproduce any issue, we just skip
>>> that specific cache entirely, but everything else appears. If you guys
>>> want to make that "no_cache" cache appear, I'll make it a Unified cache
>>> unless you tell me what to show :)
> IIUC, Jeffrey Hugo did see error as per his initial message:
> "
> This fixes the following lscpu issue where only the cache type sysfs file
> is missing which results in no output providing a poor user experience in
> the above system configuration.
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> "
>

I don't know about lscpu (it's a different project), but lstopo
shouldn't have any such problem.

If you see an issue with lstopo, I'd be interesting in getting the
tarball generated by hwloc-gather-topology (it dumps useful files from
procfs and sysfs so that we may debug offline).

Brice

