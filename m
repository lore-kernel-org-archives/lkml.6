Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD33C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6583627A0E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cH1g+vE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6583627A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935443AbeF1WRA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:17:00 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37487 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933153AbeF1WQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:16:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6-v6so6958011wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Wg6EPR8kROalNpK3m966bmvq/1vI0FypjbSKpnUJTM=;
        b=cH1g+vE8/vgNi7ceSWtNDTspZ/uLCz5lmop8rE+O1D1ICUWCSA53rlDZBbaUWG7W7s
         q6fa1dI+PCwRmt6KdqvHokLFGRaYYhteJ7GYYhA+HVvVxmPzQVQcckKd/AB8azlp/k2a
         M8kh6cvjv5q0ETmE85HsmX8MM0Uufa1CHPG5YFgNvlSujGra+JDKYqwf05YFhQpwDgBG
         /tjRStqf+QQoDw/g2jwr8pgdSEW2Q8KXnw0cd49rdUEVMDm/RPtJM2WTXje38t2fuKA6
         u4ZkuFKljH5j9paNk4qzrfxi4179iuabvFiNF4cW2zg2XsXIhtLzli3mf6TY7A2vVoAg
         hygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Wg6EPR8kROalNpK3m966bmvq/1vI0FypjbSKpnUJTM=;
        b=GQrN3wq2aK9F676pzg9l/Bk0TlDYPLEVN0y5T42VFJAsDDg5qsftar15PtNpwQg5Tj
         PIGWMkbu3+nCNKhfSxO5jKIYj2Lz862cKYRicTLnhbYlahelP4R3szGzGwph3v9ZA0rs
         EkzTIAydg2HyKZL4tHPA1gSfxfDIgWE/MzFeiIwBU5s7t8q9WLs3kkAwU9dLBzjtGYTE
         VnpHRfnxB7jLw7tENce2jRWpOkxygpl8RY8JKgK0YPbnSCDkUd1yHfh2pcmkpWCEkwkY
         4Y3pjRdxoj5ZN2T0JdsuMAuvIH2J2+YRkkVjX6py1z5ptWNxDkrDlyJj/CIXNYzUi5Ba
         SDdw==
X-Gm-Message-State: APt69E1b56ZovzLFNfupErlp7CX7P39UteKElNfftMvXcabbXEQrDfuW
        SsZAQWtyslBL0DKgSAs5Lpbbe9iSl9i52AIGaXniAA==
X-Google-Smtp-Source: AAOMgpd6hbOsYm4taA8Iadg7vyqoC4BLLuWxUMZyma7gjpm+X7LjtsM/kRczx1FO+53QTdG1OmFEXgbR2N8qYdWh7Ik=
X-Received: by 2002:adf:b310:: with SMTP id j16-v6mr9752001wrd.207.1530224217727;
 Thu, 28 Jun 2018 15:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180627214447.260804-1-cannonmatthews@google.com> <20180628112139.GC32348@dhcp22.suse.cz>
In-Reply-To: <20180628112139.GC32348@dhcp22.suse.cz>
From:   Cannon Matthews <cannonmatthews@google.com>
Date:   Thu, 28 Jun 2018 15:16:46 -0700
Message-ID: <CAJfu=Uc8zkN1fc73_UtiREW061xakrnMNP27oV5i3AreP1XS+w@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb: yield when prepping struct pages
To:     mhocko@kernel.org, mike.kravetz@oracle.com
Cc:     akpm@linux-foundation.org, nyc@holomorphy.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the quick turnaround.

Good to know about the how the 2M code path differs, I have been
trying to trace through some of this and it's easy to get lost between
which applies to which size.

Thanks!
On Thu, Jun 28, 2018 at 12:03 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 27-06-18 14:44:47, Cannon Matthews wrote:
> > When booting with very large numbers of gigantic (i.e. 1G) pages, the
> > operations in the loop of gather_bootmem_prealloc, and specifically
> > prep_compound_gigantic_page, takes a very long time, and can cause a
> > softlockup if enough pages are requested at boot.
> >
> > For example booting with 3844 1G pages requires prepping
> > (set_compound_head, init the count) over 1 billion 4K tail pages, which
> > takes considerable time. This should also apply to reserving the same
> > amount of memory as 2M pages, as the same number of struct pages
> > are affected in either case.
> >
> > Add a cond_resched() to the outer loop in gather_bootmem_prealloc() to
> > prevent this lockup.
> >
> > Tested: Booted with softlockup_panic=1 hugepagesz=1G hugepages=3844 and
> > no softlockup is reported, and the hugepages are reported as
> > successfully setup.
> >
> > Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
>
> > ---
> >  mm/hugetlb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a963f2034dfc..d38273c32d3b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2169,6 +2169,7 @@ static void __init gather_bootmem_prealloc(void)
> >                */
> >               if (hstate_is_gigantic(h))
> >                       adjust_managed_page_count(page, 1 << h->order);
> > +             cond_resched();
> >       }
> >  }
> >
> > --
> > 2.18.0.rc2.346.g013aa6912e-goog
>
> --
> Michal Hocko
> SUSE Labs
