Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeBZLCe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:02:34 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42748 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBZLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:02:30 -0500
X-Google-Smtp-Source: AG47ELtDKpFzfHiMRNKArrlcmBF6+UHC7L+MsdXFd+qsBPewP3rI1S5gip9BFjWJqBUxtECieX9m6JvolKrdjtUXLGY=
MIME-Version: 1.0
In-Reply-To: <20180226104921.GA4377@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic> <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 26 Feb 2018 19:02:29 +0800
Message-ID: <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 18:49 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> On Mon, Feb 26, 2018 at 06:06:42PM +0800, Wanpeng Li wrote:
>> I think it is the host admin(e.g. cloud provider)'s responsibility to
>> set an expected microcode revision.
>
> +       vcpu->arch.microcode_version = 0x1;
>
> That already looks pretty arbitrary and non-sensical to me.

This is the original kvm implementation before the patch.

>
>>In addition, the non-sensical value which is written by the guest will
>>not reflect to guest-visible microcode revision and just be ignored in
>>this implementation.
>
> Huh? How so?
>
> So a guest will have *two* microcode revisions - both of which are most
> likely wrong?!

Just one revision.

>
> This whole thing sounds like the wrong approach to me.
>
>> Linux (among the others) has checks to make sure that certain features
>> aren't enabled on a certain family/model/stepping if the microcode version
>> isn't greater than or equal to a known good version.
>
> It sounds to me like the proper fix is to make the kernel *not* look at
> microcode revisions when running virtualized. The same way we're not
> loading microcode in a guest:
>
>         if (native_cpuid_ecx(1) & BIT(31))
>
> Letting userspace control the microcode revision number is revision
> number management SNAFU waiting to happen IMO.

https://lkml.org/lkml/2017/12/9/29 The original discussion explain in
more details.

Regards,
Wanpeng Li
