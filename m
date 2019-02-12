Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5488520842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfBLRxE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:53:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:64079 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfBLRxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:53:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 09:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="299188860"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 09:52:56 -0800
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.35]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.11]) with mapi id 14.03.0415.000;
 Tue, 12 Feb 2019 09:52:56 -0800
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Thread-Topic: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Thread-Index: AQHUurcny1nr1bh3OUa368MjRfPkBKXQdIYAgAAVcwCAAA5OAIAADdAAgADJ2YCAAG0OAIAAHVWAgAgBrgCAAQs1gIABucMAgAADrQCAADGcgP//iwUA
Date:   Tue, 12 Feb 2019 17:52:55 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D873902@ORSMSX106.amr.corp.intel.com>
References: <9fa7406b-113f-fe0a-9fc7-ef00b3a6b620@intel.com>
 <20190204195704.GJ29639@zn.tnic>
 <5c2f0af3-1740-f16b-6ff6-6bec6a325034@intel.com>
 <20190205084857.GK17528@hirez.programming.kicks-ass.net>
 <ec193a66-b395-ed1a-e39c-40fa1ece3f56@intel.com>
 <20190205170415.GG17550@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902102012520.8784@nanos.tec.linutronix.de>
 <20190211191643.GB103371@romley-ivt3.sc.intel.com>
 <20190212133750.GJ32494@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1902121444250.3710@nanos.tec.linutronix.de>
 <20190212164833.GK32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190212164833.GK32494@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTJjZDljNzgtOTAxYi00MjczLWE5Y2EtYzZjYzE0OTExNzdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidVY3K3N3blZHOXloMmlmczZwWVlSRjkzK3ZpTzhjdkk0SW1vZ3FqNlwvb29LM0p3ZDhUWXY4Wk1vV1BSRVwveTN6In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Peter Zijlstra [mailto:peterz@infradead.org]
> On Tue, Feb 12, 2019 at 02:51:00PM +0100, Thomas Gleixner wrote:
> > On Tue, 12 Feb 2019, Peter Zijlstra wrote:
> >
> > > On Mon, Feb 11, 2019 at 11:16:43AM -0800, Fenghua Yu wrote:
> > > > 4. The feature can be disabled by kernel option
> > > > "clearcpuid=split_lock_detection" during early boot time.
> > >
> > > IFF clearcpuid lives, it should also employ CPUID faulting and clear
> > > it for userspace too.
> >
> > We have it already,
> 
> D'0h right, I thought that was introduced here, but that's just extending it
> to multiple arguments.

In this patch set, patch #5 extends clearcpuid to support multiple options and
Patch #6 extends clearcpuid to support cpu cap flag strings. So we already have
string support and can use "clearcpuid=split_lock_detection" to disable
the split lock feature at the boot time.

Thanks.

-Fenghua
