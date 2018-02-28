Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933719AbeB1RnJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:43:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752647AbeB1RnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:43:07 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH 1/3] x86/kvm/hyper-v: add reenlightenment MSRs support
References: <20180228134401.6544-1-vkuznets@redhat.com>
        <20180228134401.6544-2-vkuznets@redhat.com>
        <20180228164822.GA12531@rkaganb.sw.ru>
Date: Wed, 28 Feb 2018 18:43:00 +0100
In-Reply-To: <20180228164822.GA12531@rkaganb.sw.ru> (Roman Kagan's message of
        "Wed, 28 Feb 2018 19:48:22 +0300")
Message-ID: <87efl5ggd7.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Wed, Feb 28, 2018 at 02:43:59PM +0100, Vitaly Kuznetsov wrote:
>> Nested Hyper-V/Windows guest running on top of KVM will use TSC page
>> clocksource in two cases:
>> - L0 exposes invariant TSC (CPUID.80000007H:EDX[8]).
>> - L0 provides Hyper-V Reenlightenment support (CPUID.40000003H:EAX[13]).
>> 
>> Exposing invariant TSC effectively blocks migration to hosts with different
>> TSC frequencies,
>
> I wonder if TSC scaling on the destination host doesn't allow to relax
> this requirement?

I don't see why it wouldn't, Skylake+ should be fine (but this, of
course, will limit possible destination hosts to those supporting the
feature -- even if no other CPU features are required).

>> providing reenlightenment support will be needed when we
>> start migrating nested workloads.
>> 
>> Implement rudimentary support for reenlightenment MSRs. For now, these are
>> just read/write MSRs with no effect.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |  4 ++++
>>  arch/x86/kvm/hyperv.c           | 21 +++++++++++++++++++++
>>  arch/x86/kvm/x86.c              | 12 +++++++++++-
>>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>

Thanks!

-- 
  Vitaly
