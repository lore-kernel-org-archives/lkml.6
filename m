Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeBLLbd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:31:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934034AbeBLLba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:31:30 -0500
Subject: Re: [PATCH] KVM: lapic: stop advertising DIRECTED_EOI when in-kernel
 IOAPIC is in use
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180209130133.28387-1-vkuznets@redhat.com>
 <20180211052539.GA31261@xz-mi> <87r2pqxx6r.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d3e535c-3f26-0a7e-efd7-fd55fd4928e8@redhat.com>
Date: Mon, 12 Feb 2018 12:31:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87r2pqxx6r.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2018 12:30, Vitaly Kuznetsov wrote:
>> - Radim's suggestion was to disable DIRECTED_EOI unconditionally but I'm not
>>   that radical :-) In theory, we may have multiple IOAPICs in userspace in
>>   future and DIRECTED_EOI can be leveraged.
> 
> I sort of agree on this, especially considering that we already have
> IOAPIC version 0x20 support in QEMU already.

Yeah, and directed EOI is faster AFAIU.

> My thoughts were: with in-kernel IOAPIC nobody does EOI broadcast
> disabling today or he's already broken -- there's no way to EOI
> level-triggered interrupts. And the patch changes nothing for QEMU
> ioapic implementation.
> 
> What I'm not sure about is if we allow migration between in-kernel and
> QEMU ioapic implementations. I don't think so but in case we do it is
> again already broken because going down from 0x20 to 0x11 will leave you
> without EOI register. Migrating from 0x11 to 0x20 should be fine, the
> guest will continue without knowing there's a new feature available.

No, we don't allow that.

Paolo
