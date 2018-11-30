Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3FBC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA7520863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FqTAYkVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA7520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeLAJjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:39:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36029 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeLAJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:39:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so6577365otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NubkKiW6Sjq2y83Kih4Uh6i4G/4fIuJUxusgIItCsI=;
        b=FqTAYkVlQYuH3CdsJ0XsLjzTP2hjGG2KDZ79shSEUXhzK4KctAquuXMAfHSDk8JolU
         7ftjELjdAAheUeUSo5Tyzim+trcCuRViu1h0Peofm6AcNAQ7YmsF8moJ/N1Jr42UyeTu
         9qZt/6E9VFWsdrMn/NMEj5E45VG4QNE5Wl15WpyWs3tt2vaKfLuFVnIc3XlqLV7NuMFM
         +5Cxcl0Hn2fylkEFmqAIXglQSH2j/1uXeM7jjbR/0PHtD/lGFE2QbVg+EhWkSCdFDFuQ
         y/8lrygy+FlLYNDh8ITRujRyDIiGyvsEhA+fVwmF5cgdur34DOCjoBNZObioJcGuJ+eP
         Rg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NubkKiW6Sjq2y83Kih4Uh6i4G/4fIuJUxusgIItCsI=;
        b=BRFr5JMWh+0F5S6d4/GrNh/a0sJuEeLlfxlcDOlqrmn6ej/aeVJkMD63hSUrOokpjw
         3RIKcPFhztU5UEOgDiC/FUzFtStq1qJfilbrb2S1EVaZexQ5X1Hj5foDlMB8Z7GYxVrB
         ZghI+QiVKi2lu/UOgeANXERMBLRRbE6OpkaaHuUfTggQ7M54shCLRc5t3TKSlBnAgh4c
         5zHEhBPzm1mM3sBMNEPeYsAAU1Km2YUUUJMjosFtBzu8oKiRPA1fF9ylJ4VnwmmFVlaz
         1QhPESmdSGP1820O9lJZZrlyyQLhaWwsfylrL4aHRQzSE2xJU5GEgOZWSeebCWDXv6Gy
         EclQ==
X-Gm-Message-State: AA+aEWYtuPJmp6WZNTmcuj9pFIOiGidFwF6dN6+gfxBBJmEYP0y14l3B
        JQT/vN4qAkz+/ppa3x6iglc3gEGxhxQX28OSKEGGDQ==
X-Google-Smtp-Source: AFSGD/W+DirQoyuuwSmnd1nixut60r655Vj6/NYc2hKejFcEc9NSYmKGCIng48qRzLSvEDPhY8QX0pcNMQCTu6fUVHA=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr4714497oti.367.1543616927425;
 Fri, 30 Nov 2018 14:28:47 -0800 (PST)
MIME-Version: 1.0
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275558526.76910.7535251937849268605.stgit@dwillia2-desk3.amr.corp.intel.com>
 <6875ca04-a36a-89ae-825b-f629ab011d47@deltatee.com> <CAPcyv4i9QXsX9Rjz9E3gi643LQbSzaO_+iFLqLS+QO-GmrS0Eg@mail.gmail.com>
 <14d6413c-b002-c152-5016-7ed659c08c24@deltatee.com> <CAPcyv4gZisOAE8VJPJChNXrWv0NhUevWuutsPdvNORBTOBXJfA@mail.gmail.com>
 <43778343-6d43-eb43-0de0-3db6828902d0@deltatee.com> <CAPcyv4hJV71RLhBCKgqc=nQ_D_upySD=ZZk0y=5Qk69kKPHFog@mail.gmail.com>
 <b8ae55a4-7c1a-cc35-beea-badf35a69b06@deltatee.com>
In-Reply-To: <b8ae55a4-7c1a-cc35-beea-badf35a69b06@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Nov 2018 14:28:36 -0800
Message-ID: <CAPcyv4iVCMo29SWM2jhnNTZ5ugYaqjeW_LKe9O2YmeNohwQG3A@mail.gmail.com>
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

On Fri, Nov 30, 2018 at 2:19 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hey,
>
> On 2018-11-29 11:51 a.m., Dan Williams wrote:
> > Got it, let me see how bad moving arch_remove_memory() turns out,
> > sounds like a decent approach to coordinate multiple users of a single
> > ref.
>
> I've put together a patch set[1] that fixes all the users of
> devm_memremap_pages() without moving arch_remove_memory(). It's pretty
> clean except for the p2pdma case which is fairly tricky but I don't
> think there's an easy way around that.

The solution I'm trying is to introduce a devm_memremap_pages_remove()
that each user can call after they have called percpu_ref_exit(), it's
just crashing for me currently...

> If you come up with a better solution that's great, otherwise let me
> know and I'll do some clean up and more testing and send this set to the
> lists. Though, we might need to wait for your patch to land before we
> can properly send the fix to it (the first patch in my series)...

I'd say go ahead and send it. We can fix p2pdma as a follow-on. Send
it to Andrew as a patch relative to the current -next tree.
