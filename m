Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B970C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7F7214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRa/9bfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfAKCl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:41:57 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55623 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfAKCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:41:57 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so211643ith.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfMVf92gzaxzMAZMAu2AYRtnc2xIj45ckuZbtAg6QGU=;
        b=MRa/9bfdZyRjEJLIeG7zx4theoKEg2zKgAgFkxZWKncN6J87EabS6DUt0NbHO1ShdA
         5VCjc19Bfd313iZS4han3kE2BUIsu4KP2d0mnR+bdlN0tCmi2tAsGryx7UV1q55ZEDkD
         U9C9Ev40HlWbWLjIy8nxTZjhag0WOz4FJPnAsl9n+i+Rmg21C41DXjdU3LkKWbQvGoZ5
         3WdypC25V/3ydUa1q5Ec6VDvN2voHGx1GAzSo1X9dXUgjVf7YXcUqN1EqW/9Mfk/66IV
         GWlzmqJSRzdVqnTD23i7h+2jp0MH6UX79KJSD6/npLCUrRTqSlN1Be8lwtxlIH/MJl4D
         C6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfMVf92gzaxzMAZMAu2AYRtnc2xIj45ckuZbtAg6QGU=;
        b=ubKaV14HPFjvCvwv1LY+f9e6w43gsxK8zGVPKfGhy3NoRlRNP9D3i5odsstKJVR/p9
         b6/lbxpGhmU4OsChNYpK4SIqqclDm50P7R2BJfqKlg6SER+QTqUNLK8R+jylVabMQ/Sb
         r4SZFcVnRBJ9iEG8HdyiXbmfaeW5r3BWZvzSSGVBHRVMG0yjbL6PjjSwYOJ0bf/KFHqv
         jhdv/Ut2BS/KIIpo3GbljzWe7bpGOTV0s/xYbvAlLtTdjiacDwYs1k/JOOW6imYiEbLC
         vPuFMaO+qC0SBOxqq6AqC3hSuBueipUKt/aibz25bRGd8CU97U245OKNjU5F4NKORlA9
         dbpA==
X-Gm-Message-State: AJcUukdhGBjmhIJcpFBrV15KlfW3utFEgHzEaBdtBUFGvYODr0u3OIcF
        NoUh5yrdQxIRv8rlrpUv3RsMrIALFQAXoRmeAf2TYS/pQA==
X-Google-Smtp-Source: ALg8bN7Gjki6FZggg6PyH5Cia7SKfuhztuj+BXYJGNQKyxr4jO6MOJX9oHMpyEvghsT3ptD0NxppM2zcXF6UenjhjZc=
X-Received: by 2002:a24:7a94:: with SMTP id a142mr83215itc.88.1547174515528;
 Thu, 10 Jan 2019 18:41:55 -0800 (PST)
MIME-Version: 1.0
References: <1546848299-23628-1-git-send-email-kernelfans@gmail.com>
 <20190108080538.GB4396@rapoport-lnx> <20190108090138.GB18718@MiWiFi-R3L-srv>
 <20190108154852.GC14063@rapoport-lnx> <20190109142516.GA14211@MiWiFi-R3L-srv>
In-Reply-To: <20190109142516.GA14211@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 11 Jan 2019 10:41:44 +0800
Message-ID: <CAFgQCTt6YjoqfvZhEFNAvg-0_r_V5apowNAcg4SSLx1QOMSSWA@mail.gmail.com>
Subject: Re: [PATCHv5] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Baoquan He <bhe@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        kexec@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        yinghai@kernel.org, vgoyal@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 10:25 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 01/08/19 at 05:48pm, Mike Rapoport wrote:
> > On Tue, Jan 08, 2019 at 05:01:38PM +0800, Baoquan He wrote:
> > > Hi Mike,
> > >
> > > On 01/08/19 at 10:05am, Mike Rapoport wrote:
> > > > I'm not thrilled by duplicating this code (yet again).
> > > > I liked the v3 of this patch [1] more, assuming we allow bottom-up mode to
> > > > allocate [0, kernel_start) unconditionally.
> > > > I'd just replace you first patch in v3 [2] with something like:
> > >
> > > In initmem_init(), we will restore the top-down allocation style anyway.
> > > While reserve_crashkernel() is called after initmem_init(), it's not
> > > appropriate to adjust memblock_find_in_range_node(), and we really want
> > > to find region bottom up for crashkernel reservation, no matter where
> > > kernel is loaded, better call __memblock_find_range_bottom_up().
> > >
> > > Create a wrapper to do the necessary handling, then call
> > > __memblock_find_range_bottom_up() directly, looks better.
> >
> > What bothers me is 'the necessary handling' which is already done in
> > several places in memblock in a similar, but yet slightly different way.
>
> The page aligning for start and the mirror flag setting, I suppose.
> >
> > memblock_find_in_range() and memblock_phys_alloc_nid() retry with different
> > MEMBLOCK_MIRROR, but memblock_phys_alloc_try_nid() does that only when
> > allocating from the specified node and does not retry when it falls back to
> > any node. And memblock_alloc_internal() has yet another set of fallbacks.
>
> Get what you mean, seems they are trying to allocate within mirrorred
> memory region, if fail, try the non-mirrorred region. If kernel data
> allocation failed, no need to care about if it's movable or not, it need
> to live firstly. For the bottom-up allocation wrapper, maybe we need do
> like this too?
>
> >
> > So what should be the necessary handling in the wrapper for
> > __memblock_find_range_bottom_up() ?
> >
> > BTW, even without any memblock modifications, retrying allocation in
> > reserve_crashkerenel() for different ranges, like the proposal at [1] would
> > also work, wouldn't it?
>
> Yes, it also looks good. This patch only calls once, seems a simpler
> line adding.
>
> In fact, below one and this patch, both is fine to me, as long as it
> fixes the problem customers are complaining about.
>
It seems that there is divergence on opinion. Maybe it is easier to
fix this bug by dyoung's patch. I will repost his patch.

Thanks and regards,
Pingfan
> >
> > [1] http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
>
> Thanks
> Baoquan
