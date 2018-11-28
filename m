Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B48C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D76F20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W98GuLgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D76F20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeK1T46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:56:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42879 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1T46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:56:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so9189886pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 00:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2joXtoL181T0Q+21ODaRSamdDlvS5I215c8Di1fWVs=;
        b=W98GuLgAcg0nB6qqCE3sDvPMTo73UFUgvoi7Y0+0FCPdnSGSRNoJ68DULJZyImO+Uk
         X3Ywz2WANNZrLW/ebqlF7Uiu9Ea3QddUHMsO78IZ4pBpfIyGloASm/iB4voVCSi+Q3aW
         AcYQN0ZqLef8yMV3oxXsNYKQDKRFSiDmUpMBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2joXtoL181T0Q+21ODaRSamdDlvS5I215c8Di1fWVs=;
        b=D/Sou1ci5D9jurO5OqMrWmtpaiXiZseLIQ0bShyZqv9BIIufEvntofhE06nSFM4kWi
         yf/AsU7p+dP24XM+CK6SVID0+/m7lWy09XGkoWBA5sk86wv3Mu5mQDnies+Z0gOrSZJL
         lZ8sV1FZ4uUGczJBhqv0btFzyEKmLrdXxI9+d5xLlEl3s7VAuI28O4nGgLluJpjhhDKC
         NaGTXN06mOanIBLa0FQKuJ196wIDLmACAXJvxl2eElg4G9NyKhnq98tgffz5bNgfH0Lr
         T/I1qlPxmlbPDbhK8heVz8LzIMS2skkaQ/OT/v2JHBGM96mcirwY2xnaFj2VQsoUWLpS
         CYEg==
X-Gm-Message-State: AGRZ1gIUGyotsI33S4OCXqSLuPS4G5fo3Ex+7xRPfM+454t2+HPUvWu5
        vZAx0or/gCKkxrZCcGhVew0PyD2M1qOtlAxKGOQztw==
X-Google-Smtp-Source: AJdET5cxONVrz01SwOMvHbLkxB35vXTRz12KRwMc2vhsNl/ZTPs/NNfq06/M+CpRCuOZ129zxxQXkjrnz2DsB7+iGyY=
X-Received: by 2002:a62:d0c1:: with SMTP id p184mr36225520pfg.245.1543395365831;
 Wed, 28 Nov 2018 00:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <0100016737801f14-84f1265d-4577-4dcf-ad57-90dbc8e0a78f-000000@email.amazonses.com>
 <20181121213853.GL3065@bombadil.infradead.org> <c5ccde1e-a711-ad33-537c-2d5a0bd9edd4@arm.com>
 <20181122082336.GA2049@infradead.org> <555dd63a-0634-6a39-7abc-121e02273cb2@suse.cz>
 <20181126080213.GA17809@infradead.org>
In-Reply-To: <20181126080213.GA17809@infradead.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 28 Nov 2018 16:55:54 +0800
Message-ID: <CANMq1KBYAgoPh37e+BPz7xK4z3jJ4Gm30Gs662+_gTdM8v0QDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     hch@infradead.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Robin Murphy <robin.murphy@arm.com>, willy@infradead.org,
        Christoph Lameter <cl@linux.com>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, Michal Hocko <mhocko@suse.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        David Rientjes <rientjes@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 4:02 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 23, 2018 at 01:23:41PM +0100, Vlastimil Babka wrote:
> > Is this also true for caches created by kmem_cache_create(), that
> > debugging options can result in not respecting the alignment passed to
> > kmem_cache_create()? That would be rather bad, IMHO.
>
> That's what I understood in the discussion.  If not it would make
> our live simpler, but would need to be well document.

From my experiment, adding `slub_debug` to command line does _not_
break the alignment of kmem_cache_alloc'ed objects.

We do see an increase in slab_size
(/sys/kernel/slab/io-pgtable_armv7s_l2/slab_size), from 1024 to 3072
(probably because slub needs to allocate space on each side for the
red zone/padding, while keeping the alignment?)

> Christoph can probably explain the alignment choices in slub.
>
> >
> > > But I do agree with the sentiment of not wanting to spread GFP_DMA32
> > > futher into the slab allocator.
> >
> > I don't see a problem with GFP_DMA32 for custom caches. Generic
> > kmalloc() would be worse, since it would have to create a new array of
> > kmalloc caches. But that's already ruled out due to the alignment.
>
> True, purely slab probably isn't too bad.
