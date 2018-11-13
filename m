Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D328C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BCB2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 21:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BCB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeKNHHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 02:07:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:45059 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeKNHHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 02:07:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 13:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="96045377"
Received: from yyu32-desk1.sc.intel.com ([143.183.136.51])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Nov 2018 13:07:47 -0800
Message-ID: <43979cffef0a4b5ea90b3fc41b6f9edd2a4324db.camel@intel.com>
Subject: Re: [PATCH v5 05/27] Documentation/x86: Add CET description
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
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
        Eugene Syromiatnikov <esyr@redhat.com>,
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
Date:   Tue, 13 Nov 2018 13:02:24 -0800
In-Reply-To: <20181113184337.GM10502@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
         <20181011151523.27101-6-yu-cheng.yu@intel.com>
         <20181113184337.GM10502@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 19:43 +0100, Borislav Petkov wrote:
> On Thu, Oct 11, 2018 at 08:15:01AM -0700, Yu-cheng Yu wrote:
> > Explain how CET works and the no_cet_shstk/no_cet_ibt kernel
> > parameters.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   6 +
> >  Documentation/index.rst                       |   1 +
> >  Documentation/x86/index.rst                   |  11 +
> >  Documentation/x86/intel_cet.rst               | 266 ++++++++++++++++++
> >  4 files changed, 284 insertions(+)
> >  create mode 100644 Documentation/x86/index.rst
> >  create mode 100644 Documentation/x86/intel_cet.rst
> 
> So this patch should probably come first in the series so that a reader
> can know what to expect...
> 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index 92eb1f42240d..3854423f7c86 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2764,6 +2764,12 @@
> >  			noexec=on: enable non-executable mappings (default)
> >  			noexec=off: disable non-executable mappings
> >  
> > +	no_cet_ibt	[X86-64] Disable indirect branch tracking for
> > user-mode
> > +			applications
> > +
> > +	no_cet_shstk	[X86-64] Disable shadow stack support for user-
> > mode
> > +			applications
> > +
> >  	nosmap		[X86]
> >  			Disable SMAP (Supervisor Mode Access Prevention)
> >  			even if it is supported by processor.
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index 5db7e87c7cb1..1cdc139adb40 100644
> > --- a/Documentation/index.rst
> > +++ b/Documentation/index.rst
> 
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense:
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #76: FILE: Documentation/x86/index.rst:1:
> +=======================
> 
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #93: FILE: Documentation/x86/intel_cet.rst:1:
> +=========================================
> 
> > @@ -104,6 +104,7 @@ implementation.
> >     :maxdepth: 2
> >  
> >     sh/index
> > +   x86/index
> >  
> >  Filesystem Documentation
> >  ------------------------
> > diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> > new file mode 100644
> > index 000000000000..9c34d8cbc8f0
> > --- /dev/null
> > +++ b/Documentation/x86/index.rst
> > @@ -0,0 +1,11 @@
> > +=======================
> > +X86 Documentation
> > +=======================
> > +
> > +Control Flow Enforcement
> > +========================
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   intel_cet
> > diff --git a/Documentation/x86/intel_cet.rst
> > b/Documentation/x86/intel_cet.rst
> > new file mode 100644
> > index 000000000000..946f4802a51f
> > --- /dev/null
> > +++ b/Documentation/x86/intel_cet.rst
> > @@ -0,0 +1,266 @@
> > +=========================================
> > +Control Flow Enforcement Technology (CET)
> > +=========================================
> > +
> > +[1] Overview
> > +============
> > +
> > +Control Flow Enforcement Technology (CET) provides protection against
> > +return/jump-oriented programming (ROP) attacks.  It can be implemented
> > +to protect both the kernel and applications.  In the first phase,
> > +only the user-mode protection is implemented on the 64-bit kernel.
> 
> s/the//			         is implemented in 64-bit mode.
> 
> > +However, 32-bit applications are supported under the compatibility
> > +mode.
> 
> Drop "However":
> 
> "32-bit applications are, of course, supported in compatibility mode."
> 
> > +
> > +CET includes shadow stack (SHSTK) and indirect branch tracking (IBT).
> 
> "CET introduces two a shadow stack and an indirect branch tracking mechanism."
> 
> > +The SHSTK is a secondary stack allocated from memory.  The processor
> 
> s/The//
> 
> > +automatically pushes/pops a secure copy to the SHSTK every return
> > +address and,
> 
> that reads funny - pls reorganize. Also, what is a "secure copy"?
> 
> You mean a copy of every return address which software cannot access?
> 
> > by comparing the secure copy to the program stack copy,
> > +verifies function returns are as intended. 
> 
> 			 ... have not been corrupted/modified."
> 
> > The IBT verifies all
> > +indirect CALL/JMP targets are intended and marked by the compiler with
> > +'ENDBR' op codes.
> 
> "opcode" - one word. And before you use "ENDBR" you need to explain it
> above what it is.
> 
> /me reads further... encounters ENDBR's definition...
> 
> ah, ok, so you should say something like
> 
> "... and marked by the compiler with the ENDBR opcode (see below)."

I will work on it.  Thanks!

Yu-cheng
