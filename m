Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A4AC4151A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A0E20684
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ygCqCFny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBVD7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:59:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43295 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBVD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 22:59:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id i8so701778oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 19:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5gRCZQed2GgtoNqI7unw3B/0pzNIdbxo5u3Ey/lkKQ8=;
        b=ygCqCFny5vhMw3l3f82xU7dA/0HvWP6VDx4wdV2qHmtXsyhl829cYc6prJ43Fk9d+e
         vLN/EA5z8rI5Ydxc6v6NwgqACSPtqwZhn26GcBYkJ9R/3a4meo4bD1VG0C5N2/vbb5eZ
         FxtktJSuhFYnJvi5KHw5YDpF8ym7JTkvUwqtSVMaBVIJzkh+VcuxUcNDJk1eQtRrdvPH
         9WwykWTgaaLltK+mkwxfe5t1+PAOwCVCn2cTITjPiutidvrCEblIgcs/mZuikN0vzapr
         bh++A6CQgsM+P1CTe2Ril6afwE0jTzyWpdP8G33PE9OimVO5Bv0htO576AoLYgcy3faB
         8Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5gRCZQed2GgtoNqI7unw3B/0pzNIdbxo5u3Ey/lkKQ8=;
        b=uPVtrVs5paDvJYAa9AvZMtRzXXDeR2f8cROEEmKUFRx4DEEtWVIN4dPibkvia2xEQr
         GAbkXQSQDtDpV83OwJSJR+YdGlSZ0Gvn1s6x0XIC32Miljsp+LiueagfgcUnffNFiE0V
         1SGNuprlBDda0/7GHmq6aJoDTNXiQKGZAiAa5vbm6J5asiMubv0qLaroH7pmC8B954yZ
         CrRTY4m5b1Rad7Rh0qFbwRKXSbu2Al+vTZ0EA64SOpcf1qDXDsJIAnprWW8SqUZBvdrh
         loEkkh1d7hxMrgXH1S8rozY4PhDdvM4xLRtEkxlqGCqW8UZDrBohUv7ve0KEk92KXalG
         Nnbg==
X-Gm-Message-State: AHQUAubh9eVf2BfrNcj10SWN7D/FpCTj6Md+Hdx4PGr6BWnH2Kh3ixsN
        Nc3S9cNV/jJUPbraH9zU1ebtG+6f9XvWCmNhTdmAbg==
X-Google-Smtp-Source: AHgI3IYa/5jxncrdh7IMyPPa5GQx1xP4Mpt5MZZpI+YqkDRxJ6RItcKLaNgKuTiMJGo0FO0qFr7P5ob7rzjwcZ7J1V8=
X-Received: by 2002:aca:3906:: with SMTP id g6mr1284282oia.149.1550807942340;
 Thu, 21 Feb 2019 19:59:02 -0800 (PST)
MIME-Version: 1.0
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155000671719.348031.2347363160141119237.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49ftsgsnzp.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49ftsgsnzp.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Feb 2019 19:58:51 -0800
Message-ID: <CAPcyv4h9s1jYROGqkMfKk0MNBUedP=vQ1nJObLRwFiTB405nOg@mail.gmail.com>
Subject: Re: [PATCH 7/7] libnvdimm/pfn: Fix 'start_pad' implementation
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add linux-mm ]


