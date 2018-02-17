Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751122AbeBQKSF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:18:05 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38022 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeBQKSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:18:04 -0500
X-Google-Smtp-Source: AH8x226fkz95/kT3/SWG7oSi5AAJM/TWwYNDWeM2toE0yxaTwmmdltyP5l0tmfJduNihgX7wudqNiA==
Date: Sat, 17 Feb 2018 11:17:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org, douly.fnst@cn.fujitsu.com,
        joro@8bytes.org, uobergfe@redhat.com, prarit@redhat.com
Subject: Re: [PATCH v5 0/6] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180217101759.4hn7tdqgudxcq4rk@gmail.com>
References: <20180214054656.3780-1-bhe@redhat.com>
 <20180216093836.v6iq32jycy7sxwln@gmail.com>
 <87a7w8wxr1.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7w8wxr1.fsf@xmission.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Ingo Molnar <mingo@kernel.org> writes:
> 
> > * Baoquan He <bhe@redhat.com> wrote:
> >
> >> This is v5 post. Newly added patch 0002 includes the change
> >> related to KEXEC_JUMP path. Patch 0003 only includes the
> >> regression fix.
> >> 
> >> A regression bug was introduced in below commit.
> >> commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")
> >> 
> >> It caused the action to fail that we try to restore boot irq mode
> >> in reboot and kexec/kdump. Details can be seen in patch 0003.
> >> 
> >> Warning can always be seen during kdump kernel boot on qemu/kvm
> >> platform. Our customer even saw casual kdump kernel hang once in
> >> ~30 attempts during stress testing of kdump on KVM machine.
> >> 
> >> v4->v5:
> >>   Take out the change related to KEXEC_JUMP to a new patch 0002
> >>   according to Eric's suggestion.
> >>   Patch 0003 in this series only includes the regression fix.
> >> 
> >> v3->v4:
> >>   Eric pointed out that in patch 0002 the change related to
> >>   KEXEC_JUMP is not right.
> >>   Correct it.
> >> 
> >>   Add Fixes tag and Cc to stable.
> >
> > Eric, are these patches looking good to you now?
> 
> The result of applying the patches looks good.
> Barring whatever fix to header files that kbuild seems to find necessary.
> 
> I wish patches 1 2 and 4 were all the same patch.  That I think would
> make reading the patches a bit easier, and make the backports clearer.
> But at this point that is just me bike-shedding.
> 
> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thank you!

	Ingo
