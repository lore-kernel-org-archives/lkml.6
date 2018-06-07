Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZErgNXR+GVvWawAAmS7hNA
	; Thu, 07 Jun 2018 18:52:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D0076074D; Thu,  7 Jun 2018 18:52:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMYEGc+X"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F18F606DD;
	Thu,  7 Jun 2018 18:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F18F606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbeFGSwO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:52:14 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33374 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753066AbeFGSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:52:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id e11-v6so5183393pgq.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAU99C9zD3UsghKcPiymqFmN6jOxU+sKBReB+2Fl77c=;
        b=UMYEGc+XphVzhcWKKGYa4oeBMj6jIro6wZDDEEq3CJCRLsdiDq6FdCCyHzKHyYOrml
         gg5ik++TxRHx2iukX3iJSpGCdgzqo6YWbXsdltXF9vERu/ZNlXN66tXHTauYONCrEq56
         CNO/9EVaFZMRRFZgcbGnIaJ1Lt4vbgHZlXZQRaGCOw+2s/Lq/VoZtT10+G/onwuMcvOc
         eE1gTSn3nfvvNiPvIjvAG0cnyiJnRwMD1TZAH+hbDZjh5HwPgyRbAniM5nnpS5EyJdUk
         tHdmuW7TKhe5dVC27e21sLxE/YWrOcxviN9qgKhsoVfCOU5mLu3hpNggZNB0WSOEgZ6T
         pavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAU99C9zD3UsghKcPiymqFmN6jOxU+sKBReB+2Fl77c=;
        b=BhUL+de3M69q9BKO3Tlnh7tpUY0ZVekd6eOX7NQSOYc7wXQkkhCeFyLq9wqIkltfVp
         EMT8u0cS5+xJAd8O4zUj6zwfN7zS7qgd+mYYPELh0VFRCDy1li8Mi/UDUR7BpM+pmund
         IDHFBNxfEsA01MeoY2YgAWYW9kcc8OR1MNlpBhe947YH7w4l0X4D21+1Kp09DMqQ1Lt8
         DYTMgeLPB9uvxAeZ62XBOEA89s+QQkz5+XJZ5WrehtP5c4uYo2YyrIHO3GTfZ85rX5aX
         T7rD/ejFaxdSNqWIDSCPa/k+WSMroEkZJHHN2Mge5/h2R5jfq8zjDCWGFTrIcivTmS5P
         se2g==
X-Gm-Message-State: APt69E3O+imCb4kD/NqH2ibkSFNdMRXDB4fJfkV3YafTTU+tMlPwp6cv
        TTr3xqG2y3DU7UKnEofDvMyUQuX3DjpU2F9/NV+mVA==
X-Google-Smtp-Source: ADUXVKK7nnWe3wzigDzsdNspyvSJGJG3/u+QBc07PhZitbpc/mKCdUEFlsoPr/WUq9SagiL+tl5MVGwtaz5rd3BhXw4=
X-Received: by 2002:a63:af50:: with SMTP id s16-v6mr2563785pgo.263.1528397531471;
 Thu, 07 Jun 2018 11:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180605170532.170361-1-ndesaulniers@google.com>
 <20180605170532.170361-2-ndesaulniers@google.com> <202492204c2d5bd5ca27307cbca5e44673b739ed.camel@perches.com>
 <CAKwvOdkUk7ZL8tXgBs0Y+0Y5NVebgAYne_qgdSWWDOvQaWFPhw@mail.gmail.com> <28c288fd3e87b6c839697519043cf642518e0262.camel@perches.com>
In-Reply-To: <28c288fd3e87b6c839697519043cf642518e0262.camel@perches.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Jun 2018 11:51:59 -0700
Message-ID: <CAKwvOdkDyVC02oXsTX9YYAFLw5Q+aFNWsAp911h6VdjMCYFwJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] compiler-gcc.h: add gnu_inline to all inline declarations
To: joe@perches.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, akataria@vmware.com,
        boris.ostrovsky@oracle.com, brijesh.singh@amd.com,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>, hpa@zytor.com,
        "J. Kiszka" <jan.kiszka@siemens.com>,
        jarkko.sakkinen@linux.intel.com, jgross@suse.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kirill.shutemov@linux.intel.com, mingo@redhat.com,
        mjg59@google.com, Matthias Kaehlcke <mka@chromium.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
        thomas.lendacky@amd.com, Thiebaud Weksteen <tweek@google.com>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, Kees Cook <keescook@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        geert@linux-m68k.org, Will Deacon <will.deacon@arm.com>,
        mawilcox@microsoft.com, Arnd Bergmann <arnd@arndb.de>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 11:31 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2018-06-07 at 10:26 -0700, Nick Desaulniers wrote:
> > I get the feeling that the use of __inline__ or __inline (vs inline)
> > in the kernel may be wrong and their use should be eradicated in the
> > follow up patch set, but it would be cool if others have additional
> > insight.
>
> __inline is easy and useful to remove as it's used in
> just a few files.
>
> But __inline__ is used in a lot of files and locations:
>
> $ git grep -w --name-only __inline__ | wc -l
> 154
> $ git grep -w __inline__ | wc -l
> 503
>
> Some of these files are used in asm includes as
> well where __inline__ may be preferred by gcc
>
> https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html#Alternate-Keywords
>
> so perhaps asm exclusions would be necessary.

Oops, just saw this email after sending v3: https://lkml.org/lkml/2018/6/7/1055

Guess I should re-add __inline__ and __inline then to 1/3?
https://lkml.org/lkml/2018/6/7/1060

ie:

+#define __inline__ __inline__ inline
instead of
+#define __inline__ inline

?

On the other hand, I was able to assemble with gcc+binutils and v3 as it stands.

Reading the link you sent, it seems more about compiling with
-pedantic or non-gnu C standards being used (I'd call that unlikely
for the kernel). So it still seems incorrect to me the use of
__inline__ (but I do appreciate the link!) at least in the kernel.