On Thu, Feb 21, 2019 at 3:47 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Dan,
>
> Thanks for the comprehensive write-up.  Comments below.
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > In the beginning the pmem driver simply passed the persistent memory
> > resource range to memremap and was done. With the introduction of
> > devm_memremap_pages() and vmem_altmap the implementation needed to
> > contend with metadata at the start of the resource to indicate whether
> > the vmemmap is located in System RAM or Persistent Memory, and reserve
> > vmemmap capacity in pmem for the latter case.
> >
> > The indication of metadata space was communicated in the
> > nd_pfn->data_offset property and it was defined to be identical to the
> > pmem_device->data_offset property, i.e. relative to the raw resource
> > base of the namespace. Up until this point in the driver's development
> > pmem_device->phys_addr == __pa(pmem_device->virt_addr). This
> > implementation was fine up until the discovery of platforms with
> > physical address layouts that mapped Persistent Memory and System RAM to
> > the same Linux memory hotplug section (128MB span).
> >
> > The nd_pfn->start_pad and nd_pfn->end_trunc properties were introduced
> > to pad and truncate the capacity to fit within an exclusive Linux
> > memory hotplug section span, and it was at this point where the
> > ->start_pad definition did not comprehend the pmem_device->phys_addr to
> > pmem_device->virt_addr relationship. Platforms in the wild typically
> > only collided 'System RAM' at the end of the Persistent Memory range so
> > ->start_pad was often zero.
> >
> > Lately Linux has encountered platforms that collide Persistent Memory
> > regions between each other, specifically cases where ->start_pad needed
> > to be non-zero. This lead to commit ae86cbfef381 "libnvdimm, pfn: Pad
> > pfn namespaces relative to other regions". That commit allowed
> > namespaces to be mapped with devm_memremap_pages(). However dax
> > operations on those configurations currently fail if attempted within the
> > ->start_pad range because pmem_device->data_offset was still relative to
> > raw resource base not relative to the section aligned resource range
> > mapped by devm_memremap_pages().
> >
> > Luckily __bdev_dax_supported() caught these failures and simply disabled
> > dax.
>
> Let me make sure I understand the current state of things.  Assume a
> machine with two persistent memory ranges overlapping the same hotplug
> memory section.  Let's take the example from the ndctl github issue[1]:
>
> 187c000000-967bffffff : Persistent Memory
>
> /sys/bus/nd/devices/region0/resource: 0x187c000000
> /sys/bus/nd/devices/region1/resource: 0x577c000000
>
> Create a namespace in region1.  That namespace will have a start_pad of
> 64MiB.  The problem is that, while the correct offset was specified when
> laying out the struct pages (via arch_add_memory), the data_offset for
> the pmem block device itself does not take the start_pad into account
> (despite the comment in the nd_pfn_sb data structure!).

Unfortunately, yes.

> As a result,
> the block device starts at the beginning of the address range, but
> struct pages only exist for the address space starting 64MiB into the
> range.  __bdev_dax_supported fails, because it tries to perform a
> direct_access call on sector 0, and there's no pgmap for the address
> corresponding to that sector.
>
> So, we can't simply make the code correct (by adding the start_pad to
> pmem->data_offset) without bumping the superblock version, because that
> would change the size of the block device, and the location of data on
> that block device would all be off by 64MiB (and you'd lose the first
> 64MiB).  Mass hysteria.

Correct. Systems with this bug are working fine without DAX because
everything is aligned in that case. We can't change the interpretation
of the fields to make DAX work without losing access to existing data
at the proper offsets through the non-DAX path.

> > However, to fix this situation a non-backwards compatible change
> > needs to be made to the interpretation of the nd_pfn info-block.
> > ->start_pad needs to be accounted in ->map.map_offset (formerly
> > ->data_offset), and ->map.map_base (formerly ->phys_addr) needs to be
> > adjusted to the section aligned resource base used to establish
> > ->map.map formerly (formerly ->virt_addr).
> >
> > The guiding principles of the info-block compatibility fixup is to
> > maintain the interpretation of ->data_offset for implementations like
> > the EFI driver that only care about data_access not dax, but cause older
> > Linux implementations that care about the mode and dax to fail to parse
> > the new info-block.
>
> What if the core mm grew support for hotplug on sub-section boundaries?
> Would't that fix this problem (and others)?

Yes, I think it would, and I had patches along these lines [2]. Last
time I looked at this I was asked by core-mm folks to await some
general refactoring of hotplug [3], and I wasn't proud about some of
the hacks I used to make it work. In general I'm less confident about
being able to get sub-section-hotplug over the goal line (core-mm
resistance to hotplug complexity) vs the local hacks in nvdimm to deal
with this breakage.

Local hacks are always a sad choice, but I think leaving these
configurations stranded for another kernel cycle is not tenable. It
wasn't until the github issue did I realize that the problem was
happening in the wild on NVDIMM-N platforms.

[2]: https://lore.kernel.org/lkml/148964440651.19438.2288075389153762985.stgit@dwillia2-desk3.amr.corp.intel.com/
[3]: https://lore.kernel.org/lkml/20170319163531.GA25835@dhcp22.suse.cz/

>
> -Jeff
>
> [1] https://github.com/pmem/ndctl/issues/76
