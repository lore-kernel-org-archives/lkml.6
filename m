Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766E3C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA5320651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jA7QiM6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA5320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJWJc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:32:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44051 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:32:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id p23so41996669otf.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 18:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vbiFRMacvtoJch1EW1cVVUWmDejCJWS6fB1hOkqn7U=;
        b=jA7QiM6QS5DOqLiSJecChF35p1vzfw09QuCCjMs4msMP1CTCi641iokgM3EP1Ai2In
         S4izbqmAyhCHhZwI+F3ietA/TEj3nCPHyDpNuJLXnUNSKBqQ0XIRPXqWi303BW9M+HGh
         CPBoUQsehJJqY+xbGzUL3ftJ+1WwaZK5z7VgTfykOypOi54MWY+3CXLRJQkirI/25cyL
         WCPw2MHJ794F8VhrjlShrNq9FvD7tL1+qKKj28oh9v3O1wP52P103KDijXKAnKPs2F3k
         eSEi17wAcJ3gbxIRHDyvx9ravlztq16q9YSFwecSRvi+EJhDHQsdfuwuaAU2DuTVmyX/
         BnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vbiFRMacvtoJch1EW1cVVUWmDejCJWS6fB1hOkqn7U=;
        b=FfWvPBbEnFgjL8h3VpJb5sGEYarR/TECNYAz/tx+esBf1m/F6TN7OUVxdmGQEw8ovy
         nBbBtU8ZhVsGOGClezCOXyP1jkYFmpmw4PlsvIVAt/1zoROUnmYKOStIYuaOMpxc8nrC
         foZW1Qgq1ugLuKyRanbtsV880xzfStrCT2/P5lvdtJZ7QWMLv2j8wBrfGSJlr2fsG7VI
         zyNF75409WNXSQv2w4qYcDVFzYyWAx1cIJMMZKUHxdrcNvq0erYaIS+w5tBKQaeMgQCl
         cDRk4bbG40piLjA4G0MIhsqtWp27YPTO1uJasfoWpdBoBXm5PXnaO4ZF7z0gDwimdDes
         zicw==
X-Gm-Message-State: ABuFfogTNVWa7USn9z66gtK3zF1VkfsTJalAVPEDZVFU8DSeSqLltwBR
        1NGhYf3yTPnws7NiF9o5vOsUlueucgv6zeiCfFPaInzs
X-Google-Smtp-Source: ACcGV60QtRZp4eH0d7S3//9OztqkrdnzefrzDRM0l899cbW36MxkhCTKUYQbwLGRjozeaZM+DW9cn3i+sx9pS6uOZeM=
X-Received: by 2002:a9d:7d93:: with SMTP id j19mr28532826otn.32.1540257088493;
 Mon, 22 Oct 2018 18:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181022201317.8558C1D8@viggo.jf.intel.com> <CAPcyv4hxs-GnmwQU1wPZyg5aydCY5K09-YpSrrLpvU1v_8dbBw@mail.gmail.com>
In-Reply-To: <CAPcyv4hxs-GnmwQU1wPZyg5aydCY5K09-YpSrrLpvU1v_8dbBw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Oct 2018 18:11:17 -0700
Message-ID: <CAPcyv4hFoPkda0YfNKo=nFxttyBG3OjD7vKWyNzLY+8T5gLc=g@mail.gmail.com>
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

On Mon, Oct 22, 2018 at 6:05 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Oct 22, 2018 at 1:18 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> >
> > Persistent memory is cool.  But, currently, you have to rewrite
> > your applications to use it.  Wouldn't it be cool if you could
> > just have it show up in your system like normal RAM and get to
> > it like a slow blob of memory?  Well... have I got the patch
> > series for you!
> >
> > This series adds a new "driver" to which pmem devices can be
> > attached.  Once attached, the memory "owned" by the device is
> > hot-added to the kernel and managed like any other memory.  On
> > systems with an HMAT (a new ACPI table), each socket (roughly)
> > will have a separate NUMA node for its persistent memory so
> > this newly-added memory can be selected by its unique NUMA
> > node.
> >
> > This is highly RFC, and I really want the feedback from the
> > nvdimm/pmem folks about whether this is a viable long-term
> > perversion of their code and device mode.  It's insufficiently
> > documented and probably not bisectable either.
> >
> > Todo:
> > 1. The device re-binding hacks are ham-fisted at best.  We
> >    need a better way of doing this, especially so the kmem
> >    driver does not get in the way of normal pmem devices.
> > 2. When the device has no proper node, we default it to
> >    NUMA node 0.  Is that OK?
> > 3. We muck with the 'struct resource' code quite a bit. It
> >    definitely needs a once-over from folks more familiar
> >    with it than I.
> > 4. Is there a better way to do this than starting with a
> >    copy of pmem.c?
>
> So I don't think we want to do patch 2, 3, or 5. Just jump to patch 7
> and remove all the devm_memremap_pages() infrastructure and dax_region
> infrastructure.
>
> The driver should be a dead simple turn around to call add_memory()
> for the passed in range. The hard part is, as you say, arranging for
> the kmem driver to not stand in the way of typical range / device
> claims by the dax_pmem device.
>
> To me this looks like teaching the nvdimm-bus and this dax_kmem driver
> to require explicit matching based on 'id'. The attachment scheme
> would look like this:
>
> modprobe dax_kmem
> echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/new_id
> echo dax0.0 > /sys/bus/nd/drivers/dax_pmem/unbind
> echo dax0.0 > /sys/bus/nd/drivers/dax_kmem/bind
>
> At step1 the dax_kmem drivers will match no devices and stays out of
> the way of dax_pmem. It learns about devices it cares about by being
> explicitly told about them. Then unbind from the typical dax_pmem
> driver and attach to dax_kmem to perform the one way hotplug.
>
> I expect udev can automate this by setting up a rule to watch for
> device-dax instances by UUID and call a script to do the detach /
> reattach dance.

The next question is how to support this for ranges that don't
originate from the pmem sub-system. I expect we want dax_kmem to
register a generic platform device representing the range and have a
generic platofrm driver that turns around and does the add_memory().
