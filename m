Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1377420841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1377420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbeHAJqQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:46:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:4897 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387673AbeHAJqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:46:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 01:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,431,1526367600"; 
   d="scan'208";a="220819594"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2018 01:01:49 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 01:01:49 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.242]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.221]) with mapi id 14.03.0319.002;
 Wed, 1 Aug 2018 01:01:48 -0700
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
Thread-Index: AQHUKDpXeyPtJ37V00Gaz4M9pA51zKSotaGA///0qMCAAMpIgIAAI0OggACazwCAAFa4cA==
Date:   Wed, 1 Aug 2018 08:01:47 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F47654398@ORSMSX114.amr.corp.intel.com>
References: <1532978396-2197-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1807302153570.1725@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F4757790C@ORSMSX114.amr.corp.intel.com>
 <alpine.DEB.2.21.1807311018040.1725@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F475E3158@ORSMSX114.amr.corp.intel.com>
 <alpine.DEB.2.21.1807312139350.1713@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807312139350.1713@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjI0Mzg4NzUtMjJmOC00ZGFlLTlkZDUtZGU3ZjE5NGU4NzQxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU0tEQ0pXOWZrZVpYZlFPNE1aTEV0OGEwWFZSTDZtTDY3S0VIK2pmb29lS3BmemhaM3hpY2JzYjBreFFrRzlFXC8ifQ==
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

> > Yes, that makes sense.
> > But on the machine, I see IBRS bit set on all cores. As you said,
> > someone else might be writing the MSR. I will try to find that out and will
> update the patch accordingly.
> >
> > I initially suspected it to be __ssb_select_mitigation() as I have
> > "spec_store_bypass_disable=on" in the kernel command line, but turns out it's
> not so.
> > I will update you more on this.
> 
> There are lots of places like the firmware mitigation stuff and other things which
> write that MSR. And because the bit is set in x86_spec_ctrl_base it will be on at
> some point and stay so.

True! After a bit of experimenting with printk(), I see that it's being set by 
intel_set_ssb_state() during systemd initialization.

> 
> Writing it explicitely at the point where it is set makes it independent of other
> mechanisms which touch that MSR and Just Works.

Yes, that makes sense. I will add an explicit wrmsrl().
Just wanted to have a better understanding of how things work.

Regards,
Sai
