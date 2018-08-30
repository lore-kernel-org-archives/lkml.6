Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9025C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1AC205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEFAtDXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1AC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeHaAtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:49:11 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44302 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeHaAtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:49:10 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so17884345oih.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IP30Y1YhjynsIjlW5YIr2azX4Y9nlVjraWdcjhS3RFg=;
        b=UEFAtDXbGd4VPyHxaw6oDLz0N3WEQBZHluX5MN9Wwt5OA/Xe80i5CCB5ZreWrEQnfT
         KHIf5ZROXkN653XoB83aYym4VTCvpd9U5ywV/L8dWL3TZB4CK4VeR5yA6qAbt+A1EnJe
         ZnvyvsReLBsmae7z3IRRKNYPoonLag6ua8MDc3qCCZ2u3KqhEMZVDAs6HeZocNTTxO9s
         ZD/5pm+9vxRa/gxrheOcLitnUFac1M6pxa5l9hWt8pTy1ldnuMMBTDFkiftV6pdF+9HC
         9qsmS/N7gYXZJSvox6hsx2UhQ5LYw3ggKxfqA1lcz+RdYO0CsKeFxTnvE52MbPjMUGkX
         eYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IP30Y1YhjynsIjlW5YIr2azX4Y9nlVjraWdcjhS3RFg=;
        b=uMLiz5XWIEFLZNUIPlEGr5v+VPo/JGXKo57DfHsIKt1Nd7llMcXLoeNcTR/d0HwjdH
         iWqcKzvT1podYbJjgTimEMnPACpy7mHygHWpu8Q8h/67oHrF+AUKSa3FPfbuRz4J7Mas
         d8wUOxd+KJjfnfh+Tv+DYuv+QNNFCIVruucADAxvL10H/UFEZ3OXKplfjbsk7v3GkbJi
         Y6RN4kxNW0CC2pAO1ypsR7/s0Y7v0VuqhaFNAZi98dNqptnvJJkB3VQNuAdofYovnAXH
         dZoawVxqIVtet1GBUVn+8Ro3tnsO9V8rwt0Ae3NPcAfIyZyKtL7r2LhLAI8rgWh0qJim
         X2aQ==
X-Gm-Message-State: APzg51DsZMxVCG/Vet7no2Mg8aBmeXdqPJwRb08BjSkojiTsFstjxd9j
        A16bi8JaX7iuHQ4ABGGh6QflJyAR93iwf8pr0OXdmg==
X-Google-Smtp-Source: ANB0VdbZLx6RYiq0Zqll//pCr7nxeIqw4vzMDac+JG1YePUuGhFQAoWahxeo2AvE+PBsTjOYnlJvtRhx6U67GFxDy7k=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr4328731oia.229.1535661910290;
 Thu, 30 Aug 2018 13:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com>
 <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com>
 <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com> <CAG48ez2gHOD9hH4+0wek5vUOv9upj79XWoug2SXjdwfXWoQqxw@mail.gmail.com>
 <ce051b5b-feef-376f-e085-11f65a5f2215@linux.intel.com> <1535649960.26689.15.camel@intel.com>
 <33d45a12-513c-eba2-a2de-3d6b630e928e@linux.intel.com> <1535651666.27823.6.camel@intel.com>
 <CAG48ez3ixWROuQc6WZze6qPL6q0e_gCnMU4XF11JUWziePsBJg@mail.gmail.com> <1535660494.28258.36.camel@intel.com>
In-Reply-To: <1535660494.28258.36.camel@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Aug 2018 22:44:43 +0200
Message-ID: <CAG48ez0yOuDhqxB779aO3Kss3gQ3cZTJL1VphDXQm+_M9jFPvQ@mail.gmail.com>
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

On Thu, Aug 30, 2018 at 10:25 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Thu, 2018-08-30 at 19:59 +0200, Jann Horn wrote:
> > On Thu, Aug 30, 2018 at 7:58 PM Yu-cheng Yu <yu-cheng.yu@intel.com>
> > wrote:
> > >
> > >
> > > On Thu, 2018-08-30 at 10:33 -0700, Dave Hansen wrote:
> > > >
> > > > On 08/30/2018 10:26 AM, Yu-cheng Yu wrote:
> > > > >
> > > > >
> > > > > We don't have the guard page now, but there is a shadow stack
> > > > > token
> > > > > there, which cannot be used as a return address.
> > > > The overall concern is that we could overflow into a page that
> > > > we
> > > > did
> > > > not intend.  Either another actual shadow stack or something
> > > > that a
> > > > page
> > > > that the attacker constructed, like the transient scenario Jann
> > > > described.
> > > >
> > > A task could go beyond the bottom of its shadow stack by doing
> > > either
> > > 'ret' or 'incssp'.  If it is the 'ret' case, the token prevents
> > > it.
> > >  If it is the 'incssp' case, a guard page cannot prevent it
> > > entirely,
> > > right?
> > I mean the other direction, on "call".
>
> In the flow you described, if C writes to the overflow page before B
> gets in with a 'call', the return address is still correct for B.  To
> make an attack, C needs to write again before the TLB flush.  I agree
> that is possible.
>
> Assume we have a guard page, can someone in the short window do
> recursive calls in B, move ssp to the end of the guard page, and
> trigger the same again?  He can simply take the incssp route.

I don't understand what you're saying. If the shadow stack is between
guard pages, you should never be able to move SSP past that area's
guard pages without an appropriate shadow stack token (not even with
INCSSP, since that has a maximum range of PAGE_SIZE/2), and therefore,
it shouldn't matter whether memory outside that range is incorrectly
marked as shadow stack. Am I missing something?
