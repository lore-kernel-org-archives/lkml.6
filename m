Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85767C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499092082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499092082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeHaC6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:58:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:52478 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeHaC6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:58:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 15:54:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="85936098"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2018 15:54:06 -0700
Message-ID: <1535669391.28781.7.camel@intel.com>
Subject: Re: [RFC PATCH v3 05/24] Documentation/x86: Add CET description
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
Date:   Thu, 30 Aug 2018 15:49:51 -0700
In-Reply-To: <20180830203948.GB1936@amd>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
         <20180830143904.3168-6-yu-cheng.yu@intel.com> <20180830203948.GB1936@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-30 at 22:39 +0200, Pavel Machek wrote:
> Hi!
> 
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index 9871e649ffef..b090787188b4 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2764,6 +2764,12 @@
> >  			noexec=on: enable non-executable mappings
> > (default)
> >  			noexec=off: disable non-executable
> > mappings
> >  
> > +	no_cet_ibt	[X86-64] Disable indirect branch
> > tracking for user-mode
> > +			applications
> > +
> > +	no_cet_shstk	[X86-64] Disable shadow stack support
> > for user-mode
> > +			applications
> Hmm, not too consistent with "nosmap" below. Would it make sense to
> have cet=on/off/ibt/shstk instead?
> 
> > 
> > +++ b/Documentation/x86/intel_cet.rst
> > @@ -0,0 +1,252 @@
> > +=========================================
> > +Control Flow Enforcement Technology (CET)
> > +=========================================
> > +
> > +[1] Overview
> > +============
> > +
> > +Control Flow Enforcement Technology (CET) provides protection
> > against
> > +return/jump-oriented programing (ROP) attacks.
> Can you add something like "It attempts to protect process from
> running arbitrary code even after attacker has control of its stack"
> -- for people that don't know what ROP is, and perhaps link to
> wikipedia explaining ROP or something...
> 
> > 
> > It can be implemented
> > +to protect both the kernel and applications.  In the first phase,
> > +only the user-mode protection is implemented for the 64-bit
> > kernel.
> > +Thirty-two bit applications are supported under the compatibility
> 32-bit (for consistency).
> 
> Ok, so CET stops execution of malicious code before architectural
> effects are visible, correct? Does it prevent micro-architectural
> effects of the malicious code? (cache content would be one example;
> see Spectre).
> 
> > 
> > +[3] Application Enabling
> > +========================
> "Enabling CET in applications" ?
> 
> > 
> > +Signal
> > +------
> > +
> > +The main program and its signal handlers use the same
> > SHSTK.  Because
> > +the SHSTK stores only return addresses, we can estimate a large
> > +enough SHSTK to cover the condition that both the program stack
> > and
> > +the sigaltstack run out.
> English? Is it estimate or is it large enough? "a large" -- "a"
> should
> be deleted AFAICT.
>  

I will work on these, thanks!
