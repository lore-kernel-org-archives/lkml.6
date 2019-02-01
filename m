Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7DEC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9720855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfBAPop convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:44:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:13747 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbfBAPom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:44:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 07:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="123190475"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2019 07:44:39 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.16]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 15:44:38 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH 1/3] perf: convert perf_event_context.refcount to
 refcount_t
Thread-Topic: [PATCH 1/3] perf: convert perf_event_context.refcount to
 refcount_t
Thread-Index: AQHUtwTi/sKFnZBdYUmAtnFolFsLAqXF/o0AgABHo5CABH7AAIAAU1TQ
Date:   Fri, 1 Feb 2019 15:44:38 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B9DD52@IRSMSX102.ger.corp.intel.com>
References: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
 <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
 <20190129093748.GF28467@hirez.programming.kicks-ass.net>
 <2236FBA76BA1254E88B949DDB74E612BA4B98D3A@IRSMSX102.ger.corp.intel.com>
 <20190201103254.GB31409@lakrids.cambridge.arm.com>
In-Reply-To: <20190201103254.GB31409@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTM5MTJiMGYtMzc5NC00ZjUzLTk2YTctMGJlNjIzNTVjNmFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUExHNW85QkhVWVd6RW5pSXl6YW5jV3FwQW12b2hUdmtUc3I4Q2c3XC9jcUhjZkZLczAwWk9lTG4wSythQjI1OFQifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 29, 2019 at 01:55:32PM +0000, Reshetova, Elena wrote:
> > > On Mon, Jan 28, 2019 at 02:27:26PM +0200, Elena Reshetova wrote:
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index 3cd13a3..a1e87d2 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -1171,7 +1171,7 @@ static void perf_event_ctx_deactivate(struct
> > > perf_event_context *ctx)
> > > >
> > > >  static void get_ctx(struct perf_event_context *ctx)
> > > >  {
> > > > -	WARN_ON(!atomic_inc_not_zero(&ctx->refcount));
> > > > +	WARN_ON(!refcount_inc_not_zero(&ctx->refcount));
> > >
> > > This could be refcount_inc(), remember how that already produces a WARN
> > > when we try and increment 0.
> >
> > But is this true for the x86 arch-specific implementation also?
> 
> If you use recount_inc_checked(), it will always produce the WARN(),
> even when using the x86-specific refcount implementation.
> 
> (this was one place I had intended to use the *_checked() forms of the
> refcount ops).

Yes, with refcount_inc_checked() it would work, but I don't like it
that much when we have functions that behave regardless of refcount 
config. It does help for code minimization & clarity like here, but I think 
it complicates things even more: two different configs, then functions that
do not obey configs, etc. 

Anyhow, I can change this to refcount_inc_checked(), if this is what everyone
thinks is the best. 

Best Regards,
Elena.



