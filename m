Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeBZLZe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:25:34 -0500
Received: from mail-ot0-f178.google.com ([74.125.82.178]:40852 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbeBZLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:25:29 -0500
X-Google-Smtp-Source: AG47ELtgZBWrg+o14DYQ8KedCvfOaIJQw3Emv/R+Vt9p0mtFZF8QboQHSeqh+Vjm6F/leAQGEVolAkjcxDeq7eQPYo4=
MIME-Version: 1.0
In-Reply-To: <20180226111630.GB4377@pd.tnic>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic> <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic> <CANRm+Cy+Cr1-AMwM+u20X53=GqY0zfOugFypZcZwyJmnnwNNwA@mail.gmail.com>
 <20180226111630.GB4377@pd.tnic>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 26 Feb 2018 19:25:28 +0800
Message-ID: <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 19:16 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> On Mon, Feb 26, 2018 at 07:02:29PM +0800, Wanpeng Li wrote:
>> > So a guest will have *two* microcode revisions - both of which are most
>> > likely wrong?!
>>
>> Just one revision.
>
> So what does "the non-sensical value which is written by the guest will
> not reflect to guest-visible microcode revision" even mean then?
>
> cat /proc/cpuinfo
>
> in the guest shows what exactly?
>
> And what would RDMSR 0x8b show then?

Both are the same values set by kvm userspace.

>
>> https://lkml.org/lkml/2017/12/9/29 The original discussion explain in
>> more details.
>

> approach. Instead, the kernel should not look at microcode revisions if
> it runs virtualized.

This is correct. The link explains why the userspace sets microcode
revision is still needed.

Regards,
Wanpeng Li
