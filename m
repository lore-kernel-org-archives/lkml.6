Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A962087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfIpI3yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A962087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeJETKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:10:22 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38457 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeJETKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:10:22 -0400
Received: by mail-lf1-f65.google.com with SMTP id g89-v6so9186566lfl.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uj8PI0hRtqnpOYPLhZNNNFL3SQHaccQzPAS9iGIOZo=;
        b=VfIpI3yN//g8GKorXPUBjXPIHuIpzqZxONFptlzht/NYTsAJZOpn1otSULkp78jiol
         xRosK0h226qx3p1D5kTz1talwOS9O62LgHp3hPuj4wV/E1R2pFmY1UEqonWqPSG0tJhh
         5x7v6n5fr3sYyzURxps1R5nfjE4bmm37qS5SXivuwBqsvlSVqK8f71q4jbgyGw5MCd4K
         YdP9DC7sSCuCQz2QWsaKxtsZIK9oiUS/cAzoQx+uudg0UZakNUxdnhTcpZJVSzrDEBd9
         iN3yJQZfzKL8/A5pSuN5SmJVpoBlqjVy7jaR8qkrBujrfjc6wDO+4uXP9tRmlPdt0itv
         6utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uj8PI0hRtqnpOYPLhZNNNFL3SQHaccQzPAS9iGIOZo=;
        b=o0CgFjJ2w0dfxU4RbpPPYK8KnVdmbDQgn+6Ec+a5gy7c2mSMEdJCUrYixlIA8abo2T
         6UatpWkCQbrEMwC9wa3uI3PSyZOGH0onqCYmWUK41i3QZ5NqNs3w7qBw/SZZYm5AvNs2
         pHa7JCtXj+m9LYheJsezHNw91FR3+tsOAi1v6XPeohFhUewX14o8bfAuDfpLGGU567Yu
         p+aocPW7OjKR2omEZhDgfgXR7qPpCDbN3PEDOlIHabBN36Ts9M1O/50hRMB0/Qlh5Y0Y
         sG09E3rjyrwKqsAsYS03TTL13O7IeMd3B1z6fp/32UWqmPKzWzO83f4+ZC5DX1ACO+PM
         T8FQ==
X-Gm-Message-State: ABuFfoipvhae62fEb/ik4Qah2spXWjDJX6CRShiMaeEWBuoej+lCwHjg
        XS+8/oyRNY66UYsEqpEccVv1q8D8+ayOtiIorXs=
X-Google-Smtp-Source: ACcGV61444YsdP2FvwcDrcOmihSIemU5qkS9CAaeGW6VJ+uGnNN9KxB6IgWuFbJu+Dwq8BOVY/bA9owR1s8hPosDvv0=
X-Received: by 2002:a19:5311:: with SMTP id h17-v6mr6362539lfb.24.1538741512180;
 Fri, 05 Oct 2018 05:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org> <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
 <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com> <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
In-Reply-To: <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 5 Oct 2018 17:41:39 +0530
Message-ID: <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
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

On Fri, Oct 5, 2018 at 4:19 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Souptick,
>
> On Fri, Oct 5, 2018 at 12:01 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > The final goal is to remove vm_insert_page by converting it to
> > vmf_insert_page. But to do that we have to first introduce the
> > new API which is similar to vm_insert_page  (for non #PF). I tried this by
> > introducing vm_insert_kmem_page ( * identical as vm_insert_page
> > except API name *) in this patch. But this looks like a bad approach.
>
> We are going in circles here. That you want to convert vm_insert_page
> to vmf_insert_page for the PF case is fine and understood. However,
> you don't *need* to introduce a new name for the remaining non-PF
> cases if the function is going to be the exact same thing as before.
> You say "The final goal is to remove vm_insert_page", but you haven't
> justified *why* you need to remove that name.
>
> Now, if we want to rename the function for some reason (e.g. avoid
> confusion with vmf_insert_page), that is fine but is another topic. It
> may be or not a good idea, but it is orthogonal to the vmf_ work.
> Matthew, on this regard, told you that you shouldn't duplicate
> functions. If you want a rename, do so; but don't copy the code. In
> other words: nobody said introducing the vm_insert_kmem_page name is a
> bad idea -- what Matthew told you is that *duplicating* vm_insert_page
> just for that is bad.
>
> Further, you are copying the code (if I understand your thought
> process) because you want to change the callers of non-PF first, and
> then do the "full conversion from vm_* to vmf_*". However, that is
> confusing, because there is no need to change non-PF callers of
> vm_insert_page since they don't care about the new vmf_* functions.
>
> Instead, the proper way of doing this is:
>
>   1. Introduce the vmf_* API
>   2. Change all PF-users users to that (leaving all non-PF ones
> untouched!) -- if this is too big, you can split this patch into
> several patches, one per subsystem, etc.

We are done with step 2. All the PF-users are converted to use
vmf_insert_page. ( Ref - linux-next-20181005)

>   3. Remove the vm_* functions (except the ones that are still used in
> non-PF contexts, e.g. vm_insert_page)

Step 3 is part of step 2. Already done.

>
> Then, optionally, if you want to rename the function for the remaining
> non-PF users:
>
>   4. Rename vm_insert_page (justifying why the current name is
> confusing *on its own merits*).
>
> Otherwise, if you want to pursue Matthew's idea:
>
>   4. Introduce the vm_insert_range (possibly leveraging
> vm_insert_page, or not; you have to see what is best).
>   5. Replace those callers that can take advantage of vm_insert_range
>   6. Remove vm_insert_page and replace callers with vm_insert_range
> (only if it is not worth to keep vm_insert_range, again justifying it
> *on its own merits*)

Step 4 to 6, going to do it.  It is part of plan now :-)

>
> As you see, these are all logical step-by-step improvements, without
> duplicating functions temporarily, leaving temporary changes or
> changing current callers to new APIs for unrelated reasons (i.e. no
> need to introduce vm_insert_kmem_page simply to do a "conversion" to
> vmf_).
>
> Cheers,
> Miguel
