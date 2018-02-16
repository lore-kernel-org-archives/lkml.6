Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933466AbeBPKYo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:24:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933129AbeBPKYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:24:43 -0500
Date: Fri, 16 Feb 2018 18:24:37 +0800
From: Baoquan He <bhe@redhat.com>
To: ebiederm@xmission.com, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com
Subject: Re: [PATCH v5 0/6] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180216102437.GA28912@localhost.localdomain>
References: <20180214054656.3780-1-bhe@redhat.com>
 <20180216093836.v6iq32jycy7sxwln@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216093836.v6iq32jycy7sxwln@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Eric,

On 02/16/18 at 10:38am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > This is v5 post. Newly added patch 0002 includes the change
> > related to KEXEC_JUMP path. Patch 0003 only includes the
> > regression fix.
> > 
> > A regression bug was introduced in below commit.
> > commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")
> > 
> > It caused the action to fail that we try to restore boot irq mode
> > in reboot and kexec/kdump. Details can be seen in patch 0003.
> > 
> > Warning can always be seen during kdump kernel boot on qemu/kvm
> > platform. Our customer even saw casual kdump kernel hang once in
> > ~30 attempts during stress testing of kdump on KVM machine.
> > 
> > v4->v5:
> >   Take out the change related to KEXEC_JUMP to a new patch 0002
> >   according to Eric's suggestion.
> >   Patch 0003 in this series only includes the regression fix.
> > 
> > v3->v4:
> >   Eric pointed out that in patch 0002 the change related to
> >   KEXEC_JUMP is not right.
> >   Correct it.
> > 
> >   Add Fixes tag and Cc to stable.
> 
> Eric, are these patches looking good to you now?

Thanks for checking this!

I got warning message from kbuild test robot on previous v3 and v4. I
guess this v5 post also has the issue since the code is the same, just
patch format is changed.

Will report status after investigation.

Thanks
Baoquan
