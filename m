Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jDazATqFGVv1MgAAmS7hNA
	; Thu, 07 Jun 2018 19:23:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C8E3D6074D; Thu,  7 Jun 2018 19:23:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgzLe+C6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2CAD86063F;
	Thu,  7 Jun 2018 19:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2CAD86063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeFGTXp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:23:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42648 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeFGTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:23:44 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so6741177pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKUq8EW8/jGY7z4VbTzriOkFRTwtP1HW5von+rEJnbE=;
        b=tgzLe+C60bZKyDRSzJp6c70lf/zHcgrDdI9FyvfHJflX69RUOqRzDx52Fnz2IjNQyN
         eE0F2toxcPOWVdg0A0KvDVaWN/qzSX97DFmerHwtzibe0bTm5EkOB5KN6EB+8DUb7lbO
         9lUl/YPUfxx5VGCchyHFvKbVBdtsOknqgIMfqXF2/IwZOM4LZECeJytsWcixE/leH6Ir
         k8BYn2MD27TrGNFMFqS2Ip5VqkeKpaifJU7J+CYOipynwkr6d/PKexvZK8gVLl7EihLk
         cMzM/JYfq1Nc92IE/ElilQooam8C/LuLt7TTY2a9iWi1D7ARuKRi6nEjVG/0AjZFcHUr
         VGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKUq8EW8/jGY7z4VbTzriOkFRTwtP1HW5von+rEJnbE=;
        b=a0sXC55E0jtjWTekrIiYfP2gKfTNGJ+k0dB1OcyNvLn0g2U4HaAVkL23UYVc2jwjPJ
         PuKgvaTdGfuCLNK1+jUJhu3IELMonpRAwhN8+G9OApZIVqG/YUEuRxfCW9mNcRMekjoB
         L+UIZ0ui0K9JtQzZGWW5idV+i/mVWTX/6SNXFdAXcki54VYossxnJhj0GgAlBPh9q2QJ
         D/ZBB7YAuF1pF+Kvc67AkK4CFB/eEo3D2tFubIdNIbAimRAlVJ8BfhtDI9zoHodRVV4q
         NldSnx/FrlYuiCONFhDe3k5ufKSTFfPFe96ZMkRvK6nJYuKq9ljoPw7LzHzIIArqzJCl
         iRRQ==
X-Gm-Message-State: APt69E1eDvBkm33stw4E/3jhZmmzRL42r0NBTYNKHspgn1rTdJlUVO5f
        xH/yGie4JxlMTSS0JGPlk7CjDCWdm3Z+MWm6vNeCmQ==
X-Google-Smtp-Source: ADUXVKJGFNBiP6tjPayeWnjNgZKgqmw3GdobCysYRpvQkl21MaAlI0f+8YcO1qR2Yoy+2LpWoNQ1pKEmq/sohTrkNTI=
X-Received: by 2002:a17:902:5409:: with SMTP id d9-v6mr3381543pli.0.1528399423292;
 Thu, 07 Jun 2018 12:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com> <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net> <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com> <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com> <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404193247.lsoxe3xjcidwtlgv@treble>
In-Reply-To: <20180404193247.lsoxe3xjcidwtlgv@treble>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 7 Jun 2018 12:23:31 -0700
Message-ID: <CAKwvOdmFVO=SUxazTR+WGgrTtKyfqgEup-aY_P3LrQBZqrL84Q@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Y Knight <jyknight@google.com>,
        Chandler Carruth <chandlerc@google.com>,
        Stephen Hines <srhines@google.com>,
        Kees Cook <keescook@google.com>, groeck@chromium.org,
        Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 12:32 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Apr 04, 2018 at 04:53:52PM +0000, Nick Desaulniers wrote:
> > (re-sending as plain text)
> >
> > On Wed, Apr 4, 2018 at 2:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > There are known-bugs with building a kernel with clang right now (I
> > > pointed one out a few days ago about NULL checks being deleted from the
> > > clang output for no good reason, which really is scary for obvious
> > > reasons).
> >
> > Is this the thread you are referring to?
> > https://lkml.org/lkml/2018/3/27/1286
> >
> > It's definitely something curious that I'll need to sit down and
> > investigate more.  If there are other known instances, it would be good to
> > let me know.
>
> As Matthias mentioned elsewhere, it sounds like they're planning to
> implement -fno-delete-null-pointer-checks, which would presumably fix
> the above issue.

Just to follow this up, -fno-delete-null-pointer-checks is being added
to clang in:
https://reviews.llvm.org/D47894
https://reviews.llvm.org/D47895

-- 
Thanks,
~Nick Desaulniers
