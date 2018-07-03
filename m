Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839DC23ECE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHIowl2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839DC23ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeGCQUQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:20:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39278 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933569AbeGCQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:20:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id b8-v6so2575450wro.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EkZjQBQ3lmuTKD+2wPHV/1uQ3NIyz4LgTpDgxXKf9uY=;
        b=HHIowl2nR+mEjJJukim+y4iGGOeTjQJY+G+hgeaE/KTu/7kD6fuCtf2lfC1U4mr7uX
         anFqfMixxjQRC3VE8ctcFD28QIQZ8zEAezpzgTTeZRG92BGMSxYhmOK2THaG8JAJtgYJ
         UF9l6RfRn2tNRvu8juTmvTXju0BBLSIEVlbJjYQK3hSpStqcAUXkgeApIimd2Ol5xZ6z
         uXmfXxZSTvzSBe/0GbKhYKPz0HoaP5KqGIB54qGdDiUMz5NzE7PpWYdfCIfumtfb/5HV
         Ez1CEEGU1ZIjmyAjGl3j1T9AhJl+KuALSop57+xk9vAMz5noj/o5Nk5wtUO2+2Vs8u7K
         uygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EkZjQBQ3lmuTKD+2wPHV/1uQ3NIyz4LgTpDgxXKf9uY=;
        b=caOVnb/+vz28xqLenf1HRLe0JX41GZDQ7DmcdFx06/jApWj4mMLBv4u9hM8DNsBDBb
         HXcjIOIiWTPf//Tb7fvcq6ddaZEA3PwSeMbS7fSgNCuvYOnQspUYza7t7ZFVrrSIumCo
         ZDTJoGmwXdYbY5tfp2jG4uMtyTAgxQq7RiI5EBKxDO+2XtyQjHyPZok1aAoWLXbPnyzd
         xPOign6BRFI9hgquBLYlyFuoi3v4EpalZDNUtGmu/E+dVlXwkAMfaAU8sIETU3Bjar09
         huKyw6TyUYxyQYqj4VEdbZuSGF3ewSMKxj4U6FjeH2B5VU0bWS04HDo70FfOlpIQVKj/
         8YeQ==
X-Gm-Message-State: APt69E1YVrKNfC2fzhAEpkVNmO1G5cpLIlLhnDF3hG07utnFJUtaCneJ
        oEke3+WSjCCxpzozu28pyt9i69dhdfcUPiR2uRs=
X-Google-Smtp-Source: AAOMgpdK8cBQ7ZW/J9lFvf31oTc2A1Hm+kKcPIjDrGfPJ3uffuCDNSv9kNNQK/no5QCzhQ98vfjos30PVJTqvN4T8sA=
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr25115693wrd.176.1530634812230;
 Tue, 03 Jul 2018 09:20:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8e6b:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 09:20:11 -0700 (PDT)
In-Reply-To: <CAGS+omATU0gus_EvbHtegGK1ZkaKVmSOr1E6QLQjd+LA_tC_LA@mail.gmail.com>
References: <20180413161601.109431-1-djkurtz@chromium.org> <6e46904a-d721-d583-8ab5-82cb07df7934@amd.com>
 <CAGS+omATU0gus_EvbHtegGK1ZkaKVmSOr1E6QLQjd+LA_tC_LA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 3 Jul 2018 12:20:11 -0400
