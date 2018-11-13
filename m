Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD653224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD653224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeKNEnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:43:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53556 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbeKNEnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:43:11 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1IpCPw9TDn4i; Tue, 13 Nov 2018 19:43:48 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15BD31EC00EB;
        Tue, 13 Nov 2018 19:43:48 +0100 (CET)
Date:   Tue, 13 Nov 2018 19:43:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
Subject: Re: [PATCH v5 05/27] Documentation/x86: Add CET description
Message-ID: <20181113184337.GM10502@zn.tnic>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011151523.27101-6-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:15:01AM -0700, Yu-cheng Yu wrote:
> Explain how CET works and the no_cet_shstk/no_cet_ibt kernel
> parameters.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  Documentation/index.rst                       |   1 +
>  Documentation/x86/index.rst                   |  11 +
>  Documentation/x86/intel_cet.rst               | 266 ++++++++++++++++++
>  4 files changed, 284 insertions(+)
>  create mode 100644 Documentation/x86/index.rst
>  create mode 100644 Documentation/x86/intel_cet.rst

So this patch should probably come first in the series so that a reader
can know what to expect...

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 92eb1f42240d..3854423f7c86 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2764,6 +2764,12 @@
>  			noexec=on: enable non-executable mappings (default)
>  			noexec=off: disable non-executable mappings
>  
> +	no_cet_ibt	[X86-64] Disable indirect branch tracking for user-mode
> +			applications
> +
> +	no_cet_shstk	[X86-64] Disable shadow stack support for user-mode
> +			applications
> +
>  	nosmap		[X86]
>  			Disable SMAP (Supervisor Mode Access Prevention)
>  			even if it is supported by processor.
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 5db7e87c7cb1..1cdc139adb40 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#76: FILE: Documentation/x86/index.rst:1:
+=======================

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#93: FILE: Documentation/x86/intel_cet.rst:1:
+=========================================

> @@ -104,6 +104,7 @@ implementation.
>     :maxdepth: 2
>  
>     sh/index
> +   x86/index
>  
>  Filesystem Documentation
>  ------------------------
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> new file mode 100644
> index 000000000000..9c34d8cbc8f0
> --- /dev/null
> +++ b/Documentation/x86/index.rst
> @@ -0,0 +1,11 @@
> +=======================
> +X86 Documentation
> +=======================
> +
> +Control Flow Enforcement
> +========================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   intel_cet
> diff --git a/Documentation/x86/intel_cet.rst b/Documentation/x86/intel_cet.rst
> new file mode 100644
> index 000000000000..946f4802a51f
> --- /dev/null
> +++ b/Documentation/x86/intel_cet.rst
> @@ -0,0 +1,266 @@
> +=========================================
> +Control Flow Enforcement Technology (CET)
> +=========================================
> +
> +[1] Overview
> +============
> +
> +Control Flow Enforcement Technology (CET) provides protection against
> +return/jump-oriented programming (ROP) attacks.  It can be implemented
> +to protect both the kernel and applications.  In the first phase,
> +only the user-mode protection is implemented on the 64-bit kernel.

s/the//			         is implemented in 64-bit mode.

> +However, 32-bit applications are supported under the compatibility
> +mode.

Drop "However":

"32-bit applications are, of course, supported in compatibility mode."

> +
> +CET includes shadow stack (SHSTK) and indirect branch tracking (IBT).

"CET introduces two a shadow stack and an indirect branch tracking mechanism."

> +The SHSTK is a secondary stack allocated from memory.  The processor

s/The//

> +automatically pushes/pops a secure copy to the SHSTK every return
> +address and,

that reads funny - pls reorganize. Also, what is a "secure copy"?

You mean a copy of every return address which software cannot access?

> by comparing the secure copy to the program stack copy,
> +verifies function returns are as intended. 

			 ... have not been corrupted/modified."

> The IBT verifies all
> +indirect CALL/JMP targets are intended and marked by the compiler with
> +'ENDBR' op codes.

"opcode" - one word. And before you use "ENDBR" you need to explain it
above what it is.

/me reads further... encounters ENDBR's definition...

ah, ok, so you should say something like

"... and marked by the compiler with the ENDBR opcode (see below)."

> +
> +There are two kernel configuration options:
> +
> +    INTEL_X86_SHADOW_STACK_USER, and
> +    INTEL_X86_BRANCH_TRACKING_USER.
> +
> +To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or later
> +are required.  To build a CET-enabled application, GLIBC v2.28 or
> +later is also required.
> +
> +There are two command-line options for disabling CET features:
> +
> +    no_cet_shstk - disables SHSTK, and
> +    no_cet_ibt - disables IBT.
> +
> +At run time, /proc/cpuinfo shows the availability of SHSTK and IBT.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
