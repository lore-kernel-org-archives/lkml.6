Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E14DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69F62077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV5vWuzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69F62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIEUDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:03:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37255 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIEUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:03:00 -0400
Received: by mail-io0-f195.google.com with SMTP id v14-v6so6313386iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjLH9ciHOhwbLWgGqp0p3xuGDB4/F6sB1OcWP6uNQCc=;
        b=rV5vWuzcfNpeh6lJ+rtg0fGiJGUMPIvfyvJEO94DsUz7EzlEDWTZ7gXBsfU57XfQQC
         S1IOaRHkj8BQ6FbGQjv2Zx8eP3NjOYC0S8eCXjRCJfsTZLa7v+DlZZkkyyOiiUcx7LlH
         ENKRLavg269HMlZzG7NzHYmjuj2KuMPN7zgeDtV9JHnrNGzAzrD9TocgHaOzAjkek9xZ
         ZvFAGxNAdrpwDOgZLmJ7dn0x8SUl9b6Ul/lJO2xerJVV6gfAUXwLkVX5kd0lSShEs1ui
         kPAUZ2ZbfwyxrCit2gXQvnycKLZtTl+0kuy4Dtgf902hql21UosH2cwrvk/9ZGHdzvZR
         NFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjLH9ciHOhwbLWgGqp0p3xuGDB4/F6sB1OcWP6uNQCc=;
        b=uOkv1sRJhtjSmA/h1DtKp8aqYnClAUCOJ4vp7kvWu3+k2gxUWVIg7EZMIqZ29Hwxn4
         dVdiRamIkdk5ejEBLFt8mZyghGnd3PGM19OSdp0WMvKn7/xJt+HBntIGizTeSx6sZW4X
         ALW9ErpX3Pw0VNHK6vqEbE9TUZP/6iGdDuLNnyp4Amr0fW0nIUrzj6nYSZ0tBkZQU+30
         qfpquIDXOqvIDmPWnNv8R+y52NFOJTzU0A6+Cy51jc0T25w5CWhEK+6ztDii6S1Pn2/8
         0/uklsCAqE8mHog0WV8TAjNDLpkSQNr3IRdoudYjd4mRBQtLZqP5DsWseFYVwVFKkMBo
         1X/g==
X-Gm-Message-State: APzg51BCmDd4o6OoFgKukLq4jeNivJBUBK+BANEox/MjBDNTK9IIOGT0
        QN78BMGEdb2rVLtPBRq79JbTK6ieowgJFk892kQ=
X-Google-Smtp-Source: ANB0VdYYBFi5C2xEDgCp9QNQjfBxjkfu9oVSMCZOzvHoSnoN0cGISQkIlK2Z0TMxp4L+rbuGMkWQzrqyB4tRGkV2FKI=
X-Received: by 2002:a6b:5911:: with SMTP id n17-v6mr26900599iob.68.1536161537537;
 Wed, 05 Sep 2018 08:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183339.4416.44582.stgit@localhost.localdomain> <20180905061044.GT14951@dhcp22.suse.cz>
In-Reply-To: <20180905061044.GT14951@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 5 Sep 2018 08:32:05 -0700
Message-ID: <CAKgT0Uc3vV_knsA6rcbD2m02--+QGVZA=_=mJnTyB8b+xpUCAw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Move page struct poisoning from CONFIG_DEBUG_VM
 to CONFIG_DEBUG_VM_PGFLAGS
To:     mhocko@kernel.org
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        pavel.tatashin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 11:10 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 04-09-18 11:33:39, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > On systems with a large amount of memory it can take a significant amount
> > of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> > value. I have seen it take over 2 minutes to initialize a system with
> > over 12GB of RAM.
> >
> > In order to work around the issue I had to disable CONFIG_DEBUG_VM and then
> > the boot time returned to something much more reasonable as the
> > arch_add_memory call completed in milliseconds versus seconds. However in
> > doing that I had to disable all of the other VM debugging on the system.
>
> I agree that CONFIG_DEBUG_VM is a big hammer but the primary point of
> this check is to catch uninitialized struct pages after the early mem
> init rework so the intention was to make it enabled on as many systems
> with debugging enabled as possible. DEBUG_VM is not free already so it
> sounded like a good idea to sneak it there.
>
> > I did a bit of research and it seems like the only function that checks
> > for this poison value is the PagePoisoned function, and it is only called
> > in two spots. One is the PF_POISONED_CHECK macro that is only in use when
> > CONFIG_DEBUG_VM_PGFLAGS is defined, and the other is as a part of the
> > __dump_page function which is using the check to prevent a recursive
> > failure in the event of discovering a poisoned page.
>
> Hmm, I have missed the dependency on CONFIG_DEBUG_VM_PGFLAGS when
> reviewing the patch. My debugging kernel config doesn't have it enabled
> for example. I know that Fedora configs have CONFIG_DEBUG_VM enabled
> but I cannot find their config right now to double check for the
> CONFIG_DEBUG_VM_PGFLAGS right now.
>
> I am not really sure this dependency was intentional but I strongly
> suspect Pavel really wanted to have it DEBUG_VM scoped.

So I think the idea as per the earlier discussion with Pavel is that
by preloading it with all 1's anything that is expecting all 0's will
blow up one way or another. We just aren't explicitly checking for the
value, but it is still possibly going to be discovered via something
like a GPF when we try to access an invalid pointer or counter.

What I think I can do to address some of the concern is make this
something that depends on CONFIG_DEBUG_VM and defaults to Y. That way
for systems that are defaulting their config they should maintain the
same behavior, however for those systems that are running a large
amount of memory they can optionally turn off
CONFIG_DEBUG_VM_PAGE_INIT_POISON instead of having to switch off all
the virtual memory debugging via CONFIG_DEBUG_VM. I guess it would
become more of a peer to CONFIG_DEBUG_VM_PGFLAGS as the poison check
wouldn't really apply after init anyway.

- Alex
