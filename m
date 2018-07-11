Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A03C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BCD20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BCD20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbeGKPeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:34:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:46172 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbeGKPeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:34:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 08:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="71458759"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2018 08:29:26 -0700
Message-ID: <1531322749.13297.17.camel@intel.com>
Subject: Re: [RFC PATCH v2 05/27] Documentation/x86: Add CET description
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Pavel Machek <pavel@ucw.cz>
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
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 11 Jul 2018 08:25:49 -0700
In-Reply-To: <20180711082739.GA18919@amd>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-6-yu-cheng.yu@intel.com> <20180711082739.GA18919@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 10:27 +0200, Pavel Machek wrote:
> On Tue 2018-07-10 15:26:17, Yu-cheng Yu wrote:
> > 
> > Explain how CET works and the no_cet_shstk/no_cet_ibt kernel
> > parameters.
> > 
> > 
> > --- /dev/null
> > +++ b/Documentation/x86/intel_cet.txt
> > @@ -0,0 +1,250 @@
> > +=========================================
> > +Control Flow Enforcement Technology (CET)
> > +=========================================
> We normally use .rst for this kind of formatted text.

I will change this to a .rst file.

> 
> 
> > 
> > +[6] The implementation of the SHSTK
> > +===================================
> > +
> > +SHSTK size
> > +----------
> > +
> > +A task's SHSTK is allocated from memory to a fixed size that can
> > +support 32 KB nested function calls; that is 256 KB for a 64-bit
> > +application and 128 KB for a 32-bit application.  The system admin
> > +can change the default size.
> How does admin change that? We already have ulimit for stack size,
> should those be somehow tied together?
> 
> $ ulimit -a
> ...
> stack size              (kbytes, -s) 8192
> 

We can do that.  This makes sense to me.

Yu-cheng

