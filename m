Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7BEC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FA32088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stfBKjXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FA32088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeILTyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:54:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43398 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:54:10 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so376241ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyR9uM0oo0QzcqQCTSGpk1bUh7snJwEjrzVg8A5vW1c=;
        b=stfBKjXJMt+JsW6jtuRmOwrwemXtktO2KXfA6zm7eHpnTcar/TY3Bof3SHt87V5Xt6
         RtuakD98BkD/c4uPlupvyOoL81B+HnDRIi8qJIXRC9Ca507ttLa9hrwE/Bh6u3mBKoql
         29jLLJiDsK9tQq/IhDxBAEaBZfYSrqzUN7czfpgkGf5RCbPZ7Vt11Nn2ByJ1LlmESHNH
         LEnkXQAJeauAR0VIfWumeJLFdm8esrPJc2mvWkY2QE6W4gQeq2WgQPka3Fs3Jk6Ojevw
         ObC4ugVZZxNf8JYE+So2jjFmE154PNzF6tTovuGiW8S6+WEhFx0xu9/jyoTvD+E9PO4F
         WwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyR9uM0oo0QzcqQCTSGpk1bUh7snJwEjrzVg8A5vW1c=;
        b=ct9p5BngQi6JJl1zvA0xL4OJTJAYiWeg4Y8sXABar7RrlqnXZ2oKkmqqBcsq+paRHA
         G8QZw1k66jxQDCnIlRUVKKnOQ2500escyt9WCh3HjhMpfgwHuvDRt6v8yACenDo8X7us
         kwMuMIbftuCI/laiPejNnLxmTg+0NwEtCsQ2QyPUvdH2iZQ5ydLsuv1YrjbGMV924qhS
         wYkEY357Xfse5eW1pux78db1ciD09FLdeJpRA7wZ3WpDjO3f40/MNrWSE93vcX34fW6t
         9r5FCxDdL4zGnJQy09W87f5CdJWq4iSxtGJUoKwzO0F3ovZGCZ1dwqOKuslgKURZdzQ7
         WTJw==
X-Gm-Message-State: APzg51AhJDE0M1xrTSx3KjTUh8nRwINgMcOWIhpYqBYONiT/52yH+QXu
        KQLHrri3JmtZqGs/np0p2yM7fO5xCx7IXo/J1N4=
X-Google-Smtp-Source: ANB0Vdb/DiGIS6bCrJCVUojzEj7M0uZfAz3BoGj3tG2p+eMVwQFgxkghSH0Z50b1DnJo1hc4kvqXWyE3S8yYA+ZvKTg=
X-Received: by 2002:a5e:dd41:: with SMTP id u1-v6mr1980050iop.200.1536763758887;
 Wed, 12 Sep 2018 07:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234341.4068.26882.stgit@localhost.localdomain> <20180912141053.GL10951@dhcp22.suse.cz>
In-Reply-To: <20180912141053.GL10951@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 12 Sep 2018 07:49:06 -0700
Message-ID: <CAKgT0UdvhV7U5Zniq=KskXz2QsRP8C7ctr5=ZtJwYAVpBT-RHw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
To:     mhocko@kernel.org
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, pavel.tatashin@microsoft.com,
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

On Wed, Sep 12, 2018 at 7:10 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 10-09-18 16:43:41, Alexander Duyck wrote:
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
> >
> > In order to work around a kernel that might have CONFIG_DEBUG_VM enabled on
> > a system that has a large amount of memory I have added a new kernel
> > parameter named "page_init_poison" that can be set to "off" in order to
> > disable it.
>
> I am still not convinced that this all is worth the additional code. It
> is much better than a new config option for sure. If we really want this
> though then I suggest that the parameter handler should note the
> disabled state (when CONFIG_DEBUG_VM is on) to the kernel log. I would
> also make it explicit who might want to do that in the parameter
> description.

Anything specific in terms of the kernel log message we are looking
for? I'll probably just go with "Page struct poisoning disabled by
kernel command line option 'page_init_poison'" or something along
those lines.

> > +     page_init_poison=       [KNL] Boot-time parameter changing the
> > +                     state of poisoning of page structures during early
> > +                     boot. Used to verify page metadata is not accessed
> > +                     prior to initialization. Available with
> > +                     CONFIG_DEBUG_VM=y.
> > +                     off: turn off poisoning
> > +                     on: turn on poisoning (default)
> > +
>
> what about the following wording or something along those lines
>
> Boot-time parameter to control struct page poisoning which is a
> debugging feature to catch unitialized struct page access. This option
> is available only for CONFIG_DEBUG_VM=y and it affects boot time
> (especially on large systems). If there are no poisoning bugs reported
> on the particular system and workload it should be safe to disable it to
> speed up the boot time.

That works for me. I will update it for the next release.

Thanks.

- Alex
