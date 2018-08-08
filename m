Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE13C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF3721766
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF3721766
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeHHQ1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:27:10 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36801 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHHQ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:27:10 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so2540400qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 07:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEt5He4Mjvm+PEzMkFcS33b85QNrxGIDFx9rCZLBybs=;
        b=M/DXj87LrIxxJIBC+o0YVlsJRDLkz5nM/dRONiwI+QPN2D5VGeZCT7Yvnm5mhhesJ+
         YUoWlruPUUE+rfBs6olzTqCu8cCmrFqUgUVWq8iqmT3+qmxYg7YmW+gpwEv3RoL9EC1R
         AsSOZ3luwPP0mc4JPDix7J4idymoqafQz1o5XrQV2THP4pK/HhRT1tgk7NPaoyH2Yp8w
         lMbQjMQLXGU0aX670Wm7s965FvPN/xSiD8KEJ2Qng1tD5OQNqkyzDRMyWDmkzfxVmdyU
         Qb6o/QaT6vEygchWfqiBgg7nTtWbgX/QK8+pOt8jbrXM6u4pau3dQ0ycTcR8KtryHMTg
         rx/w==
X-Gm-Message-State: AOUpUlF0+KmyCNKxZe4YCWNzXI+/tPbLDyRgYlh9xmCDK8e8LLfqpYpI
        kyknIukuASeoXn87d9ZYl10QhanumC5n+NZuMcE=
X-Google-Smtp-Source: AA+uWPymotSUbY4lgjrLMhUVTqUmcKT1VdampDSrQr9/YTKpfALrLtxq8pYzPEziKkDvBtDPSgsdz9pWpkjIAI8Q6D0=
X-Received: by 2002:ac8:2dc6:: with SMTP id q6-v6mr2891838qta.178.1533737240661;
 Wed, 08 Aug 2018 07:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <1533662247-17575-1-git-send-email-kan.liang@linux.intel.com>
 <1b7cb461-5321-86cf-3031-5ff545c3dc42@linux.intel.com> <20180807174851.GJ2494@hirez.programming.kicks-ass.net>
 <20180807183736.GR4238@tassilo.jf.intel.com> <alpine.DEB.2.21.1808072257080.1672@nanos.tec.linutronix.de>
 <20180807221725.GU4238@tassilo.jf.intel.com> <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808080653120.1672@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Aug 2018 16:07:04 +0200
Message-ID: <CAK8P3a2wfZvDTuHEfYBCa7w2whAbUVU1SsLNkMqHU0EVt8q50w@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Rename Denverton and Gemini Lake
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kan.liang@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 7 Aug 2018, Andi Kleen wrote:
> > > It's even worse with Silvermont.
> > >
> > > So no, the interesting information is the UARCH and the variant of that,
> >
> > With Uarch you mean the core uarch?  That doesn't really work for
> > something like Silvermont or Goldmont.
> >
> > > e.g. UARCH_CLIENT, UARCH_SERVER, UARCH_WHATEVER. All the magic Code Names
> >
> > Right your scheme totally doesn't work on Silvermont because there
> > are multiple client variants.
>
> We have that for the big cores as well:
>
> #define INTEL_FAM6_HASWELL_CORE         0x3C
> #define INTEL_FAM6_HASWELL_X            0x3F
> #define INTEL_FAM6_HASWELL_ULT          0x45
> #define INTEL_FAM6_HASWELL_GT3E         0x46
>
> Why would we treat ATOM differently? It's all the same scheme:
>
> SILVERMONT_CLIENT       0x37         Baytrail, Valleyview
> SILVERMONT_SERVER       0x40         Avaton, Rangely

0x5D SoFIA is another Silvermont variant on the client side, and doesn't
fit well in that scheme I'd say. Calling it SILVERMONT_SOFIA would
probably be best here so people can figure out what it is.

     Arnd
