Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB72C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 04:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DA12082D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 04:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="04QRpWIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DA12082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJ0NZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 09:25:24 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46418 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeJ0NZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 09:25:24 -0400
Received: by mail-ot1-f67.google.com with SMTP id u26so2942683otk.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXawhzQWODaXCLjs2ljpcbscFVjI+kqDvBknjO5m0w8=;
        b=04QRpWIqRqq4voPiNKklfRVVOKAfXZ83nV6kfRLc0oe+jhZF64sX3KlITg2+TdaBXT
         nupnZpFHf8GS0R1PEOL2crL5kwfnv6APJ2DgoCWG4fOSm19I1v7W/mwThKDnsUb2d1Tp
         3bUOUpf40tFEjLvJPH6kVs6snDyKin42UnNtjZe5ZN0ztuRLjj8u1xbs2Mu+ReK+m1/3
         BLoDbU3zgMnD2q/6kcBsO3atnVMHa62rEbNXudn7zu7hWs+noZLDtj5rxQ8zpIQB21R6
         R44jEA0DNOzjSBMRn/KjOp769fli6rpVpubxvRk3s5/YMQ/0t+fR7JNQerYOMr0e354I
         4LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXawhzQWODaXCLjs2ljpcbscFVjI+kqDvBknjO5m0w8=;
        b=Y72WgeY/RjQZ81XAcMgqQ8xQNf5gRWQDCR1NFG+U06uOCNLGY7Jedw+sjKNu80Clp9
         7oD5Cif2WaBG6Usfy9VVLbWq5Fpx4TxtXQDFb1syA3i2n+WkHKWiW2J6cTrht+Va4qQB
         MAJl69o/9FCCdQ5VgQ7kggJayYDuM65U1+4r4g87Xrfi774y+ubNHVXToVC2eJC52Krk
         36nq5ehy27SaKlM9V7VTbSKa3EsqsvLVVZV1dBKkgMpW3fJCIINOTQR8KSMLtgjjWO6b
         ELUVGlsWyHpkcfQEfqmkgh59H9jup5mS/AnONL2Qj10gxFtXqsBXhU51V2EfWLsXBtdx
         0OrA==
X-Gm-Message-State: AGRZ1gIFNh2OpsXI+vHT2gzdEm72TI4Vny/rO/1po69Lq215pFoQ3cqn
        ldWcMphp89zELu536HUtjvIza/2toDW4smaFdL611A==
X-Google-Smtp-Source: AJdET5ffBonDKDF4CwacAnjkE1eIZRabJCOq8JrwNXj9VBKxLGamCfGLQbAfY/xr51lH1IltGHyDBaT9aBxD5mssT0U=
X-Received: by 2002:a9d:24c7:: with SMTP id z65mr3692245ota.229.1540615542466;
 Fri, 26 Oct 2018 21:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181022201317.8558C1D8@viggo.jf.intel.com> <CAPcyv4hxs-GnmwQU1wPZyg5aydCY5K09-YpSrrLpvU1v_8dbBw@mail.gmail.com>
 <CAPcyv4hFoPkda0YfNKo=nFxttyBG3OjD7vKWyNzLY+8T5gLc=g@mail.gmail.com>
In-Reply-To: <CAPcyv4hFoPkda0YfNKo=nFxttyBG3OjD7vKWyNzLY+8T5gLc=g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 26 Oct 2018 21:45:30 -0700
Message-ID: <CAPcyv4iE8o1rs+a9YrFPhtH6bQ73HECnLin1MShR0-vV_eWKEQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 6:11 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Oct 22, 2018 at 6:05 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Oct 22, 2018 at 1:18 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> > >
> > > Persistent memory is cool.  But, currently, you have to rewrite
> > > your applications to use it.  Wouldn't it be cool if you could
> > > just have it show up in your system like normal RAM and get to
> > > it like a slow blob of memory?  Well... have I got the patch
> > > series for you!
> > >
> > > This series adds a new "driver" to which pmem devices can be
> > > attached.  Once attached, the memory "owned" by the device is
> > > hot-added to the kernel and managed like any other memory.  On
> > > systems with an HMAT (a new ACPI table), each socket (roughly)
> > > will have a separate NUMA node for its persistent memory so
> > > this newly-added memory can be selected by its unique NUMA
> > > node.
> > >
> > > This is highly RFC, and I really want the feedback from the
> > > nvdimm/pmem folks about whether this is a viable long-term
> > > perversion of their code and device mode.  It's insufficiently
> > > documented and probably not bisectable either.
> > >
> > > Todo:
> > > 1. The device re-binding hacks are ham-fisted at best.  We
> > >    need a better way of doing this, especially so the kmem
> > >    driver does not get in the way of normal pmem devices.
> > > 2. When the device has no proper node, we default it to
> > >    NUMA node 0.  Is that OK?
> > > 3. We muck with the 'struct resource' code quite a bit. It
> > >    definitely needs a once-over from folks more familiar
> > >    with it than I.
> > > 4. Is there a better way to do this than starting with a
> > >    copy of pmem.c?
> >
> > So I don't think we want to do patch 2, 3, or 5. Just jump to patch 7
> > and remove all the devm_memremap_pages() infrastructure and dax_region
> > infrastructure.
> >
> > The driver should be a dead simple turn around to call add_memory()
> > for the passed in range. The hard part is, as you say, arranging for
> > the kmem driver to not stand in the way of typical range / device
> > claims by the dax_pmem device.
> >
> > To me this looks like teaching the nvdimm-bus and this dax_kmem driver
> > to require explicit matching based on 'id'. The attachment scheme
> > would look like this:
> >
> > modprobe dax_kmem
> > echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/new_id
> > echo dax0.0 > /sys/bus/nd/drivers/dax_pmem/unbind
> > echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/bind
> >
> > At step1 the dax_kmem drivers will match no devices and stays out of
> > the way of dax_pmem. It learns about devices it cares about by being
> > explicitly told about them. Then unbind from the typical dax_pmem
> > driver and attach to dax_kmem to perform the one way hotplug.
> >
> > I expect udev can automate this by setting up a rule to watch for
> > device-dax instances by UUID and call a script to do the detach /
> > reattach dance.
>
> The next question is how to support this for ranges that don't
> originate from the pmem sub-system. I expect we want dax_kmem to
> register a generic platform device representing the range and have a
> generic platofrm driver that turns around and does the add_memory().

I forgot I have some old patches that do something along these lines
and make device-dax it's own bus. I'll dust those off so we can
discern what's left.
