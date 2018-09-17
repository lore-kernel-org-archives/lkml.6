Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5A62088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5A62088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeIQULh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:11:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbeIQULg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:11:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97F93ED1;
        Mon, 17 Sep 2018 07:43:57 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.4.13.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0903F5BD;
        Mon, 17 Sep 2018 07:43:55 -0700 (PDT)
Subject: Re: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave P Martin <dave.martin@arm.com>, julien.grall@arm.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com>
 <CAFEAcA-AKpkzSpMofMFxxf5XdYPii3PTB8xXDAvmyFWno7nZeA@mail.gmail.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <a3d37f11-3d09-390d-8df9-9635a9e55660@arm.com>
Date:   Mon, 17 Sep 2018 15:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AKpkzSpMofMFxxf5XdYPii3PTB8xXDAvmyFWno7nZeA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 17/09/2018 15:20, Peter Maydell wrote:
> On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> Allow specifying the physical address size limit for a new
>> VM via the kvm_type argument for the KVM_CREATE_VM ioctl. This
>> allows us to finalise the stage2 page table as early as possible
>> and hence perform the right checks on the memory slots
>> without complication. The size is ecnoded as Log2(PA_Size) in
>> bits[7:0] of the type field. For backward compatibility the
>> value 0 is reserved and implies 40bits. Also, lift the limit
>> of the IPA to host limit and allow lower IPA sizes (e.g, 32).
>>
>> The userspace could check the extension KVM_CAP_ARM_VM_PHYS_SHIFT
>> for the availability of this feature. The cap check returns the
>> maximum limit for the physical address shift supported by the host.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Peter Maydel <peter.maydell@linaro.org>
> 
> Typo: my surname has two "l"s in it.

Sorry about that. I have fixed this locally. Btw, did you get
a chance to look at the patch itself ? If you did, are you fine
with the API ?

Suzuki

