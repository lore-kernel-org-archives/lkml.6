Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7E213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 18:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui2+mLFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F7E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbeJFBJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 21:09:06 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:45468 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFBJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 21:09:06 -0400
Received: by mail-qt1-f169.google.com with SMTP id e10-v6so3669210qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/EbpG1rWscNdYMVIbel/cuHFeBG2uQ4hI3+QuRBaIE=;
        b=Ui2+mLFCca1Ym99XJTXL/+mY7gXqcBTZpolLrmtDAdVShaIycVAoKewvJGruJfvQq4
         WQXntq3mVZA/eavJm7/iMqMvIMUBCx0L5DZz4cF+8kI3NefLLYFNFGjXyipAXeV3XCVh
         lU6qFvWLcw7DAevV7Kbi/oQ71L+4yoLkfqGs6/FZytpHGVoFyQVx0J0BRntKaMrFDKE3
         gKmNdXmQNI87ZP30BzlUI7/1FSbNZCwo5xSCAAjpS4K00lQNKwyo3c+all1Xpz+VRtQ3
         Civx284v+he14Uy8AfIhUkwH36mVcxuQcs5ISndW3N7+cXVA10m/uSQ4MlJFKLet2SF1
         +3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/EbpG1rWscNdYMVIbel/cuHFeBG2uQ4hI3+QuRBaIE=;
        b=qLn3q5+j4iDJrghrOAPZoRi9IMO+5T+QU+I0MgqlnHZyALMH2wKX/Ch4kmUvVdr4zi
         8Kbgs/OHE9Bip749dPIdQboi1Njg3F22MnOB64fEiP4u+wpJaem7XzwHL597T23wfxmc
         itHMNpleldCdhTf5w/gTJ7OtGzZQGqv7SMtxTO6fgoceKmq+UKorYQpFw7A12k2h70RZ
         WQZk5fFOrD/cssD16EaSjwn1mhTMVXMpdsCyBk+VIsm3IQXcmitP3B1uc0HFPlCTufDM
         mDVvGJGhlbouuzQL62lwxVWHP6Dr1v2o1rNm+6hgaiVGWVuLwsRsd6qRRM2eAJjLo/41
         OS9A==
X-Gm-Message-State: ABuFfogEwNcFwYIVbQp1IftEGAe7QCyfBoce8mR07D3L22Y16CyoAO0w
        +eoMKNWjhzYO5i2HMli9eEgRPDEhc4LEeygqvBU=
X-Google-Smtp-Source: ACcGV63jyHGL4AFEkmmavZWcfebiNrivTcclbtCnHuh+5RMs/lycKkVJbB1n4XNE0fZVKQK43oMSSvClA7qo7fNjPKo=
X-Received: by 2002:a0c:aedd:: with SMTP id n29-v6mr10437305qvd.10.1538762955025;
 Fri, 05 Oct 2018 11:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org> <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
 <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com> <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
In-Reply-To: <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 Oct 2018 20:09:03 +0200
Message-ID: <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux@armlinux.org.uk,
        Robin van der Gracht <robin@protonic.nl>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Dave Airlie <airlied@linux.ie>, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        mhocko@suse.com, Dan Williams <dan.j.williams@intel.com>,
        kirill.shutemov@linux.intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, minchan@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, ying.huang@intel.com,
        Andi Kleen <ak@linux.intel.com>, rppt@linux.vnet.ibm.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 2:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 4:19 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> >   1. Introduce the vmf_* API
> >   2. Change all PF-users users to that (leaving all non-PF ones
> > untouched!) -- if this is too big, you can split this patch into
> > several patches, one per subsystem, etc.
>
> We are done with step 2. All the PF-users are converted to use
> vmf_insert_page. ( Ref - linux-next-20181005)

They are not supposed to be "steps". You did it with 70+ commits (!!)
over the course of several months. Why a tree wasn't created, stuff
developed there, and when done, submitted it for review?

> >
> > Otherwise, if you want to pursue Matthew's idea:
> >
> >   4. Introduce the vm_insert_range (possibly leveraging
> > vm_insert_page, or not; you have to see what is best).
> >   5. Replace those callers that can take advantage of vm_insert_range
> >   6. Remove vm_insert_page and replace callers with vm_insert_range
> > (only if it is not worth to keep vm_insert_range, again justifying it
> > *on its own merits*)
>
> Step 4 to 6, going to do it.  It is part of plan now :-)
>

Fine, but you haven't answered to the other parts of my email: you
don't explain why you choose one alternative over the others, you
simply keep changing the approach.

Cheers,
Miguel
