Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC2C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB01220833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdQxBElt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB01220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeILVty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:49:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53743 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:49:53 -0400
Received: by mail-it0-f68.google.com with SMTP id p79-v6so3948371itp.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OB7AoDPEbx16N2FTuQjUMhquk4mNQQxLjBjCTqR7wL8=;
        b=YdQxBEltGXq7O/4VT6w1sZPgIIACN56ojAK6YAk8v60GSVTtI7UZvy09AXXegk6eGp
         MR863XkuEDU3cNy3V5AKYihJG/h1r1dtiQm1BM813oD4nJUWpbRYQiLn0QPPHIuve2zO
         i8tYHCYSeJobfek9EJNvp7e/Rxb2WfJNexpaj8pNUJc4ZenIy02MhcRg2j/XFqzXyAeo
         1IMFqEvTynF17u4rprb2F1wF+Q9DIkw/07CA7ig4ZLCFlSsck92a4BkL6n/st0vk/fDR
         ZWbQ9PZvCqpUCDX0MjVjTL46v9/6JqU4VCqaAmpkxbHrb59u3OSWDNyUPVdxlZuBdlwT
         AK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OB7AoDPEbx16N2FTuQjUMhquk4mNQQxLjBjCTqR7wL8=;
        b=qGIt1aIU8fOA+kMnOqLDVw30eov++TrR0kZsBiJCFilkqQ1XwtNQItnfm5M0il9ApW
         uUgG/wOJEmMUkH8Sar1qFpfhLl76EAFpdYRmCqB6eVSevz1dhqw0eJRYDSIigZDy+VR7
         Fp/QofbSj1TAPq6Sf6qZHWzlVsP4j3hMC/5HLmp5Y9iIJCz2l52aD7/ZYpY77d+f0yN4
         QqsJDRmY5WekIudEUyhi2a+MrvTLCYz2G+Eke0KG+S85AHfbs6g82cvoa6LCFxbPf4oc
         kleKsSsOnFIf/dAKw4IrsI8NLmVvzvLfXDYKbtSILwcP/pEKe6FHHsoVkSyE8ZtR9Iu9
         QnKA==
X-Gm-Message-State: APzg51AqYz0lVmufelb3KLlaPdZarYLkflgZ6KhYPoNa9+zUaEx3Vkez
        OPfWcCyCBMGBZW3/i7oja979I1mbxWskMMoCTfs=
X-Google-Smtp-Source: ANB0VdaDM8iDa7B96smGYRSVXjWbDNfvAzcILSoE2KUhUnsk+Bi8omiDEYg1A5/9SCmH5VeZUIVOWmKcor/qJrSBNBM=
X-Received: by 2002:a24:c2c2:: with SMTP id i185-v6mr2962254itg.76.1536770671233;
 Wed, 12 Sep 2018 09:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234354.4068.65260.stgit@localhost.localdomain> <7b96298e-9590-befd-0670-ed0c9fcf53d5@microsoft.com>
 <CAKgT0UdKZVUPBk=rg5kfUuFBpuZQEKPuGw31x5O2nMyuULgi0g@mail.gmail.com> <4d520227-52d3-6cd0-11d8-9be534097ea5@microsoft.com>
In-Reply-To: <4d520227-52d3-6cd0-11d8-9be534097ea5@microsoft.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 12 Sep 2018 09:44:19 -0700
Message-ID: <CAKgT0Uf7Wo3JdrMub-NFv3RXJx6+vT4MVXzyQwh1v+JMbK2VgA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Pavel.Tatashin@microsoft.com
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>,
        dave.jiang@intel.com, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, jglisse@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>, logang@deltatee.com,
        dan.j.williams@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:54 AM Pasha Tatashin
<Pavel.Tatashin@microsoft.com> wrote:
>
>
>
> On 9/12/18 11:48 AM, Alexander Duyck wrote:
> > On Wed, Sep 12, 2018 at 6:59 AM Pasha Tatashin
> > <Pavel.Tatashin@microsoft.com> wrote:
> >>
> >> Hi Alex,
> >
> > Hi Pavel,
> >
> >> Please re-base on linux-next,  memmap_init_zone() has been updated there
> >> compared to mainline. You might even find a way to unify some parts of
> >> memmap_init_zone and memmap_init_zone_device as memmap_init_zone() is a
> >> lot simpler now.
> >
> > This patch applied to the linux-next tree with only a little bit of
> > fuzz. It looks like it is mostly due to some code you had added above
> > the function as well. I have updated this patch so that it will apply
> > to both linux and linux-next by just moving the new function to
> > underneath memmap_init_zone instead of above it.
> >
> >> I think __init_single_page() should stay local to page_alloc.c to keep
> >> the inlining optimization.
> >
> > I agree. In addition it will make pulling common init together into
> > one space easier. I would rather not have us create an opportunity for
> > things to further diverge by making it available for anybody to use.
> >
> >> I will review you this patch once you send an updated version.
> >
> > Other than moving the new function from being added above versus below
> > there isn't much else that needs to change, at least for this patch. I
> > have some follow-up patches I am planning that will be targeted for
> > linux-next. Those I think will focus more on what you have in mind in
> > terms of combining this new function
>
> Hi Alex,
>
> I'd like see the combining to be part of the same series. May be this
> patch can be pulled from this series and merged with your upcoming
> patches series?
>
> Thank you,
> Pavel

The problem is the issue is somewhat time sensitive, and the patches I
put out in this set needed to be easily backported. That is one of the
reasons this patch set is as conservative as it is.

I was hoping to make 4.20 with this patch set at the latest. My
follow-up patches are more of what I would consider 4.21 material as
it will be something we will probably want to give some testing time,
and I figure there will end up being a few revisions. I would probably
have them ready for review in another week or so.

Thanks.

- Alex
