Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B53DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B5820881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bqnL29j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbfAaQAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:00:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51716 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfAaQAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:00:25 -0500
Received: from zn.tnic (p200300EC2BCC590020EEBF3E0FF207A8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5900:20ee:bf3e:ff2:7a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 947031EC0345;
        Thu, 31 Jan 2019 17:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548950423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HTk1e3YK6hwlavPXg6uD34RITpXl73OuYJ5vzGWfCKQ=;
        b=bqnL29j6Vovc6FkJumIcQc9U8WVWQYrKmDWzIE9g9Fk1EyGJCa57VPAm0RJOQa9oSyn+KJ
        VC/thAbSI5vh7FYPDO6wnnPv6+VfdI3izZH47xyv8Ij+dsAlfZcyHL5aV2JhHpK7w48oQa
        FFMtLXOjgsrJ0dJDFztr/oYYSYQjh3g=
Date:   Thu, 31 Jan 2019 17:00:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, hpa@zytor.com,
        Ingo Molnar <mingo@kernel.org>, jpoimboe@redhat.com,
        Juergen Gross <jgross@suse.com>,
        Len Brown <len.brown@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v7 01/28] linkage: new macros for assembler symbols
Message-ID: <20190131160019.GM6749@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-2-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:46:44PM +0100, Jiri Slaby wrote:
> Introduce new C macros for annotations of functions and data in
> assembly. There is a long-standing mess in macros like ENTRY, END,
> ENDPROC and similar. They are used in different manners and sometimes
> incorrectly.
> 
> So introduce macros with clear use to annotate assembly as follows:

...

> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: hpa@zytor.com
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: jpoimboe@redhat.com
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: mingo@redhat.com
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: xen-devel@lists.xenproject.org
> Cc: x86@kernel.org
> ---
>  Documentation/asm-annotations.rst | 217 ++++++++++++++++++++++++++

I guess you wanna integrate that into the doc hierarchy. Hunk ontop:

---
diff --git a/Documentation/index.rst b/Documentation/index.rst
index c858c2e66e36..754055d9565c 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -91,6 +91,14 @@ needed).
    vm/index
    bpf/index
 
+Architecture-agnostic documentation
+-----------------------------------
+
+.. toctree::
+   :maxdepth: 2
+
+   asm-annotations
+
 Architecture-specific documentation
 -----------------------------------
 

>  arch/x86/include/asm/linkage.h    |  10 +-
>  include/linux/linkage.h           | 245 +++++++++++++++++++++++++++++-
>  3 files changed, 461 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/asm-annotations.rst
> 
> diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
> new file mode 100644
> index 000000000000..265d64a1fc0b
> --- /dev/null
> +++ b/Documentation/asm-annotations.rst
> @@ -0,0 +1,217 @@
> +Assembler Annotations
> +=====================
> +
> +Copyright (c) 2017 Jiri Slaby
> +
> +This document describes the new macros for annotation of data and code in
> +assembler. In particular, it contains information about ``SYM_FUNC_START``,

s/assembler/assembly/

> +``SYM_FUNC_END``, ``SYM_CODE_START``, and similar.
> +
> +Rationale
> +---------
> +Some code like entries, trampolines, or boot code needs to be written in
> +assembly. The same as in C, we group such code into functions and accompany
> +them with data. Standard assemblers do not force users into precisely marking
> +these pieces as code, data, or even specifying their length. Nevertheless,
> +assemblers provide developers with such marks to aid debuggers throughout
> +assembly. On the top of that, developers also want to stamp some functions as
> +*global* to be visible outside of their translation units.
> +
> +Over the time, the Linux kernel took over macros from various projects (like

s/the //

> +``binutils``) to ease these markings. So for historic reasons, we have been
> +using ``ENTRY``, ``END``, ``ENDPROC``, and other annotations in assembly. Due
> +to the lack of their documentation, the macros are used in rather wrong
> +contexts at some locations. Clearly, ``ENTRY`` was intended for starts of
> +global symbols (be it data or code). ``END`` used to be the end of data or end
> +of special functions with *non-standard* calling convention. In contrast,
> +``ENDPROC`` should annotate only ends of *standard* functions.

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
