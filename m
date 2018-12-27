Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E2CC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475A7218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+2m4e4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeL0C5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:57:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36078 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0C5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:57:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so14322412edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKQTIZOHtW8ffxErHOxVgcrRWqvLiNdZTXKdv5GszKU=;
        b=H+2m4e4dUs2NStwlS0hNRqDW2kNZIKr0QiDZbzwa7QrQDDrGpHrDHp0zQMhgOA3mZa
         vmXbW+d9hrltuJFXIAoxcrAQ7k5Rs9FPmL8tRs60/9A5mqcqBuRb848DMy+7p+knRDTc
         WBt4SZJjIWQ/ECMFPaWUYCj7a8GEWe7TcPDFikUgtNSTI6Fy1ohNNCxUXNsYVcyXrjzt
         QZA/i4iqHnNd5fwrtUlZri1s8OcbTRosZ6gC9m/LSHOPBhe3Ecb3QAU0LYBsMfzv9Aqa
         SpdW72rhHFiXcIVQ0NbiqmkAa6q5Wx/CfUsZmtfAFym8UUtaLaFuvf8DG6tF4zZk9Jjo
         5ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKQTIZOHtW8ffxErHOxVgcrRWqvLiNdZTXKdv5GszKU=;
        b=jyvzMPgco1q8TNAXkz1PzIlr5Fc8jefNKYuhaUmdMffnuLToO+rBR9eqmspYc+3zn8
         XnYPS5G9lbVJSmTnwLuJUATUhPC/W6FlzfieY6gO7HRtqMyuYq/KGvKhQoO59ufQmQ0L
         RlWaUFbszfcaXihsAteI2pUG7tjatc9qN4YZNMjM84suDL/Sv7nddIFN5Ajd7/ulUvx2
         6OBzjEeOWpWzvGxf+7uj5YN/nvDkRCKtvdWVqwWFBIjRUuPR+JvDNIASeKglKVdhl6U1
         wKYaKHYo5Lol7oKoGRDzGGEPFtdisKJSZ+zGZSC5IMNPrerPUyQMlHQ3fIJQmDHRY772
         +9hQ==
X-Gm-Message-State: AA+aEWYBGWEO2xjv03Y+42ueDUUQ6+gvncZNUHftA7sRMTmxrTvjlZY4
        VAYe7c10pD5ZvVYAdkNNnwCtTO4UXmJyufNphg==
X-Google-Smtp-Source: AFSGD/XtHFKn4kDyEZN6q8HVJOLIljvc5tPo+g6X6lq6NAdQq+bFPvJ910kno6zkzXg7UkcdqOmZpVtsTreRnXOikTo=
X-Received: by 2002:a17:906:2acf:: with SMTP id m15-v6mr14416497eje.180.1545879457523;
 Wed, 26 Dec 2018 18:57:37 -0800 (PST)
MIME-Version: 1.0
References: <1544760446-506-1-git-send-email-kernelfans@gmail.com> <20181226014701.GD11472@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20181226014701.GD11472@dhcp-128-65.nay.redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 27 Dec 2018 10:57:26 +0800
Message-ID: <CAFgQCTtEMw9f9H-nMAEntwLkNLTP9s9zpoNLvx+cK_hquXTA4A@mail.gmail.com>
Subject: Re: [PATCHv2] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 9:47 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 12/14/18 at 12:07pm, Pingfan Liu wrote:
> > Customer reported a bug on a high end server with many pcie devices, where
> > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > though we still see much memory under 896 MB, the finding still failed
> > intermittently. Because currently we can only find region under 896 MB,
> > if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > why failure is found. It raises confusion to the end user that sometimes
> > crashkernel=X works while sometimes fails.
> > If want to make it succeed, customer can change kernel option to
> > "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> > limited space to behave even though its grammer looks more generic.
> > And we can't answer questions raised from customer that confidently:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> >
> > This patch simplifies the method suggested in the mail [1]. It just goes
> > bottom-up to find a candidate region for crashkernel. The bottom-up may be
> > better compatible with the old reservation style, i.e. still want to get
> > memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> >
> > There is one trivial thing about the compatibility with old kexec-tools:
> > if the reserved region is above 896M, then old tool will fail to load
> > bzImage. But without this patch, the old tool also fail since there is no
> > memory below 896M can be reserved for crashkernel.
> >
> > [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: kexec@lists.infradead.org
> >
> > ---
> > v1->v2:
> >   improve commit log
> >  arch/x86/kernel/setup.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index d494b9b..60f12c4 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
> >
> >       /* 0 means: find the address automatically */
> >       if (crash_base <= 0) {
> > +             if (!memblock_bottom_up())
> > +                     memblock_set_bottom_up(true);
> >               /*
> >                * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> >                * as old kexec-tools loads bzImage below that, unless
> >                * "crashkernel=size[KMG],high" is specified.
> >                */
> >               crash_base = memblock_find_in_range(CRASH_ALIGN,
> > -                                                 high ? CRASH_ADDR_HIGH_MAX
> > -                                                      : CRASH_ADDR_LOW_MAX,
> > -                                                 crash_size, CRASH_ALIGN);
> > +                     (max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
> > +             if (!memblock_bottom_up())
> > +                     memblock_set_bottom_up(false);
>
> The previous memblock_set_bottom_up(true) set it as true, so
> "!memblock_bottom_up()" is impossible, not sure what is the point of
> this condition check.
>
> Do you want to restore the original memblock direction? If so a variable
> to save the old direction is needed.  But is this really necessary?
> Do you know any side effects of setting the bottom up as true?
>
Yes, will fix it.

Thanks
> > +
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
> Thanks
> Dave
