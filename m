Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07839ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A6C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="I8JFBfhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A6C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeGQSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:06:26 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54767 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeGQSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:06:26 -0400
Received: by mail-it0-f66.google.com with SMTP id s7-v6so267702itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ysh1gY8sUsIllb6gjGmMXZqHePjvlipDu2vSy/OTmRw=;
        b=I8JFBfhf5nVKBWAGjrOm8wtIV22SaT9MT4uR3bqOfbsXZnJGuK+81CryYTpqHbNHEW
         MkRX1O1DMNxoNQ45OYojp7tkW5Ih8T7FyxgUcHuAM9yAvw2fu9VrmiJJlIZuMqhFiLzP
         l23I8xKMlL3hQ6txGEvwqUpp0YMlmMYv0ucPq/UKwpeHvJ2L1iqFp8mJaWHrYVWD1up0
         gkFRUhN5tVgtM1C4b9PnC4PJ0SJcmEGkBwccJqstbIy9lHkmqvDOZltfpfr2WjbIArS5
         6pzw+OomwIn55/5e7NC8oiEF8SW+OdoUl/+OMazoeJPGnOlqT9WjwSRUiWSs0QqbDNAF
         274w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ysh1gY8sUsIllb6gjGmMXZqHePjvlipDu2vSy/OTmRw=;
        b=BLSW4NL0Hzyvat/O1Qgt4mBeiHWPqUV0VPHtXqOMS0DT83XKGXldC2fStHTE9WkR3x
         jE3RMhKC+ZCTL+iVhmVA3he1i4mFSpaxNHcRcMeRENDrJnIFvt9VxA6ZM5mp3cIC8qky
         WRNGnfDOOQEB2KYgGfbTBLLkr8Upcr5jOmlOadQpZb+nKl3C7ex7ItjSm5BBnUvdjYnJ
         YWmAi5vVzIcR1RQCboeQHehg8OGkqJuqScmORUMncMC9SrMhLxX2XwfUjYxlgegJB1bD
         XYcUpoEum2c8R4P5RYrnKfIifViJUlSJZVBvlo6erl3GzC3ZFz3tPuzKP8fUGprG0NVt
         9AxQ==
X-Gm-Message-State: AOUpUlFUrzV5WGaF3cVrIuiXBYlQsqhlnhT3GVZiakN+SD0MMHm5/rtK
        wtEntzpVYeDWrCrKLWeeBTVT8oFqNaffReiugHU=
X-Google-Smtp-Source: AAOMgperIMvstX88b9Pb5EWnpqSxP27FQGWxhydWXn4lv9fqO9CygATEsNQJEi7AmTbZLPfrKeV9bFZ9sTTx8OXNpu4=
X-Received: by 2002:a24:3041:: with SMTP id q62-v6mr2354218itq.86.1531848764772;
 Tue, 17 Jul 2018 10:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
 <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
 <CAGM2reacO1HF91yH8OR5w5AdZwPgwfSFfjDNBsHbP66v1rEg=g@mail.gmail.com> <20180717155006.GL7193@dhcp22.suse.cz>
In-Reply-To: <20180717155006.GL7193@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Jul 2018 10:32:32 -0700
Message-ID: <CAA9_cmez_vrjBYvcpXT_5ziQ2CqRFzPbEWMO2kdmjW0rWhkaCA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init for ZONE_DEVICE
To:     Michal Hocko <mhocko@kernel.org>
Cc:     pasha.tatashin@oracle.com, dalias@libc.org,
        Jan Kara <jack@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        daniel.m.jordan@oracle.com, Ingo Molnar <mingo@redhat.com>,
        fenghua.yu@intel.com, Jerome Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 8:50 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 17-07-18 10:46:39, Pavel Tatashin wrote:
> > > > Hi Dan,
> > > >
> > > > I am worried that this work adds another way to multi-thread struct
> > > > page initialization without re-use of already existing method. The
> > > > code is already a mess, and leads to bugs [1] because of the number of
> > > > different memory layouts, architecture specific quirks, and different
> > > > struct page initialization methods.
> > >
> > > Yes, the lamentations about the complexity of the memory hotplug code
> > > are known. I didn't think this set made it irretrievably worse, but
> > > I'm biased and otherwise certainly want to build consensus with other
> > > mem-hotplug folks.
> > >
> > > >
> > > > So, when DEFERRED_STRUCT_PAGE_INIT is used we initialize struct pages
> > > > on demand until page_alloc_init_late() is called, and at that time we
> > > > initialize all the rest of struct pages by calling:
> > > >
> > > > page_alloc_init_late()
> > > >   deferred_init_memmap() (a thread per node)
> > > >     deferred_init_pages()
> > > >        __init_single_page()
> > > >
> > > > This is because memmap_init_zone() is not multi-threaded. However,
> > > > this work makes memmap_init_zone() multi-threaded. So, I think we
> > > > should really be either be using deferred_init_memmap() here, or teach
> > > > DEFERRED_STRUCT_PAGE_INIT to use new multi-threaded memmap_init_zone()
> > > > but not both.
> > >
> > > I agree it would be good to look at unifying the 2 async
> > > initialization approaches, however they have distinct constraints. All
> > > of the ZONE_DEVICE memmap initialization work happens as a hotplug
> > > event where the deferred_init_memmap() threads have already been torn
> > > down. For the memory capacities where it takes minutes to initialize
> > > the memmap it is painful to incur a global flush of all initialization
> > > work. So, I think that a move to rework deferred_init_memmap() in
> > > terms of memmap_init_async() is warranted because memmap_init_async()
> > > avoids a global sync and supports the hotplug case.
> > >
> > > Unfortunately, the work to unite these 2 mechanisms is going to be
> > > 4.20 material, at least for me, since I'm taking an extended leave,
> > > and there is little time for me to get this in shape for 4.19. I
> > > wouldn't be opposed to someone judiciously stealing from this set and
> > > taking a shot at the integration, I likely will not get back to this
> > > until September.
> >
> > Hi Dan,
> >
> > I do not want to hold your work, so if Michal or Andrew are OK with
> > the general approach of teaching    memmap_init_zone() to be async
> > without re-using deferred_init_memmap() or without changing
> > deferred_init_memmap() to use the new memmap_init_async() I will
> > review your patches.
>
> Well, I would rather have a sane code base than rush anything in. I do
> agree with Pavel that we the number of async methods we have right now
> is really disturbing. Applying yet another one will put additional
> maintenance burden on whoever comes next.

I thought we only had the one async implementation presently, this
makes it sound like we have more than one? Did I miss the other(s)?

> Is there any reason that this work has to target the next merge window?
> The changelog is not really specific about that.

Same reason as any other change in this space, hardware availability
continues to increase. These patches are a direct response to end user
reports of unacceptable init latency with current kernels.

> There no numbers or
> anything that would make this sound as a high priority stuff.

From the end of the cover letter:

"With this change an 8 socket system was observed to initialize pmem
namespaces in ~4 seconds whereas it was previously taking ~4 minutes."

My plan if this is merged would be to come back and refactor it with
the deferred_init_memmap() implementation, my plan if this is not
merged would be to come back and refactor it with the
deferred_init_memmap() implementation.

In practical terms, 0day has noticed a couple minor build fixes are needed:
https://lists.01.org/pipermail/kbuild-all/2018-July/050229.html
https://lists.01.org/pipermail/kbuild-all/2018-July/050231.html

...and I'm going to be offline until September. I thought it best to
post this before I go, and I'm open to someone else picking up this
work to get in shape for merging per community feedback.
