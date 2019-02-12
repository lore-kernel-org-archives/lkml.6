Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94701C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DBE20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 05:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJl5JR6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfBLFfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 00:35:24 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37835 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBLFfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 00:35:24 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so4566740iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 21:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k16c7Vwqs2BtbxacAaCK2evvPfhEyH6pxlx6O4bySs4=;
        b=BJl5JR6udyA177kKw6+kpZIIdsck2dfSCDZf0zE6ojzr6ofJGec1b6QsMuFWrRKllf
         JPsV4IoqkzE+MSwcadi4OKNov/1ejtGCxe6PEWFrIbno0BpjvzZ8ZROMzkuV4mG627kB
         xiCPUl0/PJbIXi8JCZ0RxJnRv465mhiGG3ofSyslLwa8qT2UsTOhH1PaEjXYVpE3xfXB
         kqp2lUqQuuahuw7xEf48iXYhO1p1Q68TzryYS7OxeTDruWatTvWbeT9QANYB+PeQbmiI
         oXXYFBfBwp0dhXxEHwAyp7wj+J5NBRxpAwPLQIYM6o41WVvQ1GEESUUce0YVxh2aVEKB
         ZvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k16c7Vwqs2BtbxacAaCK2evvPfhEyH6pxlx6O4bySs4=;
        b=M8C3052oVszSXXGw1UoQqIKyc1gTVA/bunwW2B2JQpAY+6aYFtehQdAyfx2/kgZnvw
         anhOYBfTbk/RN/iHjWkmEG7g2sC/aZbpby9JEY12lq1BNLvHRT+AUqvH58BaCL7HLUf5
         t07mEvpoFmwriB41yQnKY3ItT7MV8DLGprYlmpIZZSKRU9PDbQjmTth9zRpv1ukqnVn2
         ZEshq0VQ7S/7wcKBzzBIi1Iigx+wMn1vyoBe6uBNVfjnPJIX5t2esB6+UqauxqR3/zsr
         XvLyCkcYpAe0bBP/xN9pHLT4gJ5b1ljztgrSmjHyO4cmXJEbYDn5tTEsBSkXeexcY3Yd
         wDGQ==
X-Gm-Message-State: AHQUAub/e6AhIqAdRV5MzziNoUuqojAXLjFfAsdSfboopKa7NNi9UZ/V
        OTBZWUQJHLUrVlpoNnPjGKMG6SaLvvLSkHF8Bw==
X-Google-Smtp-Source: AHgI3IYjdlKatJkCbM6WN+xQNWMLeDvpl/gXyukV1W1ujr3n8HtPjD+XO3iH00Gz8EwehoUPqFV9WHpnECzGTuBIJuU=
X-Received: by 2002:a24:a10:: with SMTP id 16mr1062640itw.42.1549949723046;
 Mon, 11 Feb 2019 21:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20190125103924.GB27998@zn.tnic> <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic> <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic> <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 12 Feb 2019 13:35:11 +0800
Message-ID: <CAFgQCTv0gkXpvJ6U+RztfVe+eL=5nL+=_TVaNV0VozX_dKtrWQ@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:48 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 02/06/19 at 08:08pm, Dave Young wrote:
> > On 02/05/19 at 09:15am, Borislav Petkov wrote:
> > > On Mon, Feb 04, 2019 at 03:30:16PM -0700, Jerry Hoemann wrote:
> > > > Is your objection only to the second fallback of allocating
> > > > memory above >= 4GB?   Or are you objecting to allocating from
> > > > (896 .. 4GB) as well?
> > >
> > > My problem is why should the user need to specify high or low allocation
> > > explicitly when we can handle all that in the kernel automatically.
> > >
> > > The presence of crashkernel= on the cmdline sure means that the user
> > > wants to allocate memory for a second kernel.
> > >
> > > Now, if the requested allocation fails, we say:
> > >
> > >   Error reserving crashkernel
> > >
> > > So, instead of saying that, we can *try* *again* and say
> > >
> > >   Error reserving requested crashkernel at @..., attempting a high range.
> > >
> > > and run memblock_find_in_range() on the other regions which we deemed
> > > are ok to allocate from.
> > >
> > > Why aren't we doing that by default instead of placing all those
> > > different options in front of the user and expecting her/him to know
> > > something about all those magic ranges?
> >
> > As we talked in another reply, for the >4G allocation we can not avoid
> > the swiotlb issue,  but if one request for 256M in high region and we
> > allocate the low part automatically, it will eat more memory eg. 512M.
> >
> > But probably in case allacation failed in low region ,high is a must for kdump
> > reservation, since no other choices perhaps we can make that as you said
>
> That is exactly what Pingfan is doing in this patch.
>
> Even we make it automatic in kernel, but we have to have some default
> value for swiotlb in case crashkernel can not find a free region under 4G.
> So this default value can not work for every use cases, people need
> manually use crashkernel=,low and crashkernel=,high in case
> crashkernel=X does not work.  One can tune it for their use:
>
> 1) crashkernel=X reservation fails, likely the ,low default value is
> still too big, one can shrink the value and manually try other value
> 2) crashkernel=X reserve successfully on high memory and along with some
> default low memory region. But the low region is not enough.  In this
> case one can increase the
>
> This should answer the question why ,high and ,low is still needed.
>
> But for above consumption 1),  KASLR can still cause default ,low memory
> failed to reserve.  So I wonder if KASLR can skip the 0-896M if the
> system memory is big enough.
>
A little fix about the comment. Refer to reserve_crashkernel_low(),
low_base = memblock_find_in_range(0, 1ULL << 32, low_size,
CRASH_ALIGN); So it should try 0~4G for ",low". And the default size
for low is 256M. Given the limited memory region reserved by other
component before crashkernel, we always can find a continuous chunk of
256M inside the fragmented [0,4G], which is split by initrd, KASLR.

Thanks,
Pingfan
