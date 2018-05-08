Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754556AbeEHHzk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:55:40 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32997 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbeEHHzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:55:38 -0400
X-Google-Smtp-Source: AB8JxZrK3C/ri+GhUFeCWfeMa7r/P/n/tcglnpK4OOaD5NOVk4c7peOdx2CS9hDnMQlCSYqi7DbIfuDACec27EquQXM=
MIME-Version: 1.0
In-Reply-To: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 8 May 2018 15:55:37 +0800
Message-ID: <CANRm+CzEdE2xMWju56g8jPVAHQ7BTue_=CV+zP6_46dpfb3Kgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] KVM: VMX: Allow to disable ioport intercept per-VM by userspace
To: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w487tkcF028571

2018-04-17 13:45 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> Tim Shearer reported that "There is a guest which is running a packet
> forwarding app based on the DPDK (dpdk.org). The packet receive routine
> writes to 0xc070 using glibc's "outw_p" function which does an additional
> write to I/O port 0x80. It does this write for every packet that's
> received, causing a flood of KVM userspace context switches". He uses
> mpstat to observe a CPU performing L2 packet forwarding on a pinned
> guest vCPU, the guest time is 95 percent when allowing I/O port 0x80
> bypass, however, it is 65.78 percent when I/O port 0x80 bypss is
> disabled.
>
> This patchset introduces per-VM I/O permission bitmaps, the userspace
> can disable the ioport intercept when they are more concern the
> performance than the security.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Tim Shearer <tshearer@advaoptical.com>
> Cc: Liran Alon <liran.alon@oracle.com>
>

Hi Paolo,

Did you send the patch to glibc or the patchset still can be considered?

Regards,
Wanpeng Li

> Wanpeng Li (3):
>   KVM: VMX: Introduce per-VM I/O permission bitmaps
>   KVM: X86: Allow userspace to disable ioport intercept
>   KVM: VMX: Allow I/O port 0x80 bypass when userspace prefer
>
>  Documentation/virtual/kvm/api.txt | 11 +++++++++++
>  arch/x86/include/asm/kvm_host.h   |  2 ++
>  arch/x86/kvm/vmx.c                | 41 ++++++++++++++++++++++++++++++++++++---
>  arch/x86/kvm/x86.c                |  5 +++++
>  include/uapi/linux/kvm.h          |  1 +
>  5 files changed, 57 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>
