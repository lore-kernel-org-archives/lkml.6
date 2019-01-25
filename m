Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C88C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ECC218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYE31XaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfAYVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:20:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37125 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAYVUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:20:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so7919412wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AuShI/ZLMzIuyIFpWIZYV2dIaJN3nI2cO3Hf3dXoPA=;
        b=gYE31XaQs/N6mpZngKb6iRa2tcC954UOspCPeBL1CCs5J73VQJVLS4zC9ObIn6AcWf
         hrWTdIQHRxqZmWDht1oj6dtg6Dd6wtWyZG/g9Q7uTjhqdczsjQ5O0JErgtq0mOM20Ess
         cZCUWI7/t2VcU7+8J3AxuFvam5Sx0zrxr0LIll2gn5hSTC/jioH4xAfZVzturBI74cWP
         GYK+gg6h0qfj2JqkuwYXyFIwdB4ig5zHicIbNOJZHclTBW5KDvxPdOX/TkuAPlNiDNst
         kUspTcHJMjAIHByL8yu91MUe7/A7oFMH6y4sMflkzVfuZC++sCDgGK9hVrYXX6YbjB0Z
         PAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AuShI/ZLMzIuyIFpWIZYV2dIaJN3nI2cO3Hf3dXoPA=;
        b=llLIFrumJjA2K0+1u2MeSYcfYDDe5aJ/PjwLOJSdN6EQiUV5BL6f5kZ3gwOnvnv0Qw
         qWXBrAfvel86bd8alEwc+vFdcBR+y1RwKshxkiDzWgPl3zcQDB1IwCaCsyCphxxbypfS
         mQ/NKTFIZnuF0lpDKTSkl/fXja+4OJN/BEx6QxnIh1BNpg42kk4jGuUMuVOPJiUq4uXJ
         yW9lQ6dPRBKlQRPLcaSjeZTMxLEmnZp03IMJe9sF4lnLYAsiTI5NmNEvXmIQRcH2uRWc
         10Z41q8F/N+hsBh1wZMGoIb1swo8M3mFz3oMu5d0QbXGzjK/GazH8tYNLIqLVA+Xv6hZ
         Qfxg==
X-Gm-Message-State: AJcUukdlgwRjRVJUr0fgm7Kjz29P6btlFzjdLc7DE/dxJ/2neFt14BZC
        RV+4ly/vPa5uXK/OaFX4mHR2EtC+6hECuLCcsXybUFYcbQ==
X-Google-Smtp-Source: ALg8bN6EdE6TpDEV7m3+3V8X9LXezFN+6KYlM3bDM8zvOhfMdVlhxvm8+vry9ShrZwpuRdrUVENiKew7WK/Xge2rXpA=
X-Received: by 2002:a1c:5984:: with SMTP id n126mr7962569wmb.62.1548451210486;
 Fri, 25 Jan 2019 13:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231442.EFD29EE0@viggo.jf.intel.com>
 <CAErSpo7kMjfi-1r8ZyGbheWzo+JCFkDZ1zpVhyNV7VVy8NOV7g@mail.gmail.com> <4898e064-5298-6a82-83ea-23d16f3dfb3d@intel.com>
In-Reply-To: <4898e064-5298-6a82-83ea-23d16f3dfb3d@intel.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 25 Jan 2019 15:19:58 -0600
Message-ID: <CAErSpo5pAQs-SJRKc-ie15zpSqf9FsPWnHeSpggU-EeZDg=AYQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/resource: return real error codes from walk failures
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>,
        Jerome Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 3:10 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/25/19 1:02 PM, Bjorn Helgaas wrote:
> >> @@ -453,7 +453,7 @@ int walk_system_ram_range(unsigned long
> >>         unsigned long flags;
> >>         struct resource res;
> >>         unsigned long pfn, end_pfn;
> >> -       int ret = -1;
> >> +       int ret = -EINVAL;
> > Can you either make a similar change to the powerpc version of
> > walk_system_ram_range() in arch/powerpc/mm/mem.c or explain why it's
> > not needed?  It *seems* like we'd want both versions of
> > walk_system_ram_range() to behave similarly in this respect.
>
> Sure.  A quick grep shows powerpc being the only other implementation.
> I'll just add this hunk:
>
> > diff -puN arch/powerpc/mm/mem.c~memory-hotplug-walk_system_ram_range-returns-neg-1 arch/powerpc/mm/mem.c
> > --- a/arch/powerpc/mm/mem.c~memory-hotplug-walk_system_ram_range-returns-neg-1  2019-01-25 12:57:00.000004446 -0800
> > +++ b/arch/powerpc/mm/mem.c     2019-01-25 12:58:13.215004263 -0800
> > @@ -188,7 +188,7 @@ walk_system_ram_range(unsigned long star
> >         struct memblock_region *reg;
> >         unsigned long end_pfn = start_pfn + nr_pages;
> >         unsigned long tstart, tend;
> > -       int ret = -1;
> > +       int ret = -EINVAL;
>
> I'll also dust off the ol' cross-compiler and make sure I didn't
> fat-finger anything.

Sounds good.  Then add my

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
