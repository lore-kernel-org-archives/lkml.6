Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5845C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BD023EF8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BD023EF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934093AbeGDI2u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:28:50 -0400
Received: from foss.arm.com ([217.140.101.70]:33152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933939AbeGDI2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:28:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75DDE7A9;
        Wed,  4 Jul 2018 01:28:45 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B5C73F5BA;
        Wed,  4 Jul 2018 01:28:42 -0700 (PDT)
Subject: Re: [PATCH v3 10/20] kvm: arm64: Dynamic configuration of VTTBR mask
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-11-git-send-email-suzuki.poulose@arm.com>
 <e0c8dc62-42e8-ee24-5519-e19b2739160b@redhat.com>
 <a6fa912a-b2ff-ac1e-0120-b2f7eabb6f7f@arm.com>
 <3192c7dc-4127-ec97-6ba3-262fa3ff6243@redhat.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1696a35f-9cd5-d807-f2e9-41d9f19d919a@arm.com>
Date:   Wed, 4 Jul 2018 09:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3192c7dc-4127-ec97-6ba3-262fa3ff6243@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 09:24 AM, Auger Eric wrote:
>>>> + *
>>>> + * We have a magic formula for the Magic_N below.
>>>> + *
>>>> + *  Magic_N(PAGE_SIZE, Entry_Level) = 64 - ((PAGE_SHIFT - 3) *
>>>> Number of levels)
>>
>> [0] ^^^
>>
>>
>>
>>>> + *
>>>> + * where number of levels = (4 - Entry_Level).
>>
>> ^^^ Doesn't this help make it clear ? Using the expansion makes it a bit
>> more
>> unreadable below.
> 
> I just wanted to mention the tables you refer (D4-23 and D4-25) give
> Magic_N for a larger scope as they deal with any lookup level while we
> only care about the entry level for BADDR. So I was a little bit
> confused when reading the explanation but that's not a big deal.

Ah, ok. I will try to clarify it.

Cheers
Suzuki
