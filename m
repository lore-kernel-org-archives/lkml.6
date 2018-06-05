Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2158426-1528169565-2-15098709938121492990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528169565; b=YoozoUlTR3kNGrIUgpUqy0GbgbPzHTBqsuwWbO0/JjY2ooHQ/s
    6/0XdU29krwft+vEHaY123wGA73Z1qXrQwXX1nYRZd1wBBUdvsKcA4BW1BiV+T7f
    AptqYAFuisJTsPMrJ4EgwsIC+QDgfjGWaa6dXddGW/mbUhOeLNegf31GTgyzjEFi
    W4I1ZSOZloxGB4FvU529Hg6k7vLR1PnVzaDhlTbN9jdsQ5/71VUMRoaKWv6TZZpn
    qgHP02phEQyZoWZHgOn1IbmBGT3AsrJwc/ifxWLhqvges0TG7TfgnuvJ+WihKlWl
    DToo+nrx9PeMEcVtkEFChCV/Fj3uOLDnUIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528169565; bh=eLy5LdDEG9q7Seg40lgwRmlMLAEt/zjsfxskebE6N5
    c=; b=cX3+A+0ylw8ePi+gwPKqFu18ZxTqQ8pSTcBiSsXMbXPF6dqo9oIq4gu9el
    eDOQBlBLR/FG34Ip23grCSzhloHnKfEcwRYtonLL8mBWbDcihf9OPfYLizeZ0h9u
    a3sjhBWu2vhiyQPBz8hjDV3to9jD9Z0yLSBgPD5iknDx4fX4iRqR8hnqhqFEssuA
    XyjIEU9Ny3MbG9fkmH2f7c85JWOwwK/j35rzm5PUlZqLNej4GBMMD6t85APpYzsl
    WeBBIiWJoX4coatHiCb1pm1MIxm7yFqpzEy4JInm+wHUKcA5Mk1n3olmnxnJsz4Z
    lvWEkkxm3CCjB7dpKRSYs2a8wBBA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=Hv+MYXrt
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=mhmU27rU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=Hv+MYXrt
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=mhmU27rU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGB4XFIXdLCoUDfIftSCr4980yOIQ+W2wXTYI6G5wdrcZfq+mePQx4xEUaxGQpqiRkkrAbjo5e6d6tWHVKDdPYSUbdQJEn0gJ/sD7fktw+2yaZ0YbHfb
    F/ShllokaubfMBzF4ZuwUVItlpYlDr9CmTH75GTbC4bVpsf23zBciaG9yNLXoA9XC6ZoZcLZnx7AKy/82RxK9cAM8+sFXTXZ1VCaOzpQtV4KPaNOBPmt/Aym
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=Y4Uh3gtukcvl6jUD8-QA:9 a=QEXdDO2ut3YA:10
    a=biEYGPWJfzWAr4FL6Ov7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbeFEDcd (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 23:32:33 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41231 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFEDcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jun 2018 23:32:31 -0400
X-Google-Smtp-Source: ADUXVKJ7d7uvbr4YZbcDQOKpG0lN7AYj0az/D9SpIzdfqFX16mibtIsqpp+nnZhcL4Gyc3luI+l0MAgmQTrGtEufw9o=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iVU3n3G3Vxf9e6cKuCtQtmrm6+R6vS379NyHX6eTZ5Lg@mail.gmail.com>
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
 <20180529195106.14268-3-ross.zwisler@linux.intel.com> <20180529212510.GJ30110@magnolia>
 <20180529220114.GA13948@linux.intel.com> <20180531191332.GB7825@magnolia>
 <20180601012657.GQ10363@dastard> <CAPcyv4g6dv9sG9dR-iY+aEfSi2r3ey1dXGbX-nexKsN72t0QMw@mail.gmail.com>
 <20180601022418.GR10363@dastard> <CAPcyv4iXTsxmQgjoLs2E_8QrLHrFOV_58T7UYf0zPJuB2744qQ@mail.gmail.com>
 <20180603222038.GS10363@dastard> <20180604002525.GI10363@dastard>
 <CAPcyv4jL5AKgP3io_hBZxkrKzBZq8wtuqk49L48v=XRiOHdoEw@mail.gmail.com> <CAPcyv4iVU3n3G3Vxf9e6cKuCtQtmrm6+R6vS379NyHX6eTZ5Lg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jun 2018 20:32:30 -0700
Message-ID: <CAPcyv4i-ocx3-9dCsKfyhf=vBtYnfJwzYyCU2jektHZ2LPL0rA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dax: change bdev_dax_supported() to support
 boolean returns
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ adding KASAN devs...]

