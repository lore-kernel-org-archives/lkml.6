Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB1C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953DE20875
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoVtXYNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953DE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJFMNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 08:13:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45717 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeJFMNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 08:13:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id m80-v6so10694263lfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWXgY7eOBVPu0bsJqVnQe+rib0h8PmCN34cCY8vdgwg=;
        b=SoVtXYNpB1tB09CyTIj/ns6jt36TQu172uoMLQFixAfNFNKQYXRvOhTnbLjWbJ5OJx
         3GHHl+0aRItn/impWbeGR2nu27C61P0403j/HLGbeEpFbZbhK3AO9kP2eISDitRfWMKq
         beJD0bsjOkz5yrmijlyXH1EGKvogVTO22bPCoZhVsp8PD4SI4XvTuMncRENajRjRDCVT
         X9/8wvjL/igs1uLliphFxxYUmmuTl7ofuGPEOaJEox61fq13k9wQEAqrM7+E2KhWwd0K
         yY5tuHnAQOAjmcyIvgX+a50n5uz8Z9NBu+RbbqtPEsNroZWMENeqMUiGbnXwYdrmDZ2K
         m28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWXgY7eOBVPu0bsJqVnQe+rib0h8PmCN34cCY8vdgwg=;
        b=ErVbcFsvjrlV81fnD3ypTvDSoVa9OpOuU/aq3TdR/0nldYRK7rqxezFhSz43I4PzUa
         ySJbn6m/Dc6lOfz/a/BSjP6Jy/VsZsl1Yq2LNLSwnhhjwzV1TsmvWqIslar/0qMCxJX4
         G0SH8NcdJ/vfEC3XFXulIDIAQTiagfJo4s9B8u96NuVo+BEvzsEOANTyvnfWcdfISw3b
         bk121/eIsXSMYbOhfY56S2rBYLdM6kDj04gsN+UKlRsMFwJy1GJB+hd3EyKMh1LAyWuE
         dq7dY7XZSDJmOlOQILjqOa+C+24yiVLS4B6VzT0klAiLJWQCff8tFz2s/37N7189g3V7
         aoEA==
X-Gm-Message-State: ABuFfoi8YZxQ4Kb472ylWWdYbLR9luVJlt2wSIAeyUoGmL0eNf3Fdehx
        OgO2ttfn4aVVUNm16bocyG2MqgLpctf9fU1uPeo=
X-Google-Smtp-Source: ACcGV63jxCQyoP6GXmPcoxR6NNwK9mM7JifH6dpHs279atreUqvqSVs9nTaqIRY2pnLe1Xhh6GTb74b1mMYVRWGICoU=
X-Received: by 2002:a19:6544:: with SMTP id c4-v6mr530271lfj.31.1538802678053;
 Fri, 05 Oct 2018 22:11:18 -0700 (PDT)
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
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com> <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
In-Reply-To: <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 6 Oct 2018 10:44:26 +0530
Message-ID: <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin@protonic.nl, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, aryabinin@virtuozzo.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 11:39 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 2:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Fri, Oct 5, 2018 at 4:19 PM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > >   1. Introduce the vmf_* API
> > >   2. Change all PF-users users to that (leaving all non-PF ones
> > > untouched!) -- if this is too big, you can split this patch into
> > > several patches, one per subsystem, etc.
> >
> > We are done with step 2. All the PF-users are converted to use
> > vmf_insert_page. ( Ref - linux-next-20181005)
>
> They are not supposed to be "steps". You did it with 70+ commits (!!)
> over the course of several months. Why a tree wasn't created, stuff
> developed there, and when done, submitted it for review?

Because we already have a plan for entire vm_fault_t migration and
the * instruction * was to send one patch per driver.
>
> > >
> > > Otherwise, if you want to pursue Matthew's idea:
> > >
> > >   4. Introduce the vm_insert_range (possibly leveraging
> > > vm_insert_page, or not; you have to see what is best).
> > >   5. Replace those callers that can take advantage of vm_insert_range
> > >   6. Remove vm_insert_page and replace callers with vm_insert_range
> > > (only if it is not worth to keep vm_insert_range, again justifying it
> > > *on its own merits*)
> >
> > Step 4 to 6, going to do it.  It is part of plan now :-)
> >
>
> Fine, but you haven't answered to the other parts of my email: you
> don't explain why you choose one alternative over the others, you
> simply keep changing the approach.

We are going in circles here. That you want to convert vm_insert_page
to vmf_insert_page for the PF case is fine and understood. However,
you don't *need* to introduce a new name for the remaining non-PF
cases if the function is going to be the exact same thing as before.
You say "The final goal is to remove vm_insert_page", but you haven't
justified *why* you need to remove that name.

I think I have given that answer. If we don't remove vm_insert_page,
future #PF caller will have option to use it. But those should be
restricted. How are we going to restrict vm_insert_page in one half
of kernel when other half is still using it  ?? Is there any way ? ( I don't
know)
