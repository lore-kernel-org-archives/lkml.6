Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3484C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C844D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfARRmg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:42:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:55386 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfARRmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:42:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2019 09:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,491,1539673200"; 
   d="scan'208";a="126909419"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2019 09:42:33 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX104.ger.corp.intel.com ([169.254.5.101]) with mapi id 14.03.0415.000;
 Fri, 18 Jan 2019 17:41:32 +0000
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
Subject: RE: [PATCH 0/5] sched refcount_t conversions
Thread-Topic: [PATCH 0/5] sched refcount_t conversions
Thread-Index: AQHUryk8nIpvQnacJEKv36LRANRZEaW1II0AgAArGOA=
Date:   Fri, 18 Jan 2019 17:41:32 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B872C9@IRSMSX102.ger.corp.intel.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <20190118150650.GA8790@andrea>
In-Reply-To: <20190118150650.GA8790@andrea>
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

> On Fri, Jan 18, 2019 at 02:27:25PM +0200, Elena Reshetova wrote:
> > I would really love finally to merge these old patches
> > (now rebased on top of linux-next/master as of last friday),
> > since as far as I remember none has raised any more concerns
> > on them.
> >
> > refcount_t has been now successfully used in kernel in many places,
> > helped to detect bugs and mistakes in logic of refcounters.
> >
> > This series, for scheduler and task struct specifically,
> > replaces atomic_t reference counters with the new refcount_t type
> > and API (see include/linux/refcount.h).
> > By doing this we prevent intentional or accidental
> > underflows or overflows that can lead to use-after-free vulnerabilities.
> >
> > The patches are fully independent and can be cherry-picked separately.
> > More information about each conversion in each patch separately.
> >
> > Elena Reshetova (5):
> >   sched: convert sighand_struct.count to refcount_t
> >   sched: convert signal_struct.sigcnt to refcount_t
> >   sched: convert numa_group.refcount to refcount_t
> >   sched/task_struct: convert task_struct.usage to refcount_t
> >   sched/task_struct: convert task_struct.stack_refcount to refcount_t
> 
> For the series, please feel free to add:
> 
> Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Thank you for your review!

Best Regards,
Elena
