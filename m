Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93043C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A49A2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 18:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfA0Sln convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 13:41:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:32379 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfA0Sln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 13:41:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2019 10:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,531,1539673200"; 
   d="scan'208";a="128958615"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2019 10:41:40 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX151.ger.corp.intel.com ([169.254.4.172]) with mapi id 14.03.0415.000;
 Sun, 27 Jan 2019 18:41:39 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Topic: [PATCH] kcov: convert kcov.refcount to refcount_t
Thread-Index: AQHUrYYWOOwEuMXWwEOBiuSRPC5USKWx2V6AgAepqoCAADl1AIAALpmAgAEc9ACACHwm4A==
Date:   Sun, 27 Jan 2019 18:41:38 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B944B3@IRSMSX102.ger.corp.intel.com>
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
 <20190122090456.GE13777@hirez.programming.kicks-ass.net>
In-Reply-To: <20190122090456.GE13777@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjk3OGZmMWItYWY2Zi00NDUwLTg3YTMtNzZmNzRlYTk1MzI0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieklCT2l3bGtaOXU2VVllZkoxRnFRTDl0V25TUHEyVXFvNFVJNzJMNnpsRmN5cmh5XC9jd2FMV20weUI1YTZCZ2QifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 21, 2019 at 11:05:03AM -0500, Alan Stern wrote:
> > On Mon, 21 Jan 2019, Peter Zijlstra wrote:
> 
> > > Any additional ordering; like the one you have above; are not strictly
> > > required for the proper functioning of the refcount. Rather, you rely on
> > > additional ordering and will need to provide this explicitly:
> > >
> > >
> > > 	if (refcount_dec_and_text(&x->rc)) {
> > > 		/*
> > > 		 * Comment that explains what we order against....
> > > 		 */
> > > 		smp_mb__after_atomic();
> > > 		BUG_ON(!x->done*);
> > > 		free(x);
> > > 	}
> > >
> > >
> > > Also; these patches explicitly mention that refcount_t is weaker,
> > > specifically to make people aware of this difference.
> > >
> > > A full smp_mb() (or two) would also be much more expensive on a number
> > > of platforms and in the vast majority of the cases it is not required.
> >
> > How about adding smp_rmb() into refcount_dec_and_test()?  That would
> > give acq+rel semantics, which seems to be what people will expect.  And
> > it wouldn't be nearly as expensive as a full smp_mb().
> 
> Yes, that's a very good suggestion.
> 
> I suppose we can add smp_acquire__after_ctrl_dep() on the true branch.
> Then it reall does become rel_acq.
> 
> A wee something like so (I couldn't find an arm64 refcount, even though
> I have distinct memories of talk about it).
> 
> This isn't compiled, and obviously needs comment/documentation updates
> to go along with it.
> 
> ---
>  arch/x86/include/asm/refcount.h | 9 ++++++++-
>  lib/refcount.c                  | 7 ++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index dbaed55c1c24..6f7a1eb345b4 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -74,9 +74,16 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
> 
>  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
> -	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> +	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> 
> 	REFCOUNT_CHECK_LT_ZERO,
>  					r-
> >refs.counter, e, "cx");
> +
> +	if (ret) {
> +		smp_acquire__after_ctrl_dep();
> +		return true;
> +	}
> +
> +	return false;
>  }

Actually as I started to do this, any reason why the change here only for dec_and_test and not
for sub_and _test also? Should not the arch. specific logic follow the generic?

Best Regards,
Elena. 
