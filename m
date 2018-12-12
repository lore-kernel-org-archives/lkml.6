Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48461C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0453B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1KhKjEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0453B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbeLLRY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:24:59 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45494 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeLLRY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:24:58 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so7283260ywd.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aj16qc+993hcx/+GJx4fYCcJFsU2nVBVBFn3y+WxdUE=;
        b=V1KhKjEHkMFmym+6Xe2kuXydGeShubZcJNeZEoIm0gE5y7w25MGUVl4CfGU4jeQ/kG
         69veFvzpLVGm2DrENcgI2FRZjY67LDEdydyqB2JTokZ2t22ayCDVQDGjEnfDSAzQMHUf
         i7qtzE7NgctH8udlfbi+OT2SrvLTyzZBzCwQJNnGw8D8mcKY2eBZxYYu4cMB1Wo8R8TZ
         NV3Mcc3Hof9Mn0l/fNselNcPhRd42WrTVadxm1S9RDHwXjLIGVp2xSeGNXEr3YyMPayA
         sgoFjpN8Rrx9AWg1rruiI7AXz8opKYrU15L2N+kyntJLrzk4jLJl2L35IRi/qQJxpkqK
         MtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aj16qc+993hcx/+GJx4fYCcJFsU2nVBVBFn3y+WxdUE=;
        b=q8nVSBYwyPIyaaDy5mlskMmoBp5l+XYxxavOmqYvrEeog64r3MWcAbhvIirz6BlvVW
         tFZDUYmNECXGPz6vB4MXwfq53QstTg733titpAFO9D49cEfPy/4QElwcmkdNUUVu3xUe
         Dv/dqDA9e4SdUiU476JqQubigy87Qane2H4m60Mp8wza9M+En+4yXe5qc7bv/13oUuA/
         uVxoeQHDqHmsv6kPhgyAoEjuxDyrJvVUV6nhzaI0yyh5wUfPF7BAntmLNgKG7gF4WW2P
         iXu+tGimH/YoVk529n+E4QOHMIGisDnMvmBPA5ezNiubKM7vJ25ldhXC/d1EJLAoIVjR
         5Jaw==
X-Gm-Message-State: AA+aEWYFE3cB2Ip7aiqw+sx5G68olVvCX8O6JGnaqY7ciwLJ4iWpe+tr
        2Kbr2049BQOx+EH5+t61pazMj8wefCoNRXNiEWxSNgbuftE/iA==
X-Google-Smtp-Source: AFSGD/WEZtkiOjf6QbZBenkCH8kkXYS9NRhTOy/EOtrLb5o3YgRrn91oFcVj7uskCzH7w5vBLJyrhJkxcmadsf5Yh9s=
X-Received: by 2002:a0d:cb4c:: with SMTP id n73mr21025993ywd.255.1544635496965;
 Wed, 12 Dec 2018 09:24:56 -0800 (PST)
MIME-Version: 1.0
References: <20181211132645.31053-1-mhocko@kernel.org> <20181212155055.1269-1-mhocko@kernel.org>
In-Reply-To: <20181212155055.1269-1-mhocko@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 12 Dec 2018 09:24:45 -0800
Message-ID: <CALvZod4A237wvwsDjQXdwGBXEV9gLrjbARtP5-MaMAD_9OhQrg@mail.gmail.com>
Subject: Re: [PATCH v2] mm, memcg: fix reclaim deadlock with writeback
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        bo.liu@linux.alibaba.com, Jan Kara <jack@suse.cz>,
        david@fromorbit.com, tytso@mit.edu,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 7:51 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> From: Michal Hocko <mhocko@suse.com>
