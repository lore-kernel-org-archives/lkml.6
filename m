Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BE7C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A6B2064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV6mOQiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A6B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeJERsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:48:07 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:36211 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeJERsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:48:07 -0400
Received: by mail-qt1-f176.google.com with SMTP id u34-v6so13250886qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/WC9PR0SsRfsVv/Ruor5wKfCcU9I0tyzAaQtBCuP/U=;
        b=TV6mOQiVDUHO3O/yKwRI1H90B5I5k7NUut/BiIm8rpOvkmdUbhLXoaM6zyNW/dezuM
         UjvpQhoF6vnhmImEGrjsYs6DTjWZj6pXf1/tEWpz1W5ozTEzcgJLsaojlJ3CEQt+LBcQ
         xSrxhI0T3P/j8wHTPl6Ey19PsIbPReL+0yfMwe+qr8rYWfBGSet5pp7NccPiECU7E7nC
         dEa5BDBU9LBHqeMBWPAxRPirlFF6LI1/q90o/rMhYvw1h6nMMRBWDiD7qQa/U0qel32Y
         LC0U5+U2Pm0Htw/3vi6TnI5WqNldudeVBrNsZbBRFPJ8yqOxO1RyiWEIsuOcOfKxDyX1
         pSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/WC9PR0SsRfsVv/Ruor5wKfCcU9I0tyzAaQtBCuP/U=;
        b=rdV8mRp/Dw70KmmuQiVJZPlOSTKxJl7LbpuCZyoY/A8xkxsMUDdCSYDRnYm/VWr3yk
         QGztV753siMy4FJ3tQcFhik7N1tq409HyRNjuQKXW6iepYxTXhtaqjIFI5AWmlS8g/od
         gSSHczNiYVsxtlXFp23YuVngJpBqvAEDoq85ZQwKdvC9vneoljoB7brj14+iX8u8snHD
         ECGoWc9VDtDA7e6zJO8hIJc6kryuRCY7XX2PRTecoABlswbQxLORIzlAcKGJObjCOFCW
         2EXu1OS4dhhl/myaaBDmmOaZvXSWaW08aqB6UTXIztH+wTgVi+bQTGHG/YDsU0hOnfdJ
         31Ew==
X-Gm-Message-State: ABuFfogQIFVEBi3OYF3MikD8NfSkCGEqe1OSOhEFUTFvOzBe8g1WMeqX
        1UYDVluTsrcx6ZlqDT4cBlsGB6hGg52DlyWZYaM=
X-Google-Smtp-Source: ACcGV62QUdWVdvDIp0c7zpbBp/3LtJ4FbjSm31obIvKB44t1Xb1sU5z3G1KAk7q2LSH6HBFkqNdmoNZt/bUu+F3nGTk=
X-Received: by 2002:a0c:aedd:: with SMTP id n29-v6mr8830842qvd.10.1538736592274;
 Fri, 05 Oct 2018 03:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org> <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
 <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com> <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
In-Reply-To: <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 Oct 2018 12:49:41 +0200
Message-ID: <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
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

Hi Souptick,

On Fri, Oct 5, 2018 at 12:01 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> The final goal is to remove vm_insert_page by converting it to
> vmf_insert_page. But to do that we have to first introduce the
> new API which is similar to vm_insert_page  (for non #PF). I tried this by
> introducing vm_insert_kmem_page ( * identical as vm_insert_page
> except API name *) in this patch. But this looks like a bad approach.

We are going in circles here. That you want to convert vm_insert_page
to vmf_insert_page for the PF case is fine and understood. However,
you don't *need* to introduce a new name for the remaining non-PF
cases if the function is going to be the exact same thing as before.
You say "The final goal is to remove vm_insert_page", but you haven't
justified *why* you need to remove that name.

Now, if we want to rename the function for some reason (e.g. avoid
confusion with vmf_insert_page), that is fine but is another topic. It
may be or not a good idea, but it is orthogonal to the vmf_ work.
Matthew, on this regard, told you that you shouldn't duplicate
functions. If you want a rename, do so; but don't copy the code. In
other words: nobody said introducing the vm_insert_kmem_page name is a
bad idea -- what Matthew told you is that *duplicating* vm_insert_page
just for that is bad.

Further, you are copying the code (if I understand your thought
process) because you want to change the callers of non-PF first, and
then do the "full conversion from vm_* to vmf_*". However, that is
confusing, because there is no need to change non-PF callers of
vm_insert_page since they don't care about the new vmf_* functions.

Instead, the proper way of doing this is:

  1. Introduce the vmf_* API
  2. Change all PF-users users to that (leaving all non-PF ones
untouched!) -- if this is too big, you can split this patch into
several patches, one per subsystem, etc.
  3. Remove the vm_* functions (except the ones that are still used in
non-PF contexts, e.g. vm_insert_page)

Then, optionally, if you want to rename the function for the remaining
non-PF users:

  4. Rename vm_insert_page (justifying why the current name is
confusing *on its own merits*).

Otherwise, if you want to pursue Matthew's idea:

  4. Introduce the vm_insert_range (possibly leveraging
vm_insert_page, or not; you have to see what is best).
  5. Replace those callers that can take advantage of vm_insert_range
  6. Remove vm_insert_page and replace callers with vm_insert_range
(only if it is not worth to keep vm_insert_range, again justifying it
*on its own merits*)

As you see, these are all logical step-by-step improvements, without
duplicating functions temporarily, leaving temporary changes or
changing current callers to new APIs for unrelated reasons (i.e. no
need to introduce vm_insert_kmem_page simply to do a "conversion" to
vmf_).

Cheers,
Miguel
