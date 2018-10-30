Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4F3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C77C2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C77C2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeJaCtV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:49:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:50171 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbeJaCtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:49:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 10:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="85408266"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2018 10:54:53 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 10:54:53 -0700
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 10:54:52 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.49]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 11:54:49 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/fsgsbase/64: Fix the base write helper functions
Thread-Topic: [PATCH] x86/fsgsbase/64: Fix the base write helper functions
Thread-Index: AQHUcHXzyJaeP41KZUe+LIVY1qL3yKU4EF/g
Date:   Tue, 30 Oct 2018 17:54:48 +0000
Message-ID: <C9BB696F3A938947B10DCAD29FAB8FFA66CD7D84@CRSMSX101.amr.corp.intel.com>
References: <20181030172719.6753-1-chang.seok.bae@intel.com>
In-Reply-To: <20181030172719.6753-1-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWNmY2NmNWYtNTE0YS00MzY0LTg5OTgtZmEyYjVhZWRhYzlmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiajg1MzFFREpGNk96ZEtYREJzcytXUWlRRCs4ZjNcLzNPM2hkQkkyaUwxZitmM3RuUG04MTJGUXFtTExlQzU1TTYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Factor out the code to change index from x86_fsbase_write_cpu() and
> x86_gsbase_write_cpu_inactive(). Now the code is located in
> do_arch_prctl_64().
> 
> The helper functions that purport to write the base register should just write the
> base register only. It shouldn't have magic optimizations to change the index.
> 
> putreg() in ptrace does not write the current task, but a stopped task.
> 

Wm, I just realized that the changelog should also clearly include this:
	"While at here, subsequently factor out the read for the current task's base 
	from x86_fsbase_read_task() and x86_gsbase_read_task() to do_arch_prctl_64()."
Sorry for this. Let me know if you feel it should go as a separate patch.

Chang
