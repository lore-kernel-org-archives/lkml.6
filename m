Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AEEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B4521479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544123993;
	bh=lyVAKEyUgaA0R8m2RXj5eSGRNXKTao2ItAdsMCdAxdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RwaoR8v3gXXSFBAoMHOscuhSJ/zIoXh+quTwlvoqryoOr0V0e9bjpeQSFrVnAgSz0
	 yIVyjvLcqfY4ZwxWzUx/ohtJCpaylTOCOQX2NIFqnrtMzT0T5MrST9+hItayuIi2Wf
	 GKPdN24nSup+mDmAIwwqRudluhgX5zXGmKhYjBxQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B4521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLFTTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFTTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 14:19:52 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488602154B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544123990;
        bh=lyVAKEyUgaA0R8m2RXj5eSGRNXKTao2ItAdsMCdAxdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0Kdbq365s5oxK2Qaxv7gQQSFO2BWtmeeWJxYLy//3Dt5bCXRSksKOeHSBR+J9fyXK
         R1D6eocxd4PefDad7udwbPaQIvuM2YUFRIWhK5XsIRC1lBcTD/moK9uvS493pxbnDz
         vIWVvuIfou6S9qX9we1wePzONiBWJvuZmH0yr7dY=
Received: by mail-wm1-f51.google.com with SMTP id z18so2102643wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 11:19:50 -0800 (PST)
X-Gm-Message-State: AA+aEWZvdcLG3RYYtSsJKWe55E4xr+bTOT8UDBhC1Sd2uplNUShDWsNN
        FgG44AW0PqyIx1vKyr+adDu8XgLXQ+w3WdTPa2JXfA==
X-Google-Smtp-Source: AFSGD/Wp3A8BNUEt7cKl+ZPbshxN30LexpX3o08cUpv2xwsxJ5hbayUK3GsELLqlUXwPFKcYCgfuUqxkNz4FzdFOdlU=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr16724744wmd.83.1544123988638;
 Thu, 06 Dec 2018 11:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com> <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
 <20181205114148.GA15160@arm.com> <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
 <CAKv+Gu_EEjhwbfp1mdB0Pu3ZyAsZgNeaCDArs569hAeWzHMWpw@mail.gmail.com>
 <CALCETrVedB7yacMU=i3JaUZxiwsnM+PnABfG48K9TZK32UWshA@mail.gmail.com> <20181206190115.GC10086@cisco>
In-Reply-To: <20181206190115.GC10086@cisco>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 11:19:36 -0800
X-Gmail-Original-Message-ID: <CALCETrUmxht8dibJPBbPudQnoe6mHsKocEBgkJ7O1eFrVBfekQ@mail.gmail.com>
Message-ID: <CALCETrUmxht8dibJPBbPudQnoe6mHsKocEBgkJ7O1eFrVBfekQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jann Horn <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 11:01 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Thu, Dec 06, 2018 at 10:53:50AM -0800, Andy Lutomirski wrote:
> > > If we are going to unmap the linear alias, why not do it at vmalloc()
> > > time rather than vfree() time?
> >
> > That=E2=80=99s not totally nuts. Do we ever have code that expects __va=
() to
> > work on module data?  Perhaps crypto code trying to encrypt static
> > data because our APIs don=E2=80=99t understand virtual addresses.  I gu=
ess if
> > highmem is ever used for modules, then we should be fine.
> >
> > RO instead of not present might be safer.  But I do like the idea of
> > renaming Rick's flag to something like VM_XPFO or VM_NO_DIRECT_MAP and
> > making it do all of this.
>
> Yeah, doing it for everything automatically seemed like it was/is
> going to be a lot of work to debug all the corner cases where things
> expect memory to be mapped but don't explicitly say it. And in
> particular, the XPFO series only does it for user memory, whereas an
> additional flag like this would work for extra paranoid allocations
> of kernel memory too.
>

I just read the code, and I looks like vmalloc() is already using
highmem (__GFP_HIGH) if available, so, on big x86_32 systems, for
example, we already don't have modules in the direct map.

So I say we go for it.  This should be quite simple to implement --
the pageattr code already has almost all the needed logic on x86.  The
only arch support we should need is a pair of functions to remove a
vmalloc address range from the address map (if it was present in the
first place) and a function to put it back.  On x86, this should only
be a few lines of code.

What do you all think?  This should solve most of the problems we have.

If we really wanted to optimize this, we'd make it so that
module_alloc() allocates memory the normal way, then, later on, we
call some function that, all at once, removes the memory from the
direct map and applies the right permissions to the vmalloc alias (or
just makes the vmalloc alias not-present so we can add permissions
later without flushing), and flushes the TLB.  And we arrange for
vunmap to zap the vmalloc range, then put the memory back into the
direct map, then free the pages back to the page allocator, with the
flush in the appropriate place.

I don't see why the page allocator needs to know about any of this.
It's already okay with the permissions being changed out from under it
on x86, and it seems fine.  Rick, do you want to give some variant of
this a try?
