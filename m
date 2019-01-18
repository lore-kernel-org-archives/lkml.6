Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB41C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D7320823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfARRYW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:24:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:18749 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfARRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:24:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 09:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="115727686"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jan 2019 09:24:20 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.47]) with mapi id 14.03.0415.000;
 Fri, 18 Jan 2019 17:24:19 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH 1/5] sched: convert sighand_struct.count to refcount_t
Thread-Topic: [PATCH 1/5] sched: convert sighand_struct.count to refcount_t
Thread-Index: AQHUryk+/hLqHu17K0+WlS07ChGXxKW0/A2AgAAw1tA=
Date:   Fri, 18 Jan 2019 17:24:19 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B8723A@IRSMSX102.ger.corp.intel.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <1547814450-18902-2-git-send-email-elena.reshetova@intel.com>
 <20190118125611.GA8205@andrea>
In-Reply-To: <20190118125611.GA8205@andrea>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Elena,

Hi!

> 
> [...]
> 
> > **Important note for maintainers:
> >
> > Some functions from refcount_t API defined in lib/refcount.c
> > have different memory ordering guarantees than their atomic
> > counterparts.
> > The full comparison can be seen in
> > https://lkml.org/lkml/2017/11/15/57 and it is hopefully soon
> > in state to be merged to the documentation tree.
> 
> Just a remark to point out that that document got merged, even though
> in a different location/format: c.f.,
> 
>   b6e859f6cdd1 ("docs: refcount_t documentation")
> 

Ups, indeed, forgot that we merged the docs. It has been long time that 
these patches has been sitting in my old repo. 

Best Regards,
Elena.
