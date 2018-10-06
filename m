Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ADDC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A845F2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 10:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF+BjCkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A845F2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJFRwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 13:52:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44183 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeJFRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 13:52:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so13782169ljc.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkcBsM2+ahYK5Ozk5bZjgc4F1TQ+raSPB3ys8/U2oVM=;
        b=lF+BjCkT6ct8h7R0/ITNp347Fl/tueaS/0D0qDy1t1qxOBUlfxiXj6Wqb16iWD4zfu
         jk1sA1PCmsqZv35/xBvrqPDQ237G+E/SWnC8OgDBefHd4C87aD628GbHUC78EzYA8Spa
         VMhB/j97r/OfUUta0gAszjyhwUN5TqJ//Y/yYrJ/cx164cm+/hp5AlYlyoXUtFqfWi4c
         uWjGgl9sfjvOUwOGTYdMnFWH747KVQdF1GI+kY5OsQxTkE0KHBwF4APRT1CYIEZVOwE4
         jOxxv+Rc8v0i6CwjDfCQFtJr/3EGeQCApo2WrbD1u+oP/cw7/nmPqI0M+bPfgA65yyG5
         ZyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkcBsM2+ahYK5Ozk5bZjgc4F1TQ+raSPB3ys8/U2oVM=;
        b=WEIbOvdMjwiMrUU8hjo6R26bgt5/Df4SzxwogJ3iqFrrJXlsMjN1mrEikklxkUuho7
         A1fo964Ui0DyLSla63NRr0l6wGRSbm8u0ZkExLllYPvBZIsoVZebd/4rsb/B3dQ9e+gW
         aWUKtbKkAf2qGqmhp94vFsdxAiPJCfHz2qtnL6ZzoHZXGQV4VW+FG33ueXm6xIXqn/65
         dwRlN25g+re873Mp7fJIOgFvqeM+w+KlL/BtkXPWhPhBSpLUtQ5pImARz+2srNEWSnxn
         QbQtDhyi2MOxIOmjhVjgYpTfCN09tW5iNfUNvgtkZalemaGDQPc5tPhucqjKEVw1q8rJ
         eyGg==
X-Gm-Message-State: ABuFfoh6JVgILDAFeP2++R/OqZStMFyZfrd1CgnxJ8GZNAMKF8U//x2k
        zGvyMOcqdFexc6BGPGWLNdluAe1O40S6z2qG7ag=
X-Google-Smtp-Source: ACcGV638UNbIY05GDS89F7JsvPKvBTy7j9PaR8O0UqCoJVp/zjimjO0s5oGxMgUT+GRHxZ5wQGfEW5TDXe5GyRxsIC0=
X-Received: by 2002:a2e:9615:: with SMTP id v21-v6mr9640705ljh.150.1538822994132;
 Sat, 06 Oct 2018 03:49:54 -0700 (PDT)
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
 <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com> <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
In-Reply-To: <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 6 Oct 2018 12:49:42 +0200
Message-ID: <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
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

On Sat, Oct 6, 2018 at 7:11 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 11:39 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > They are not supposed to be "steps". You did it with 70+ commits (!!)
> > over the course of several months. Why a tree wasn't created, stuff
> > developed there, and when done, submitted it for review?
>
> Because we already have a plan for entire vm_fault_t migration and
> the * instruction * was to send one patch per driver.

The instruction?

> >
> > Fine, but you haven't answered to the other parts of my email: you
> > don't explain why you choose one alternative over the others, you
> > simply keep changing the approach.
>
> We are going in circles here. That you want to convert vm_insert_page
> to vmf_insert_page for the PF case is fine and understood. However,
> you don't *need* to introduce a new name for the remaining non-PF
> cases if the function is going to be the exact same thing as before.
> You say "The final goal is to remove vm_insert_page", but you haven't
> justified *why* you need to remove that name.
>
> I think I have given that answer. If we don't remove vm_insert_page,
> future #PF caller will have option to use it. But those should be
> restricted. How are we going to restrict vm_insert_page in one half
> of kernel when other half is still using it  ?? Is there any way ? ( I don't
> know)

Ah, so that is what you are concerned about: future misuses. Well, I
don't really see the problem. There are only ~18 calls to
vm_insert_page() in the entire kernel: checking if people is using it
properly for a while should be easy. As long as the new behavior is
documented properly, it should be fine. If you are really concerned
about mistakes being made, then fine, we can rename it as I suggested.

Now, the new vm_insert_range() is another topic. It simplifies a few
of the callers and buys us the rename at the same time, so I am also
OK with it.

As you see, I am not against the changes -- it is just that they
should clearly justified. :-) It wasn't clear what your problem with
the current vm_insert_page() is.

Cheers,
Miguel
