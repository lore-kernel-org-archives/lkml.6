Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E992146F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ggDKrPPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfAHX21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:28:27 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40451 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfAHX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:28:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so4827226oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ck4eOE9s0olsjMNNzvOyvV78GdkiU301RjxTpk/zJxg=;
        b=ggDKrPPNFzFW5wKCKmaEyA/siQTwaowNG1I3kcDEW5A47Hvg4BO9ultxnFCXar20so
         g8tju+kKdk34rZ6q3i7691e8T0qEaalmYbC6C/AMT/+SO7flH60GrZGN8dLWL4OssZ0u
         wariuoVzYOD41PvQQ8Sk+oKcA7H9zgMA9FQWbKyRVMsHuOZwH5fOykXhNQa2NSKQQoET
         bWlDicjoN57v9weJprmlaDiI4yyWwtCJm3vEoJTtzOxrU25qpvY6Fi7Lg2vlp3GcJeUb
         uf/dCzL/nOWwp5lNxdtr3kiB1T6DIr88+ZKQbExGzZjZ0SzrLvM9N9vegn72FZm+iVlJ
         dVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ck4eOE9s0olsjMNNzvOyvV78GdkiU301RjxTpk/zJxg=;
        b=DNEddrbF9aeAr+h9rO0wL2plXqIXDvUzbZlHh9B+lpO7Z5njJ9MvekvXCXfP4E2aLl
         U8XcgnIDIFyhiHdGun+kroWH5iKqh/lPWlKxStVfG4YOpLZsFh+aIJ/1b2Ct1i4Gc6HZ
         q7XX7dci8e4TR3Nq+R3tzXxZW+/PaISDb8BUhRtxshIDTQeCueO8nKzRi4JByy8I1WlV
         XfAPd1pFOpCLXYGCBmidYYtW0s1J72yoyRCECZV2TZwMctFSEfvc2DjDr4lJv+aQeMl7
         vLhToppV7LH/vMT7uU5bk6eiG2xfJESHBI0fzLlAXRKVJLquFqvfFC8Mb3uDqy1YaY9g
         ZmKg==
X-Gm-Message-State: AJcUukdAtJ7BGNYH6yMR8S7DoOzvi/aZtUgDJUP4w6RBDyr5XwD2+wM0
        15sisC01ECqBI37pn/8uRLctUE78KKJE4UOHyn/FnQnqopk=
X-Google-Smtp-Source: ALg8bN4NGLseMMIH0w3vy6rt5eTqE+iUrtM6JWm1ruJ29o/sPFqT/iy9JpSpIL4jOBxJrcfaT1foVKrt2viPhs5NFN4=
X-Received: by 2002:aca:5205:: with SMTP id g5mr2476563oib.149.1546990103804;
 Tue, 08 Jan 2019 15:28:23 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jan 2019 15:28:12 -0800
Message-ID: <CAPcyv4iZZEM3D8vta_sge7a4iMgPZ5a1AnunXa4DKUaWauZk1g@mail.gmail.com>
Subject: Re: nvdimm crash at boot
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 3:10 PM Kees Cook <keescook@chromium.org> wrote:
>
> This is a warn that I added to fail more gracefully (sorry for
> whitespace damage):
>
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 4890310df874..1161b994b1ec 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -516,6 +516,8 @@ static umode_t nvdimm_visible(struct kobject
> *kobj, struct attribute *a, int n)
>                 return a->mode;
>         if (nvdimm->sec.state < 0)
>                 return 0;
> +       if (WARN_ON_ONCE(!nvdimm->sec.ops))
> +               return 0;
>         /* Are there any state mutation ops? */
>         if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
>                         || nvdimm->sec.ops->change_key
>
> Without it, I would crash at boot due to the sec.ops dereference. It's
> not clear to me if there is a better solution than just the sec.ops
> NULL test (i.e. should it ever be NULL?)

It will always be NULL for anything other than real nvdimms with
security support.

