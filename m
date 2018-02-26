Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeBZLrd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:47:33 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40450 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeBZLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:47:30 -0500
X-Google-Smtp-Source: AH8x225bW7QROil50ejd7Qfp77zJnRWwJvPPBALccSi2OLV/P9PHpQgA2Flx+Dp3cgWh527Vmsdrqw==
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
To: Borislav Petkov <bp@alien8.de>, Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
 <20180226094148.GA15539@pd.tnic>
 <CANRm+CzODxLQ4UHgFCnpjABmBUvi9sbw=uyO1xk1dyWgnH86ig@mail.gmail.com>
 <20180226104921.GA4377@pd.tnic>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eeae3e95-c908-695a-043f-a99f8ed39919@redhat.com>
Date: Mon, 26 Feb 2018 12:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226104921.GA4377@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 11:49, Borislav Petkov wrote:
>> I think it is the host admin(e.g. cloud provider)'s responsibility to
>> set an expected microcode revision.
> +       vcpu->arch.microcode_version = 0x1;
> 
> That already looks pretty arbitrary and non-sensical to me.

It's actually 0x100000000.

>> In addition, the non-sensical value which is written by the guest will
>> not reflect to guest-visible microcode revision and just be ignored in
>> this implementation.
>
> Huh? How so?
> 
> So a guest will have *two* microcode revisions - both of which are most
> likely wrong?!

I don't understand this either.

Actually I think this patch makes sense, since some errata actually can
be worked around in the guest in the same way as the host.  However, it
should also be tied to the recently introduced mechanism to read MSR
contents from the host.

Paolo
