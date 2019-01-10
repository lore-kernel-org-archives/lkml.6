Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CD7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18E6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAJKMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:12:25 -0500
Received: from foss.arm.com ([217.140.101.70]:59304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbfAJKMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:12:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 223E280D;
        Thu, 10 Jan 2019 02:12:24 -0800 (PST)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F17A93F694;
        Thu, 10 Jan 2019 02:12:22 -0800 (PST)
Subject: Re: [PATCH] ARM: irq: Add IRQ_SET_MASK_OK_DONE handling in
 migrate_one_irq()
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
References: <20190108135805.5535-1-dietmar.eggemann@arm.com>
 <9288fdeb-8eb1-28ca-f950-ccf36d63688a@arm.com>
 <1fcb35b7-4105-e4b7-a528-eb48be876edf@arm.com>
 <9235d4df-55b8-2f33-a992-abab64e35347@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <29e5c472-40b0-f7e2-e04e-ef3093f997a6@arm.com>
Date:   Thu, 10 Jan 2019 11:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9235d4df-55b8-2f33-a992-abab64e35347@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/19 5:21 PM, Marc Zyngier wrote:
> On 09/01/2019 15:47, Dietmar Eggemann wrote:
>> Hi Marc,
>>
>> On 1/8/19 3:16 PM, Marc Zyngier wrote:
>>> Hi Dietmar,
>>>
>>> On 08/01/2019 13:58, Dietmar Eggemann wrote:

[...]

>>> On the arm64 side, we've solved the exact same issue by getting rid of
>>> this code and using the generic implementation. See 217d453d473c5
>>> ("arm64: fix a migrating irq bug when hotplug cpu"), which uses
>>> irq_migrate_all_off_this_cpu instead.
>>>
>>> I'm not sure there is much value in not using the core code in this case.
>>
>> Thanks for the hint! Much more elegant! I tried the following on TC2 and
>> it worked just fine. I'm not aware on any drawbacks of using the generic
>> irq migration for Arm32 as well.
> 
> [...]
> 
> Sounds great! Can you put it in a proper patch and resend it?

Yes. I renamed the patch to "arm: fix a migrating irq bug when hotplug 
cpu" so it's closer to its arm64 counterpart patch.

https://lore.kernel.org/lkml/20190110100922.20280-1-dietmar.eggemann@arm.com/
