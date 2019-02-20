Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC96C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1168621773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/wsEmqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfBTHi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:38:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51799 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfBTHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:38:56 -0500
Received: by mail-it1-f195.google.com with SMTP id y184so13107755itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 23:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtGVXohNM/IP6aQpyRt4JKzW9QednskqOIKnMuthC24=;
        b=D/wsEmqGiShOS9LKl4SrTx2FRYRMzYyTNx1wXhkswZf0OLkiBMSfomz695OLIc4nCF
         j2r9F4Ufz7aMh2KUhkersW9iliIqLPHv6PcXU6KDzJb7aRAl8uvalZatcEVXUT9sHexH
         ckEcXs30s9yzFsa6yOHf2dd9hRwRQz3rcuQdvja/PwfyahIpbWPqrDe5pJXPA4W2h3JD
         WlpVhP6wXuH/HE5spHgNhIH6YD+e8p80w3PsXS05UBsEe+Z5yOTtyy9kQ1FPNCvtjTW3
         muAHm6rLLfch3n6L82vkPYaHyaMnCeL+koBOjDI/K7CYLzjGaqdmGYOd5k85GJ2JYDQa
         aE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtGVXohNM/IP6aQpyRt4JKzW9QednskqOIKnMuthC24=;
        b=AZQzujIX8Qm18bCSyfh/CqI+kB8JeimEKZrH2FFG6WPeWZ28uGtCX60Dh/1ruPHiOB
         VUht7ncv8+t7zTKGT49yrlJGbA9yNZaZMRWEXXWCD9PMhYi3v+ppf0mT+qgbuhqUaYvG
         JQ6HBWKsRYO81nvNEMckmf9YZJVdqJExBpd81IEBZs1Q8xxtVjNQR5td3nmW6smYoCPG
         +xMRVHI7ogCe8CgYbjWioG9ldROooKfbf9MS4ot8L0X/R9rVatO4CjAqB2i59oDPziTQ
         JwuyPz01tU9fTnmkdkAtvX4lT253z9P6LOkxABuZW2VYEiOVpNRaVDWStPB72U8tkG8Y
         3ZmA==
X-Gm-Message-State: AHQUAubSrpPAxNHMSWLqd2zu0A5HwPd1Z6yFOA29TOrQblEY9ERHN3bm
        yafiiRevv9qYbSCodnqe+bL39Ipmv3rMNjkFAA==
X-Google-Smtp-Source: AHgI3IZ3lxaXD8y+tWxPk6bG5RJhwIAqEsv9/z2yPNXKCRv4KFyEPKzhJEJwIQSAMW2KdKRb2jX49e460IUX0ukXH04=
X-Received: by 2002:a02:f5c:: with SMTP id h89mr16270380jad.15.1550648335363;
 Tue, 19 Feb 2019 23:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20190125140823.GC27998@zn.tnic> <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic> <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic> <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic> <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
 <20190211204816.GB21473@dhcp-128-65.nay.redhat.com> <20190215102458.GD10433@zn.tnic>
 <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190218014820.GA10711@dhcp-128-65.nay.redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 20 Feb 2019 15:38:43 +0800
Message-ID: <CAFgQCTu7pS=f2NgNvUgWaSt0hQ=KOZJXjBxktLi4PBkuXwvDFA@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Dave Young <dyoung@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 9:48 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 02/15/19 at 11:24am, Borislav Petkov wrote:
> > On Tue, Feb 12, 2019 at 04:48:16AM +0800, Dave Young wrote:
> > > Even we make it automatic in kernel, but we have to have some default
> > > value for swiotlb in case crashkernel can not find a free region under 4G.
> > > So this default value can not work for every use cases, people need
> > > manually use crashkernel=,low and crashkernel=,high in case
> > > crashkernel=X does not work.
> >
> > Why would the user need to find swiotlb range? The kernel has all the
> > information it requires at its finger tips in order to decide properly.
> >
> > The user wants a crashkernel range, the kernel tries the low range =>
> > no workie, then it tries the next range => workie but needs to allocate
> > swiotlb range so that DMA can happen too. Doh, then the kernel does
> > allocate that too.
>
> It is ideal if kernel can do it automatically, but I'm not sure if
> kernel can predict the swiotlb reserved size automatically.
>
Agreed, I think it is hard to decide the reserved size automatically.
We do not know the requirement for memory of ZONE_DMA32 at boot time.
The requirement depends on how many DMA32 devices, and the dynamic
payload of them.

> Let's add more people to seek for comments.
>
> >
> > Why would the user need to do anything here?!
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > Good mailing practices for 400: avoid top-posting and trim the reply.