>
> Liu Bo has experienced a deadlock between memcg (legacy) reclaim and the
> ext4 writeback
> task1:
> [<ffffffff811aaa52>] wait_on_page_bit+0x82/0xa0
> [<ffffffff811c5777>] shrink_page_list+0x907/0x960
> [<ffffffff811c6027>] shrink_inactive_list+0x2c7/0x680
> [<ffffffff811c6ba4>] shrink_node_memcg+0x404/0x830
> [<ffffffff811c70a8>] shrink_node+0xd8/0x300
> [<ffffffff811c73dd>] do_try_to_free_pages+0x10d/0x330
> [<ffffffff811c7865>] try_to_free_mem_cgroup_pages+0xd5/0x1b0
> [<ffffffff8122df2d>] try_charge+0x14d/0x720
> [<ffffffff812320cc>] memcg_kmem_charge_memcg+0x3c/0xa0
> [<ffffffff812321ae>] memcg_kmem_charge+0x7e/0xd0
> [<ffffffff811b68a8>] __alloc_pages_nodemask+0x178/0x260
> [<ffffffff8120bff5>] alloc_pages_current+0x95/0x140
> [<ffffffff81074247>] pte_alloc_one+0x17/0x40
> [<ffffffff811e34de>] __pte_alloc+0x1e/0x110
> [<ffffffffa06739de>] alloc_set_pte+0x5fe/0xc20
> [<ffffffff811e5d93>] do_fault+0x103/0x970
> [<ffffffff811e6e5e>] handle_mm_fault+0x61e/0xd10
> [<ffffffff8106ea02>] __do_page_fault+0x252/0x4d0
> [<ffffffff8106ecb0>] do_page_fault+0x30/0x80
> [<ffffffff8171bce8>] page_fault+0x28/0x30
> [<ffffffffffffffff>] 0xffffffffffffffff
>
> task2:
> [<ffffffff811aadc6>] __lock_page+0x86/0xa0
> [<ffffffffa02f1e47>] mpage_prepare_extent_to_map+0x2e7/0x310 [ext4]
> [<ffffffffa08a2689>] ext4_writepages+0x479/0xd60
> [<ffffffff811bbede>] do_writepages+0x1e/0x30
> [<ffffffff812725e5>] __writeback_single_inode+0x45/0x320
> [<ffffffff81272de2>] writeback_sb_inodes+0x272/0x600
> [<ffffffff81273202>] __writeback_inodes_wb+0x92/0xc0
> [<ffffffff81273568>] wb_writeback+0x268/0x300
> [<ffffffff81273d24>] wb_workfn+0xb4/0x390
> [<ffffffff810a2f19>] process_one_work+0x189/0x420
> [<ffffffff810a31fe>] worker_thread+0x4e/0x4b0
> [<ffffffff810a9786>] kthread+0xe6/0x100
> [<ffffffff8171a9a1>] ret_from_fork+0x41/0x50
> [<ffffffffffffffff>] 0xffffffffffffffff
>
> He adds
> : task1 is waiting for the PageWriteback bit of the page that task2 has
> : collected in mpd->io_submit->io_bio, and tasks2 is waiting for the LOCKED
> : bit the page which tasks1 has locked.
>
> More precisely task1 is handling a page fault and it has a page locked
> while it charges a new page table to a memcg. That in turn hits a memory
> limit reclaim and the memcg reclaim for legacy controller is waiting on
> the writeback but that is never going to finish because the writeback
> itself is waiting for the page locked in the #PF path. So this is
> essentially ABBA deadlock.
>
> Waiting for the writeback in legacy memcg controller is a workaround
> for pre-mature OOM killer invocations because there is no dirty IO
> throttling available for the controller. There is no easy way around
> that unfortunately. Therefore fix this specific issue by pre-allocating
> the page table outside of the page lock. We have that handy
> infrastructure for that already so simply reuse the fault-around pattern
> which already does this.

Michal, can you please add the following para in the commit message as
well which was in the first version. This fact should be documented at
least in the commit message.

>
> There are probably other hidden __GFP_ACCOUNT | GFP_KERNEL allocations
> from under a fs page locked but they should be really rare. I am not
> aware of a better solution unfortunately.
>

thanks,
Shakeel
