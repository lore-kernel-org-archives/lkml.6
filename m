Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65016C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0959B2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Pql407ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0959B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJIFPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:15:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45857 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIFO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:14:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id e17-v6so16671800oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFQbAlSVZ/4mgSkMOMvG6OsiGtbzPqAEEunYLPhiDus=;
        b=Pql407okiW/vDQ8rnsbWA5q00vQfhu54zLutLEqsFBr1CRWtTcm5HW+Gvlski8rt/h
         w02d9yhhI5jHp6qR3bR9XuA8sS9BbEv55T272D+EkuD8sWuKaH5lPv1dypC4sRD11Y0R
         eIWY4hHvLvetPlOP2JBGs0ZOxXBDaxtgFoXDWuDFY4trf29YwLaF6jjm5QShUtncWTIL
         zmRAhS4olvumgYULeKkx0haBsMvFA6AHiBRSgyUy4DT2wdTPRtFdFFyCJF8NTLIZ2iBl
         J/l8cfGVo41ur2/wWyF+xY0fIMMjB71br4EWmEF5YpMK3ZqMAarbeTi5sOBrpowCf0SW
         HBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFQbAlSVZ/4mgSkMOMvG6OsiGtbzPqAEEunYLPhiDus=;
        b=b8C4/ImqJVyQ9mu67kWT7w4opItfptO5p46CVQBwZSnycWYaem7Y9dzEu3Cyu0pRki
         WBpSY9Brxsn4/h8QGwZqe7uAwAtSQF7t/pICFaprwHlKo4vgFzpKnp8q8iCbtsm5Ncvz
         KQjHJldls+E3xbW/eAU1Ftd6LBQ8XUnd3yIUHVgxrpnXIcX1HwUw5WnF+16+ootfsP/0
         JmkLt60Ed8dTRpTQzLIzAmlL1C55nlWriJ+VK/81H6+IpbbidTAEHfEK451DGxiXAR0c
         BXtHd/ArXVsyo91EgkzWwwAx4xDW/RViKifWMEe/0Teskh4aF3TJvIOqvBEsPQ7I5h35
         QRdw==
X-Gm-Message-State: ABuFfog8uNAtf9IU9ijTGnSSugrBd8jIpnFBDvjncy+wwvkjFO6bpYvp
        890Rx2efW5YkB2nEhTFXmrBQRcRYihxlMWPmQarT2g==
X-Google-Smtp-Source: ACcGV63khD5Kc/ufY8ufaYRDu1u/2FkJNNtgeDRZLJPgk9hacZ+v1I3ZV10wlXp+TxWbxw7p1BonzmuMceE5AZouVnk=
X-Received: by 2002:aca:1c19:: with SMTP id c25-v6mr5157909oic.246.1539036068903;
 Mon, 08 Oct 2018 15:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain> <CAPcyv4jX5WYmMYzGCBrnaqT7tqHGSVPwm7Dpi-XpuM9ns84+0w@mail.gmail.com>
 <379e1d22-4194-6744-9e80-897b6ba126e9@linux.intel.com>
In-Reply-To: <379e1d22-4194-6744-9e80-897b6ba126e9@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Oct 2018 15:00:57 -0700
Message-ID: <CAPcyv4i_x4NO2_qsfgwsgii9zmjZ43gJW6OCLpf=CweztRtZZw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Logan Gunthorpe <logang@deltatee.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 2:48 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On 10/8/2018 2:01 PM, Dan Williams wrote:
> > On Tue, Sep 25, 2018 at 1:29 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> >>
> >> The ZONE_DEVICE pages were being initialized in two locations. One was with
> >> the memory_hotplug lock held and another was outside of that lock. The
> >> problem with this is that it was nearly doubling the memory initialization
> >> time. Instead of doing this twice, once while holding a global lock and
> >> once without, I am opting to defer the initialization to the one outside of
> >> the lock. This allows us to avoid serializing the overhead for memory init
> >> and we can instead focus on per-node init times.
> >>
> >> One issue I encountered is that devm_memremap_pages and
> >> hmm_devmmem_pages_create were initializing only the pgmap field the same
> >> way. One wasn't initializing hmm_data, and the other was initializing it to
> >> a poison value. Since this is something that is exposed to the driver in
> >> the case of hmm I am opting for a third option and just initializing
> >> hmm_data to 0 since this is going to be exposed to unknown third party
> >> drivers.
> >>
> >> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >> ---
> >>
> >> v4: Moved moved memmap_init_zone_device to below memmmap_init_zone to avoid
> >>      merge conflicts with other changes in the kernel.
> >> v5: No change
> >
> > This patch appears to cause a regression in the "create.sh" unit test
> > in the ndctl test suite.
>
> So all you had to do is run the create.sh script to see the issue? I
> just want to confirm there isn't any additional information needed
> before I try chasing this down.

From the ndctl source tree run:

    make -j TESTS="create.sh" check

...the readme has some more setup instructions:
https://github.com/pmem/ndctl/blob/master/README.md

0day has sometimes run this test suite automatically, but we need to
get that more robust because setting up this environment is a bit of a
hoop to jump through with the need to setup the nfit_test module.

> > I tried to reproduce on -next with:
> >
> > 2302f5ee215e mm: defer ZONE_DEVICE page initialization to the point
> > where we init pgmap
> >
> > ...but -next does not even boot for me at that commit.
>
> What version of -next? There are a couple of patches probably needed
> depending on which version you are trying to boot.

Today's -next, but backed up to that above commit. I was also seeing
CONFIG_DEBUG_LIST spamming the logs, and a crash in the crypto layer.

> > Here is a warning signature that proceeds a hang with this patch
> > applied against v4.19-rc6:
> >
> > percpu ref (blk_queue_usage_counter_release) <= 0 (-1530626) after
> > switching to atomic
> > WARNING: CPU: 24 PID: 7346 at lib/percpu-refcount.c:155
> > percpu_ref_switch_to_atomic_rcu+0x1f7/0x200
> > CPU: 24 PID: 7346 Comm: modprobe Tainted: G           OE     4.19.0-rc6+ #2458
> > [..]
> > RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x1f7/0x200
> > [..]
> > Call Trace:
> >   <IRQ>
> >   ? percpu_ref_reinit+0x140/0x140
> >   rcu_process_callbacks+0x273/0x880
> >   __do_softirq+0xd2/0x428
> >   irq_exit+0xf6/0x100
> >   smp_apic_timer_interrupt+0xa2/0x220
> >   apic_timer_interrupt+0xf/0x20
> >   </IRQ>
> > RIP: 0010:lock_acquire+0xb8/0x1a0
> > [..]
> >   ? __put_page+0x55/0x150
> >   ? __put_page+0x55/0x150
> >   __put_page+0x83/0x150
> >   ? __put_page+0x55/0x150
> >   devm_memremap_pages_release+0x194/0x250
> >   release_nodes+0x17c/0x2c0
> >   device_release_driver_internal+0x1a2/0x250
> >   driver_detach+0x3a/0x70
> >   bus_remove_driver+0x58/0xd0
> >   __x64_sys_delete_module+0x13f/0x200
> >   ? trace_hardirqs_off_thunk+0x1a/0x1c
> >   do_syscall_64+0x60/0x210
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
>
> So it looks like we are tearing down memory when this is triggered. Do
> we know if this is at the end of the test or if this is running in
> parallel with anything?

Should not be running in parallel with anything this test is
performing a series of namespace setup and teardown events.

Wait, where did the call to "percpu_ref_get()" go? I think that's the bug.
