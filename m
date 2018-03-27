Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbeC0FDS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 01:03:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36577 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeC0FDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 01:03:17 -0400
X-Google-Smtp-Source: AIpwx49bImeVvTOLUvq6KC792oJbBZ64qTnMkM9nNZBVt4dDG1P/+HDN+CoSbSo1WM5m7PCCJyUayr2K9GlLaoTR0dw=
MIME-Version: 1.0
In-Reply-To: <20180327045558.GC16974@char.us.oracle.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-3-git-send-email-wanpengli@tencent.com> <20180327044020.GB16974@char.us.oracle.com>
 <20180327045558.GC16974@char.us.oracle.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 27 Mar 2018 13:03:15 +0800
Message-ID: <CANRm+Cw7VVNmA=DvrzbUDoTQZ_O2sTQVJiu-v-fVt+e3jfB_gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-27 12:55 GMT+08:00 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
> On Tue, Mar 27, 2018 at 12:40:20AM -0400, Konrad Rzeszutek Wilk wrote:
>> On Mon, Mar 26, 2018 at 07:12:15PM -0700, Wanpeng Li wrote:
>> > From: Wanpeng Li <wanpengli@tencent.com>
>> >
>> > This patch introduces a Force Emulation Prefix (ud2a; .ascii "kvm") for
>> > "emulate the next instruction", the codes will be executed by emulator
>> > instead of processor, for testing purposes.
>>
>> Can you expand a bit ? Why do you want this in KVM in the first place?

Please refer to the original discussion(Force Emulation Prefix part).
https://lkml.org/lkml/2018/3/22/220

>> Should this be controlled by a boolean parameter?
>
> .. per guest. That is instead of a global one, have a per guest one?

As Paolo pointed out offline:
> Testing without the hacks being done by emulator.flat (TLB mismatch between instructions and data).
I think a global module is enough for testing.

Regards,
Wanpeng Li
