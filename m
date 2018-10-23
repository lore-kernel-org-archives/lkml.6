Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B83C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B046E20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKcj5FK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B046E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeJWUiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:38:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44721 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:38:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so1120534ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBAwiVSgHF1r2FEzQ1N95UBkQZFlWElgz2GsLIR5y1Q=;
        b=jKcj5FK18qHxKi8uhKcyfxaucS9xPoPDL0pat1y45W0Mg50ZHplITKEfmcg8cxgX6a
         /BxJsDAwxOAcJvT9wvMQr7XsTQvbT5Z8yA0L+TT5CwiNBGICjNDJymMXuGxy3GCwdOTp
         /Z47kGeou09D2YjNgGsiHAvDTracP6Wj8FdIKugMf/MJZIS8ABZgY+YpAqi8LKaO+Ihy
         S8+qrR4M1DLg9axAAmTZiJ3uCVlJWRcJUXpZRa0Ac8TqSwG9Nm0e5Gf16fJ3T6LW3D4z
         bql3QfnK3qLpDkYIwJv0S82mgptb0Z2YqfsN1jH6XtWMlH/z6H6oFr5uoscbnHbwK+WL
         98pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBAwiVSgHF1r2FEzQ1N95UBkQZFlWElgz2GsLIR5y1Q=;
        b=uV0AwTHUJP3J5yo2k13wA2TQYgQ9QJty0G0ydOuOReqlvz/RXEE/uHuRdRlZCfzamp
         p/7lnsbokJ5LTRoYmDCVVb1wSX+qrQ5aLx9Xy64N4Xjo9hU0Y2sA7zqfixBVTlyEM/o1
         SFf/1qATn/cPIrGVIxuE8eQgBWR95RJRxqjt/2bN2HrHQYJ+KRJvohm3PiV2hJQVra4f
         dOEGLcEro6f2c8QUBaPMDg9d2y7izzkixi4EzHnefwbaZGOf0KPqgzuzvYzx+iJCp2qs
         8H/9GWQct36aId4K6LO8M5dvZVbdmOWla9Tr2YtFOjYtGa15Cfrtwg9oXNE9ES4vlMTg
         FjVw==
X-Gm-Message-State: ABuFfoi6PvxQgX3rhcnRnLMr2eu9gZBgqLzmbQ4wWw/y9bgcQi8ui0Xq
        hXuet5j0bCsqTrAmztRdXQ2XS3lEQCF62MaQt6U=
X-Google-Smtp-Source: ACcGV62iMaozcdTVuKmKDY42Rn2SXVejGskhzJsjtZzlGQf8wfeLjYUtSO0qtLt+Efv/tKJVHmTP4VYS+g7rNHInl8s=
X-Received: by 2002:a2e:5586:: with SMTP id g6-v6mr31371476lje.75.1540296884897;
 Tue, 23 Oct 2018 05:14:44 -0700 (PDT)
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
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
 <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
 <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com> <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
In-Reply-To: <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 23 Oct 2018 17:44:32 +0530
Message-ID: <CAFqt6zZ2yHkVcbYtK1dxr9B3K5WVYGboavjP1ibmYei0u4zFbQ@mail.gmail.com>
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

On Sat, Oct 6, 2018 at 4:19 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 6, 2018 at 7:11 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Fri, Oct 5, 2018 at 11:39 PM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > They are not supposed to be "steps". You did it with 70+ commits (!!)
> > > over the course of several months. Why a tree wasn't created, stuff
> > > developed there, and when done, submitted it for review?
> >
> > Because we already have a plan for entire vm_fault_t migration and
> > the * instruction * was to send one patch per driver.
>
> The instruction?

Sorry for the delayed response.
Instruction from Matthew  Wilcox who is supervising the entire vm_fault_t
migration work :-)

>
> > >
> > > Fine, but you haven't answered to the other parts of my email: you
> > > don't explain why you choose one alternative over the others, you
> > > simply keep changing the approach.
> >
> > We are going in circles here. That you want to convert vm_insert_page
> > to vmf_insert_page for the PF case is fine and understood. However,
> > you don't *need* to introduce a new name for the remaining non-PF
> > cases if the function is going to be the exact same thing as before.
> > You say "The final goal is to remove vm_insert_page", but you haven't
> > justified *why* you need to remove that name.
> >
> > I think I have given that answer. If we don't remove vm_insert_page,
> > future #PF caller will have option to use it. But those should be
> > restricted. How are we going to restrict vm_insert_page in one half
> > of kernel when other half is still using it  ?? Is there any way ? ( I don't
> > know)
>
> Ah, so that is what you are concerned about: future misuses. Well, I
> don't really see the problem. There are only ~18 calls to
> vm_insert_page() in the entire kernel: checking if people is using it
> properly for a while should be easy. As long as the new behavior is
> documented properly, it should be fine. If you are really concerned
> about mistakes being made, then fine, we can rename it as I suggested.
>
> Now, the new vm_insert_range() is another topic. It simplifies a few
> of the callers and buys us the rename at the same time, so I am also
> OK with it.
>
> As you see, I am not against the changes -- it is just that they
> should clearly justified. :-) It wasn't clear what your problem with
> the current vm_insert_page() is.
>
> Cheers,
> Miguel
