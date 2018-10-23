Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F656C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E96D207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsKFdJPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E96D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeJWU5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:57:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46755 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:57:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id o2-v6so974711lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Im/vJP/8ibJsV2ja1RXrqoJL/BIDk7XHcC1dS5X+auQ=;
        b=NsKFdJPuWPJD3iWIr3Bc09+MqfKBJix+AcqiTsbAaNugNQWW5Rl34NV268jEw53106
         J1ZoZIP9hib5r4rokehA5hVpSklPbRhEMeplTNUEOnPiV3CQhwnFcIV370V6XGwL4rj0
         gtR2nbAJ4dlR9zLk3svqWwQQ9Wdtc2FFiDd9oJJ6sfRyR7OF4kH3fjzjjMG95f+LAnPQ
         GGvfLjrR3lDH2JuszVoomQNGosh/HoySbMtG2Dfy4t37z3RGsAilQU68lxlQ7I0KYlyS
         /feBNqJH3nSPrXho02v+wtlOiBcGTTHWm7jZpghzuXkYkovyw5GJCdPhTjAj89SPUsKt
         LVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im/vJP/8ibJsV2ja1RXrqoJL/BIDk7XHcC1dS5X+auQ=;
        b=VNSO6/rwz7DhPxWkZ3qwexedLcO2znFDhzyuTvk7DBVKfzvSLsz9mPxUkXKGjlHxdl
         RB8AD5RBrCZpZi9BJRuvijrjmJk0kVM+LNTQ9TS7TWos+VZWK7AFenouq7Tb+fZKz7t2
         /sJYuOy86C+EPBu6IlwvdyLgt+rGAezUCB3PQj8yEgjfPZEEuEnnp+k6lXVAr5gLrxqt
         D4M0jSVgt4N5E93C+uGg/L+RIHW5sz0FhCS7MV/KwCuYMCzny95Y69i870JcDoCFpoZF
         JJda2UMmD64WVEiSed6Rkxy5YQQgNDdOg5XgSP+oWsIV4tvymVv0QQZ0nez4H1vMST7W
         iTMg==
X-Gm-Message-State: ABuFfoi3KpyrngiUslGPXXoa/4VK+xwYlEK77fZEg4UhrP1wnFTsTHV1
        aEpTB8hELSj6xhrCHn5yz3+tuYM/j53Ddl3efIg=
X-Google-Smtp-Source: ACcGV61Lkoc809vfK0d2ee3CoVAr5ArFpj0bamz+LKMkifeAXJ2sjIOTS7d0HWcmEFbJ+NafNzJKuBovPdn8YWXg/Bo=
X-Received: by 2002:a19:d908:: with SMTP id q8mr11952946lfg.88.1540298034824;
 Tue, 23 Oct 2018 05:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
 <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
 <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
 <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
 <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
 <CAFqt6zZ2yHkVcbYtK1dxr9B3K5WVYGboavjP1ibmYei0u4zFbQ@mail.gmail.com> <20181023122435.GB20085@bombadil.infradead.org>
In-Reply-To: <20181023122435.GB20085@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 23 Oct 2018 18:03:42 +0530
Message-ID: <CAFqt6zZp=UsSGH148=tPWLnSxC51EGdR0Vv4f5tP58MO-6OS_w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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

On Tue, Oct 23, 2018 at 5:54 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 23, 2018 at 05:44:32PM +0530, Souptick Joarder wrote:
> > On Sat, Oct 6, 2018 at 4:19 PM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > On Sat, Oct 6, 2018 at 7:11 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > >
> > > > On Fri, Oct 5, 2018 at 11:39 PM Miguel Ojeda
> > > > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > > > They are not supposed to be "steps". You did it with 70+ commits (!!)
> > > > > over the course of several months. Why a tree wasn't created, stuff
> > > > > developed there, and when done, submitted it for review?
> > > >
> > > > Because we already have a plan for entire vm_fault_t migration and
> > > > the * instruction * was to send one patch per driver.
> > >
> > > The instruction?
> >
> > Sorry for the delayed response.
> > Instruction from Matthew  Wilcox who is supervising the entire vm_fault_t
> > migration work :-)
>
> Hang on.  That was for the initial vm_fault_t conversion in which each
> step was clearly an improvement.  What you're looking at now is far
> from that.

Ok. But my understanding was, the approach of vm_insert_range comes
into discussion as part of converting vm_insert_page into vmf_insert_page
which is still part of original vm_fault_t conversion discussion.  No ?
