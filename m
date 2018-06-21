Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56456C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4F92075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9KoxIpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4F92075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeFUNjV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:39:21 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44901 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeFUNjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:39:19 -0400
Received: by mail-ot0-f193.google.com with SMTP id w13-v6so3575644ote.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5lO0xzBv5ZFk74nSUCyWO+ib0P3YWdsmnq33Y3FXK4=;
        b=X9KoxIpzXwQe9aX9nLAqalEqHU+HRDVEu4hDIV3rMRYMbIWfI2hnrzs00CVsge/Cyh
         twBl+ukyRv41uGLtDaPxGeI1MCPl36OASR+Xu+j0Lvu2UpSD4UU12+R1dpmF7WY6cvzV
         eMGE1biYc+1+1xNFjjtYTIZie37xDEMJ139OOD/mt+ASkhI7tPb0hfyfctz22mXZu+6L
         Fe5RfhF8Rhu+fPTz5gxkiAncc2krqTHVXv9uezgNj5l8scwCaT7LHzaoqVZIru4aVUrN
         /o5hPF8Rcg1B/cw1EVt1dewX3UyHuj2H2L2Bm70Y3IDwKU++CRWg7es1xautcVUTFoGs
         Xqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5lO0xzBv5ZFk74nSUCyWO+ib0P3YWdsmnq33Y3FXK4=;
        b=tltffuihPnRxxneC7alD693JLXAFH0qlPoCKed9bB8V4G7JG37ROt2/BDlTW9rgFMU
         rU85jnxoyQhuMv5tUY4KvQnBrTjD1mta8R5oHtQ2eEqHWX+KSTRbwSPFhURauCRE85UL
         fKxz6BL2era1F1zgJD8q8aNY/AA+xnCno72f4AiwJzkdTAtxhOSRTkYZOvSOP9qcV55r
         8Wj4IUTi5GkQasNgiw2CzkJDxJxnhPWSe5fs87x0eTVinZPyhyH2yB95j4XgVyb/FjXm
         9aLb+HoAsUu5b7htHumDGJKfbXGYruaDkqRKfGFSgvmSdE2QEZI1yYcusfZnOoKaPDMP
         D73Q==
X-Gm-Message-State: APt69E3GaglksyziIcDh/n5KZpi9fQ7WVFbm1Wv2WPwXjMw6fxZr0IuG
        WDflC+Y6jrm0aj/bX9aHSRtdzBQvq9twtm3Tfj0OnQ==
X-Google-Smtp-Source: ADUXVKLRewET/L6x3SxyitWr0kuMwsXFD41826Juuf9bnjV/lRY8YLw9q5JN4JvDcEBadMsebdQ6TM7RrIdGj8NW9ek=
X-Received: by 2002:a9d:2115:: with SMTP id i21-v6mr14958889otb.72.1529588354418;
 Thu, 21 Jun 2018 06:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
 <CAGXu5jLt8Zv-p=9J590WFppc3O6LWrAVdi-xtU7r_8f4j0XeRg@mail.gmail.com> <CAG48ez2uuQkSS9DLz6j5HbpuxaHMyAVYGMM+xoZEo51N=sHmdg@mail.gmail.com>
In-Reply-To: <CAG48ez2uuQkSS9DLz6j5HbpuxaHMyAVYGMM+xoZEo51N=sHmdg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 Jun 2018 15:39:03 +0200
Message-ID: <CAG48ez1eAKVy13tmAxrVkRqj2Fd+wduqBt4fzMBjY5FA1aFFmw@mail.gmail.com>
Subject: Re: [PATCH 0/3] KASLR feature to randomize each loadable module
To:     Kees Cook <keescook@chromium.org>, rick.p.edgecombe@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen.c.accardi@intel.com, Dave Hansen <dave.hansen@intel.com>,
        arjan.van.de.ven@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 3:37 PM Jann Horn <jannh@google.com> wrote:
>
> On Thu, Jun 21, 2018 at 12:34 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Jun 20, 2018 at 3:09 PM, Rick Edgecombe
> > <rick.p.edgecombe@intel.com> wrote:
> > > This patch changes the module loading KASLR algorithm to randomize the position
> > > of each module text section allocation with at least 18 bits of entropy in the
> > > typical case. It used on x86_64 only for now.
> >
> > Very cool! Thanks for sending the series. :)
> >
> > > Today the RANDOMIZE_BASE feature randomizes the base address where the module
> > > allocations begin with 10 bits of entropy. From here, a highly deterministic
> > > algorithm allocates space for the modules as they are loaded and un-loaded. If
> > > an attacker can predict the order and identities for modules that will be
> > > loaded, then a single text address leak can give the attacker access to the
> >
> > nit: "text address" -> "module text address"
> >
> > > So the defensive strength of this algorithm in typical usage (<800 modules) for
> > > x86_64 should be at least 18 bits, even if an address from the random area
> > > leaks.
> >
> > And most systems have <200 modules, really. I have 113 on a desktop
> > right now, 63 on a server. So this looks like a trivial win.
[...]
> Also: What's the impact on memory usage? Is this going to increase the
> number of pagetables that need to be allocated by the kernel per
> module_alloc() by 4K or 8K or so?

Sorry, I meant increase the amount of memory used by pagetables by 4K
or 8K, not the number of pagetables.
