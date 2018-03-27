Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeC0H3c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:29:32 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:40377 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeC0H3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:29:30 -0400
X-Google-Smtp-Source: AG47ELuKttJ+Krh54W8fx4dmgRJbkMt7iOdYGdASeSEIp4UtPJLLNzcyFFbHbo+cq41c+P5h272yBFsqd5sPZ0deIvA=
MIME-Version: 1.0
In-Reply-To: <0ad9fff9-6ebb-2d63-5c9f-b9aba7d619ac@redhat.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-3-git-send-email-wanpengli@tencent.com> <20180327044020.GB16974@char.us.oracle.com>
 <20180327045558.GC16974@char.us.oracle.com> <CANRm+Cw7VVNmA=DvrzbUDoTQZ_O2sTQVJiu-v-fVt+e3jfB_gw@mail.gmail.com>
 <20180327051840.GF16974@char.us.oracle.com> <0ad9fff9-6ebb-2d63-5c9f-b9aba7d619ac@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 27 Mar 2018 15:29:29 +0800
Message-ID: <CANRm+CzY+zLhfUeW5cRzNzC8TnSeCTdnkkYa5=QUSxqj=JgSrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-27 15:25 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 27/03/2018 07:18, Konrad Rzeszutek Wilk wrote:
>>> I think a global module is enough for testing.
>> If so, perhaps have it wrapped with #ifdef DEBUG?
>>
>> No need to put code gadgets that won't be utilized 99% of time.
>
> It is going to be used a lot in testing, actually.  There are quite a
> few emulate.c bugfixes that are hard to test (see for example the
> syscall eflags.tf bug that can currently be tested only on Intel) and
> having something like this can only improve our coverage.
>
> #ifdef DEBUG is almost always a bad idea, and though I agree that the
> commit messages can be improved, I think the module parameter is the way
> to go.
>
> Wanpeng, can you also add it to svm.c?

Yeah, thanks for the review. :)

Regards,
Wanpeng Li
