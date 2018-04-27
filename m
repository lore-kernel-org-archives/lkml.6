Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759064AbeD0TqB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:46:01 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33778 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758703AbeD0Tp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:45:59 -0400
X-Google-Smtp-Source: AB8JxZqRVyNZSKDs4wKsDwjUJpbAG++N+y9M4lRkHeZ75Qc84LuFGGX6Uhx0W4IUAZA9ZupEHxHjBLor+4dc7p83m64=
MIME-Version: 1.0
In-Reply-To: <20180427193204.GD23874@flask>
References: <20180423080512.1614520-1-arnd@arndb.de> <20180427193204.GD23874@flask>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 21:45:58 +0200
X-Google-Sender-Auth: bnTQnsrJCeZMCLl0uij_nf8GL_w
Message-ID: <CAK8P3a0exO_uFUhhOL1FVgToe7_FEbYrCOvyAXSgZRfVqY4M+w@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] KVM: x86: use timespec64 for KVM_HC_CLOCK_PAIRING
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3RJk75u015182

On Fri, Apr 27, 2018 at 9:32 PM, Radim Krčmář <rkrcmar@redhat.com> wrote:
> 2018-04-23 10:04+0200, Arnd Bergmann:
>> The hypercall was added using a struct timespec based implementation,
>> but we should not use timespec in new code.
>>
>> This changes it to timespec64. There is no functional change
>> here since the implementation is only used in 64-bit kernels
>> that use the same definition for timespec and timespec64.
>>
>> Fixes: 55dd00a73a51 ("KVM: x86: add KVM_HC_CLOCK_PAIRING hypercall")
>
> (Removed the "Fixes:" tag as it doesn't really change behavior.)
>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> I originally sent this in October, but got no reply. The patch
>> is still required for the overall cleanup of 'timespec' uses
>> in the kernel, please apply.
>
> Queued now, thanks!
>
> Anything we need to do for the x86_platform_ops switch?

I think it's on me to resend what I have. That patch is one of the few
remaining ones in my backlog for y2038 after having sent out
some 50 other patches (some new, some old).

It has been in my testing tree since October though and not shown
any regressions for a while (I had to do one modification after
Jailhouse got merged), so I'll just send it out now.

       Arnd
