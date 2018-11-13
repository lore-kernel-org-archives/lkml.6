Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15392C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54A42175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="S225OUuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54A42175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbeKNIx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:53:59 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37267 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNIx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:53:59 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so22593753qkd.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cZK1bZyelR1PbPik2Myy3suEY1afuJFSacaUrlVRAtY=;
        b=S225OUuKCwTFd/Ldj6GKawqujM20aM74zGPUpcVdTJULdE3Q4nmjB6GtDbp+faINdz
         ixk6PuPGx7FuE9PnzlrMW255AVfqDM4KC8koO6GE+NaEJhTnC3nZ3kTGZKQgNt2O6Xrl
         1DSc6Pmgc2aRlkTtDTzdDGg3dkdbKSneaUyK9Pnbza9JzbPj5jo9YFYlGuhgW+VD2I3M
         IQspOG1XwRcm0OrPzvmvwtWMaVJp9sYb1P4P4kJF/Dm0aZllHg8AyjfmMsSH9Qf4UJfa
         fwjStBaICLkyU6ovsxwVa1ntPwa02lysG0+q2yqbv6VtpOw1pmw/Ud6ZJqlgzaoHVvJe
         GRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cZK1bZyelR1PbPik2Myy3suEY1afuJFSacaUrlVRAtY=;
        b=sSlBigmPDbTfc7vmzMA4H5ZFF4ICnq5ULMQXljhiU/265iFRbyFPfEql03xn/TAaUd
         AjH0QPmeeC2fGW6qy39kmnfOva6SSiuEtyLhr7LMPiymLTUndgKI5PZ2v//BL4UNnb3U
         0gccxcNb+1/Fm1XSt6mj0/FtD/fU7baGRLCMM3F0xlB3RhpyCfF/DIFvkc0sNOdR5Vnm
         gvCPeboBpnm/VuW++PbHl1sa6vNMKWznZ5e+CJRlmkLuMN1Ehc7IgxGsNrQULfLPL28I
         Zz/PeB2m9UORlOKTJeOJbdWS2kAlhrfL+d/kvzehkCC2991LE47GacBY/f4dc3Glv7Bv
         8CxQ==
X-Gm-Message-State: AGRZ1gJlVeEGqyn9QaffHCPiGqPJZXO30DIWhqZpWnugQhCS6eKPRfYw
        caeAzxYnBFfVA8IVt2xKl/xzKr8bBZJe3w==
X-Google-Smtp-Source: AJdET5eUk/VVt6k96NkkiOPOhKkaONqmkWoq29AFZAPlkFnvijg+AiJjYUXucAOEmh+oFiqclAI/Lw==
X-Received: by 2002:ac8:1:: with SMTP id a1mr3617347qtg.366.1542149617644;
        Tue, 13 Nov 2018 14:53:37 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id t140sm8095891qke.6.2018.11.13.14.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 14:53:36 -0800 (PST)
Date:   Tue, 13 Nov 2018 22:53:34 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Timofey Titovets <timofey.titovets@synesis.ru>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH V3] KSM: allow dedup all tasks memory
Message-ID: <20181113225334.hnz7pqoldvvg6j3w@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <CAG48ez0ZprqUYGZFxcrY6U3Dnwt77q1NJXzzpsn1XNkRuXVppw@mail.gmail.com>
 <d43da6ad1a3c164aa03e0f22f065591a@natalenko.name>
 <20181113175930.3g65rlhbaimstq7g@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi74gpvJv8=B-3pVSMrDssu-aYMxW9xM7mt1WNQjGLjMZqA@mail.gmail.com>
 <20181113183510.5y2hzruoi23e7o2t@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi763e4sZj1NHAk2fAjtPtb-kAZfcPq=KTH8B3sE-oDVvGw@mail.gmail.com>
 <20181113191653.btbzobquxtwt47z4@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAGqmi77JMyxU9L4bZHPv4Nt=tyQsEZDQcMVMRfQ7de_LjZg+-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGqmi77JMyxU9L4bZHPv4Nt=tyQsEZDQcMVMRfQ7de_LjZg+-Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > That must work, but we out of bit space in vm_flags [1].
> > > i.e. first 32 bits already defined, and other only accessible only on
> > > 64-bit machines.
> >
> > So, grow vm_flags_t to 64-bit, or enable this feature on 64-bit only.
> 
> With all due respect to you, for that type of things we need
> mm maintainer opinion.

As far as I understood, you already got directions from the maintainers
to do similar to the way THP is implemented, and THP uses two flags:

VM_HUGEPAGE VM_NOHUGEPAGE, the same as I am thinking ksm should do if we
honor MADV_UNMERGEABLE.

When VM_NOHUGEPAGE is set khugepaged ignores those VMAs.

There may be a way to add VM_UNMERGEABLE without extending the size of
vm_flags, but that would be a good start point in looking how to add a
new flag.

Again, you could simply enable this feature on 64-bit only.

Pasha
