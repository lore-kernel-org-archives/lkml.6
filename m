Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeCZOKx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:10:53 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:39091 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbeCZOKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:10:51 -0400
X-Google-Smtp-Source: AIpwx4/Gqc75E7pEw3GjNIhuXRa3bYFpz1BRb3A9g21euQZzkJO/7CCfq9cRVOp5tIWgqugxtONZGi6E70r7K+ieWEA=
MIME-Version: 1.0
In-Reply-To: <20180326002732.qks4cp7qq2xzysnx@linux-n805>
References: <1521951444-5087-1-git-send-email-wanpengli@tencent.com> <20180326002732.qks4cp7qq2xzysnx@linux-n805>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon, 26 Mar 2018 22:10:50 +0800
Message-ID: <CANRm+CxaDNcVdySSH7O3ikyhbmpO9ZVGRx9GxL2gi28s9RoqVQ@mail.gmail.com>
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

2018-03-26 8:27 GMT+08:00 Davidlohr Bueso <dave@stgolabs.net>:
> On Sat, 24 Mar 2018, Wanpeng Li wrote:
>
>> Note: Peterz pointed out in the IRC we have to audit all the architectures
>> that
>> implement smp_prepare_boot_cpu() to see what they depend on if we want to
>> move
>> jump_label_init() before smp_prepare_boot_cpu(). So what this patch does
>> is
>> similar to the issue which handled in xen ca5d376e.
>
>
> After some auditing, the jump_label_init() being moved before
> smp_prepare_boot_cpu()
> seems fine, however, bulky mechanisms to update text segments conflict with
> early smp
> bootup stages, such as this patch. So, while the disabling

I didn't see any issue when testing this patch, could you elaborate
what's the bulky mechanism and how it conflicts with early smp bootup
stages? In addition, do you mean the xen fix is also not suitable?

Regards,
Wanpeng Li
