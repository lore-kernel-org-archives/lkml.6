Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52F82082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="PJMbUGRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52F82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJaDXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:23:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41895 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbeJaDXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:23:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id i10-v6so11331495oik.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JAI1HlD5dqyB57uwgCSv8VB+R5Ii9fVP8ESJ5dTebS8=;
        b=PJMbUGRmPILUnsWvEUdbJIt7iUWOCmUt02bd9DyUKPUQ33vRm3PZjHaUHSL+1UY1qW
         iZTK/ujHIqGV1xQn/UMj7VL9pg4/Cf+i3IoKSnFt6gAMbjjYLKGY40ZFeMCUC5edThpn
         cXKpkZ0T9yNtTdx6KY9Tkf3XCRp52YxRPiFqVkQ/PR4D06VBHmXncHXzvUP881uUF6Qy
         Q/rP7sAD92l3p6pNekTxgNh5eBVZS9YgrAZA9SrQB5Ec1yYR04uwI0Ed3mTxx1ZXE05o
         e6fuwObYCuO07bw4QI1iwdlzXGoFM7YQBwZtpwVI4ohwxLogtdmKhlIOQ25zXhJ28BYw
         Jh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JAI1HlD5dqyB57uwgCSv8VB+R5Ii9fVP8ESJ5dTebS8=;
        b=QeKIloSitC2ohAiTeJ5JT6op/qJsT620Lb37MJY5VNJ61o+k+0wKGUY6HMRgntTR8b
         6++4n7jAY+AaSQw6RaOKjw4HHpKnmvRfOtUamrI1feZNICnlt8PjpDKN+sU/WJjZikuI
         0E/FBzAXdTXnpdNEJgirvVFfdK+9i8PLaPPusoYs0vIvibUirFsQrNYK2ltj2yu1Al/d
         nSZAVCkmVjZpCkZVxt6YzIrixkOT5WFm1jLFxFI5QNYoxNAvTt8E1LQTIuqyP6JFO93L
         L2SAJJfDgN+J9mfLdP3NP8wv2gZuCfDg7o2jbgBKGBaRJZ0dbhkoC7+wnii5PU2YEeTs
         2kuw==
X-Gm-Message-State: AGRZ1gIB1TZGNArT5CfhvsfuYej5/gJg64ov5++dAlAFQ16XPvXcGxLn
        iIkDzHrdboO6P+Geb0yLKdELKg==
X-Google-Smtp-Source: AJdET5e7OwnfpoGuZ/wri/U0UVODeOEd6lgoAUGVeZGLs9KrBtMDUUXspaq0Iv8fu6Yeo7UGCEGS2Q==
X-Received: by 2002:aca:72cd:: with SMTP id p196-v6mr3533oic.252.1540924126358;
        Tue, 30 Oct 2018 11:28:46 -0700 (PDT)
Received: from cisco ([128.107.241.170])
        by smtp.gmail.com with ESMTPSA id w37sm9597052oti.77.2018.10.30.11.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 11:28:45 -0700 (PDT)
Date:   Tue, 30 Oct 2018 12:28:41 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/17] prmem: documentation
Message-ID: <20181030182841.GE7343@cisco>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030175814.GB10491@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:58:14AM -0700, Matthew Wilcox wrote:
> On Tue, Oct 30, 2018 at 10:06:51AM -0700, Andy Lutomirski wrote:
> > > On Oct 30, 2018, at 9:37 AM, Kees Cook <keescook@chromium.org> wrote:
> > I support the addition of a rare-write mechanism to the upstream kernel.
> > And I think that there is only one sane way to implement it: using an
> > mm_struct. That mm_struct, just like any sane mm_struct, should only
> > differ from init_mm in that it has extra mappings in the *user* region.
> 
> I'd like to understand this approach a little better.  In a syscall path,
> we run with the user task's mm.  What you're proposing is that when we
> want to modify rare data, we switch to rare_mm which contains a
> writable mapping to all the kernel data which is rare-write.
> 
> So the API might look something like this:
> 
> 	void *p = rare_alloc(...);	/* writable pointer */
> 	p->a = x;
> 	q = rare_protect(p);		/* read-only pointer */
> 
> To subsequently modify q,
> 
> 	p = rare_modify(q);
> 	q->a = y;

Do you mean

    p->a = y;

here? I assume the intent is that q isn't writable ever, but that's
the one we have in the structure at rest.

Tycho

> 	rare_protect(p);
> 
> Under the covers, rare_modify() would switch to the rare_mm and return
> (void *)((unsigned long)q + ARCH_RARE_OFFSET).  All of the rare data
> would then be modifiable, although you don't have any other pointers
> to it.  rare_protect() would switch back to the previous mm and return
> (p - ARCH_RARE_OFFSET).
> 
> Does this satisfy Igor's requirements?  We wouldn't be able to
> copy_to/from_user() while rare_mm was active.  I think that's a feature
> though!  It certainly satisfies my interests (kernel code be able to
> mark things as dynamically-allocated-and-read-only-after-initialisation)
