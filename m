Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-36588-1526267092-2-16889298755528459605
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526267092; b=J3JzTZnCWqW61EKDNGvK7IRxa2002FAIg7L8a2jwBoQ7FJQza2
    LVKTyi5pKj2ne9qpIOd3KPZU5CGgOjVCiyNpCM5fUm2o4zRp2hq7iq3fMQwmJE0b
    uTFBI4nqFdbc7H1lwEZxciOXBzHBYzf1wlNOnrkuwIfPA+3QELcA45+k0vw7dext
    3awRQiIX4OF6fvcFSrVURzogNOVEk1brCZSUL+OWFKNyoYs6wYOnLzi33/BEM1op
    KXqQ95pjZDdmOzmKjVrMpm4agcTWvIV5zFD2CeXQ8FNGcpXnbltqQRb2culIMibC
    1H0pq5HCxkvSUPatjzAaiGfhKXAkDDR5nGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526267092;
    bh=awYINJ7rvz3fzZw1OWn9+RBdxlAxHRczix9ZCoGeHkk=; b=Zv19sAj7aZBT
    z2+TpydHvsdxoajnSxljXZXgBAlLNJ8CirbbBjjfsBygNYzEIIN4t3EaQ3D8GU53
    EMUZHb54AeWiDbmEXpsFXyXjUTqGshIBvS8D7BKEGPPoSf7VQDiRfj1mdZ+lxTZd
    m98h/qVP/UU+Siwg+EeO8gdOMVDEyfl8xIzmzAIIXuD40mSaNqQilQfBySnwKwXG
    nbCDJcl41i5kY4vi+zYCQ54nZb52YCiwqcx5Qub+KbmgJLgAyYeYHBvdaoBaFIKV
    qtJf8/mnX/XuUJ7achNpwUWa/R7K8PP9zA8V/QpQssJ7gAsJvtYEWpba5jtFVrF5
    Kt91YIKe/g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=Wl3eMQAD
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=Wl3eMQAD
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKSbh5o3U5OWn7RqBKjS2YoniqRD2kBOTgjfXVwofSiQcA/sTl/subZwrL8FqI184LiO9XVoORL7yQ75A+7rhGUZ+fv5TKypAy1CXngSKVLq/wL1y/EH
    i01KpW2kYWe3LzraG03kF7ptpsMWgeD1Fk7zn/qGzFI+cqvEqhhRLTIyLI1x+p+IacpiXVDD6JMgBldSA87pCQUiK0eTBPCzZlrALqGTIo1AjqxRf+ravbdK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=gu6fZOg2AAAA:8 a=R6WbNC7LW8mEunR6-OIA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeENDEu (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 23:04:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbeENDEt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2018 23:04:49 -0400
Subject: Re: [PATCH -resend 01/27] linkage: new macros for assembler symbols
To: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
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
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-2-jslaby@suse.cz>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5e17ecd-0e74-7766-e730-333004ada199@infradead.org>
Date: Sun, 13 May 2018 20:04:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510080644.19752-2-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/10/2018 01:06 AM, Jiri Slaby wrote:

> ---
>  Documentation/asm-annotations.rst | 218 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/linkage.h    |  10 +-
>  include/linux/linkage.h           | 257 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 475 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/asm-annotations.rst
> 
> diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
> new file mode 100644
> index 000000000000..3e9b426347f0
> --- /dev/null
> +++ b/Documentation/asm-annotations.rst
> @@ -0,0 +1,218 @@
> +Assembler Annotations
> +=====================
> +
> +Copyright (c) 2017 Jiri Slaby

[snip]

> +This is not only important for debugging purposes. When we have properly
> +marked objects like this, we can run tools on them and let the tools generate
> +more useful information. In particular, on properly marked objects, we can run
> +``objtool`` and let it check and fix the object if needed. Currently, it can
> +report missing frame pointer setup/destruction in functions. It can also
> +automatically generate annotations for *ORC unwinder* (cf.
> +<Documentation/x86/orc-unwinder.txt>) for most code. Both of this is

                                                        Both of these are

> +especially important to support reliable stack traces which are in turn
> +necessary for *Kernel live patching* (see
> +<Documentation/livepatch/livepatch.txt>).
> +
> +Caveat and Discussion
> +---------------------
> +As one might realize, there were only three macros previously. That is indeed
> +insufficient to cover all the combinations of cases:
> +
> +* standard/non-standard function
> +* code/data
> +* global/local symbol
> +
> +We had a discussion_ and instead of extending the current ``ENTRY/END*``
> +macros, it was decided that we shoould introduce brand new macros instead::

                                  should

> +
> +    So how about using macro names that actually show the purpose, instead
> +    of importing all the crappy, historic, essentially randomly chosen
> +    debug symbol macro names from the binutils and older kernels?
> +
> +.. _discussion: https://marc.info/?i=20170217104757.28588-1-jslaby%40suse.cz
> +
> +Macros Description
> +------------------
> +
> +The new macros are prefixed with the ``SYM_`` prefix and can be divided into
> +three main groups:
> +
> +1. ``SYM_FUNC_*`` -- to annotate C-like functions. This means functions with
> +   standard C calling conventions, i.e. the stack contains a return address at
> +   the predefined place and a return from the function can happen in a
> +   standard way. When frame pointers are enabled, save/restore of frame
> +   pointer shall happen at the start/end of a function, respectively, too.
> +
> +   Checking tools like ``objtool`` should ensure such marked functions conform
> +   to these rules. The tools can also easily annotate these functions with
> +   debugging information (like *ORC data*) automatically.
> +
> +2. ``SYM_CODE_*`` -- special functions called with special stack. Be it
> +   interrupt handlers with special stack content, trampolines, or startup
> +   functions.
> +
> +   Checking tools mostly ignore checking of these functions. But some debug
> +   information still can be generated automatically. For correct debug data,
> +   this code needs hints like ``UNWIND_HINT_REGS`` provided by developers.
> +
> +3. ``SYM_DATA*`` -- obviosly data belonging to ``.data`` sections and not to

                       obviously

> +   ``.text``. Data do not contain instructions, so they have to be treated
> +   specially by the tools: they should not treat the bytes as instructions,
> +   neither assign any debug information to them.

      nor assign

> +
> +Instruction Macros
> +~~~~~~~~~~~~~~~~~~
> +This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
> +

[snip]

> +
> +Data Macros
> +~~~~~~~~~~~
> +Similar to instructions, we have a couple of macros to describe data in the
> +assembly. Again, they help debuggers to understand the layout of the resulting
> +object files.
> +
> +* ``SYM_DATA_START`` and ``SYM_DATA_START_LOCAL`` mark the start of some data
> +  and shall be in couple with either ``SYM_DATA_END``, or

(maybe:) and shall be used in conjunction with either

> +  ``SYM_DATA_END_LABEL``. The latter adds also a label to the end, so that
> +  people can use ``lstack`` and (local) ``lstack_end`` in the following
> +  example::
> +
> +    SYM_DATA_START_LOCAL(lstack)
> +        .skip 4096
> +    SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
> +
> +* ``SYM_DATA`` and ``SYM_DATA_LOCAL`` are variants for simple, mostly one-line
> +  data::
> +
> +    SYM_DATA(HEAP,     .long rm_heap)
> +    SYM_DATA(heap_end, .long rm_stack)
> +
> +  In the end, they expand to ``SYM_DATA_START`` with ``SYM_DATA_END``
> +  internally.
> +
> +Support Macros
> +~~~~~~~~~~~~~~
> +All the above reduce themselves to some invocation of ``SYM_START``,
> +``SYM_END``, or ``SYM_ENTRY`` at last. Normally, developers should avoid using
> +these.
> +
> +Further, in the above examples, one could saw ``SYM_L_LOCAL``. There are also

                                             see

> +``SYM_L_GLOBAL`` and ``SYM_L_WEAK``. All are deserved to denote linkage of a

                                                eh?  defined? reserved? intended?

> +symbol marked by them. They are used either in ``_LABEL`` variants of the
> +earlier macros, or in ``SYM_START``.
> +
> +
> +Overriding Macros
> +~~~~~~~~~~~~~~~~~
> +Architecture can also override any of the macros in their own
> +``asm/linkage.h``.  Including macros specifying the type of a symbol

                    , including

> +(``SYM_T_FUNC``, ``SYM_T_OBJECT``, and ``SYM_T_NONE``).  As every macro
> +described in this file is surrounded by ``#ifdef`` + ``#endif``, it is enough
> +to define the macros differently in the aforementioned architecture-dependent
> +header.

HTH.
-- 
~Randy
