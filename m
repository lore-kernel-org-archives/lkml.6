Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EFCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5420B2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5420B2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIYWmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:42:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:17969 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeIYWmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:42:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 09:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,302,1534834800"; 
   d="scan'208";a="93136136"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2018 09:34:25 -0700
Message-ID: <309a30584a56babbd4d25199f71b786442300c1e.camel@intel.com>
Subject: Re: [RFC PATCH v4 01/27] x86/cpufeatures: Add CPUIDs for
 Control-flow Enforcement Technology (CET)
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Tue, 25 Sep 2018 09:29:51 -0700
In-Reply-To: <20180925162705.GB30146@hirez.programming.kicks-ass.net>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
         <20180921150351.20898-2-yu-cheng.yu@intel.com>
         <20180925162705.GB30146@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 18:27 +0200, Peter Zijlstra wrote:
> On Fri, Sep 21, 2018 at 08:03:25AM -0700, Yu-cheng Yu wrote:
> 
> > diff --git a/arch/x86/kernel/cpu/scattered.c
> > b/arch/x86/kernel/cpu/scattered.c
> > index 772c219b6889..63cbb4d9938e 100644
> > --- a/arch/x86/kernel/cpu/scattered.c
> > +++ b/arch/x86/kernel/cpu/scattered.c
> > @@ -21,6 +21,7 @@ struct cpuid_bit {
> >  static const struct cpuid_bit cpuid_bits[] = {
> >  	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
> >  	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
> > +	{ X86_FEATURE_IBT,		CPUID_EDX, 20, 0x00000007, 0},
> 
>                                                                    ^^
> missing white space at the end there.

I will fix it.  Thanks!