On Mon, Jun 4, 2018 at 4:40 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, Jun 3, 2018 at 6:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Sun, Jun 3, 2018 at 5:25 PM, Dave Chinner <david@fromorbit.com> wrote:
>>> On Mon, Jun 04, 2018 at 08:20:38AM +1000, Dave Chinner wrote:
>>>> On Thu, May 31, 2018 at 09:02:52PM -0700, Dan Williams wrote:
>>>> > On Thu, May 31, 2018 at 7:24 PM, Dave Chinner <david@fromorbit.com> wrote:
>>>> > > On Thu, May 31, 2018 at 06:57:33PM -0700, Dan Williams wrote:
>>>> > >> > FWIW, XFS+DAX used to just work on this setup (I hadn't even
>>>> > >> > installed ndctl until this morning!) but after changing the kernel
>>>> > >> > it no longer works. That would make it a regression, yes?
>>>>
>>>> [....]
>>>>
>>>> > >> I suspect your kernel does not have CONFIG_ZONE_DEVICE enabled which
>>>> > >> has the following dependencies:
>>>> > >>
>>>> > >>         depends on MEMORY_HOTPLUG
>>>> > >>         depends on MEMORY_HOTREMOVE
>>>> > >>         depends on SPARSEMEM_VMEMMAP
>>>> > >
>>>> > > Filesystem DAX now has a dependency on memory hotplug?
>>>>
>>>> [....]
>>>>
>>>> > > OK, works now I've found the magic config incantantions to turn
>>>> > > everything I now need on.
>>>>
>>>> By enabling these options, my test VM now has a ~30s pause in the
>>>> boot very soon after the nvdimm subsystem is initialised.
>>>>
>>>> [    1.523718] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>>>> [    1.550353] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>>>> [    1.552175] Non-volatile memory driver v1.3
>>>> [    2.332045] tsc: Refined TSC clocksource calibration: 2199.909 MHz
>>>> [    2.333280] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb5dcd4620, max_idle_ns: 440795264143 ns
>>>> [   37.217453] brd: module loaded
>>>> [   37.225423] loop: module loaded
>>>> [   37.228441] virtio_blk virtio2: [vda] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)
>>>> [   37.245418] virtio_blk virtio3: [vdb] 146800640 512-byte logical blocks (75.2 GB/70.0 GiB)
>>>> [   37.255794] virtio_blk virtio4: [vdc] 1073741824000 512-byte logical blocks (550 TB/500 TiB)
>>>> [   37.265403] nd_pmem namespace1.0: unable to guarantee persistence of writes
>>>> [   37.265618] nd_pmem namespace0.0: unable to guarantee persistence of writes
>>>>
>>>> The system does not appear to be consuming CPU, but it is blocking
>>>> NMIs so I can't get a CPU trace. For a VM that I rely on booting in
>>>> a few seconds because I reboot it tens of times a day, this is a
>>>> problem....
>>>
>>> And when I turn on KASAN, the kernel fails to boot to a login prompt
>>> because:
>>
>> What's your qemu and kernel command line? I'll take look at this first
>> thing tomorrow.
>
> I was able to reproduce this crash by just turning on KASAN...
> investigating. It would still help to have your config for our own
> regression testing purposes it makes sense for us to prioritize
> "Dave's test config", similar to the priority of not breaking Linus'
> laptop.

I believe this is a bug in KASAN, or a bug in devm_memremap_pages(),
depends on your point of view. At the very least it is a mismatch of
assumptions. KASAN learns of hot added memory via the memory hotplug
notifier. However, the devm_memremap_pages() implementation is
intentionally limited to the "first half" of the memory hotplug
procedure. I.e. it does just enough to setup the linear map for
pfn_to_page() and initialize the "struct page" memmap, but then stops
short of onlining the pages. This is why we are getting a NULL ptr
deref and not a KASAN report, because KASAN has no shadow area setup
for the linearly mapped pmem range.

In terms of solving it we could refactor kasan_mem_notifier() so that
devm_memremap_pages() can call it outside of the notifier... I'll give
this a shot.
