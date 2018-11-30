Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06219C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEC120673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="m/HsHxIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEC120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeLAJ7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:59:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36458 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeLAJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:59:02 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so6614876otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1U+mCp8jznu5F5hquo5H1m1oEmKGVT68oLFDjir14jk=;
        b=m/HsHxInFG9/2JfZ/oW1tdDaZX5wVlZadFVibHiurOC/UXdSGcTbBp17mWXy5c3pMY
         nE+Qx5y/ANF5Ld73LSmUenor4+wQSHf8y1U/CRtrbhV/iafJWmOhI2sOjO2oFLcz93Js
         Xee9iMhvGpyVhoYpw++dsol4DKCeASDcrGDJAWWCHfher82g4S/fY/0u29ZLvmyxOLjd
         zYSsCz6bNGAv6VxOZaqUwK9P+JEitQ7sB5PQ7qRP2VYgk17rd95BwOU5XbseikXQdlp7
         WC86rYSoMdRV0VXorvyu6y/fIqWSV4+Ny1aJfCs79WR/JvnB0cp47w/wQod5DRLzZdfv
         0PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1U+mCp8jznu5F5hquo5H1m1oEmKGVT68oLFDjir14jk=;
        b=uajJGaqInmHyGZx0QKt5NwTiG509gg4iHHlSbBub0YSoko9pq0mXLHaMuKAG329dmW
         f9+3BXmp0sAPVo132wQuzVMLDeIaidesw+GXf3f0ZXXq08Y89T1URDf3tUVQ4JRcYMWw
         gjuXX+dk/omlsUNqytqAxRTK+NT9RRQlv+G6a8orVuIwJdZNmA/TwPt89tmddY98bE0B
         SBbpI+rlnezJb+WgXw/dvbkuSePRKRHTsTKMsH1S7qoLqxGFgaxiAua/5pO44qvGR2bm
         H1yP9JMaRMkD5GScYhTEtCZgHxcqK8nVf1OxSYI3MSJ7qIekDMWAtVl4xwvwOy0uLwpU
         SCyg==
X-Gm-Message-State: AA+aEWYXP6VmlKv3ZhJrivDiOh4U9om1c9kOE7MXL74Oyj0/PxeRUQtO
        AmDWOvn38CSIc/Ce9t3rBuPoZBmbwYw1GGGSMbmAqw==
X-Google-Smtp-Source: AFSGD/VHuDSOgmxvbbG0qSoMvIVJRuxp5bvQ5DrOypvHJByTCYU2q4hndIL3tpBcEXanoKb25WAqmsbWvBM94yLWNQ4=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr4334288otn.95.1543618090878;
 Fri, 30 Nov 2018 14:48:10 -0800 (PST)
MIME-Version: 1.0
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
 <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com> <CAPcyv4i9QXsX9Rjz9E3gi643LQbSzaO_+iFLqLS+QO-GmrS0Eg@mail.gmail.com>
 <14d6413c-b002-c152-5016-7ed659c08c24@deltatee.com> <CAPcyv4gZisOAE8VJPJChNXrWv0NhUevWuutsPdvNORBTOBXJfA@mail.gmail.com>
 <43778343-6d43-eb43-0de0-3db6828902d0@deltatee.com> <CAPcyv4hJV71RLhBCKgqc=nQ_D_upySD=ZZk0y=5Qk69kKPHFog@mail.gmail.com>
 <b8ae55a4-7c1a-cc35-beea-badf35a69b06@deltatee.com> <CAPcyv4iVCMo29SWM2jhnNTZ5ugYaqjeW_LKe9O2YmeNohwQG3A@mail.gmail.com>
 <b55bf34b-9ff2-2c28-afdb-08e20b9ba84e@deltatee.com>
In-Reply-To: <b55bf34b-9ff2-2c28-afdb-08e20b9ba84e@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Nov 2018 14:47:59 -0800
Message-ID: <CAPcyv4i9My=3gwPUd_1qGVfhFUPBRh8teM6pgMD2w1scTRk12A@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mm, devm_memremap_pages: Fix shutdown handling
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 2:34 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-11-30 3:28 p.m., Dan Williams wrote:
> > On Fri, Nov 30, 2018 at 2:19 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >> Hey,
> >>
> >> On 2018-11-29 11:51 a.m., Dan Williams wrote:
> >>> Got it, let me see how bad moving arch_remove_memory() turns out,
> >>> sounds like a decent approach to coordinate multiple users of a single
> >>> ref.
> >>
> >> I've put together a patch set[1] that fixes all the users of
> >> devm_memremap_pages() without moving arch_remove_memory(). It's pretty
> >> clean except for the p2pdma case which is fairly tricky but I don't
> >> think there's an easy way around that.
> >
> > The solution I'm trying is to introduce a devm_memremap_pages_remove()
> > that each user can call after they have called percpu_ref_exit(), it's
> > just crashing for me currently...
>
> Ok, that's probably less of a clean up for other users, but sounds like
> it would be less tricky for p2pdma. I'd have to create a list of all
> pgmaps, but that's not so hard and doesn't create any nasty races to
> consider like my current solution.
>
> >> If you come up with a better solution that's great, otherwise let me
> >> know and I'll do some clean up and more testing and send this set to the
> >> lists. Though, we might need to wait for your patch to land before we
> >> can properly send the fix to it (the first patch in my series)...
> >
> > I'd say go ahead and send it. We can fix p2pdma as a follow-on. Send
> > it to Andrew as a patch relative to the current -next tree.
>
> Ok, though, how do I reference the current patch in Andrew's tree? Or
> does it matter?

I would just let Andrew know that this applies incrementally to
"mm-hmm-mark-hmm_devmem_add-add_resource-export_symbol_gpl.patch" in
his tree. You can't specify Fixes: tags for pending patches in -mm.
Andrew may choose to squash the change into the existing patch, which
may be the best outcome for not exposing a bisect regression point for
p2pdma.
