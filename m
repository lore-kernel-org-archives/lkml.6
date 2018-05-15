Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeEOVzU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:55:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42435 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeEOVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:55:19 -0400
X-Google-Smtp-Source: AB8JxZrBuLyAcZVsUBZnlKL8pzcBpOqliwV9YUn7IxtLhfMYA3gbqxVci1Yv+kNwgMIrvQVvwRqTOqlOrW5R/Gp0JC4=
MIME-Version: 1.0
In-Reply-To: <20180511153922.GA31844@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <1523943962-25415-2-git-send-email-wanpengli@tencent.com> <20180511153922.GA31844@char.us.oracle.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 15 May 2018 14:55:17 -0700
Message-ID: <CALMp9eRLZO4Ou3W=1hJ93OyBp+-ykP4nefOSXeyZn-XePFBg+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: VMX: Introduce per-VM I/O permission bitmaps
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since these pages are typically not used, can we allocate them conditionally?

On Fri, May 11, 2018 at 8:39 AM, Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>>       /*
>> -      * A vmexit (to either L1 hypervisor or L0 userspace) is always needed
>> -      * for I/O port accesses.
>> +      * Merging of IO bitmap not currently supported.
>
> s/not/is not/
>
> And with that
>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>
> Thank you!
>> +      * Rather, exit every time.
>>        */
>>       exec_control &= ~CPU_BASED_USE_IO_BITMAPS;
>>       exec_control |= CPU_BASED_UNCOND_IO_EXITING;
>> --
>> 2.7.4
>>
