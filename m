Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CADC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C752F208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeOw5gzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C752F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeJEPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:50:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45897 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbeJEPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:50:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id e10-v6so1906426qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJWHjNXWemoMUJn75+cUAAvlfbLu23chzrXcnTQoDqM=;
        b=VeOw5gzB/nAC6zeqj/iQMfHnPqlvhFclvss5eCp6bD8wKSgIafZvbf69yZwv9N0hwt
         FmqglPGYn5RUbzMSPjtcMAUDRFIMRxY5QYOoVcQ1eTAqL++MQRC5+3L2p4AJNQlnDUU1
         ktGU6OfoABTAtNHAD//1jTAZu5ZurwLNlMuTjHV7UYjfTaeRcVpO0VeqRb53F8MEaFSa
         lapMPwwLGV1Ug29Ok4PLe4VrQxZIxgbxYVuLHFF7uy4T+fyaCHWU5RJ9bgAJXbsq9jnV
         NpGDP4wdPH9dKlK8UEvUe0e12XOmcRr83IJm8uJbf9EV7Ttb9intRxhjRHJH9oxyCQQF
         K/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJWHjNXWemoMUJn75+cUAAvlfbLu23chzrXcnTQoDqM=;
        b=ZagNJOftyLtori0GklsbpFbjnh8yEuYRW4QHl1jHEc+DthqHKQmA7lTMNznyMkknpM
         me+ml7Q/0GiL88SO/bk2y8pjTLVRXmNAaNJA7qUKTGGYLVNSDERD8Upx1RK6qxRnA3D6
         B3SxpaaSSFosJg/8/cE3YaeiHuZSgZSYlSDXSVMrl5Y/6tVPV97FDR/0mffnZPXZ6kZP
         Zqy/1fkqBNSVA4LUR5HR1BW1MYPRHksICxklt0ZfgdcdBPpq2s7CYxxD5f77F9fXATLD
         w43j511dNw507AnY/TV0SxwWgr1toI6NCgIkD8BP7dM/pbKChRQ4y3RpWBq2VG/6U0hT
         J3Pg==
X-Gm-Message-State: ABuFfojyLVDBTsP6EKbnuin4UzzKeaGrS/4aQGZlffLR9MddD0ppSB89
        qWcVEd3/49ajNyQcpE6Fcf0ZzDbDD9W+Cv1edH8=
X-Google-Smtp-Source: ACcGV61I+XpPLtRQ5/hjxUlXyAp0BC1t5Wap5hc3EStiqekiUER0dzD0UOmCdJsu5w6pGzLAx2IbY5Mhr5iaE6MhbsI=
X-Received: by 2002:ac8:34ce:: with SMTP id x14-v6mr8596923qtb.115.1538729540503;
 Fri, 05 Oct 2018 01:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org> <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com> <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
In-Reply-To: <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 Oct 2018 10:52:09 +0200
Message-ID: <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
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

On Fri, Oct 5, 2018 at 7:51 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Oct 5, 2018 at 1:16 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> >
> > Also, not sure if you saw my comments/review: if the interface is not
> > going to change, why the name change? Why can't we simply keep using
> > vm_insert_page?
>
> yes, changing the name without changing the interface is a
> bad approach and this can't be taken. As Matthew mentioned,
> "vm_insert_range() which takes an array of struct page pointers.
> That fits the majority of remaining users" would be a better approach
> to fit this use case.
>
> But yes, we can't keep vm_insert_page and vmf_insert_page together
> as it doesn't guarantee  that future drivers will not use vm_insert_page
> in #PF context ( which will generate new errno to VM_FAULT_CODE).
>

Maybe I am hard of thinking, but aren't you planning to remove
vm_insert_page with these changes? If yes, why you can't use the keep
vm_insert_page name? In other words, keep returning what the drivers
expect?

Cheers,
Miguel
