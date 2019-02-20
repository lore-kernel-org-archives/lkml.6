Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0949A2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5MFkkrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBTMwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:52:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39912 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfBTMwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:52:06 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so15096620iti.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OShJ4IKPAZAJ1bKiE/tE2b7iqayfrWeOVFDf6LYzjg=;
        b=H5MFkkrcBxtFGXzmeHE0xTfEKwy3Obb8KqNDiQfH6fHzwV0B/T6BI0Bu7PQlCr91KS
         nkxH3y3/wVNmdVY7jGF54QCYJPA8/2WLwpZz6LOF12z13J3oYdNH3qr8rMPEV6BZ6KW+
         oQdzNXLOCoaJrYwXu5CUya40sBtV/Cfy0FINPR6xud9Ul401wBY3oiyDeO86RtooFUtF
         NgQuaRpQaD377zOUizUMGcxr/CSvZ33TGdLvUAwCY7Pf5UnVOK/elXP99lxRkk7fQIW0
         ecAEHud9UqGNUB2w9tzJ5SYczMY4rNTET8Pz9xBZ3u2DZCGIt0beO10d/1kCSSlQrZVW
         kCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OShJ4IKPAZAJ1bKiE/tE2b7iqayfrWeOVFDf6LYzjg=;
        b=ZwjF3Q7SL8fP2eRxCfzmYZuJNQepQ5utErbSRE8OqxBVsmVj5whhAwwHbB+VQOEA1D
         NNYOV6izyGe8sl7ljUuT7Qks+dDEwQFxFBnzGmCmBVXR4mQNnr3OAG2f0ZBZG3DdsM0q
         M/eiMCgBwdWer6ENhcBwcuaKvFqN2AyVoFJx3uYme95QmKKg3XfSbzRE74BQDbfrpDl2
         n3fLh6FOEDPFLabEH/yBcb/sE8ejOQ5QepZ/fssVKBsRpDFdwsM429L/n4KBVS+z2/Ju
         VnfhVjNdtxJsN3LsaSvUTxN0OBKWQ8Iaf5XE/tpDKNtvoytjzEpC0gFI8Y2z6LPYd8Ol
         iQhg==
X-Gm-Message-State: AHQUAua02V/XLAOtxhh3tA7+oFrb21CTDMDHUbJe+prd9ohvsgNMnwb2
        N1cnd2BEPVBzVRLrB1a3rp0b6YPczRXHJGg6og==
X-Google-Smtp-Source: AHgI3IZAOmlQfzrbWqY7ZUNAeEMdg9V83SYT2Oi/8/4y2NGZbSmsJzjCAhv68QTNhwb96B+K5v0hNwUcKPDCjfumRm8=
X-Received: by 2002:a6b:1583:: with SMTP id 125mr19483027iov.102.1550667125498;
 Wed, 20 Feb 2019 04:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic> <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com> <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com> <20190220083241.GA3447@zn.tnic>
 <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 20 Feb 2019 20:51:53 +0800
Message-ID: <CAFgQCTsZ_ZYJf7BGQZwVtthRzySrvaA+tFjmB3TJDC-=idGXjg@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 5:41 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 02/20/19 at 09:32am, Borislav Petkov wrote:
> > On Mon, Feb 18, 2019 at 09:48:20AM +0800, Dave Young wrote:
> > > It is ideal if kernel can do it automatically, but I'm not sure if
> > > kernel can predict the swiotlb reserved size automatically.
> >
> > Do you see how even more absurd this gets?
> >
> > If the kernel cannot know the swiotlb reserved size automatically, how
> > is the normal user even supposed to know?!
> >
I think swiotlb is bounce-buffer, if we enlarge it, we can get better
performance. Default size should be enough for platform to work. But
in case of reserving low memory for crashkernel, things are different.
The reserve low memory = swiotlb_size_or_default() + DMA32 memory for
devices. And the 2nd item in the right of the equation varies, based
on machine type and dynamic payload

