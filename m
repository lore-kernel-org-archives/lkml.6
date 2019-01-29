Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CBC20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfA2Nzg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:55:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:39672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2Nzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:55:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 05:55:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="138836433"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jan 2019 05:55:33 -0800
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 IRSMSX154.ger.corp.intel.com (163.33.192.96) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 29 Jan 2019 13:55:33 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.157]) with mapi id 14.03.0415.000;
 Tue, 29 Jan 2019 13:55:33 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHUtwTi/sKFnZBdYUmAtnFolFsLAqXF/o0AgABHo5A=
Date:   Tue, 29 Jan 2019 13:55:32 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B98D3A@IRSMSX102.ger.corp.intel.com>
References: <1548678448-24458-1-git-send-email-elena.reshetova@intel.com>
 <1548678448-24458-2-git-send-email-elena.reshetova@intel.com>
 <20190129093748.GF28467@hirez.programming.kicks-ass.net>
In-Reply-To: <20190129093748.GF28467@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjY1ODdiOGUtMDQ1Yy00ZDFhLTkxMzgtMWM0Y2JjODA2ZWMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiblY1YmNpRlRsNVpzZnhvakJYYUxtelpSSWl3SUxFSXU2aWxIeVREdmRSSm9SMFNSSTNqY3NEM2VVTkMwMDhvVyJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 28, 2019 at 02:27:26PM +0200, Elena Reshetova wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 3cd13a3..a1e87d2 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -1171,7 +1171,7 @@ static void perf_event_ctx_deactivate(struct
> perf_event_context *ctx)
> >
> >  static void get_ctx(struct perf_event_context *ctx)
> >  {
> > -	WARN_ON(!atomic_inc_not_zero(&ctx->refcount));
> > +	WARN_ON(!refcount_inc_not_zero(&ctx->refcount));
> 
> This could be refcount_inc(), remember how that already produces a WARN
> when we try and increment 0.

But is this true for the x86 arch-specific implementation also? 
