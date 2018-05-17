Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeEQHGF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 03:06:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750779AbeEQHGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 03:06:03 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: KY Srinivasan <kys@microsoft.com>
Cc: "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex} definitions to common header
References: <20180516152131.30689-1-vkuznets@redhat.com>
        <20180516152131.30689-2-vkuznets@redhat.com>
        <MW2PR2101MB1113225D3DBAF5A62FAA990AA0920@MW2PR2101MB1113.namprd21.prod.outlook.com>
Date: Thu, 17 May 2018 09:05:58 +0200
In-Reply-To: <MW2PR2101MB1113225D3DBAF5A62FAA990AA0920@MW2PR2101MB1113.namprd21.prod.outlook.com>
        (KY Srinivasan's message of "Wed, 16 May 2018 15:52:45 +0000")
Message-ID: <87d0xuiwx5.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KY Srinivasan <kys@microsoft.com> writes:

>> -----Original Message-----
>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Sent: Wednesday, May 16, 2018 8:21 AM
>> To: kvm@vger.kernel.org
>> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim Krčmář
>> <rkrcmar@redhat.com>; Roman Kagan <rkagan@virtuozzo.com>; KY
>> Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; Stephen Hemminger
>> <sthemmin@microsoft.com>; Michael Kelley (EOSG)
>> <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
>> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH v4 1/8] x86/hyper-v: move struct hv_flush_pcpu{,ex}
>> definitions to common header
>> 
>> Hyper-V TLB flush hypercalls definitions will be required for KVM so move
>> them hyperv-tlfs.h. Structures also need to be renamed as '_pcpu' suffix is
>> irrelevant for a general-purpose definition.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/hyperv/mmu.c              | 40 ++++++++++----------------------------
>>  arch/x86/include/asm/hyperv-tlfs.h | 20 +++++++++++++++++++
>>  2 files changed, 30 insertions(+), 30 deletions(-)
>
> Vitaly,
>
> We should  coordinate on this; I have patches in flight that conflict with
> the changes here.

I see you also fixed 'HV_GENERIC_SET_SPARCE_4K' typo. I don't think it's
a big deal as we fix it in the same way :-)

I see you also altered hv_flush_pcpu_ex definition but kept it in mmu.c:
I think my patches should be applied on top of yours, I only need to
move it to hyperv-tlfs.h header and get rid of _pcpu suffix.

I hope Thomas will merge your patches very soon. In case Paolo/Radim
decide that my series is ready too we'll ask their guidance on how to
resolve the conflict (topic branch?). It should be relatively easy.

Thanks,

-- 
  Vitaly
