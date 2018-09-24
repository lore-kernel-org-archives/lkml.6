Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FA1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C9120883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C9120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbeIXVdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:33:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:56450 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeIXVdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:33:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 08:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="91460965"
Received: from 2b52.sc.intel.com ([143.183.136.51])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2018 08:30:27 -0700
Message-ID: <4e453720b77fd9c4dade6fcefc5b6f0eea396a1a.camel@intel.com>
Subject: Re: [RFC PATCH v4 00/27] Control Flow Enforcement: Shadow Stack
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Mon, 24 Sep 2018 08:25:51 -0700
In-Reply-To: <1ca5178d-60f3-ae70-ce95-7026ac0429b4@linux.intel.com>
References: <20180921150351.20898-1-yu-cheng.yu@intel.com>
         <1ca5178d-60f3-ae70-ce95-7026ac0429b4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-21 at 15:53 -0700, Dave Hansen wrote:
> On 09/21/2018 08:03 AM, Yu-cheng Yu wrote:
> > The previous version of CET patches can be found in the following
> > link:
> > 
> >   https://lkml.org/lkml/2018/8/30/608
> 
> So, this is an RFC, but there no mention of what you want comments *on*. :)
> 
> What do you want folks to review?  What needs to get settled before this
> is merged?

Thanks, Dave!

These patches passed GLIBC built-in tests and more tests HJ and I put together
at https://github.com/hjl-tools/cet-smoke-test.

I made some changes since V3 as outlined in the cover letter.
In particular there are two new patches for the VMA guard and preventing shadow
stack merging.  Does anyone have comments on those and the whole Shadow
Stack/IBT series in general?

Thanks,
Yu-cheng

