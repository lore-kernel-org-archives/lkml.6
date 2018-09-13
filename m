Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F9C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B7820882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B7820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeIMFL5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:11:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:33011 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeIMFL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:11:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 17:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,366,1531810800"; 
   d="scan'208";a="72517985"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga007.jf.intel.com with ESMTP; 12 Sep 2018 17:04:50 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.245]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.237]) with mapi id 14.03.0319.002;
 Wed, 12 Sep 2018 17:04:49 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Tim Chen" <tim.c.chen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Subject: RE: [PATCH v6 1/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Thread-Topic: [PATCH v6 1/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Thread-Index: AQHUSnfcgPZqQHPKzEai9gKgBF5YbqTtP0sA
Date:   Thu, 13 Sep 2018 00:04:49 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732144BFBC@ORSMSX107.amr.corp.intel.com>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809121105330.15880@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1809121105330.15880@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDYyZmIxOTgtZDkyMy00ZWE3LTk0MGYtMGI3MGY5MmYwODBiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTnhBR1ZwYnVSdW5POWpOM0VCM2JBeVI2UmlcL1NRMXpYSDR0QkZSRERGNEtsSFlzbzBVZDh0NEhETHBJWTlXYnYifQ==
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

> -----Original Message-----
> From: Jiri Kosina [mailto:jikos@kernel.org]
> 
> 

> @@ -325,10 +326,13 @@ static int __ptrace_may_access(struct task_struct
> *task, unsigned int mode)
>  	mm = task->mm;
>  	if (mm &&
>  	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
> -	     !ptrace_has_cap(mm->user_ns, mode)))
> +	     ((mode & PTRACE_MODE_NOACCESS_CHK) ||
> +	       !ptrace_has_cap(mm->user_ns, mode))))
>  	    return -EPERM;
> 
> -	return security_ptrace_access_check(task, mode);
> +	if (!(mode & PTRACE_MODE_NOACCESS_CHK))
> +		return security_ptrace_access_check(task, mode);
> +	return 0;

Because PTRACE_MODE_IBPB includes PTRACE_MODE_NOAUDIT you
shouldn't need this change. Do you have a good way to exercise this code
path? I'm having trouble getting to the check, and have yet to get a case
where PTRACE_MODE_NOACCESS_CHK is set.

>  }
> 
>  bool ptrace_may_access(struct task_struct *task, unsigned int mode)
> 
> --
> Jiri Kosina
> SUSE Labs

