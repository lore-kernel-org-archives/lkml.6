Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3876C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6152C20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6152C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbeGaTYL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:24:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:41652 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729767AbeGaTYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:24:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 10:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,428,1526367600"; 
   d="scan'208";a="79377193"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2018 10:42:28 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.242]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.59]) with mapi id 14.03.0319.002;
 Tue, 31 Jul 2018 10:42:28 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH V2] x86/speculation: Support Enhanced IBRS on future CPUs
Thread-Topic: [PATCH V2] x86/speculation: Support Enhanced IBRS on future
 CPUs
Thread-Index: AQHUKDpXeyPtJ37V00Gaz4M9pA51zKSotaGA///0qMCAAMpIgIAAI0Og
Date:   Tue, 31 Jul 2018 17:42:27 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F475E3158@ORSMSX114.amr.corp.intel.com>
References: <1532978396-2197-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1807302153570.1725@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F4757790C@ORSMSX114.amr.corp.intel.com>
 <alpine.DEB.2.21.1807311018040.1725@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807311018040.1725@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDg4ZDJiMjEtNzI2NC00ODUwLWJkZWYtYTA1Y2JjZWQ0NTM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQjFpYnl6N0xqaCtUZ2tqMXFRaTQyU0loTWd1VkxSTDJoaGJTQW1ucDNpcmlBNG5LS0pwcVNySHlXV0hjWDhYXC8ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The feature strings are automatically generated from the define. The comment
> can be used to supress them by an empty "" string or to modify them by a
> "override" string at the beginning of the comment.

I overlooked "override" part. Sorry! about that.
It's clear now. Thanks for the explanation.

> >
> > > > +	WARN_ON_ONCE(x86_spec_ctrl_base & SPEC_CTRL_IBRS);
> 
> Please remove the warnon as well.
>

Sure! I removed it but forgot to mention it.

> > > > +	/* Ensure SPEC_CTRL_IBRS is set after VMEXIT from a guest */
> > > > +	x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
> > >
> > > And what exactly writes the MSR?
> > >
> >
> > While booting, x86_spec_ctrl_setup_ap() does that and after VMEXIT
> > x86_spec_ctrl_restore_host().
> >
> > As x86_spec_ctrl_setup_ap() does wrmsrl(MSR_IA32_SPEC_CTRL,
> > x86_spec_ctrl_base), I thought writing here would be redundant.
> 
> x86_spec_ctrl_setup_ap() is only called on the AP but not on the BP. So the boot
> processor will not have it set, unless something else writes the MSR. So you
> really want to have an explicit write there.

Yes, that makes sense.
But on the machine, I see IBRS bit set on all cores. As you said, someone else might 
be writing the MSR. I will try to find that out and will update the patch accordingly.

I initially suspected it to be __ssb_select_mitigation() as I have 
"spec_store_bypass_disable=on" in the kernel command line, but turns out it's not so.
I will update you more on this.

Regards,
Sai
