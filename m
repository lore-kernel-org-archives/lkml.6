Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935999AbeCHQ4O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:56:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935910AbeCHQzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:55:00 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Cc: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to HV_X64_MSR_VP_ASSIST_PAGE
References: <20180226171121.18974-1-vkuznets@redhat.com>
        <20180226171121.18974-2-vkuznets@redhat.com>
        <20180307161944.GE12290@flask> <20180307164812.GA2366@rkaganb.sw.ru>
        <20180307180442.GA16795@flask> <87lgf2yipt.fsf@vitty.brq.redhat.com>
        <DM5PR2101MB1030A704CDF4DF12E26141B9DCDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Date: Thu, 08 Mar 2018 17:54:54 +0100
In-Reply-To: <DM5PR2101MB1030A704CDF4DF12E26141B9DCDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
        (Michael Kelley's message of "Thu, 8 Mar 2018 16:29:04 +0000")
Message-ID: <87sh9ao6ch.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com> writes:

>> >> > Removing definitions from userspace api isn't a good idea.
>> >> >
>> >> > I have no idea why hyper.h is a userspace api, though -- Linux doesn't
>> >> > define any of those, so we could copy the definitions to a private
>> >> > header, rename, and never look at this file again.
>> >>
>> >> That was a thinko when it was moved to uapi, and it has already been
>> >> identified as a problem, so now QEMU has its own header with the
>> >> definitions it needs, and I'm unaware of any other userspace project
>> >> that depends on this stuff.  So I've been planning to remove it from
>> >> uapi but still haven't got around to posting the patch :(
>> >
>> > Great, let's be bold here.
>> 
>> asm/hyperv.h is not uapi.
>> 
>> I would include a patch renaming arch/x86/include/uapi/asm/hyperv.h to
>> arch/x86/include/asm/hyperv.h but we already have 'mshyperv.h' there and
>> I don't quite understand the difference. We can either merge them or
>> come up with a rule distinguishing them.
>> 
>> K. Y., Michael, what do you think?
>
> Good timing for this topic, as I'm now looking at cloning these two
> files into the arch/arm64 tree for Hyper-V on ARM64.  It would be great
> to get a plan agreed on so I can be consistent on the arm64 side.
>
> I would suggest keeping two files:  one with just the data structures and
> #defines that come from the Hyper-V Top-Level Functional Spec (TLFS),  
> and the other with additional data structures, macros, function prototypes,
> etc. that are specific to Linux guest code.   uapi/asm/hyperv.h is already
> the first one, and asm/mshyperv.h is mostly the second one, though it has
> some things that should probably move to the first one.   There are also a
> few stray definitions from the Hyper-V TLFS in drivers/pci/host/pci-hyperv.c
> (HVCALL_RETARGET_INTERRUPT and HV_PARTITION_ID_SELF, for example)
> that really belong in the first file.
>
> And since we're already changing the location of the first file, let's rename
> it to hyperv-tlfs.h or something similar.
>

Sounds good,

I'll add a patch or two to my eVMCS series.

Thanks!

-- 
  Vitaly