Message-ID: <CADnq5_Nwt+i2Sezh2Rmg9VyYYbc8LAMJyS6eQf9K5yAp-GgAXA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/acp: Fix slab-out-of-bounds in mfd_add_device
 in acp_hw_init
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>, jclinton@chromium.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:48 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi Alex,
>
> On Sun, Apr 15, 2018 at 9:48 PM Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>>
>>
>>
>> On 4/13/2018 9:45 PM, Daniel Kurtz wrote:
>> > Commit 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for
>> > stoney/cz") added support for the "BT_I2S" ACP i2s channel.  As part of
>> > this change, one additional acp resource was added, but the "num_resource"
>> > count was accidentally incremented by 2.
>> >
>> > This incorrect count eventually causes mfd_add_device() to try to access
>> > an invalid memory address (the location of non-existent resource 5.
>> >
>> > This fault was detected by running a KASAN enabled kernel, which produced
>> > the following splat at boot:
>> >
>> > [    6.612987] ==================================================================
>> > [    6.613509] BUG: KASAN: slab-out-of-bounds in mfd_add_device+0x4bc/0x7a7
>> > [    6.613509] Read of size 8 at addr ffff880107d4dc58 by task swapper/0/1
>> > [    6.613509]
>> > [    6.613509] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.33 #349
>> > [    6.613509] Hardware name: Google Grunt/Grunt, BIOS Google_Grunt.10543.0.2018_04_03_1812 04/02/2018
>> > [    6.613509] Call Trace:
>> > [    6.613509]  dump_stack+0x4d/0x63
>> > [    6.613509]  print_address_description+0x80/0x2d6
>> > [    6.613509]  ? mfd_add_device+0x4bc/0x7a7
>> > [    6.613509]  kasan_report+0x255/0x295
>> > [    6.613509]  mfd_add_device+0x4bc/0x7a7
>> > [    6.613509]  ? kasan_kmalloc+0x99/0xa8
>> > [    6.613509]  ? mfd_add_devices+0x58/0xe4
>> > [    6.613509]  ? __kmalloc+0x154/0x178
>> > [    6.613509]  mfd_add_devices+0xa5/0xe4
>> > [    6.613509]  acp_hw_init+0x92e/0xc4a
>> > [    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
>> > [    6.613509]  ? kmalloc_order+0x53/0x5d
>> > [    6.613509]  ? kmalloc_order_trace+0x23/0xb3
>> > [    6.613509]  amdgpu_driver_load_kms+0xce/0x267
>> > [    6.613509]  drm_dev_register+0x169/0x2fb
>> > [    6.613509]  amdgpu_pci_probe+0x217/0x242
>> > [    6.613509]  pci_device_probe+0x101/0x18e
>> > [    6.613509]  driver_probe_device+0x1dd/0x419
>> > [    6.613509]  ? ___might_sleep+0x80/0x1b6
>> > [    6.613509]  __driver_attach+0x9f/0xc9
>> > [    6.613509]  ? driver_probe_device+0x419/0x419
>> > [    6.613509]  bus_for_each_dev+0xbc/0xe1
>> > [    6.613509]  bus_add_driver+0x189/0x2c0
>> > [    6.613509]  driver_register+0x108/0x156
>> > [    6.613509]  ? ttm_init+0x67/0x67
>> > [    6.613509]  do_one_initcall+0xb2/0x161
>> > [    6.613509]  kernel_init_freeable+0x25a/0x308
>> > [    6.613509]  ? rest_init+0xcc/0xcc
>> > [    6.613509]  kernel_init+0x11/0x10d
>> > [    6.613509]  ? rest_init+0xcc/0xcc
>> > [    6.613509]  ret_from_fork+0x22/0x40
>> > [    6.613509]
>> > [    6.613509] Allocated by task 1:
>> > [    6.613509]  save_stack+0x46/0xce
>> > [    6.613509]  kasan_kmalloc+0x99/0xa8
>> > [    6.613509]  kmem_cache_alloc_trace+0x11a/0x13e
>> > [    6.613509]  acp_hw_init+0x210/0xc4a
>> > [    6.613509]  amdgpu_device_init+0x1dfb/0x22a2
>> > [    6.613509]  amdgpu_driver_load_kms+0xce/0x267
>> > [    6.613509]  drm_dev_register+0x169/0x2fb
>> > [    6.613509]  amdgpu_pci_probe+0x217/0x242
>> > [    6.613509]  pci_device_probe+0x101/0x18e
>> > [    6.613509]  driver_probe_device+0x1dd/0x419
>> > [    6.613509]  __driver_attach+0x9f/0xc9
>> > [    6.613509]  bus_for_each_dev+0xbc/0xe1
>> > [    6.613509]  bus_add_driver+0x189/0x2c0
>> > [    6.613509]  driver_register+0x108/0x156
>> > [    6.613509]  do_one_initcall+0xb2/0x161
>> > [    6.613509]  kernel_init_freeable+0x25a/0x308
>> > [    6.613509]  kernel_init+0x11/0x10d
>> > [    6.613509]  ret_from_fork+0x22/0x40
>> > [    6.613509]
>> > [    6.613509] Freed by task 0:
>> > [    6.613509] (stack is not available)
>> > [    6.613509]
>> > [    6.613509] The buggy address belongs to the object at ffff880107d4db08
>> > [    6.613509]  which belongs to the cache kmalloc-512 of size 512
>> > [    6.613509] The buggy address is located 336 bytes inside of
>> > [    6.613509]  512-byte region [ffff880107d4db08, ffff880107d4dd08)
>> > [    6.613509] The buggy address belongs to the page:
>> > [    6.613509] page:ffffea00041f5300 count:1 mapcount:0 mapping:          (null) index:0x0 compound_mapcount: 0
>> > [    6.613509] flags: 0x8000000000008100(slab|head)
>> > [    6.613509] raw: 8000000000008100 0000000000000000 0000000000000000 0000000100120012
>> > [    6.613509] raw: ffffea0004208520 ffff88010b001680 ffff88010b002cc0 0000000000000000
>> > [    6.613509] page dumped because: kasan: bad access detected
>> > [    6.613509]
>> > [    6.613509] Memory state around the buggy address:
>> > [    6.613509]  ffff880107d4db00: fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > [    6.613509]  ffff880107d4db80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> > [    6.613509] >ffff880107d4dc00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>> > [    6.613509]                                                     ^
>> > [    6.613509]  ffff880107d4dc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> > [    6.613509]  ffff880107d4dd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> > [    6.613509] ==================================================================
>> >
>> > Fixes: 51f7415039d4 ("drm/amd/amdgpu: creating two I2S instances for stoney/cz")
>> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> Acked-by: Akshu Agrawal <akshu.agrawal@amd.com>
>
>
> Was this patch ever picked up?  I can't find it in agd5f/linux.

It wasn't applied.  I don't see 51f7415039d4 ("drm/amd/amdgpu:
creating two I2S instances for stoney/cz") upstream yet either.
Daniel, Vijendar, which ones do you want applied?  Can you send me the
patches?

Alex

>
> Thanks,
> -Dan
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
