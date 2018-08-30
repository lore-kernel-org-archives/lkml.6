Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EA62082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mz0j7Bec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EA62082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeH3U1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:27:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36056 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH3U1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:27:09 -0400
Received: by mail-oi0-f67.google.com with SMTP id r69-v6so16487274oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdRJ6iJB9yUBCNR0o7ZDKPQvYsoAYmM+wP9+B/tE6a8=;
        b=mz0j7Becz6s7PClSUADz25O4B/cjzK38mT/2Aw/w0CrIuhTyD9aD6BaFgqoiSTtnF8
         b2f74v18x3ny+UGCr48cAhBPqOu1ep0HGDvkoFgt2N1IY/e1YnI2JvxTGC/5EwlPMpBv
         qhZNGTYl2w7KZgF8sNmH5Fu8rIiBBvVrxFGECdonMkhTTni2MKi0Iw0nfarQmfJnaDcQ
         tF92I8StTQ4DSP/569VS07Ezud9f33gHeABKcxFrPsCwwLv1uuq70yEJgsew0XpkTkex
         RCt8Pv7qn5l/3mb66XpZjjZBCKup4EAe0Co40/Ibhfob68QEs36OeIdnYVO3oDNtGgGW
         ngJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdRJ6iJB9yUBCNR0o7ZDKPQvYsoAYmM+wP9+B/tE6a8=;
        b=fO3BpSuSkeB7vimJ8FxSTC/NOHjVpmwFK8X5NW1G04cKYu+Y+t14pRFsYjc4xZ9Ybg
         RtWMTDRxWEig46IGlI7zyDT2UfOEaiLPV1jGlRgdyxJiBCdvt3wANJpzbT5ytH56yhd2
         msOD/TVM0gZrUlT1t7PMFX888sfs/zTdtlNlyXDyOTKGQp8nPELkAE1jqMgHgSlkwyUy
         N7BoAGf4V+In2XevUewo5I1gawKAATB0JORJbBrfndiK/8hcerlvD65OhSwCd3MnEA+a
         tkwEdOGJ8W9ogBOzUUi0lA9OzMogcnuSGcjCVa8mekH+1PbNSnbNeOiPHM1J98Fs8Ex+
         J/wA==
X-Gm-Message-State: APzg51DgOSe8Y2CFWRZoggEEywiSbPj50w/sJ4hdMzzqseXYwTT3Pq4v
        yV4jNwYdGlbCA6kpWd2r1tCLeGigqwa8wZHSQi7n/w==
X-Google-Smtp-Source: ANB0VdZTZCLZ6DphgbyhgNwGAFxehf2yWcZdP1TlDOclsOFAr4fM1yAV+uxVdc+aXARPCXQ4ZyQyy8WdBZZvtDT0kKk=
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr3382500oia.195.1535646253707;
 Thu, 30 Aug 2018 09:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180830143904.3168-1-yu-cheng.yu@intel.com> <20180830143904.3168-13-yu-cheng.yu@intel.com>
 <CAG48ez0Rca0XsdXJZ07c+iGPyep0Gpxw+sxQuACP5gyPaBgDKA@mail.gmail.com> <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com>
In-Reply-To: <079a55f2-4654-4adf-a6ef-6e480b594a2f@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Aug 2018 18:23:47 +0200
Message-ID: <CAG48ez2gHOD9hH4+0wek5vUOv9upj79XWoug2SXjdwfXWoQqxw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/24] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     yu-cheng.yu@intel.com, "the arch/x86 maintainers" <x86@kernel.org>,
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

On Thu, Aug 30, 2018 at 6:09 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> On 08/30/2018 08:49 AM, Jann Horn wrote:
> >> @@ -1203,7 +1203,28 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> >>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
> >>                                       unsigned long addr, pte_t *ptep)
> >>  {
> >> +       pte_t pte;
> >> +
> >>         clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> >> +       pte = *ptep;
> >> +
> >> +       /*
> >> +        * Some processors can start a write, but ending up seeing
> >> +        * a read-only PTE by the time they get to the Dirty bit.
> >> +        * In this case, they will set the Dirty bit, leaving a
> >> +        * read-only, Dirty PTE which looks like a Shadow Stack PTE.
> >> +        *
> >> +        * However, this behavior has been improved and will not occur
> >> +        * on processors supporting Shadow Stacks.  Without this
> >> +        * guarantee, a transition to a non-present PTE and flush the
> >> +        * TLB would be needed.
> >> +        *
> >> +        * When change a writable PTE to read-only and if the PTE has
> >> +        * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so
> >> +        * that the PTE is not a valid Shadow Stack PTE.
> >> +        */
> >> +       pte = pte_move_flags(pte, _PAGE_DIRTY_HW, _PAGE_DIRTY_SW);
> >> +       set_pte_at(mm, addr, ptep, pte);
> >>  }
> > I don't understand why it's okay that you first atomically clear the
> > RW bit, then atomically switch from DIRTY_HW to DIRTY_SW. Doesn't that
> > mean that between the two atomic writes, another core can incorrectly
> > see a shadow stack?
>
> Good point.
>
> This could result in a spurious shadow-stack fault, or allow a
> shadow-stack write to the page in the transient state.
>
> But, the shadow-stack permissions are more restrictive than what could
> be in the TLB at this point, so I don't think there's a real security
> implication here.

How about this:

Three threads (A, B, C) run with the same CR3.

1. a dirty+writable PTE is placed directly in front of B's shadow stack.
   (this can happen, right? or is there a guard page?)
2. C's TLB caches the dirty+writable PTE.
3. A performs some syscall that triggers ptep_set_wrprotect().
4. A's syscall calls clear_bit().
5. B's TLB caches the transient shadow stack.
[now C has write access to B's transiently-extended shadow stack]
6. B recurses into the transiently-extended shadow stack
7. C overwrites the transiently-extended shadow stack area.
8. B returns through the transiently-extended shadow stack, giving
    the attacker instruction pointer control in B.
9. A's syscall broadcasts a TLB flush.

Sure, it's not exactly an easy race and probably requires at least
some black timing magic to exploit, if it's exploitable at all - but
still. This seems suboptimal.

> The only trouble is handling the spurious shadow-stack fault.  The
> alternative is to go !Present for a bit, which we would probably just
> handle fine in the existing page fault code.
