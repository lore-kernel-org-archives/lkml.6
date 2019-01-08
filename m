Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B94C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EE82084D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 23:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vlv0W6NR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfAHXK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 18:10:29 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43496 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfAHXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 18:10:28 -0500
Received: by mail-ua1-f67.google.com with SMTP id z11so1830021uaa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QoiWJxh6DdVxfxZApOG6y69QsriGzRtQlDkCa7sGKBs=;
        b=Vlv0W6NRB6Yjl7/Sa/+SBiQDNO3Agx/dPg/JwU7DQL4ZI9CNUPjw5kElJUnVaBFoGI
         PYy7udFYP4FWVdiETHZBkBdtQqzG+pjqnVxYpLy4ZAy9RXdJccI543/XP7EplNg8nybW
         ammCJ63X2UycNHiH1xCp1KYwWpEfIvWx7YkD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QoiWJxh6DdVxfxZApOG6y69QsriGzRtQlDkCa7sGKBs=;
        b=T4lZkcNiEuMg8hoXqR5dDn5rxQF1tgQxQvh8qfR7yGdZpw0quCCujCx5wFKJ9QFDPC
         i9SDtWpVAdzwXWx4NStgP7xIM3ar3gh4BRaG3S+gjPnCDR4/tx4ZCXhLDBcojU6AK3n7
         ZL9odepYhvDjpxcTl44FBK6pV2LXSYwI2/4Kk54jNwC2LJ4/efcLLKln/ztQXDiNn9cS
         Q0n5EkSkuzog5IMA3e2/pBlPYi1KQFzHi6qfkyGuOyM0We6Lp3MIB4WAfudfVa54xD/3
         SqRP+bk+//5rKILSIjC7JU4CuC7Nn5fWCRVakPDt1+6QPy7EnFBqTVJ6ljwjwEeCgGeo
         UWYw==
X-Gm-Message-State: AJcUukeTN51RxG5owetCvYlIJ7L+4UBdJVg3M0gHGZMB+pbPNRzR6scR
        lPzQNfsWwXVHdd4g6U0rOXcyzgqtr4o=
X-Google-Smtp-Source: ALg8bN7zr+YF0MrdjYrL8rFqMjTCLAJztsZajJ0YSRTmFu041ebcbdHVgEOkTY3ljKeSxgOVYf3XHg==
X-Received: by 2002:ab0:30b7:: with SMTP id b23mr1357942uam.109.1546989026660;
        Tue, 08 Jan 2019 15:10:26 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id e67sm32502624vsd.32.2019.01.08.15.10.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 15:10:25 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id h78so3599002vsi.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 15:10:25 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr1555312vsl.188.1546989024645;
 Tue, 08 Jan 2019 15:10:24 -0800 (PST)
MIME-Version: 1.0
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 15:10:12 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
Message-ID: <CAGXu5jKUP9o-ZgW5Wa5-9DHeQNZ5VA3cLBCJ0P7AVkTQ5tqHtQ@mail.gmail.com>
Subject: nvdimm crash at boot
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-nvdimm@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a warn that I added to fail more gracefully (sorry for
whitespace damage):

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 4890310df874..1161b994b1ec 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -516,6 +516,8 @@ static umode_t nvdimm_visible(struct kobject
*kobj, struct attribute *a, int n)
                return a->mode;
        if (nvdimm->sec.state < 0)
                return 0;
