Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E282098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vwDASnrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E282098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeJKBmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:42:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41523 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJKBmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:42:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id c32so6310280otb.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36MHwRT1ipsNtYtZWpwxQqOkJnCbCF2tSfZNOZc+owE=;
        b=vwDASnrFTSkXN5YuR/gR8N76Fb9GfjuqmeLleaWaArjysIkqheNW+5yGHDObpLwdf8
         fOZVv6xppPjwHHy0XIuIEbYTLSNFBkA/4QNXSq3QAdeEmxTQxZVL41kuAo3GYMPZNCeC
         lMfZYOD9fr7NOjiT0HdZbH22ECRR6MSjDqtLSEm3ooTQlDU8Fny/B1G0FMoyF4F15/g1
         nroTOl5FgKBd0/Qp3PwnQBgSOHQA+OyExXwtgBY6PKp8O9nCZqY2jutVMbElZ//mzSpS
         cf3DlRyYWyV4U3ib/LrLhu8bvQSu1dohPuQCqlYlM21b5e24cv/O8Bc9fQ/nyzFZ/+zu
         zLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36MHwRT1ipsNtYtZWpwxQqOkJnCbCF2tSfZNOZc+owE=;
        b=H0i/9OCNNvetnsVP+8I2vxk2A8oDitSa2XZkLbQY6daXPmTorJkpXk1Lc9Dr2ctRuc
         B8QTkDhw7XZx641Idr8BQVPzuEcd2nXueV2HR8umiL/3J/TENfaf4Si5Z97Af4mDeb+Z
         VGgqxnqpIbUsXUzS1x1yM47Iui0lu9ks9etjUIW6NNnQFCId6u+g6jo+M9gb2JfiE+4+
         chhAJw/CbZEnU+cvPWbx7YXY6Nzli4FzhNOc07f0oDqLYgaOUXnlcRcMQ43rAYXbsJij
         FG/Dm4Uy/R+XntmCBSp1A6CjFcc9jP1vEdEaUsPtzdsnUBjItt+7CjlflEg9DRwhpTzg
         ykOw==
X-Gm-Message-State: ABuFfogZgO3U03YZP+BRvbXRmGgnN6cU/4cy3rDsILIB39EPmgS927AQ
        LMzJWBwLEZ1ARhwIeizIm418TXPbUo9Xi6y8wFOq6lvOqIs=
X-Google-Smtp-Source: ACcGV63C/MT15k3/6UZsWyvT1aZ+hDEc/vNtXzUNHWLYZ0/Ex7kET5urLj3VdF0+eDY8+gLlFWTWEKw2JWfIJkZBzQ0=
X-Received: by 2002:a9d:24c7:: with SMTP id z65mr20165781ota.229.1539195540660;
 Wed, 10 Oct 2018 11:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925202053.3576.66039.stgit@localhost.localdomain> <20181009170051.GA40606@tiger-server>
 <CAPcyv4g99_rJJSn0kWv5YO0Mzj90q1LH1wC3XrjCh1=x6mo7BQ@mail.gmail.com>
 <25092df0-b7b4-d456-8409-9c004cb6e422@linux.intel.com> <20181010095838.GG5873@dhcp22.suse.cz>
 <f97de51c-67dd-99b2-754e-0685cac06699@linux.intel.com> <20181010172451.GK5873@dhcp22.suse.cz>
In-Reply-To: <20181010172451.GK5873@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Oct 2018 11:18:49 -0700
Message-ID: <CAPcyv4inUwyYEEQ_qh5GTRxUo+JLt+caz_3mtg79DpfQSUdG5Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     alexander.h.duyck@linux.intel.com, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        rppt@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:30 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 10-10-18 09:39:08, Alexander Duyck wrote:
> > On 10/10/2018 2:58 AM, Michal Hocko wrote:
> > > On Tue 09-10-18 13:26:41, Alexander Duyck wrote:
> > > [...]
> > > > I would think with that being the case we still probably need the call to
> > > > __SetPageReserved to set the bit with the expectation that it will not be
> > > > cleared for device-pages since the pages are not onlined. Removing the call
> > > > to __SetPageReserved would probably introduce a number of regressions as
> > > > there are multiple spots that use the reserved bit to determine if a page
> > > > can be swapped out to disk, mapped as system memory, or migrated.
> > >
> > > PageReserved is meant to tell any potential pfn walkers that might get
> > > to this struct page to back off and not touch it. Even though
> > > ZONE_DEVICE doesn't online pages in traditional sense it makes those
> > > pages available for further use so the page reserved bit should be
> > > cleared.
> >
> > So from what I can tell that isn't necessarily the case. Specifically if the
> > pagemap type is MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_PUBLIC both are
> > special cases where the memory may not be accessible to the CPU or cannot be
> > pinned in order to allow for eviction.
>
> Could you give me an example please?
>
> > The specific case that Dan and Yi are referring to is for the type
> > MEMORY_DEVICE_FS_DAX. For that type I could probably look at not setting the
> > reserved bit. Part of me wants to say that we should wait and clear the bit
> > later, but that would end up just adding time back to initialization. At
> > this point I would consider the change more of a follow-up optimization
> > rather than a fix though since this is tailoring things specifically for DAX
> > versus the other ZONE_DEVICE types.
>
> I thought I have already made it clear that these zone device hacks are
> not acceptable to the generic hotplug code. If the current reserve bit
> handling is not correct then give us a specific reason for that and we
> can start thinking about the proper fix.
>

Right, so we're in a situation where a hack is needed for KVM's
current interpretation of the Reserved flag relative to dax mapped
pages. I'm arguing to push that knowledge / handling as deep as
possible into the core rather than hack the leaf implementations like
KVM, i.e. disable the Reserved flag for all non-MEMORY_DEVICE_*
ZONE_DEVICE types.

Here is the KVM thread about why they need a change:

    https://lkml.org/lkml/2018/9/7/552

...and where I pushed back on a KVM-local hack:

    https://lkml.org/lkml/2018/9/19/154
