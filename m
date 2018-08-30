Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34393C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB25D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBb9ZTwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB25D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeHaBF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:05:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42846 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaBF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:05:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so11864439oib.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQA+KgMn3gpfJEcYovqaXgqAQXkNc1MLBKsQYePtLSs=;
        b=QBb9ZTwKUBSRg35H/rKhqXALOGcSuOSlf3jZl0sWpB/QUIlJQ3ycMB5FNuEZgAPTXO
         C4254tQr8khDsxfyDgcOXHl85Rl3dITtJZ5hHYHrj1nFQBwYf/+fPcbNR8RWZ87I4z0Y
         n4Z+kdfAfo6OQOLMDbbZk4MdV1A0XgGYRMAzZqhn7c03jmgFvNy5oZoTaasMH0eyr7jg
         6rJkBgMHpyXD/D6x3Arl14aSEmXSwJzVaMax87+XED5ICx/4mQNaYQldfrZCjCRgE+CD
         PK3RKg3SJCdjcs0o24ntI57D90hjA7c96z3fVnhQIReyrnER8dftL5Rh4FHbl/M855M1
         tstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQA+KgMn3gpfJEcYovqaXgqAQXkNc1MLBKsQYePtLSs=;
        b=Qxh+74tJoUYHBfnXhGwYZYpl0O7VvB4S24dF++nJcjDdxlaF3J+Null2nYzhrczqMm
         1bCW7NIdeurl3idXyg/rRifEp1RWQRnsYcchC5raKkh+ZyfE+tHaKUtjErWGPbjaPblQ
         kLjHdgIr5OggsaHVXNA7emAHI0UtEAS3fGQ7oHIUW+ts83PeE2kqZDE3ukeiEtLDSBdc
         8+1tB7JiEn4sLIOXgup7m+DY44OhZMGfqEn8p1qKXS2jW03HXOAtzZ+Gzwo8UvhhZagZ
         b6M0Sh7OrqMIStPdT8ShE8Fk3i0xCivDfYR1m5yNApnudvEYxu5piL60QmObcIZfdRDK
         ngQA==
X-Gm-Message-State: APzg51BP3gsQLhFqk5oh+wp0UOPFT8ejaMMW9QaukETLjTA6Vd1JFml1
        ckBOvAjbrxHIPMZ7rvKf6a0Mr3QF1VAiedVP/zmvOg==
X-Google-Smtp-Source: ANB0VdaowIqqd9qSnfPcm7krWIR2VxOpNfTQQXqD6krNB/t7ORg+4bLvsoAUO7O+k0MbUWQjij+tXpLcqM9AQV5AYQI=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr4387018oia.229.1535662914424;
 Thu, 30 Aug 2018 14:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com>
 <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
 <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com> <CAG48ez2gHOD9hH4+0wek5vUOv9upj79XWoug2SXjdwfXWoQqxw@mail.gmail.com>
 <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com> <1535649960.26689.15.camel@intel.com>
 <33d45a12-513c-eba2-a2de-3d6b630e928e@linux.intel.com> <1535651666.27823.6.camel@intel.com>
 <CAG48ez3ixWROuQc6WZze6qPL6q0e_gCnMU4XF11JUWziePsBJg@mail.gmail.com>
 <1535660494.28258.36.camel@intel.com> <CAG48ez0yOuDhqxB779aO3Kss3gQ3cZTJL1VphDXQm+_M9jFPvQ@mail.gmail.com>
 <1535662366.28781.6.camel@intel.com>
In-Reply-To: <1535662366.28781.6.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Aug 2018 23:01:26 +0200
Message-ID: <CAG48ez0mkr95_TbLQnDGuGUd6G+eJVLZ-fEjDkwA6dSrm+9tLw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
To:     yu-cheng.yu@intel.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>, hjl.tools@gmail.com,
        Jonathan Corbet <corbet@lwn.net>, keescook@chromiun.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        ravi.v.shankar@intel.com, vedvyas.shanbhogue@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:57 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-08-30 at 22:44 +0200, Jann Horn wrote:
> > On Thu, Aug 30, 2018 at 10:25 PM Yu-cheng Yu <yu-cheng.yu@intel.com>
> > wrote:
> ...
> > > In the flow you described, if C writes to the overflow page before
> > > B
> > > gets in with a 'call', the return address is still correct for
> > > B.  To
> > > make an attack, C needs to write again before the TLB flush.  I
> > > agree
> > > that is possible.
> > >
> > > Assume we have a guard page, can someone in the short window do
> > > recursive calls in B, move ssp to the end of the guard page, and
> > > trigger the same again?  He can simply take the incssp route.
> > I don't understand what you're saying. If the shadow stack is
> > between
> > guard pages, you should never be able to move SSP past that area's
> > guard pages without an appropriate shadow stack token (not even with
> > INCSSP, since that has a maximum range of PAGE_SIZE/2), and
> > therefore,
> > it shouldn't matter whether memory outside that range is incorrectly
> > marked as shadow stack. Am I missing something?
>
> INCSSP has a range of 256, but we can do multiple of that.
> But I realize the key is not to have the transient SHSTK page at all.
> The guard page is !pte_write() and even we have flaws in
> ptep_set_wrprotect(), there will not be any transient SHSTK pages. I
> will add guard pages to both ends.
>
> Still thinking how to fix ptep_set_wrprotect().

cmpxchg loop? Or is that slow?
