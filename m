Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A917AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163820892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544227046;
	bh=47TLBbbgzo45ICeLUzvQqospcO4xTJkR4BwLHJbKjho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k4ifMlh/M3SYGiK2P/v2zHL1EuukVoR6ckcU7EhrVTi6ehpLOv4V5bQCAK/7buNdP
	 3NQK+FlNRDkNn6NJvrBYi2nXmAdwXlmYJ5s/3MU3fQ9CjAO3NmZKFh8r//z+ShsAZa
	 G2iEcRklxc9HNtwPmjbIt3jOB8fyGoufkgPZdgX8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6163820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGX5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeLGX5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:57:24 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B080A21479
        for <linux-kernel@vger.kernel.org>; Fri,  7 Dec 2018 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544227044;
        bh=47TLBbbgzo45ICeLUzvQqospcO4xTJkR4BwLHJbKjho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sfuYKD9DxeGcyNQFiiG4Jr8zcEhK85j/tP/c8MCrZvCwQZhZ+rf3usvcnOr0U1I4d
         mnlpTXTLHNmbC/YnN2dnI5m/w6NNKdY0y69Ka6GAjH10lQgHNbmavAAnkOfPisspvW
         2xH3FUcqOpQuBll/y7qzJYZn0f2VxVtL9qif4jYk=
Received: by mail-wm1-f45.google.com with SMTP id y185so2345958wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 15:57:23 -0800 (PST)
X-Gm-Message-State: AA+aEWYVNs5h6pQqLOQ2ZXCslNnqbWmlkfHw0CCFMSg+NUMj2LYVd7Lm
        Agyj50DB6KSeL9EA2VJ5LZGnVMSQ0bu7HEGbY+Ndlw==
X-Google-Smtp-Source: AFSGD/XL5BSBmDgy1Mt81Y1bXN2cskOEDJBvrbZmUMS1h42UlghqHk+jvg81IQy8kgfz0p1s0I7GI+lfFyD63AlvScE=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr4048526wmf.32.1544227042104;
 Fri, 07 Dec 2018 15:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20181207184423.1962-1-sean.j.christopherson@intel.com>
 <20181207195223.23968-1-sean.j.christopherson@intel.com> <CAHk-=wgtN9nQBimLuOmBxY8eYqDRhNeBOW_uvnhqtZSFycyHuA@mail.gmail.com>
 <20181207220646.GH10404@linux.intel.com> <CAHk-=wizzTem4B3muo+DV5JqPBD0n1JJ8-NDjyY1fn-N4WYHCg@mail.gmail.com>
In-Reply-To: <CAHk-=wizzTem4B3muo+DV5JqPBD0n1JJ8-NDjyY1fn-N4WYHCg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 7 Dec 2018 15:57:10 -0800
X-Gmail-Original-Message-ID: <CALCETrUu=qO4tHkk-QxKD_j687hKV56X9JvYv1YsdgtOy0urmQ@mail.gmail.com>
Message-ID: <CALCETrUu=qO4tHkk-QxKD_j687hKV56X9JvYv1YsdgtOy0urmQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/fault: Decode and print #PF oops in human readable form
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 2:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 7, 2018 at 2:06 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > Looking at it again, my own personal preference would be to swap the order
> > of the #PF lines.
>
> Yeah, probably.
>
> Also:
>
> > [  160.246820] BUG: unable to handle kernel paging request at ffffbeef00000000
> > [  160.247517] #PF: supervisor-privileged instruction fetch from kernel code
> > [  160.248085] #PF: error_code(0x0010) - not-present page
>
> With this form, I think the "kernel" in the first line is actually
> misleading. Yes, it's a #PF for the kernel, but then the "kernel" on
> the second line talks about what mode we were in when it happened, so
> we have two different meanings of "kernel" on two adjacent lines.

I'm okay with this variant.  I have a slight preference for:

#PF: supervisor-privileged instruction fetch from kernel code
#PF error_code: 0x0010 [READ]

Which is what we'd get from Sean's patch plus my patch here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/mm&id=ccfb1941f90153818c07fb1a7dc22121a970d252

Sean, what do you think?

> So maybe  that "BUG: unable to handle kernel paging request" message
> should be something like
>
>   "BUG: unable to handle page fault for address ffffbeef00000000"
>
> instead? Does that make sense to people?

Yes please.
