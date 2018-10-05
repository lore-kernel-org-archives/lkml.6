Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630DEC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0171220875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb6wWhmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0171220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeJERAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:00:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39728 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeJERAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:00:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id p1-v6so7203412ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttp8G4BKKfjID7uMysvvCvijudgb2nk325YqHkRaptE=;
        b=nb6wWhmQ5dHII92P24XyPe4vld7Px3X+Jq5n8+9yEHmkB8vxgevnLA6OZ+uyhK9QLi
         PHf3B5K8n/1Fa/Eml8b6BNSap9P8/dB75Ole3y7rOqpxyLjUyMU2jT+KFiCDkB8cEIhr
         KhwkulVlaGcsp2rYT0c4nHKsJpbYb3ywBFcQcknOgl8W4BQVX7Buc1RUEvVPpb2Jb1z0
         oiW8oVnRIHu6IWI6XphUjt+b5lBSDqFgZ96kY7XDJEg6Wgb+Kg2B5XtEoxOEYAUHqtmy
         Y3B4xHWX8007NBIfWHrhzfbbT8aqONARCWj6hjQPvSpEuLmf6v1NZTl8CEoKzajHYuiN
         Vj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttp8G4BKKfjID7uMysvvCvijudgb2nk325YqHkRaptE=;
        b=R7gHJmAkOeRrJYkgiJzovB/ntHyU+cJlgiFDUzO00ZfwnPl3X/lwgjm8d1OOG0GyEE
         MNuXtmg7px8I9FTwGxOiZGj+q67k87zX+O/IvbHR55fJ6E8DLPEk5TdJ/T1mLTrsMXLu
         Pf5S7IdBEHPNApGlL5WOzn6zOiayY+ZQWdznaL6at4zm+LUyYydaUH3cHaNrof6BgJc8
         /mCqqfg9X4G4cukYVwIeVr/EwTKhanJptjZm2rVmZ8wPY1sZNfBUsWHM9vg1p5JzSJjR
         Mz5+Rh83nRYA2GO12Ay3dpYBbPXrAqZ+9LKKvUXzItUmtKWpJYFgP0NN6DM78gJxhKvX
         63tw==
X-Gm-Message-State: ABuFfoh9NbToPDXvlnW3T9fMBoNnv5wKrRUBX/XraUhnHP/JCcvHid7o
        V08Uarov+k4IcPYOdN6M6cSDMl9UFhRKSzSyEg4=
X-Google-Smtp-Source: ACcGV63Z6qcboFiNFa+cKMeumFiNNC3SlD5ntOI6bo3+CzpF0A6skUJKa+5WIRj415Nbh0zhYOnRqaskxGHj/SWA51E=
X-Received: by 2002:a2e:b04b:: with SMTP id d11-v6mr6566130ljl.93.1538733715682;
 Fri, 05 Oct 2018 03:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org> <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
 <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com> <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
In-Reply-To: <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 5 Oct 2018 15:31:42 +0530
Message-ID: <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
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

On Fri, Oct 5, 2018 at 2:22 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Souptick,
>
> On Fri, Oct 5, 2018 at 7:51 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Fri, Oct 5, 2018 at 1:16 AM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > >
> > > Also, not sure if you saw my comments/review: if the interface is not
> > > going to change, why the name change? Why can't we simply keep using
> > > vm_insert_page?
> >
> > yes, changing the name without changing the interface is a
> > bad approach and this can't be taken. As Matthew mentioned,
> > "vm_insert_range() which takes an array of struct page pointers.
> > That fits the majority of remaining users" would be a better approach
> > to fit this use case.
> >
> > But yes, we can't keep vm_insert_page and vmf_insert_page together
> > as it doesn't guarantee  that future drivers will not use vm_insert_page
> > in #PF context ( which will generate new errno to VM_FAULT_CODE).
> >
>
> Maybe I am hard of thinking, but aren't you planning to remove
> vm_insert_page with these changes? If yes, why you can't use the keep
> vm_insert_page name? In other words, keep returning what the drivers
> expect?

The final goal is to remove vm_insert_page by converting it to
vmf_insert_page. But to do that we have to first introduce the
new API which is similar to vm_insert_page  (for non #PF). I tried this by
introducing vm_insert_kmem_page ( * identical as vm_insert_page
except API name *) in this patch. But this looks like a bad approach.

The new proposal is to introduce vm_insert_range() ( * which might be
bit different from vm_insert_page but will serve all the non #PF use cases)
