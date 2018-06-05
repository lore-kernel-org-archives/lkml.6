Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2343747-1528185059-2-12371654729761829330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528185059; b=hiqCf993+mzZeBnDfsbiZg2hLZ1TN6Zx/usPJo+UCBYCnfVGnp
    ezD5fvIDAamKWBrD2c6PRsQvVwi+OBEem/lDMSUnucaAUAWsKtA6o8oyT2KlBkHG
    irxr/Mz67q4qR2fagm6Z9uSJYXR5EWXHoaYjbEhd7coEDXrK8XN58xswUukVNJ9i
    n+AxiYuU57tPx5JvcXQpEUDKZDXxer7pOozBNVCgDK8uk3gCmfOrgQqaUov0neNZ
    b6tCu5B4pcBiNIob7VEnaCuAxj2Ax5J9VxCB1D00yl0ea4suP/W8LO3AI/IsAXYg
    mQ9tonPBTnCTgCjq60Fg+tERU2TlCapQba/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528185059; bh=m6xVfK4GwzYOGCKWJ/bJq11nYqK9oWr3XxqUAAU5jR
    s=; b=bnA/QHqqJS02MPwpNYw2X9o6VCsFxnS6zL2aAHJFPenP2jytDhFKK3W8gR
    eEvVJlh2etFXvXltM4PXz0VT5Q92yhzoEtAmIHervD2fXukCHB3e0B1oXTEdNrlN
    C7+4XYKkNpCsFw1Qu1q0YKBNGehPRJqdLnEdMbW2hCHwD4STX+ywc89X5a4p56hQ
    s4ytorlMq+DDgVbXTjCBnAosT3KAr7dTpfYxmEwzcnQwjanULb3vbD33f37ZFEO3
    Z5+xnHB8RqXpJo+D9BaT4EGEKGbG1ODQ3Au6qPwODwvBCsRr3UDeayMXY+w4HOKR
    q0xyKul6yE/7QmYhKnJeJ5K60aew==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=MofBU5OC header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=XW9haMtK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=MofBU5OC header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=XW9haMtK;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL6V2PoK/wOj+NxO0C1ka3IxU/Gm+SuK76wNwmGXby36ll3G78pkQ8AztnJucaJL2QVCxTdAQIGIAtLcL4t1z+Et9t93SJL5yYXa5dCasCJwDzsq/kP8
    +jH+Am56L+g+C21l0uer3s5U2lvGh5PskTLOym0uv1XybC2XAv5if1bG+zIugK84ehuJBiYkhr59sZrahWigS5FJvTGTVAxUi74RIIlqF6Mn8wI6nMuBjvhm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=GUVi8RmzAAAA:8 a=MZGxuxEHAKCRHyl5jYEA:9
    a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22 a=jSdgSmmMQx7r16_JUfbt:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeFEHuz (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 03:50:55 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39425 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeFEHuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:50:54 -0400
X-Google-Smtp-Source: ADUXVKKGbQ63yIhGH13pQ35FcYOni3ouyrbHb1aXcosaB3nMgfvAcnDEIS+BmUglGFA+d+Qnm1MLi8znMBzjrjmOqFc=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hJOzRBR0hg=xBZkd_oLtQRZeTXShYChdu8VA+GgTqUvg@mail.gmail.com>
References: <CAPcyv4hJOzRBR0hg=xBZkd_oLtQRZeTXShYChdu8VA+GgTqUvg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 5 Jun 2018 09:50:33 +0200
Message-ID: <CACT4Y+bMMrhMUfAWH9fPWJ9FNWJFLqSTeYvLjD=hr+85XjpY-w@mail.gmail.com>
Subject: Re: KASAN vs ZONE_DEVICE (was: Re: [PATCH v2 2/7] dax: change bdev_dax_supported()...)
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jun 5, 2018 at 6:22 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Jun 4, 2018 at 8:32 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> [ adding KASAN devs...]
>>
>> On Mon, Jun 4, 2018 at 4:40 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>> On Sun, Jun 3, 2018 at 6:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>>> On Sun, Jun 3, 2018 at 5:25 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>>> On Mon, Jun 04, 2018 at 08:20:38AM +1000, Dave Chinner wrote:
>>>>>> On Thu, May 31, 2018 at 09:02:52PM -0700, Dan Williams wrote:
>>>>>> > On Thu, May 31, 2018 at 7:24 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>>>> > > On Thu, May 31, 2018 at 06:57:33PM -0700, Dan Williams wrote:
>>>>>> > >> > FWIW, XFS+DAX used to just work on this setup (I hadn't even
>>>>>> > >> > installed ndctl until this morning!) but after changing the kernel
>>>>>> > >> > it no longer works. That would make it a regression, yes?
>>>>>>
>>>>>> [....]
>>>>>>
>>>>>> > >> I suspect your kernel does not have CONFIG_ZONE_DEVICE enabled which
>>>>>> > >> has the following dependencies:
>>>>>> > >>
>>>>>> > >>         depends on MEMORY_HOTPLUG
>>>>>> > >>         depends on MEMORY_HOTREMOVE
>>>>>> > >>         depends on SPARSEMEM_VMEMMAP
>>>>>> > >
>>>>>> > > Filesystem DAX now has a dependency on memory hotplug?
>>>>>>
>>>>>> [....]
>>>>>>
>>>>>> > > OK, works now I've found the magic config incantantions to turn
>>>>>> > > everything I now need on.
>>>>>>
>>>>>> By enabling these options, my test VM now has a ~30s pause in the
>>>>>> boot very soon after the nvdimm subsystem is initialised.
>>>>>>
>>>>>> [    1.523718] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>>>>>> [    1.550353] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>>>>>> [    1.552175] Non-volatile memory driver v1.3
>>>>>> [    2.332045] tsc: Refined TSC clocksource calibration: 2199.909 MHz
>>>>>> [    2.333280] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb5dcd4620, max_idle_ns: 440795264143 ns
>>>>>> [   37.217453] brd: module loaded
>>>>>> [   37.225423] loop: module loaded
>>>>>> [   37.228441] virtio_blk virtio2: [vda] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
>>>>>> [   37.245418] virtio_blk virtio3: [vdb] 146800640 512-byte logical blocks (75.2 GB/70.0 GiB)
>>>>>> [   37.255794] virtio_blk virtio4: [vdc] 1073741824000 512-byte logical blocks (550 TB/500 TiB)
>>>>>> [   37.265403] nd_pmem namespace1.0: unable to guarantee persistence of writes
>>>>>> [   37.265618] nd_pmem namespace0.0: unable to guarantee persistence of writes
>>>>>>
>>>>>> The system does not appear to be consuming CPU, but it is blocking
>>>>>> NMIs so I can't get a CPU trace. For a VM that I rely on booting in
>>>>>> a few seconds because I reboot it tens of times a day, this is a
>>>>>> problem....
>>>>>
>>>>> And when I turn on KASAN, the kernel fails to boot to a login prompt
>>>>> because:
>>>>
>>>> What's your qemu and kernel command line? I'll take look at this first
>>>> thing tomorrow.
>>>
>>> I was able to reproduce this crash by just turning on KASAN...
>>> investigating. It would still help to have your config for our own
>>> regression testing purposes it makes sense for us to prioritize
>>> "Dave's test config", similar to the priority of not breaking Linus'
>>> laptop.
>>
>> I believe this is a bug in KASAN, or a bug in devm_memremap_pages(),
>> depends on your point of view. At the very least it is a mismatch of
>> assumptions. KASAN learns of hot added memory via the memory hotplug
>> notifier. However, the devm_memremap_pages() implementation is
>> intentionally limited to the "first half" of the memory hotplug
>> procedure. I.e. it does just enough to setup the linear map for
>> pfn_to_page() and initialize the "struct page" memmap, but then stops
>> short of onlining the pages. This is why we are getting a NULL ptr
>> deref and not a KASAN report, because KASAN has no shadow area setup
>> for the linearly mapped pmem range.
>>
>> In terms of solving it we could refactor kasan_mem_notifier() so that
>> devm_memremap_pages() can call it outside of the notifier... I'll give
>> this a shot.
>
> Well, the attached patch got me slightly further, but only slightly...
>
> [   14.998394] BUG: KASAN: unknown-crash in pmem_do_bvec+0x19e/0x790 [nd_pmem]
> [   15.000006] Read of size 4096 at addr ffff880200000000 by task
> systemd-udevd/915
> [   15.001991]
> [   15.002590] CPU: 15 PID: 915 Comm: systemd-udevd Tainted: G
>   OE     4.17.0-rc5+ #1
> 982
> [   15.004783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.11.1-0-g0551a
> 4be2c-prebuilt.qemu-project.org 04/01/2014
> [   15.007652] Call Trace:
> [   15.008339]  dump_stack+0x9a/0xeb
> [   15.009344]  print_address_description+0x73/0x280
> [   15.010524]  kasan_report+0x258/0x380
> [   15.011528]  ? pmem_do_bvec+0x19e/0x790 [nd_pmem]
> [   15.012747]  memcpy+0x1f/0x50
> [   15.013659]  pmem_do_bvec+0x19e/0x790 [nd_pmem]
>
> ...I've exhausted my limited kasan internals knowledge, any ideas what
> it's missing?


+kasan-dev

Andrey, can you please take a look at this?
