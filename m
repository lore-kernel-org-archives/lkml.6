Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1110A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfmI4uKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1110A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeIKAnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:43:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42594 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbeIKAnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:43:47 -0400
Received: by mail-io0-f195.google.com with SMTP id n18-v6so1650635ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Ol/OhBtansvJU+w61mQSjhKetBbCopAEatwEP6lj2s=;
        b=HfmI4uKgwhLH28jgbzF2ORI3MlqNimNy2ILNFfMxzoYlfbXDmBohlyx6G25XBZXjPG
         /NMugZd06EuZM2wSDJxY8QKvuv8pL7VXQh4KsQ1DJZpY0BfZ9s3OoqlUqEZ4AWRzqa+o
         D6Zt+XkZ4qZ3BbcF5eT9A9qxcPkEx0AF6fe5p/7KtHB4U8w6kCYlofryc6He77IzlP6u
         +8v5xXDQ2vbSEkcvGwoC9hbc2ZLWgR3uzXWRlXdX2kTg5M5J1kAZ6ivt+N+o9jobrr2O
         CsAMNzlp+XY8PGmidXSvYUfG9FJhV4/eWDpkfjxnZvojm+4z1y877OrmUvhSwL+zE2b9
         Gw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Ol/OhBtansvJU+w61mQSjhKetBbCopAEatwEP6lj2s=;
        b=lBMhAylD2YdsBWCSBKyEx7/fYFpNtHWSIRZaSzmEq3kC5sxSxBT2Po4E2fVp3k/Rj7
         k0wzHB8bNZ1zPHUEMPIlOQw5RMNDy8dxoTJ0NcBZmTc6OpjDa1+NMSm1qscyhakC3MnT
         9YKVkyiYN3G6865Rv8Cp94TI2lDVkwImdovJuQNOoyEiWzJwurYdLapipolGoEE7Nh9R
         q9f2ZLrTfRCz5Gp9+LrtDVcdLIkSkyOknEHG4KJrQIgC8CzEHAzgc/22Uu/d6GMAFi2y
         f4t5x0WHXI2gjNfgWtow22/tMdmhZwl9r6hvBkJU/bbdltWcBiZr+ZM6bg13abHWigDa
         bYVQ==
X-Gm-Message-State: APzg51CTa9NklJKU5UJGHu2onjoco8ARj/ocpNL4nc5DLxugRycyKspb
        9qJoj736mI7r1A1YYMovSUnntfphMPLesSxaemQ=
X-Google-Smtp-Source: ANB0VdbiGVyehNzljBoRQfK+bV0OtsNbu29PqPenW2FL/f/wcEfw2WRaz4SihRot6J1oksRLcrfz/JYIZCwJ6UQGAEs=
X-Received: by 2002:a6b:cac3:: with SMTP id a186-v6mr17978218iog.116.1536608887010;
 Mon, 10 Sep 2018 12:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <153176041838.12695.3365448145295112857.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAGM2rea9AwQGaf1JiV_SDDKTKyP_n+dG9Z20gtTZEkuZPFnXFQ@mail.gmail.com>
 <CAPcyv4jo91jKjwn-M7cOhG=6vJ3c-QCyp0W+T+CtmiKGyZP1ng@mail.gmail.com>
 <CAGM2reacO1HF91yH8OR5w5AdZwPgwfSFfjDNBsHbP66v1rEg=g@mail.gmail.com>
 <20180717155006.GL7193@dhcp22.suse.cz> <CAA9_cmez_vrjBYvcpXT_5ziQ2CqRFzPbEWMO2kdmjW0rWhkaCA@mail.gmail.com>
 <20180718120529.GY7193@dhcp22.suse.cz> <3f43729d-fd4e-a488-e04d-026ef5a28dd9@intel.com>
 <20180723110928.GC31229@dhcp22.suse.cz> <510a1213-e391-bad6-4239-60fa477aaac0@intel.com>
 <20180724072937.GD28386@dhcp22.suse.cz> <CAPcyv4hZUgoMvUTcQLVQWvpvHnJYoPaet4b2VE-qPLtUPDgSaQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hZUgoMvUTcQLVQWvpvHnJYoPaet4b2VE-qPLtUPDgSaQ@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 10 Sep 2018 12:47:55 -0700
Message-ID: <CAKgT0UeN1Et7+5ddGW3-rD8M5o9MJ5xr755f2T7szBX=PEczRQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] mm: Asynchronous + multithreaded memmap init for ZONE_DEVICE
To:     dan.j.williams@intel.com
Cc:     mhocko@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>, dalias@libc.org,
        jack@suse.cz, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        Peter Anvin <hpa@zytor.com>, ysato@users.sourceforge.jp,
        linux-nvdimm@lists.01.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, fenghua.yu@intel.com,
        jglisse@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, mpe@ellerman.id.au,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> [ adding Alex ]
>
> On Tue, Jul 24, 2018 at 12:29 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Mon 23-07-18 09:15:32, Dave Hansen wrote:
> >> On 07/23/2018 04:09 AM, Michal Hocko wrote:
> >> > On Thu 19-07-18 11:41:10, Dave Hansen wrote:
> >> >> Are you looking for the actual end-user reports?  This was more of a
> >> >> case of the customer plugging in some persistent memory DIMMs, noticing
> >> >> the boot delta and calling the folks who sold them the DIMMs (Intel).
> >> > But this doesn't sound like something to rush a solution for in the
> >> > upcoming merge windown, does it?
> >>
> >> No, we should not rush it.  We'll try to rework it properly.
> >
> > Thanks a lot Dave! I definitely do not mean to block this at all. I just
> > really do not like to have the code even more cluttered than we have
> > now.
>
> Hi Michal,
>
> I'm back from vacation. I owe you an apology I was entirely too
> prickly on this thread, and the vacation cool-off-time was much
> needed.
>
> I come back to see that Alex has found a trove of low hanging fruit to
> speed up ZONE_DEVICE init and ditch most of the complication I was
> pushing. I'll let him chime in on the direction he wants to take this.

The basic plan I have for now will basically replace the entire set-up
with just 2 patches that would build on the 2 patches I had submitted
earlier.

One is a patch to the libnvdimm code to make it so that the probe
routine NUMA aware similar to what is done in pci_call_probe. All of
the async bits necessary were already contained in the libnvdimm code
anyway. Ideally I need to probably look at following up with adding
some NUMA awareness to the async_schedule_domain function.

The second is actually pretty simple. Instead of moving the setting of
the pgmap into memmap_init_zone we instead create a new function to
take care of setting the pgmap and include the functionality from
memmap_init_zone. The boundary between what is initialized and what
isn't is where we start replacing the LRU list pointers with pgmap and
hmm_data.

I might try to send them out as an RFC later today to get everyone's thoughts.

Thanks.

- Alex
