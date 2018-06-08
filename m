Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OM10K/iTGlsPfQAAmS7hNA
	; Fri, 08 Jun 2018 14:34:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B2A6606FA; Fri,  8 Jun 2018 14:34:57 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYF8q4dG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED2A4601D2;
	Fri,  8 Jun 2018 14:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED2A4601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFHOez (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:34:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32865 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeFHOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:34:52 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so20457187lfy.0;
        Fri, 08 Jun 2018 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7BKoDRRNvG418aZ/I0cOtaRZRkUjaVSOPXsuwmbWVvg=;
        b=hYF8q4dGNoUis1OmbxRkwSuyX8HxXtT4l9f+asvsgR4shlG/4SpWaC8jvLFb2lfEWc
         EsyJE3iYmem1R3V2IzVQhY3KJqUupikS/pbGS48nvsTRuV5nvDj1+IFT33PfD8J+sC9T
         fgnYlTIDrxlux7JxKzgFZrXiE6zJ+gMVKTVnubU/fae/Qxgy/yYDnaW7+c0x5p1XY/PK
         oVTwjiand2B2IRB9kU/2+omwzPH+p2Mj1yESQKzOQI+fzxZoQFdDNkIPo2ETFaBncdXS
         WpKFaRJ3Bxllagwu0TXwU38vFVvIc2rTnlS01qEuqZ+CYC9F9hcwEpo2NNQ76tWAdu4q
         0i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=7BKoDRRNvG418aZ/I0cOtaRZRkUjaVSOPXsuwmbWVvg=;
        b=NuMJKKXGOtqj0V8FU2auOYwz69lM/S6O9Aq/075igWVo17PvFdt/4S1D4SiY2CzZi6
         45Vohfj4COZlwco1Ef9BZWVIWnrPtdmYsRX8i67OzHajxP/vzMOdEicT7L7GW9BGq133
         +ZyP7B/pQyYZbVsPEdtuW8N+5f2yS2P9/pGbxLCIPbdMRA3n0NjG8bX//A1DlnjvcQ65
         9goXTxl+A3vmF+qKMuXPR9tK22egOW07kgXY/ivOIYryAzbDyJeYTvSvlyRRg1ujyIuu
         sVUSIxYGnkfj1M5P/4RK1rbth6nTIa4ZqQWPPgDWCTyrPuTal+hePk2kYmxFSCmBXP50
         0Y/A==
X-Gm-Message-State: APt69E1qnWcwC+TBzkkYsmoYyx4Afz0YYZ6J9D50/vjrSzeONfXurQHz
        mu7mryF5+5uG7PZocP+fyw5y3icsZJ5L7tn2pfo=
X-Google-Smtp-Source: ADUXVKKKIXnHK44WQavloInOjS7D1BFCEqG0ZuZmMaMLIrnvKMDXS/lLcGLUU0OZb68ArZ16MmqSDRO4E970FlPtuuI=
X-Received: by 2002:a19:188a:: with SMTP id 10-v6mr4333256lfy.26.1528468490963;
 Fri, 08 Jun 2018 07:34:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:b87:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 07:34:50 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <5C97550D-BEF4-4069-9373-F7543E3878FB@zytor.com>
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-2-ndesaulniers@google.com> <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com>
 <5ad1876557235a089a50e6ed6c558a7dcb0da714.camel@perches.com>
 <CA+icZUXEpe954z0TSbhSJPdFCfOqsBtpO9mPZBcJ2HWubSo_zQ@mail.gmail.com> <5C97550D-BEF4-4069-9373-F7543E3878FB@zytor.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 8 Jun 2018 16:34:50 +0200
Message-ID: <CA+icZUUz1Zb1e0LbeccY-3=HY02txe4BiNwhN0vqW_RkQpfLCw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] compiler-gcc.h: add gnu_inline to all inline declarations
To: hpa@zytor.com
Cc: Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org,
        aryabinin@virtuozzo.com, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        caoj.fnst@cn.fujitsu.com, gregkh@linuxfoundation.org,
        jan.kiszka@siemens.com, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        mjg59@google.com, mka@chromium.org, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
        tweek@google.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org, astrachan@google.com,
        manojgupta@google.com, ghackmann@google.com, tstellar@redhat.com,
        keescook@google.com, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, linux-kbuild@vger.kernel.org,
        geert@linux-m68k.org, will.deacon@arm.com, mawilcox@microsoft.com,
        Arnd Bergmann <arnd@arndb.de>, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 6:39 PM,  <hpa@zytor.com> wrote:
...
>>Beyond this, a general question: Can someone explain why all these
>>inline defines are in compiler-gcc.h (as there exists compiler.h and
>>compiler-clang.h)?
>>
>>Thanks.
>>
>>Regards,
>>- Sedat -
>
> Because gcc itself also supports both GNU89-style and C99-style inlines, but the kernel was built with the former, and it is not necessarily a trivial modification, except for "static inline" which is the same for both.
>
> The other option is to pass -fgnu89-inline on the command line, which is supported by both gcc and clang. The two methods are fully equivalent.
>

We have...

$ ls include/linux/compiler*
include/linux/compiler-clang.h  include/linux/compiler-gcc.h
include/linux/compiler.h  include/linux/compiler-intel.h
include/linux/compiler_types.h

include/linux/compiler_types.h says...

#ifdef __GNUC__
#include <linux/compiler-gcc.h>
#endif
...
/* Intel compiler defines __GNUC__. So we will overwrite implementations
 * coming from above header files here
 */
#ifdef __INTEL_COMPILER
# include <linux/compiler-intel.h>
#endif

/* Clang compiler defines __GNUC__. So we will overwrite implementations
 * coming from above header files here
 */
#ifdef __clang__
#include <linux/compiler-clang.h>
#endif

/*
 * Generic compiler-dependent macros required for kernel
 * build go below this comment. Actual compiler/compiler version
 * specific implementations come from the above header files
 */
...

include/linux/compiler-clang.h says...

#ifndef __LINUX_COMPILER_TYPES_H
#error "Please don't include <linux/compiler-clang.h> directly,
include <linux/compiler.h> instead."
#endif

So, compiler-clang.h uses defines etc. from compiler-gcc.h but might
overwrite it.
Correct?
I would have expected inline defines in compiler.h as I thought there
is the place for generic stuff.

Maybe you can clarify on the roles of especially compiler.h and
compiler_types.h.

Thanks.

- sed@ -