>
> [    1.393599] WARNING: CPU: 3 PID: 484 at
> drivers/nvdimm/dimm_devs.c:519 nvdimm_visible+0x79/0x80
> [    1.393858] Modules linked in:
> [    1.393858] CPU: 3 PID: 484 Comm: kworker/u8:3 Not tainted 5.0.0-rc1+ #926
> [    1.393858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [    1.396781] Workqueue: events_unbound async_run_entry_fn
> [    1.396781] RIP: 0010:nvdimm_visible+0x79/0x80
> [    1.396781] Code: e8 4c fc ff ff eb c7 48 83 78 20 00 75 e6 48 83
> 78 10 00 75 df 48 83 78 28 00 75 d8 48 83 78 30 00 75 d1 b8 24 01 00
> 00 eb b1 <0f> 0b eb ad 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56
> 41 55
> [    1.396781] RSP: 0000:ffffb911803abd00 EFLAGS: 00010246
> [    1.396781] RAX: 0000000000000000 RBX: ffffffff98cf5a80 RCX: 00000000000001a4
> [    1.396781] RDX: 0000000000000004 RSI: ffffffff98cf5a80 RDI: ffff94e7ed088028
> [    1.396781] RBP: ffffb911803abd10 R08: 0000000000000000 R09: 0000000000000001
> [    1.396781] R10: ffffb911803abaf8 R11: 0000000000000000 R12: ffff94e7ed088028
> [    1.396781] R13: ffff94e7ed088028 R14: ffffffff98cf5a60 R15: 0000000000000000
> [    1.396781] FS:  0000000000000000(0000) GS:ffff94e7efb80000(0000)
> knlGS:0000000000000000
> [    1.396781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.396781] CR2: 00000000ffffffff CR3: 0000000150822001 CR4: 00000000001606e0
> [    1.396781] Call Trace:
> [    1.396781]  internal_create_group+0xf4/0x380
> [    1.396781]  sysfs_create_groups+0x46/0xb0
> [    1.396781]  device_add+0x331/0x680
> [    1.396781]  nd_async_device_register+0x15/0x60
> [    1.396781]  async_run_entry_fn+0x38/0x100
> [    1.396781]  process_one_work+0x22b/0x5a0
> [    1.396781]  worker_thread+0x3f/0x3b0
> [    1.396781]  kthread+0x12b/0x150
> [    1.396781]  ? process_one_work+0x5a0/0x5a0
> [    1.396781]  ? kthread_park+0xa0/0xa0
> [    1.396781]  ret_from_fork+0x24/0x30
> [    1.396781] irq event stamp: 952
> [    1.396781] hardirqs last  enabled at (951): [<ffffffff973f5cb4>]
> __slab_alloc.constprop.79+0x44/0x70
> [    1.396781] hardirqs last disabled at (952): [<ffffffff97201cf0>]
> trace_hardirqs_off_thunk+0x1a/0x1c
> [    1.396781] softirqs last  enabled at (0): [<ffffffff97267ae3>]
> copy_process.part.55+0x413/0x1f10
> [    1.396781] softirqs last disabled at (0): [<0000000000000000>]
>       (null)
> [    1.396781] ---[ end trace 5608ce056f09564f ]---
>
> I assume this crash is due to be using nvdimm without any special
> markings (i.e. I'm using it crudely with pstore), in KVM:
>
> RAM_SIZE=16384
> NVDIMM_SIZE=128
> MAX_SIZE=$(( RAM_SIZE + NVDIMM_SIZE ))
>
> sudo qemu-system-x86_64 \
>   ...
>         -machine pc,nvdimm \
>         -m ${RAM_SIZE}M,slots=2,maxmem=${MAX_SIZE}M \
>         -object
> memory-backend-file,id=mem1,share=on,mem-path=nvdimm.img,size=${NVDIMM_SIZE}M,align=128M
> \
>         -device nvdimm,id=nvdimm1,memdev=mem1 \

Ah, thanks for the report! The key difference is that you don't define
a "label area", so the driver bails out early and never initializes
the security state.

This should fix it up.

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 4890310df874..636cdb06ee17 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -514,7 +514,7 @@ static umode_t nvdimm_visible(struct kobject
*kobj, struct attribute *a, int n)

        if (a != &dev_attr_security.attr)
                return a->mode;
-       if (nvdimm->sec.state < 0)
+       if (!nvdimm->sec.ops || nvdimm->sec.state < 0)
                return 0;
        /* Are there any state mutation ops? */
        if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
