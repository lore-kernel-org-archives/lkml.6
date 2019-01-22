Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058D32085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfAVJLr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:11:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:27132 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfAVJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:11:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 01:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; 
   d="scan'208";a="116440142"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2019 01:11:43 -0800
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX107.ger.corp.intel.com (163.33.3.99) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 22 Jan 2019 09:11:43 +0000
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.160]) with mapi id 14.03.0415.000;
 Tue, 22 Jan 2019 09:11:43 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH 2/5] sched: convert signal_struct.sigcnt to refcount_t
Thread-Topic: [PATCH 2/5] sched: convert signal_struct.sigcnt to refcount_t
Thread-Index: AQHUryk/+6USNNTpGUy8c415xyULQ6W5/xiAgAEHKeA=
Date:   Tue, 22 Jan 2019 09:11:42 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B8B877@IRSMSX102.ger.corp.intel.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
 <20190121172822.GB8088@redhat.com>
In-Reply-To: <20190121172822.GB8088@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 01/18, Elena Reshetova wrote:
> >
> > For the signal_struct.sigcnt it might make a difference
> > in following places:
> >  - put_signal_struct(): decrement in refcount_dec_and_test() only
> >    provides RELEASE ordering and control dependency on success
> >    vs. fully ordered atomic counterpart
> 
> this is fine.
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thank you Oleg! 

Will you be able to take this and the other scheduler
patch to whatever tree/path it should normally go to get eventually 
integrated? 

Best Regards,
Elena.
