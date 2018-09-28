Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F22C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400A02170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnfxwgE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400A02170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeI1SvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:51:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42357 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeI1SvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:51:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id y71-v6so5630227lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 05:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLYApzrB2a383//5QOJflBXAFfTWVmBjvn7HWIS61ZE=;
        b=RnfxwgE6Y5vpUqFVMSRC8IDtjg0eG3u+g9LuOfXHikIhW9isnVKi8Ha0ra8wxPVvmK
         0NMOU0VIyw7TWQ61cYzb0YVcdVi3OfUvUzlFsDdyzmgvzKPZ37IyPQZQlP8VRycWER2E
         i2dPoz/dojQigJ9IIQE3y1PT6oCAh9cL5Dk9TCUySIhsCcT8HIEBTsppvcJZ+tKO+0mK
         3IpO+tf9rfUMwog3IQqLF68OfmRoSdEFTFAsLfx37EnzRYJfemeiUpJY6ePAstdh3S4q
         BWBr8eVFpc8m2aywuX6Jp/kBP/cQkMo7fPXK2oNOLpgayDIuHldz13YooRpiVO7gczPO
         aICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLYApzrB2a383//5QOJflBXAFfTWVmBjvn7HWIS61ZE=;
        b=TochTRSpreAkyuS/raF9whSEm5GlRmTlqJmtZUhPu0ZtIM5zDRaxk3d8h9cakCADod
         fiufihELc261mrSgSDbvVDnu7xGrbZX5rY5OWp0RvzHH+mR9MApcX3vOK/Ei0p/V5/qw
         UjqNuYAg06qIyD021e5v2AJgJzHhuyq5KfBGrjXh4BQIsViUwmlRFk1EDYzg9l6zF/FI
         cVWS+ha4jmc9Gi1+65BRPu3Rx04s6z5I1pfoveuxHnqD2Zc5beWYaVyiAy/XpLZOttto
         L/POjYmrlGjJraSmTJSGKiu05gIurUV2y8gYnX1x1JZTPtcYC/OKAUCj7r3GgMMKFidh
         KG/Q==
X-Gm-Message-State: ABuFfoh8zv7GSBLSFrqEYeH4Sue8lAar3yilM65Rv+e5V08Vq0hlsTnw
        5viRhbe3L1rvlVejNX/rfxrlRVaAQCsd5SDPX3w=
X-Google-Smtp-Source: ACcGV622RRqXzbsDFM2CqG6FQ2o9epKLGpNatLD9CQqN+GEre2qnUXJ7/Ttg/gjuF+ro0i+GGgDWwmOyjnbTPJl8zlE=
X-Received: by 2002:a2e:b04b:: with SMTP id d11-v6mr11106553ljl.93.1538137649730;
 Fri, 28 Sep 2018 05:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180927175123.GA16367@jordon-HP-15-Notebook-PC> <20180927183236.GJ6278@dhcp22.suse.cz>
In-Reply-To: <20180927183236.GJ6278@dhcp22.suse.cz>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 28 Sep 2018 17:57:17 +0530
Message-ID: <CAFqt6zbnV+wV+O2EMi1mE4qWDjsZ=Y847MFUc+zv6g8OoVM30g@mail.gmail.com>
Subject: Re: [PATCH] mm: Introduce new function vm_insert_kmem_page
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        pasha.tatashin@oracle.com, riel@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net,
        Arnd Bergmann <arnd@arndb.de>, mcgrof@kernel.org,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:02 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 27-09-18 23:21:23, Souptick Joarder wrote:
> > vm_insert_kmem_page is similar to vm_insert_page and will
> > be used by drivers to map kernel (kmalloc/vmalloc/pages)
> > allocated memory to user vma.
> >
> > Previously vm_insert_page is used for both page fault
> > handlers and outside page fault handlers context. When
> > vm_insert_page is used in page fault handlers context,
> > each driver have to map errno to VM_FAULT_CODE in their
> > own way. But as part of vm_fault_t migration all the
> > page fault handlers are cleaned up by using new vmf_insert_page.
> > Going forward, vm_insert_page will be removed by converting
> > it to vmf_insert_page.
> >
> > But their are places where vm_insert_page is used outside
> > page fault handlers context and converting those to
> > vmf_insert_page is not a good approach as drivers will end
> > up with new VM_FAULT_CODE to errno conversion code and it will
> > make each user more complex.
> >
> > So this new vm_insert_kmem_page can be used to map kernel
> > memory to user vma outside page fault handler context.
> >
> > In short, vmf_insert_page will be used in page fault handlers
> > context and vm_insert_kmem_page will be used to map kernel
> > memory to user vma outside page fault handlers context.
> >
> > We will slowly convert all the user of vm_insert_page to
> > vm_insert_kmem_page after this API be available in linus tree.
>
> In general I do not like patches adding a new exports/functionality
> without any user added at the same time. I am not going to look at the
> implementation right now but the above opens more questions than it
> gives answers. Why do we have to distinguish #PF from other paths?

Going forward, the plan is to restrict future drivers not to use vm_insert_page
( *it will generate new errno to VM_FAULT_CODE mapping code for new drivers
which were already cleaned up for existing drivers*) in #PF context but to make
use of vmf_insert_page which returns VMF_FAULT_CODE and that is not possible
until both vm_insert_page and vmf_insert_page API exists.

But there are some consumers of vm_insert_page which use it outside #PF context.
straight forward conversion of vm_insert_page to vmf_insert_page won't
work there as
those function calls expects errno not vm_fault_t in return.

e.g - drivers/auxdisplay/cfag12864bfb.c, line 55
        drivers/auxdisplay/ht16k33.c, line 227
        drivers/firewire/core-iso.c, line 115
        drivers/gpu/drm/rockchip/rockchip_drm_gem.c, line 237
        drivers/gpu/drm/xen/xen_drm_front_gem.c, line 253
        drivers/iommu/dma-iommu.c, line 600
        drivers/media/common/videobuf2/videobuf2-dma-sg.c, line 343
        drivers/media/usb/usbvision/usbvision-video.c, line 1056
        drivers/xen/gntalloc.c, line 548
        drivers/xen/gntdev.c, line 1149
        drivers/xen/privcmd-buf.c, line 184
        mm/vmalloc.c, line 2254
        net/ipv4/tcp.c, line 1806
        net/packet/af_packet.c, line 4407

These are the approaches which could have been taken to handle this scenario -

1. Replace vm_insert_page with vmf_insert_page and then write few
   extra lines of code to convert VM_FAULT_CODE to errno which
   makes driver users more complex ( also the reverse mapping errno to
   VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
   not preferred to introduce anything similar again)

2. Maintain both vm_insert_page and vmf_insert_page and use it in
   respective places. But it won't gurantee that vm_insert_page will
   never be used in #PF context.

3. Introduce a similar API like vm_insert_page, convert all non #PF
   consumer to use it and finally remove vm_insert_page by converting
   it to vmf_insert_page.

And the 3rd approach was taken by introducing vm_insert_kmem_page().
