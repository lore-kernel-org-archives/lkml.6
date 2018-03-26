Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCZWov (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:44:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:45194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752069AbeCZWot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:44:49 -0400
Date: Mon, 26 Mar 2018 15:32:32 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Kr??m??? <rkrcmar@redhat.com>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] KVM: X86: Fix setup the virt_spin_lock_key before
 static key get initialized
Message-ID: <20180326223232.ifaoc3zyjii4gq2f@linux-n805>
References: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
 <20180326002732.qks4cp7qq2xzysnx@linux-n805>
 <CANRm+CxaDNcVdySSH7O3ikyhbmpO9ZVGRx9GxL2gi28s9RoqVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CANRm+CxaDNcVdySSH7O3ikyhbmpO9ZVGRx9GxL2gi28s9RoqVQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018, Wanpeng Li wrote:

>I didn't see any issue when testing this patch, could you elaborate
>what's the bulky mechanism and how it conflicts with early smp bootup
>stages? In addition, do you mean the xen fix is also not suitable?

I have nothing against your patch (or the xen one for that matter), other than
the fact that both seem like band-aid solutions to being able to move up the jump
label init call. I was actually peddling a similar patch but didn't want to add
the extra callback just for that -- at least xen already had smp_ops.smp_prepare_cpus.

Instead of dropping the patches in -tip (ie: delaying the feature), I have nothing
against these fixes being merged. If a better solution is available later, we can
always move dealing with virt_spin_lock_key back into smp_prepare_boot_cpu().

Also a bit unrelated, but am I correct to assume that KVM_HINTS_DEDICATED can be
used via qemu? I've only been dealing with kernel parameters.

Thanks,
Davidlohr
