Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBD7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B620877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCD7W1jI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3B620877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933340AbeGJKDE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:03:04 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43108 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933036AbeGJKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:02:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so15747142pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B05G7BxcSLGFGVDvxfE1WdngnqYPx7BXYFDek9fb9e0=;
        b=NCD7W1jI0UVpHH3NxtnNPzpQJijWHjip0S6p/QhA4IpE39HryYDRLcdWjWDaMgvr/T
         V7XPgdXMFS+kGgpJGcFAFGAalAMgf90RovZzAgXnkBBcAhL0GMcnlQrlzwF49SQrwNKU
         dlNoqbnKUsFe72ZaLS8mQ/gY/pqGkXAxOrKnxgI/aKKzFVod6M/oPlNvv2cqdcJlAHI7
         IEq0frEs4HlE3HSz8M19r0prDumU5H5V2AgNDTiAHlz4/7EfJgt+h6q2qsmCtn6ODd1p
         DX5JH46eQdqYfS+GRiDoFkFl/QWmasJy+eqimSrs5LtVumYvuzkWpeV7q43IMAV01zKg
         1hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B05G7BxcSLGFGVDvxfE1WdngnqYPx7BXYFDek9fb9e0=;
        b=GL2wyQzKIPPZkTuKyehk3Ov+ha1s5a72f7y+kBSz52EwZz6mx3bCYcZDx6IA74153z
         AepPcOoNV+vQVAQgm2xRoOvpMZx8NrJrj93sOnEyX08LfqHnsinIDoSmeR4CvLDdDjeC
         F4hduXtlxK4PwcuKov/SgfjYqvaRwe4EB1OoZYlfMbZUXXR8y3p33gmB3m3YFiO/h7kw
         9Zvrui+FsQ+x7ifABGddstRT1d3S/3ByzvNEnKnHrxoGfAfPp8arInhX9uFPClhzHBsE
         R4BkPpNumZtIsGjO5L2k/FDfMRbjCrywf1YHMDx120v4qtbBTw/ix5A5nl7MU8Ka6qfV
         7mzQ==
X-Gm-Message-State: APt69E1LbISUjPELllQ3gkhu8eU2JY/SyZ8N4vUKhRAkHinHpmKENobm
        UWvlNQpUg+Jolhyvx1KYqU4TZ/5veTBIRvWV29LDaw==
X-Google-Smtp-Source: AAOMgpccr3vPa0J1txEKnQJtLEdfXetcRNtUwcVenHyEVojsUiqytRZL8rNPjL3CNV3hN0VhHBLWTYdMC+3w75D1IGE=
X-Received: by 2002:a63:1f20:: with SMTP id f32-v6mr21247931pgf.84.1531216958209;
 Tue, 10 Jul 2018 03:02:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Tue, 10 Jul 2018 03:02:17
 -0700 (PDT)
In-Reply-To: <20180709220711.2zz75g4mo4p76bbx@kshutemo-mobl1>
References: <0000000000004a7da505708a9915@google.com> <20180709101558.63vkwppwcgzcv3dg@kshutemo-mobl1>
 <CACT4Y+a=8NOg+h6fBzpmVHiZ-vNUiG7SW4QgQvK3vD=KBqQ3_Q@mail.gmail.com>
 <CACT4Y+baBmOHwH6rUL3DjKhGk-JjBAvKOmnq65_4z6b96ohrBQ@mail.gmail.com>
 <20180709142155.jlgytrhdmkyvowzh@kshutemo-mobl1> <20180709152508.smwg252x57pnfkoq@kshutemo-mobl1>
 <CACT4Y+YM=M0b_VVNyBNq6Qa25veRzw-WhxXkovS9Kmu23LPVVA@mail.gmail.com> <20180709220711.2zz75g4mo4p76bbx@kshutemo-mobl1>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Jul 2018 12:02:17 +0200
Message-ID: <CACT4Y+bU9y3sZvynTYdwSj=T3-OvE_C4_6eWiS0i=8HE0wEb9g@mail.gmail.com>
Subject: Re: kernel BUG at mm/memory.c:LINE!
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     syzbot <syzbot+3f84280d52be9b7083cc@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        ldufour@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:07 AM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Mon, Jul 09, 2018 at 07:23:15PM +0200, Dmitry Vyukov wrote:
>> On Mon, Jul 9, 2018 at 5:25 PM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>> > On Mon, Jul 09, 2018 at 05:21:55PM +0300, Kirill A. Shutemov wrote:
>> >> > This also happened only once so far:
>> >> > https://syzkaller.appspot.com/bug?extid=3f84280d52be9b7083cc
>> >> > and I can't reproduce it rerunning this program. So it's either a very
>> >> > subtle race, or fd in the middle of netlink address magically matched
>> >> > some fd once, or something else...
>> >>
>> >> Okay, I've got it reproduced. See below.
>> >>
>> >> The problem is that kcov doesn't set vm_ops for the VMA and it makes
>> >> kernel think that the VMA is anonymous.
>> >>
>> >> It's not necessary the way it was triggered by syzkaller. I just found
>> >> that kcov's ->mmap doesn't set vm_ops. There can more such cases.
>> >> vma_is_anonymous() is what we need to fix.
>> >>
>> >> ( Although, I found logic around mmaping the file second time questinable
>> >>   at best. It seems broken to me. )
>> >>
>> >> It is known that vma_is_anonymous() can produce false-positives. It tried
>> >> to fix it once[1], but it back-fired[2].
>> >>
>> >> I'll look at this again.
>> >
>> > Below is a patch that seems work. But it definately requires more testing.
>> >
>> > Dmitry, could you give it a try in syzkaller?
>>
>> Trying.
>>
>> Not sure what you expect from this. Either way it will be hundreds of
>> crashes before vs hundreds of crashes after ;)
>>
>> But one that started popping up is this, looks like it's somewhere
>> around the code your patch touches:
>>
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] SMP KASAN
>> CPU: 0 PID: 6711 Comm: syz-executor3 Not tainted 4.18.0-rc4+ #43
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> RIP: 0010:__get_vma_policy+0x61/0x160 mm/mempolicy.c:1620
>
> Right, my bad. Here's fixup.
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index d508c7844681..12b2b3c7f51e 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -597,6 +597,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>         memset(&pseudo_vma, 0, sizeof(struct vm_area_struct));
>         pseudo_vma.vm_flags = (VM_HUGETLB | VM_MAYSHARE | VM_SHARED);
>         pseudo_vma.vm_file = file;
> +       pseudo_vma.vm_ops = &anon_vm_ops;
>
>         for (index = start; index < end; index++) {
>                 /*


With this change I don't see anything that stands out, just a typical
mix of crashes like these:

BUG: unable to handle kernel paging request in kfree
INFO: task hung in flush_work
KASAN: slab-out-of-bounds Read in fscache_alloc_cookie
KASAN: use-after-free Read in __queue_work
general protection fault in encode_rpcb_string
lost connection to test machine
no output from test machine
unregister_netdevice: waiting for DEV to become free

So I guess this can be qualified as +1 for the patch.
