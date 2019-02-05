Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E78CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361BA2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfBEL5E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:57:04 -0500
Received: from mga17.intel.com ([192.55.52.151]:4574 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfBEL5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:57:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 03:57:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="120097030"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
  by fmsmga007.fm.intel.com with ESMTP; 05 Feb 2019 03:57:02 -0800
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX151.ger.corp.intel.com (163.33.192.59) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 5 Feb 2019 11:57:01 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.160]) with mapi id 14.03.0415.000;
 Tue, 5 Feb 2019 11:57:01 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Subject: RE: [PATCH 0/5] sched refcount_t conversions
Thread-Topic: [PATCH 0/5] sched refcount_t conversions
Thread-Index: AQHUryk8nIpvQnacJEKv36LRANRZEaW1ME0AgBwD5BA=
Date:   Tue, 5 Feb 2019 11:57:00 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4BA2980@IRSMSX102.ger.corp.intel.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <20190118160312.GF14054@worktop.programming.kicks-ass.net>
In-Reply-To: <20190118160312.GF14054@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTgzM2FhNDQtZmUzMi00YjlmLTgxMTgtMzZjMzk1MmI4YTAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUlQ4TlpZUFBEWkpPWkprK1pyam5MRjk2NUQzZzhkMmU2WlQ5RXpFbHhybUI0S2ZnN2lSeGU0OU8xdEJ3aUV5MyJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jan 18, 2019 at 02:27:25PM +0200, Elena Reshetova wrote:
> > Elena Reshetova (5):
> >   sched: convert sighand_struct.count to refcount_t
> >   sched: convert signal_struct.sigcnt to refcount_t
> 
> These should really be seen by Oleg (bounced) and I'll await his reply.
> 
> >   sched: convert numa_group.refcount to refcount_t
> >   sched/task_struct: convert task_struct.usage to refcount_t
> >   sched/task_struct: convert task_struct.stack_refcount to refcount_t
> 
> Those are ok and I'll queue them.

Just to double check that nothing got lost in between: 
I noticed that above task_struct patches got merged, is numa_group one also
coming soon?

Best Regards,
Elena.
