Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE57C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2B220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SodFlu16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2B220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFTOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:39:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39097 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeFTOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:39:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so138239wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d1/IOoO5ND1w44p3Htn3C8A4a6Qcuf4X73TGcNu/vPY=;
        b=SodFlu16Gb9GLsZATGIDByDCFxdt9jQAVOcK7n1q1OFAMlr2X2Vv9SdWr2rq1A1G/S
         xpsUMlHc4vLuSl0dl/5KCKbDN+U2ROyYdJEmEDjCCIiUg5qlYP74axx87v3XG7lg+6aE
         D/qjLjMoHehRB+cb/8FWekn9t90h7V1uUZkhaIbCV76G1aacFAUUHnKNajVuWUQlS/Hq
         ArnaZ6JjxN41L1NFNZNE8J5ExmB6GzoThvy2wAcTjHgC0U3Hj4z5j33BMIWb1DYgl81K
         cQ4sEaWwXjHx+EMJFMNHnfbvyCRKfsvmQdnhbYVnMNL5EinaBFdZv8ojz3FflP7pYbBR
         mJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d1/IOoO5ND1w44p3Htn3C8A4a6Qcuf4X73TGcNu/vPY=;
        b=HlF6njtg90uh3OrtkZe0IHle/RWw3jaSzyDJFZOIdPDrYDnDS/81zzEKAU8JVSJYPh
         eIJIg+IKQiFBO+oPWHUA69v/1ntBVzxyw+LjVdnEnnul6ZtjjsBvUjMawdn9Vnl808y1
         bqOoZjHa8NebRKc/FAMEor9J3BsnWI+PBGkeGb+0BesaJolzB/afaBL2JwK7a/J/k52E
         VrvPRs4Rxrb8/WB0kHaABLjB2ZNf2TBGl2LRW4D7wRxil+5AC4T7mvLstHtyyL/iw32Z
         dWG0zUxqHqvTPun0jzj0HFRdmBI0d9Y3gJv+g1W8rQnRZv3vWc8oekrUZojlD3TcWcfW
         y0CQ==
X-Gm-Message-State: APt69E0JN+Ae3IcUDQGb+IL64JNaFcD9S42e8D3DVdO4I+BNqbUscb9i
        xyFoR9PHQ6/73NnxUpPVHJSTDQsS1bP42WGpD6w=
X-Google-Smtp-Source: ADUXVKKAs9uGWUFfnPtIc90ZEM6fiP3XOC0C66b/8FQ4uprtXgFy01iHlc8bdoLxZAZUjutw262GdFUYomCTYEpOBLs=
X-Received: by 2002:a1c:d482:: with SMTP id l124-v6mr1853517wmg.22.1529505581806;
 Wed, 20 Jun 2018 07:39:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8282:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 07:39:41
 -0700 (PDT)
