Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4604C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563E2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBDGvC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:51:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:29873 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfBDGvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:51:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2019 22:51:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,559,1539673200"; 
   d="scan'208";a="113476840"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2019 22:50:58 -0800
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX107.ger.corp.intel.com (163.33.3.99) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Feb 2019 06:50:57 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.160]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 06:50:57 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: RE: [PATCH] uprobes: convert uprobe.ref to refcount_t
Thread-Topic: [PATCH] uprobes: convert uprobe.ref to refcount_t
Thread-Index: AQHUrY2Yq0EjPRAwRUCLAKsVmClMRaXLSiAAgAQGjiA=
Date:   Mon, 4 Feb 2019 06:50:56 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4BA0C70@IRSMSX102.ger.corp.intel.com>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
 <20190201172150.GA1853@linux.vnet.ibm.com>
In-Reply-To: <20190201172150.GA1853@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTEwM2UxNWMtYmMzNi00Y2I2LWJlMmYtNzg5ZmRhNTNmNGZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia1htN05kajVNeTR6NEdvT2dUbXJxZlV6UDU0ZStDdzhscFdESHZpaWdCS2x5WjhpNGhldjB5MDNQMW5RMDJQYSJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> * Elena Reshetova <elena.reshetova@intel.com> [2019-01-16 13:20:27]:
> 
> > atomic_t variables are currently used to implement reference
> > counters with the following properties:
> >  - counter is initialized to 1 using atomic_set()
> >  - a resource is freed upon counter reaching zero
> >  - once counter reaches zero, its further
> >    increments aren't allowed
> >  - counter schema uses basic atomic operations
> >    (set, inc, inc_not_zero, dec_and_test, etc.)
> >
> > Such atomic variables should be converted to a newly provided
> > refcount_t type and API that prevents accidental counter overflows
> > and underflows. This is important since overflows and underflows
> > can lead to use-after-free situation and be exploitable.
> >
> > The variable uprobe.ref is used as pure reference counter.
> > Convert it to refcount_t and fix up the operations.
> >
> > **Important note for maintainers:
> >
> > Some functions from refcount_t API defined in lib/refcount.c
> > have different memory ordering guarantees than their atomic
> > counterparts.
> > The full comparison can be seen in
> > https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> > in state to be merged to the documentation tree.
> > Normally the differences should not matter since refcount_t provides
> > enough guarantees to satisfy the refcounting use cases, but in
> > some rare cases it might matter.
> > Please double check that you don't have some undocumented
> > memory guarantees for this variable usage.
> >
> > For the uprobe.ref it might make a difference
> > in following places:
> >  - put_uprobe(): decrement in refcount_dec_and_test() only
> >    provides RELEASE ordering and control dependency on success
> >    vs. fully ordered atomic counterpart
> >
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > ---
> >  kernel/events/uprobes.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> 
> Looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thank you very much Srikar!
Would you be able to take this patch to integration?

Best Regards,
Elena.

