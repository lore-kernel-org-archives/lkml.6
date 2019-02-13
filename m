Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DFDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375FF222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390430AbfBMOhR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:37:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:9788 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730377AbfBMOhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:37:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 06:37:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="143113131"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2019 06:37:15 -0800
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 13 Feb 2019 06:37:15 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.35]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.48]) with mapi id 14.03.0415.000;
 Wed, 13 Feb 2019 06:37:15 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Chan <michael.chan@broadcom.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v3 10/10] x86/split_lock: Handle #AC exception for split
 lock
Thread-Topic: [PATCH v3 10/10] x86/split_lock: Handle #AC exception for
 split lock
Thread-Index: AQHUurconjYUu8eSpUCLh/DOMa5OEaXbAMWA///z3YCAAwRtAP//4uhw
Date:   Wed, 13 Feb 2019 14:37:11 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D874D83@ORSMSX106.amr.corp.intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
 <1549084491-57808-11-git-send-email-fenghua.yu@intel.com>
 <20190211105339.GA40840@gmail.com>
 <20190211181013.GA103371@romley-ivt3.sc.intel.com>
 <20190213081450.GA53242@gmail.com>
In-Reply-To: <20190213081450.GA53242@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDYzNmViN2YtMDdiNy00NTBlLTg5ZmEtMjYxZjEyMGQzOTE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieUxVVXFwWGN4WG5VQXRnTzdJdXFRM2pQN1o0U2dJVDJTWFgwODB3a0NKWlhQYjdzSXIrdGNGT3NON1lrUnhwWiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar [mailto:mingo.kernel.org@gmail.com] On Behalf Of Ingo Molnar
> > On Mon, Feb 11, 2019 at 11:53:39AM +0100, Ingo Molnar wrote:
> > > > +		do_trap(trapnr, signr, str, regs, error_code, BUS_ADRALN,
> NULL);
> > > > +	}
> > > > +}
> > >
> > > Is there any experience with how frequently this signal is killing
> > > user-space processes on a modern distro? Any expectation of how
> > > frequent such SIGBUS task terminations are going to be in the field?
> >
> > We did pretty intensive testing internally (zero day tests, many
> > engineers and testers use the patches in their dailly work, etc). So
> > far I'm not aware of any user space process hiting split lock issue. I
> > guess GCC or other compilers takes care of the issue already. Inline
> > assembly code may hit the issue if code is not right, but there are
> > fewer inline assembly code in user space.
> >
> > So far we only find two kernel split lock issues and fix them in the
> > first two patches in this patch set. We also find one BIOS split lock
> > issue internally which has been fixed in production BIOS.
> >
> > Thanks.
> 
> Ok, still, for binary compatibility's sake, could you please add a sysctl knob
> (root-only, etc.) and a kernel boot parameter that disables this check?

In this patch set, we already extend kernel option "clearcpuid=" to support CPU
cap flags. So "clearcpuid=split_lock_detection" can disable this split lock
check during boot time.

In next version, I will add "/sys/kernel/split_lock_detection" to enable or disable
the split lock check during run time.

Hopefully these work.

Thanks.

-Fenghua