In-Reply-To: <c3aeb1e5-8b4c-d34d-43e8-5f69c2c95b55@linux.intel.com>
References: <20180619074756.19047-1-caizhaopeng@deepin.com> <c3aeb1e5-8b4c-d34d-43e8-5f69c2c95b55@linux.intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jun 2018 10:39:41 -0400
Message-ID: <CADnq5_Nv50A9-vLmrqpeb30sXcuBKonPTEVfhodByh979zQ59w@mail.gmail.com>
Subject: Re: [PATCH] drm: fix pci_dev root device is NULL without check.
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Caicai <caizhaopeng@deepin.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Dave Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 4:39 AM, Maarten Lankhorst
<maarten.lankhorst@linux.intel.com> wrote:
> Op 19-06-18 om 09:47 schreef Caicai:
>>     on my laptop with ATI Radeon R7 350 graphics card,I found root was NULL,we should check
>>     the device before get/set pcie speed cap mask. Here is my messages.
>>     [    8.996093] [drm] radeon kernel modesetting enabled.
>>     [    8.996093] [drm] initializing kernel modesetting (OLAND 0x1002:0x6610 0x174B:0xA00B).
>>     [    8.996093] [drm] register mmio base: 0x10000000
>>     [    8.996093] [drm] register mmio size: 262144
>>     [    9.121093] ATOM BIOS: C55001
>>     [    9.121093] [drm] GPU not posted. posting now...
>>     [    9.125000] radeon 0001:20:00.0: VRAM: 2048M 0x0000000000000000 - 0x000000007FFFFFFF (2048M used)
>>     [    9.125000] radeon 0001:20:00.0: GTT: 2048M 0x0000000080000000 - 0x00000000FFFFFFFF
>>     [    9.125000] [drm] Detected VRAM RAM=2048M, BAR=256M
>>     [    9.125000] [drm] RAM width 128bits DDR
>>     [    9.125000] [drm] radeon: 2048M of VRAM memory ready
>>     [    9.125000] [drm] radeon: 2048M of GTT memory ready.
>>     [    9.125000] [drm] Loading oland Microcode
>>     [    9.128906] [drm] Internal thermal controller with fan control
>>     [    9.128906] Unable to handle kernel paging request at virtual address 000000000000003c
>>     [    9.128906] CPU 3 systemd-udevd(148): Oops 0
>>     [    9.128906] pc = [<ffffffff80e63824>]  ra = [<fffffffc03faf914>]  ps = 0000    Not tainted
>>     [    9.128906] pc is at drm_pcie_get_speed_cap_mask+0x3c/0x12c
>>     [    9.128906] ra is at si_dpm_init+0x64/0x1398 [radeon]
>>     [    9.128906] v0 = ffffffffffffffea  t0 = fffffc07fcc3a400  t1 = 0000000000001106
>>     [    9.128906] t2 = 0000000000001166  t3 = 0000000000000000  t4 = fffffc018eafc000
>>     [    9.128906] t5 = ffffffffffffff80  t6 = 000000000000003f  t7 = fffffc07f6a90000
>>     [    9.128906] s0 = fffffc07f6a9390c  s1 = 0000000000000000  s2 = fffffc07f59119b0
>>     [    9.128906] s3 = 0000000000000001  s4 = fffffffffffffff4  s5 = fffffc07f5910000
>>     [    9.128906] s6 = 0000000000000000
>>     [    9.128906] a0 = fffffc07f706c800  a1 = fffffc07f6a9390c  a2 = fffffffffffffffc
>>     [    9.128906] a3 = ffffffff815fb510  a4 = ffffffff815fb4c8  a5 = 0000000000000000
>>     [    9.128906] t8 = 000000000000007f  t9 = ffffffff80d86c14  t10= 0000000000000001
>>     [    9.128906] t11= 00000000000003c0  pv = ffffffff80e637e8  at = 0000000000000000
>>     [    9.128906] gp = ffffffff815e9230  sp = fffffc07f6a93868
>>     [    9.128906] Disabling lock debugging due to kernel taint
>>     [    9.128906] Trace:
>>     [    9.128906] [<ffffffff80e61260>] drm_dev_register+0xb0/0x138
>>     [    9.128906] [<ffffffff80e64368>] drm_get_pci_dev+0x120/0x208
>>     [    9.128906] [<ffffffff80dcced4>] local_pci_probe+0x38/0x8c
>>     [    9.128906] [<ffffffff80dcdac0>] pci_device_probe+0x170/0x1d0
>>     [    9.128906] [<ffffffff80e9d654>] driver_probe_device+0x168/0x2fc
>>     [    9.128906] [<ffffffff80e9d87c>] __driver_attach+0x94/0xe8
>>     [    9.128906] [<ffffffff80e9acf4>] bus_for_each_dev+0x94/0xd4
>>     [    9.128906] [<ffffffff80e9d7e8>] __driver_attach+0x0/0xe8
>>     [    9.128906] [<ffffffff80e9ce98>] driver_attach+0x2c/0x40
>>     [    9.128906] [<ffffffff80e9c870>] bus_add_driver+0x140/0x2d4
>>     [    9.128906] [<ffffffff80e9e28c>] driver_register+0x100/0x180
>>     [    9.128906] [<ffffffff80dccda0>] __pci_register_driver+0x48/0x5c
>>     [    9.128906] [<ffffffff80e644cc>] drm_pci_init+0x7c/0x168
>>     [    9.128906] [<ffffffff809102fc>] do_one_initcall+0x188/0x25c
>>     [    9.128906] [<ffffffff809f5f00>] do_init_module+0x8c/0x2c8
>>     [    9.128906] [<ffffffff80a5b698>] kmem_cache_alloc+0x1f8/0x22c
>>     [    9.128906] [<ffffffff809f5eb4>] do_init_module+0x40/0x2c8
>>     [    9.128906] [<ffffffff809b36c8>] load_module+0x1ea8/0x263c
>>     [    9.128906] [<ffffffff809af9fc>] unknown_module_param_cb+0x0/0xc8
>>     [    9.128906] [<ffffffff809b40a4>] SYSC_finit_module+0x94/0xb4
>>     [    9.128906] [<ffffffff809aeb68>] module_notes_read+0x0/0x4c
>>     [    9.128906] [<ffffffff80911040>] entSys+0xa0/0xc0
> Grepping on entSys the only mention is on alpha.
>
> Is dev->pdev->bus->parent NULL by any chance?
>>     [    9.128906] Code: 8c300188  c020003b  8c210010  f85f1106  f87f1166  8d410038 <842a003c> 40220502
>>     [    9.128906] systemd-udevd[136]: worker [148] terminated by signal 11 (Segmentation fault)
>>
>> Signed-off-by: Caicai <caizhaopeng@deepin.com>
>> ---
>>  drivers/gpu/drm/drm_pci.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
>> index 4db9c515b74f..3d1cd760b79c 100644
>> --- a/drivers/gpu/drm/drm_pci.c
>> +++ b/drivers/gpu/drm/drm_pci.c
>> @@ -332,10 +332,12 @@ int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
>>       u32 lnkcap, lnkcap2;
>>
>>       *mask = 0;
>> -     if (!dev->pdev)
>> +     if (!dev->pdev || !dev->pdev->bus)
>>               return -EINVAL;
> I think we can assume our device is on a bus.
>>       root = dev->pdev->bus->self;
>> +     if (!root)
>> +             return -EINVAL;
> I'm not a PCI expert, but seems like a bad design to say none of the speeds are supported just because we lack a bridge.
>
> btw, drm_pcie_get_max_link_width is similarly affected.

Is the VM passthrough by any chance?  These functions need access to
the bridge and pci config space to determine what speeds the link
supports.  Those are not always available in VMs.

Alex


>
> ~Maarten
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