+       if (WARN_ON_ONCE(!nvdimm->sec.ops))
+               return 0;
        /* Are there any state mutation ops? */
        if (nvdimm->sec.ops->freeze || nvdimm->sec.ops->disable
                        || nvdimm->sec.ops->change_key

Without it, I would crash at boot due to the sec.ops dereference. It's
not clear to me if there is a better solution than just the sec.ops
NULL test (i.e. should it ever be NULL?)

[    1.393599] WARNING: CPU: 3 PID: 484 at
drivers/nvdimm/dimm_devs.c:519 nvdimm_visible+0x79/0x80
[    1.393858] Modules linked in:
[    1.393858] CPU: 3 PID: 484 Comm: kworker/u8:3 Not tainted 5.0.0-rc1+ #926
[    1.393858] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1ubuntu1 04/01/2014
[    1.396781] Workqueue: events_unbound async_run_entry_fn
[    1.396781] RIP: 0010:nvdimm_visible+0x79/0x80
[    1.396781] Code: e8 4c fc ff ff eb c7 48 83 78 20 00 75 e6 48 83
78 10 00 75 df 48 83 78 28 00 75 d8 48 83 78 30 00 75 d1 b8 24 01 00
00 eb b1 <0f> 0b eb ad 0f 1f 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56
41 55
[    1.396781] RSP: 0000:ffffb911803abd00 EFLAGS: 00010246
[    1.396781] RAX: 0000000000000000 RBX: ffffffff98cf5a80 RCX: 00000000000001a4
[    1.396781] RDX: 0000000000000004 RSI: ffffffff98cf5a80 RDI: ffff94e7ed088028
[    1.396781] RBP: ffffb911803abd10 R08: 0000000000000000 R09: 0000000000000001
[    1.396781] R10: ffffb911803abaf8 R11: 0000000000000000 R12: ffff94e7ed088028
[    1.396781] R13: ffff94e7ed088028 R14: ffffffff98cf5a60 R15: 0000000000000000
[    1.396781] FS:  0000000000000000(0000) GS:ffff94e7efb80000(0000)
knlGS:0000000000000000
[    1.396781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.396781] CR2: 00000000ffffffff CR3: 0000000150822001 CR4: 00000000001606e0
[    1.396781] Call Trace:
[    1.396781]  internal_create_group+0xf4/0x380
[    1.396781]  sysfs_create_groups+0x46/0xb0
[    1.396781]  device_add+0x331/0x680
[    1.396781]  nd_async_device_register+0x15/0x60
[    1.396781]  async_run_entry_fn+0x38/0x100
[    1.396781]  process_one_work+0x22b/0x5a0
[    1.396781]  worker_thread+0x3f/0x3b0
[    1.396781]  kthread+0x12b/0x150
[    1.396781]  ? process_one_work+0x5a0/0x5a0
[    1.396781]  ? kthread_park+0xa0/0xa0
[    1.396781]  ret_from_fork+0x24/0x30
[    1.396781] irq event stamp: 952
[    1.396781] hardirqs last  enabled at (951): [<ffffffff973f5cb4>]
__slab_alloc.constprop.79+0x44/0x70
[    1.396781] hardirqs last disabled at (952): [<ffffffff97201cf0>]
trace_hardirqs_off_thunk+0x1a/0x1c
[    1.396781] softirqs last  enabled at (0): [<ffffffff97267ae3>]
copy_process.part.55+0x413/0x1f10
[    1.396781] softirqs last disabled at (0): [<0000000000000000>]
      (null)
[    1.396781] ---[ end trace 5608ce056f09564f ]---

I assume this crash is due to be using nvdimm without any special
markings (i.e. I'm using it crudely with pstore), in KVM:

RAM_SIZE=16384
NVDIMM_SIZE=128
MAX_SIZE=$(( RAM_SIZE + NVDIMM_SIZE ))

sudo qemu-system-x86_64 \
  ...
        -machine pc,nvdimm \
        -m ${RAM_SIZE}M,slots=2,maxmem=${MAX_SIZE}M \
        -object
memory-backend-file,id=mem1,share=on,mem-path=nvdimm.img,size=${NVDIMM_SIZE}M,align=128M
\
        -device nvdimm,id=nvdimm1,memdev=mem1 \
...
        -append '... ramoops.mem_size=1048576 ramoops.ecc=1
ramoops.mem_address=0x440000000 ramoops.console_size=16384
ramoops.ftrace_size=16384 ramoops.pmsg_size=16384
ramoops.record_size=32768'

I assume 37833fb7989a9 ("acpi/nfit, libnvdimm: Add freeze security
support to Intel nvdimm") was where it started, but I didn't actually
bisect.

-- 
Kees Cook
