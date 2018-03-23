Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbeCWO2N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:28:13 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46934 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbeCWO17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:27:59 -0400
X-Google-Smtp-Source: AG47ELt7ZG/0y8pKt0xg2hu5Nw7oK4uvQaeHk7o/3ulHICaNXf4HLaZudXdrnROAwKy5P65ZlEdE10DYTurZ5c/LWvw=
MIME-Version: 1.0
In-Reply-To: <94bbfac5-2022-ab92-0b9a-1c3cd2275054@citrix.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com> <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com> <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
 <9bd82cb0-d88f-4891-a111-3704802e1d4e@redhat.com> <CANRm+CwmJQCFZ7oe1_YatqoOXzzEU+SP9Z5qR6zU_ybd_DoGQQ@mail.gmail.com>
 <94bbfac5-2022-ab92-0b9a-1c3cd2275054@citrix.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 23 Mar 2018 22:27:57 +0800
Message-ID: <CANRm+CwsFX7rVkPvENRM20D84zotonxFFJMSq98icS4BQm7o2Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit mode
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-22 21:53 GMT+08:00 Andrew Cooper <andrew.cooper3@citrix.com>:
> On 22/03/18 13:39, Wanpeng Li wrote:
>> 2018-03-22 20:38 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>> On 22/03/2018 12:04, Andrew Cooper wrote:
>>>> We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
>>>> magic.  Originally, this was used for PV guests to explicitly request an
>>>> emulated CPUID, but I extended it to HVM guests for "emulate the next
>>>> instruction", after we had some guest user => guest kernel privilege
>>>> escalations because of incorrect emulation.
>>> Wanpeng, why don't you add it behind a new kvm module parameter? :)
>> Great point! I will have a try. Thanks Paolo and Andrew. :)
>
> Using the force emulation prefix requires intercepting #UD, which is in
> general a BadThing(tm) for security.  Therefore, we have a build time

Yeah, however kvm intercepts and emulates #UD by default, should we
add a new kvm module parameter to enable it and disable by default?
Paolo.

> configuration option to compile in support, and require that test
> systems explicitly opt into using it via a command line parameter.
>
> http://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/x86/hvm/hvm.c;h=db52312882205e65b32e587106ca795f4bfab2eb;hb=refs/heads/staging#l3741
> is the general #UD intercept handler if you want a reference.  (You can

Thanks Andrew, it is useful. :) In addition, I didn't see the
test-memop-seg testcase has "Forced Emulation Prefix", when the prefix
is added to each instruction in the testcase?

Regards,
Wanpeng Li