> > I see swiotlb_size_or_default() so we have a sane default which we fall
> > back to. Now where's the problem with that?
>
> Good question, I expect some answer from people who know more about the
> background.  It would be good to have some actual test results, Pingfan
> is trying to do some tests.
>
Not following the idea, I do not think the following test result can
tell much. (We need various type of machine to get a final result.)
I do a quick test on "HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10",
command line "crashkernel=180M,high crashkernel=64M,low" can work for
the 2nd kernel. Although it complained some memory shortage issue:
[    7.655591] fbcon: mgadrmfb (fb0) is primary device
[    7.655639] Console: switching to colour frame buffer device 128x48
[    7.660609] systemd-udevd: page allocation failure: order:0, mode:0x280d4
[    7.660611] CPU: 0 PID: 180 Comm: systemd-udevd Not tainted
3.10.0-957.el7.x86_64 #1
[    7.660612] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380
Gen10, BIOS U30 06/20/2018
[    7.660612] Call Trace:
[    7.660621]  [<ffffffff81761dc1>] dump_stack+0x19/0x1b
[    7.660625]  [<ffffffff811bc830>] warn_alloc_failed+0x110/0x180
[    7.660628]  [<ffffffff8175d3ce>] __alloc_pages_slowpath+0x6b6/0x724
[    7.660631]  [<ffffffff811c0e95>] __alloc_pages_nodemask+0x405/0x420
[    7.660633]  [<ffffffff8120dcf8>] alloc_pages_current+0x98/0x110
[    7.660638]  [<ffffffffc00c8622>] ttm_pool_populate+0x3d2/0x4b0 [ttm]
[    7.660641]  [<ffffffffc00bf1cd>] ttm_tt_populate+0x7d/0x90 [ttm]
[    7.660644]  [<ffffffffc00c3c74>] ttm_bo_kmap+0x124/0x240 [ttm]
[    7.660648]  [<ffffffff810cecbf>] ? __wake_up_sync_key+0x4f/0x60
[    7.660650]  [<ffffffffc012677e>] mga_dirty_update+0x25e/0x310 [mgag200]
[    7.660653]  [<ffffffffc012685f>] mga_imageblit+0x2f/0x40 [mgag200]
[    7.660657]  [<ffffffff813f97ca>] soft_cursor+0x1ba/0x260
[    7.660659]  [<ffffffff813f8f53>] bit_cursor+0x663/0x6a0
[    7.660662]  [<ffffffff81098739>] ? console_trylock+0x19/0x70
[    7.660664]  [<ffffffff813f514d>] fbcon_cursor+0x13d/0x1c0
[    7.660665]  [<ffffffff813f88f0>] ? bit_clear+0x120/0x120
[    7.660668]  [<ffffffff8146af2e>] hide_cursor+0x2e/0xa0
[    7.660669]  [<ffffffff8146d4e8>] redraw_screen+0x188/0x270
[    7.660671]  [<ffffffff8146e086>] do_bind_con_driver+0x316/0x340
[    7.660672]  [<ffffffff8146e5e9>] do_take_over_console+0x49/0x60
[    7.660674]  [<ffffffff813f24c3>] do_fbcon_takeover+0x63/0xd0
[    7.660675]  [<ffffffff813f808d>] fbcon_event_notify+0x61d/0x730
[    7.660678]  [<ffffffff8176fb0f>] notifier_call_chain+0x4f/0x70
[    7.660681]  [<ffffffff810c7f6d>] __blocking_notifier_call_chain+0x4d/0x70
[    7.660683]  [<ffffffff810c7fa6>] blocking_notifier_call_chain+0x16/0x20
[    7.660684]  [<ffffffff813e8b9b>] fb_notifier_call_chain+0x1b/0x20
[    7.660686]  [<ffffffff813e9e46>] register_framebuffer+0x1f6/0x340
[    7.660690]  [<ffffffffc01027e2>]
__drm_fb_helper_initial_config_and_unlock+0x252/0x3e0 [drm_kms_helper]
[    7.660694]  [<ffffffffc01029ae>]
drm_fb_helper_initial_config+0x3e/0x50 [drm_kms_helper]
[    7.660697]  [<ffffffffc01269d3>] mgag200_fbdev_init+0xe3/0x100 [mgag200]
[    7.660699]  [<ffffffffc01254f4>] mgag200_modeset_init+0x154/0x1d0 [mgag200]
[    7.660701]  [<ffffffffc012157d>] mgag200_driver_load+0x41d/0x5b0 [mgag200]
[    7.660708]  [<ffffffffc005ba4f>] drm_dev_register+0x15f/0x1f0 [drm]
[    7.660711]  [<ffffffff813c3518>] ? pci_enable_device_flags+0xe8/0x140
[    7.660718]  [<ffffffffc005d0da>] drm_get_pci_dev+0x8a/0x1a0 [drm]
[    7.660720]  [<ffffffffc012626b>] mga_pci_probe+0x9b/0xc0 [mgag200]
[    7.660722]  [<ffffffff813c4aca>] local_pci_probe+0x4a/0xb0
[    7.660723]  [<ffffffff813c6209>] pci_device_probe+0x109/0x160
[    7.660726]  [<ffffffff814a8285>] driver_probe_device+0xc5/0x3e0
[    7.660727]  [<ffffffff814a8683>] __driver_attach+0x93/0xa0
[    7.660728]  [<ffffffff814a85f0>] ? __device_attach+0x50/0x50
[    7.660730]  [<ffffffff814a5e25>] bus_for_each_dev+0x75/0xc0
[    7.660731]  [<ffffffff814a7bfe>] driver_attach+0x1e/0x20
[    7.660733]  [<ffffffff814a76a0>] bus_add_driver+0x200/0x2d0
[    7.660734]  [<ffffffff814a8d14>] driver_register+0x64/0xf0
[    7.660735]  [<ffffffff813c5a45>] __pci_register_driver+0xa5/0xc0
[    7.660737]  [<ffffffffc012d000>] ? 0xffffffffc012cfff
[    7.660739]  [<ffffffffc012d039>] mgag200_init+0x39/0x1000 [mgag200]
[    7.660742]  [<ffffffff8100210a>] do_one_initcall+0xba/0x240
[    7.660745]  [<ffffffff81118f8c>] load_module+0x272c/0x2bc0
[    7.660748]  [<ffffffff813a3030>] ? ddebug_proc_write+0x100/0x100
[    7.660750]  [<ffffffff8111950f>] SyS_init_module+0xef/0x140
[    7.660752]  [<ffffffff81774ddb>] system_call_fastpath+0x22/0x27
[    7.660753] Mem-Info:
[    7.660756] active_anon:3364 inactive_anon:6661 isolated_anon:0
[    7.660756]  active_file:0 inactive_file:0 isolated_file:0
[    7.660756]  unevictable:0 dirty:0 writeback:0 unstable:0
[    7.660756]  slab_reclaimable:1492 slab_unreclaimable:3116
[    7.660756]  mapped:1223 shmem:8449 pagetables:179 bounce:0
[    7.660756]  free:20626 free_pcp:0 free_cma:0
[    7.660761] Node 0 DMA free:0kB min:4kB low:4kB high:4kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:564kB
managed:448kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[    7.660762] lowmem_reserve[]: 0 0 152 152
[    7.660766] Node 0 DMA32 free:0kB min:0kB low:0kB high:0kB
active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB
unevictable:0kB isolated(anon):0kB isolated(file):0kB present:65536kB
managed:0kB mlocked:0kB dirty:0kB writeback:0kB mapped:0kB shmem:0kB
slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB
pagetables:0kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? yes
[    7.660767] lowmem_reserve[]: 0 0 152 152
[    7.660771] Node 0 Normal free:82504kB min:1572kB low:1964kB
high:2356kB active_anon:13456kB inactive_anon:26644kB active_file:0kB
inactive_file:0kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:183740kB managed:158716kB mlocked:0kB
dirty:0kB writeback:0kB mapped:4892kB shmem:33796kB
slab_reclaimable:5968kB slab_unreclaimable:12464kB kernel_stack:784kB
pagetables:716kB unstable:0kB bounce:0kB free_pcp:[    8.722693]
Microsemi PQI Driver (v1.1.4-115)


> Previously Joerg posted below patch, maybe he has some idea. Joerg?
>
> commit 94fb9334182284e8e7e4bcb9125c25dc33af19d4
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Wed Jun 10 17:49:42 2015 +0200
>
>     x86/crash: Allocate enough low memory when crashkernel=high
>
> Thanks
> Dave
