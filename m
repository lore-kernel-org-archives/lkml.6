Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E5C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26638214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="0UEAqn6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26638214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeJIEOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:14:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35291 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:14:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so21324544otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4e8A7Ph01eerhw9OYVEjCyP9ANKm81lBfmFFReFvvTc=;
        b=0UEAqn6wYS/j57cZgQm0K5KRjBnRHKMldZ6wnb4+smF5gPXynViJ6W5+4cLQNIWH6f
         HXuK5MSF5nl7w02/xn/i4uzE3pgmajp43ZQClBOd4zrIcG3+h0Jk/s955cRF8pslorDb
         iGt7Nl3MqBZzr4tK4KTP6Y/5J0FKoYqL3PpT6Znjr/LFxdMT9hSwfdK+bGV9lmRfdYE2
         Uq4aRal5sTcmNw5hNskFpxPGLIlwM9FyRM2RILY1kCH1tfEL7OphPo01KvRX31rw6wYL
         ujeL5/LyCtTheW0iF3om5Gq8iQjNIbCzP+Bs4vu+N2hNkbEFtgzkZ5hVK0NsSL2yB2LC
         Dvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e8A7Ph01eerhw9OYVEjCyP9ANKm81lBfmFFReFvvTc=;
        b=OrYyvHWeTXtBevz3IwoQnA/VyJolIsYlXhKi6Di99Cf8hhcGOudnUebRNJbjQ/ZUNk
         LGvotPa69f3t8YJOBq0ON7S++g5VgTsSQ6JoJvDKqTjMtRFP60PHkJ0mOwImIVz6YPq3
         DolHtcIqaFmhsIpoCMbJFQjf47fU3UZylmGT2MrnXKLfonG4fz7MNz7vXYwI4Ngn9unK
         4FKsCZosk52e7vYtcJL5nGZqlEtBkFeHAYBXPNoTQnknyyCOwNUUe6mVHgarE5zHsizC
         xixHdAz9VXFcspZwOafSdTppmnoDd9kRkvTmnDTDFFz+WbW7j5bZZcoJyCoMxFl6T+tB
         osxg==
X-Gm-Message-State: ABuFfoiT66kMkWIXv4aoco2x7M+ROWJ2tSvgjTsvSr9B2fT1JZ3ISQRQ
        Y5EUFXPWYlRcvbZNMmmnD5/gdloW4Me1R3F6wLEP6Q==
X-Google-Smtp-Source: ACcGV62Imk155zHkdag0/7cJtp/1kDQJG+Oqv4oEaGlDD8109qwjDvmwLAfdDaGbKtjRR/en0XVi2J551AlU4nNb/PY=
X-Received: by 2002:a9d:2372:: with SMTP id k47mr14030035otd.98.1539032473582;
 Mon, 08 Oct 2018 14:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180925200551.3576.18755.stgit@localhost.localdomain> <20180925202053.3576.66039.stgit@localhost.localdomain>
In-Reply-To: <20180925202053.3576.66039.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Oct 2018 14:01:02 -0700
Message-ID: <CAPcyv4jX5WYmMYzGCBrnaqT7tqHGSVPwm7Dpi-XpuM9ns84+0w@mail.gmail.com>
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

On Tue, Sep 25, 2018 at 1:29 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> The ZONE_DEVICE pages were being initialized in two locations. One was with
> the memory_hotplug lock held and another was outside of that lock. The
> problem with this is that it was nearly doubling the memory initialization
> time. Instead of doing this twice, once while holding a global lock and
> once without, I am opting to defer the initialization to the one outside of
> the lock. This allows us to avoid serializing the overhead for memory init
> and we can instead focus on per-node init times.
>
> One issue I encountered is that devm_memremap_pages and
> hmm_devmmem_pages_create were initializing only the pgmap field the same
> way. One wasn't initializing hmm_data, and the other was initializing it to
> a poison value. Since this is something that is exposed to the driver in
> the case of hmm I am opting for a third option and just initializing
> hmm_data to 0 since this is going to be exposed to unknown third party
> drivers.
>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>
> v4: Moved moved memmap_init_zone_device to below memmmap_init_zone to avoid
>     merge conflicts with other changes in the kernel.
> v5: No change

This patch appears to cause a regression in the "create.sh" unit test
in the ndctl test suite.

I tried to reproduce on -next with:

2302f5ee215e mm: defer ZONE_DEVICE page initialization to the point
where we init pgmap

...but -next does not even boot for me at that commit.

Here is a warning signature that proceeds a hang with this patch
applied against v4.19-rc6:

percpu ref (blk_queue_usage_counter_release) <= 0 (-1530626) after
switching to atomic
WARNING: CPU: 24 PID: 7346 at lib/percpu-refcount.c:155
percpu_ref_switch_to_atomic_rcu+0x1f7/0x200
CPU: 24 PID: 7346 Comm: modprobe Tainted: G           OE     4.19.0-rc6+ #2458
[..]
RIP: 0010:percpu_ref_switch_to_atomic_rcu+0x1f7/0x200
[..]
Call Trace:
 <IRQ>
 ? percpu_ref_reinit+0x140/0x140
 rcu_process_callbacks+0x273/0x880
 __do_softirq+0xd2/0x428
 irq_exit+0xf6/0x100
 smp_apic_timer_interrupt+0xa2/0x220
 apic_timer_interrupt+0xf/0x20
 </IRQ>
RIP: 0010:lock_acquire+0xb8/0x1a0
[..]
 ? __put_page+0x55/0x150
 ? __put_page+0x55/0x150
 __put_page+0x83/0x150
 ? __put_page+0x55/0x150
 devm_memremap_pages_release+0x194/0x250
 release_nodes+0x17c/0x2c0
 device_release_driver_internal+0x1a2/0x250
 driver_detach+0x3a/0x70
 bus_remove_driver+0x58/0xd0
 __x64_sys_delete_module+0x13f/0x200
 ? trace_hardirqs_off_thunk+0x1a/0x1c
 do_syscall_64+0x60/0x210
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
