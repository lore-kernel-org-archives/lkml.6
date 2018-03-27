Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeC0AwU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:52:20 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:40733 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeC0AwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:52:19 -0400
X-Google-Smtp-Source: AIpwx4+8+L0tOZcw3l9DlHh1oBADoDLVFaR8U/Yvty/onFcSOBNy6wqP6LSZdguEBuUF5E1YAQRx1gG6xNF/e2Zbp/I=
MIME-Version: 1.0
In-Reply-To: <20180326223232.ifaoc3zyjii4gq2f@linux-n805>
References: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
 <20180326002732.qks4cp7qq2xzysnx@linux-n805> <CANRm+CxaDNcVdySSH7O3ikyhbmpO9ZVGRx9GxL2gi28s9RoqVQ@mail.gmail.com>
 <20180326223232.ifaoc3zyjii4gq2f@linux-n805>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 27 Mar 2018 08:52:18 +0800
Message-ID: <CANRm+Cw=x1YVSpX1Zcz=EkLFhojSa_zyTOLEiNX-Di3ENGmCiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: X86: Fix setup the virt_spin_lock_key before
 static key get initialized
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Radim Kr??m???" <rkrcmar@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-27 6:32 GMT+08:00 Davidlohr Bueso <dave@stgolabs.net>:
> On Mon, 26 Mar 2018, Wanpeng Li wrote:
>
>> I didn't see any issue when testing this patch, could you elaborate
>> what's the bulky mechanism and how it conflicts with early smp bootup
>> stages? In addition, do you mean the xen fix is also not suitable?
>
>
> I have nothing against your patch (or the xen one for that matter), other
> than
> the fact that both seem like band-aid solutions to being able to move up the
> jump
> label init call. I was actually peddling a similar patch but didn't want to
> add
> the extra callback just for that -- at least xen already had
> smp_ops.smp_prepare_cpus.
>
> Instead of dropping the patches in -tip (ie: delaying the feature), I have
> nothing
> against these fixes being merged. If a better solution is available later,
> we can
> always move dealing with virt_spin_lock_key back into
> smp_prepare_boot_cpu().

Yeah, we can pick the current patch for the fixes and wait a better
solution is available later.

>
> Also a bit unrelated, but am I correct to assume that KVM_HINTS_DEDICATED
> can be
> used via qemu? I've only been dealing with kernel parameters.

The host admin can control it by qemu command-line, -cpu ...+kvm-hint-dedicated

Regards,
Wanpeng Li
