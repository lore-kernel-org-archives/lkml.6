Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeELBDE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 21:03:04 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:32877 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeELBDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 21:03:03 -0400
X-Google-Smtp-Source: AB8JxZr0KkTMD9AAtfQi3AV68S83XMdilxD08WZrRRG3sKQ/SmLr5J9EDsmpFSL0yQ0HbYdmCyN6lboQQ3jvpZ4QOjs=
MIME-Version: 1.0
In-Reply-To: <20180511154019.GG27459@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com> <20180511154019.GG27459@char.us.oracle.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sat, 12 May 2018 09:03:02 +0800
Message-ID: <CANRm+CwkeQTLSOAWDMz8J+Ng5e6FPWABE94wWLZ2vbYA15H1DA@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: VMX: Allow to disable ioport intercept per-VM by userspace
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-11 23:40 GMT+08:00 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
> On Mon, Apr 16, 2018 at 10:45:59PM -0700, Wanpeng Li wrote:
>> Tim Shearer reported that "There is a guest which is running a packet
>> forwarding app based on the DPDK (dpdk.org). The packet receive routine
>> writes to 0xc070 using glibc's "outw_p" function which does an additional
>> write to I/O port 0x80. It does this write for every packet that's
>> received, causing a flood of KVM userspace context switches". He uses
>> mpstat to observe a CPU performing L2 packet forwarding on a pinned
>> guest vCPU, the guest time is 95 percent when allowing I/O port 0x80
>> bypass, however, it is 65.78 percent when I/O port 0x80 bypss is
>> disabled.
>>
>> This patchset introduces per-VM I/O permission bitmaps, the userspace
>> can disable the ioport intercept when they are more concern the
>> performance than the security.
>
> Could you kindly also add:
>
> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Yeah, both you and Liran give the original idea. :) Tim and Liran, any
review for the patchset?

Regards,
Wanpeng Li
