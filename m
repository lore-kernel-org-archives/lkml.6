Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D95AECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11930214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZicL4k21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11930214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeIRVKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:10:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44687 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeIRVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:10:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id 36-v6so2413141oth.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JsrlVcbNVbTpEC2TzUJQc63GNzsnC4B85kVDGV7b4/w=;
        b=ZicL4k217qmklNsegG3Avst8OpsT+k2BOunljLhi8F4x0O9ve+3STyBKnVkUzJtLV4
         jbTlah1iIaXGGGOuL4HYEN90t61aCs66XlAyyFpHF66WzAtOxJfhBCqQavM/lLETCiet
         sm0OnLx1/M8o0rpdOAZYUqWmLkQKL+iVmyF1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JsrlVcbNVbTpEC2TzUJQc63GNzsnC4B85kVDGV7b4/w=;
        b=FU8kjILRtimF08R1M6uXk6LnbFKa/6WbYPzo0xthgLW3JWjuujn8uCad9G1xjoIKk7
         oMAyAPxCYw29NY4/2sAQhj4BwxxXiScEbGX/USyFzXNonx9bYyibGbLEpfxsZI/e8G5x
         r7BBCmgG3lmtvuScyQ4fYeQ4n25NzHvwv7nDGTrKd4uogSZm5NTAYB6oDaZaQVDAU6+T
         TFa+bl6RfxxNnStA8Tg/r3uHfv3bS1ees0aJ4K34auGZ9juC0P0X66thJ6sk5RoKT1A2
         1jMXlwDZKd+oIOEUJ/EDZSvjsMANgF+pYbixan1gkmIPW6fBTLWcdiSd/IQdB7lwI8q3
         1Kqg==
X-Gm-Message-State: APzg51CqDjp5F+9hkqAWiXiBVAklBYqNr/iXYwHIQXtB4xypyV9wHBB7
        7zwxiySHxf9WZlwCFFk7PrRY119NdA/ulvzLcGgGVw==
X-Google-Smtp-Source: ANB0VdYXZMI5O5Dgv7x4/+athkOLGZgNwJAf+hrFdfJBGiLbjBC8B3fxQYs7lZYDbcg0Y1DVgmbIpmb639oBg/Gt/CY=
X-Received: by 2002:a9d:32c3:: with SMTP id u61-v6mr15570740otb.173.1537285035759;
 Tue, 18 Sep 2018 08:37:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e3:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 08:36:55
 -0700 (PDT)
In-Reply-To: <218b64d5-741d-97ef-8aae-bc0a2ac3e56c@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com> <CAFEAcA8eWYkzwFYHyP49dasK-NDVbbm=6DbEFNNPq9ZAdUM7JQ@mail.gmail.com>
 <218b64d5-741d-97ef-8aae-bc0a2ac3e56c@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 18 Sep 2018 16:36:55 +0100
Message-ID: <CAFEAcA8qjJJ0FkQj4yBMKFrwNFiJj3Q4FBi4GbnK2PN3B3J-mg@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 September 2018 at 16:16, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> Hi Peter,
>
> On 18/09/2018 02:55, Peter Maydell wrote:
>>
>> On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com>
>> wrote:
>>>
>>> --- a/Documentation/virtual/kvm/api.txt
>>> +++ b/Documentation/virtual/kvm/api.txt
>>> @@ -122,6 +122,14 @@ the default trap & emulate implementation (which
>>> changes the virtual
>>>   memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
>>>   flag KVM_VM_MIPS_VZ.
>>>
>>> +To configure the physical address space size for a VM (IPA size) on
>>> arm64,
>>> +check KVM_CAP_ARM_VM_PHYS_SHIFT (which returns the maximum limit for the
>>> +IPA shift) and use KVM_VM_TYPE_ARM_PHYS_SHIFT(PHYS_SHIFT). Bits[7-0] of
>>> the
>>> +machine type has been reserved for specifying the PHYS_SHIFT.
>>> +The supported range is [32...IPA_LIMIT], where IPA_LIMIT could be
>>> +identified by checking KVM_CAP_ARM_VM_PHYS_SHIFT. For backward
>>> compatibility
>>> +a value of 0 selects 40bits.
>>> +
>>
>>
>> Given this as the API documentation, I don't think I could figure out
>> what I as a userspace user of it need to do without looking at the
>> kernel code. Could I ask you to expand it so that it is a bit less
>> terse and a bit more detailed? (For instance, what is a PHYS_SHIFT
>> and why do I have to specify it rather than just telling the kernel
>> I want a 48 bit guest address space?)
>
>
> Thanks for the feedback.  I acknowledge that the documentation is not
> quite clear for a userspace user. How about:
>
> "To configure the physical address space size for a VM (IPA size) on arm64,
> check KVM_CAP_ARM_VM_IPA_SIZE and use KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits)
> as the argument to KVM_CREATE_VM, where IPA_Bits is the maximum width of
> any physical address used by the VM. The IPA_Bits is encoded in Bits[7-0]
> of the machine type, and must be one of { 0, 32, ... , Host_IPA_Limit },
> where :
> 1) IPA_Bits = 0 implies 40bits IPA (for backward compatibility)
> 2) Host_IPA_Limit is the maximum limit for IPA_Bits on the host, which is
>    dependent on the CPU capability and the host kernel configuration.
>    This can be detected by checking the extension KVM_CAP_ARM_VM_IPA_SIZE
> "

I think this is still somewhat confusing. In particular, you're
describing both the "ask the kernel what it supports" API and
the "tell the kernel what we want" API in a single sentence
("...check KVM_CAP_ARM_VM_IPA_SIZE and use KVM_VM_TYPE_ARM_IPA_SIZE...").
There isn't a length limit on documentation, so why not describe
them both clearly in separate sentences?

Also, can I use any IPA value between 32 and Host_IPA_Limit, or
are only certain values in that range supported (if so, which)?

> note: I have renamed the KVM_CAP_ARM_VM_PHYS_SHIFT =>
> KVM_CAP_ARM_VM_IPA_SIZE
> above and can update the code, if the latter is better.

I think the new name is definitely clearer, thanks.

-- PMM
