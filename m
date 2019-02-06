Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5881BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2387520844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBFUHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:07:41 -0500
Received: from foss.arm.com ([217.140.101.70]:57800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBFUHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:07:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EFAF80D;
        Wed,  6 Feb 2019 12:07:41 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87B063F719;
        Wed,  6 Feb 2019 12:07:39 -0800 (PST)
Subject: Re: [PATCH] mm/memory-hotplug: Add sysfs hot-remove trigger
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, mhocko@kernel.org, akpm@linux-foundation.org
References: <29ed519902512319bcc62e071d52b712fa97e306.1549469965.git.robin.murphy@arm.com>
 <20190206184544.GA12326@kroah.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e73cf364-2034-2312-8ef9-c24d341f8f71@arm.com>
Date:   Wed, 6 Feb 2019 20:07:28 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190206184544.GA12326@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-06 6:45 pm, Greg KH wrote:
> On Wed, Feb 06, 2019 at 05:03:53PM +0000, Robin Murphy wrote:
>> ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
>> but being able to exercise the (arguably trickier) hot-remove path would
>> be even more useful. Extend the feature to allow removal of offline
>> sections to be triggered manually to aid development.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> This is inspired by a previous proposal[1], but in coming up with a
>> more robust interface I ended up rewriting the whole thing from
>> scratch. The lack of documentation is semi-deliberate, since I don't
>> like the idea of anyone actually relying on this interface as ABI, but
>> as a handy tool it felt useful enough to be worth sharing :)
>>
>> Robin.
>>
>> [1] https://lore.kernel.org/lkml/22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com/
>>
>>   drivers/base/memory.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> You have to add new Documentation/ABI entries for each new sysfs file
> you add :(

Ah, the documentation provided is adapted from the documentation for the 
existing "probe" attribute it builds upon ;)

But yeah, perhaps I should have tagged this post as an RFC. Much as I 
dislike it being anywhere near an ABI, if everyone thinks the feature is 
merge-worthy I'll go ahead and write up some proper doc entries too.

Robin.
