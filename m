Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BA7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CF92083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pe8qnbUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CF92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeGaWxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:53:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40284 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732353AbeGaWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:53:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so9682140pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vArbByHJvRwevDJvdQUXLE2qSj06ZGIDdvGvssxpD6s=;
        b=Pe8qnbUfXjiQCcmhdiwbIXkS5aL8WwUva1S5GXrvie+litE3tl/u0KuJWc7Q4XpPmz
         GWIunEUfDqNXZVCY9TFGV+Zz2Np4AQUlgmOjIOfb1zupdSmxkxcyUHvpsGDhkiTkeDnW
         78vb+8tCAx4p3T2eJ9DoX4De7bNxW03guJseIU1IlUte8lTNyL/8ZbH7ugI/I+MaNJbp
         MV7oXG6oDU5EyXK5W83dZMZfIvKPyMTILtGyp+S5XTQsMg6mnFQOaKP1OigZgvttrOdu
         PhBIQmkw2ixn4+A0nBE/SehHyESMT872MLSDasCLpK+6X2x90zVZ8H0UZvMPhUmGMq/7
         nxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vArbByHJvRwevDJvdQUXLE2qSj06ZGIDdvGvssxpD6s=;
        b=XoegtdEOvTN+udYh0Lw6FE23a/mpK1E96SzOIgrqFOmsy5zbpr6yBx698TG9rD5IPP
         +reRbl4zXHo2iw2vQTSSuQDfQfspQIxmUGjkyr6SYGTXCXqe4Qyfig00KsQVMu/cBolJ
         c8YplqCKld1MaIxvXUxRvOWyXKFRKClgG9eg17vm4upBScorcTT0Lvuq5Nqh2Dzvc3lY
         Ia4iA4slrMv/hJ1u+845GYbWWXcOLK5OAMhfyub+o7eRtjXtiagGRfe53n2IkEb6Go3k
         htd0FRl4iQFieXD/NIosRdSn5yend+jtkc/hnC8kfqj0LcRumFUcg5Xs35RJJ5/qky36
         vsEg==
X-Gm-Message-State: AOUpUlHQHLbI5arOnhD4w/MfFI/FgxpWqmG5wzVqMF2IabnEy1qotbcG
        YKGhpoJzoh7C3lXqOsisasEvzK60kHaBIAceega5zg==
X-Google-Smtp-Source: AAOMgpes3c4gzmJGFccZ5qpjNkXN0XXeX66VypOxKcB02cMRjQYA8LmQdfgIZ9zN/Eb+R8JPrITwBvEMQIAuJ8+nllA=
X-Received: by 2002:a63:9619:: with SMTP id c25-v6mr21636151pge.75.1533071469383;
 Tue, 31 Jul 2018 14:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180730213412.242849-3-ndesaulniers@google.com>
 <201807311827.UpeCrGPC%fengguang.wu@intel.com> <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
 <CAGXu5jJFdbcmSMZi-uz0QySJ5c6uqUKEazztDfCWDeQOMF-T-Q@mail.gmail.com> <CAKwvOdneN9xG5iegvfnn9XUm_-qUHxx--7k3j-UthwvsXmZOjg@mail.gmail.com>
In-Reply-To: <CAKwvOdneN9xG5iegvfnn9XUm_-qUHxx--7k3j-UthwvsXmZOjg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 14:10:58 -0700
Message-ID: <CAKwvOd=q8VT2HnOzZtbbAZrZqGmhF5X-+fu3fK0bdaXvXrDX8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
To:     Kees Cook <keescook@chromium.org>
Cc:     lkp@intel.com, kbuild-all@01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, paul.burton@mips.com,
        christophe.leroy@c-s.fr, shorne@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, rdunlap@infradead.org,
        bp@suse.de, neilb@suse.com, LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, dwmw@amazon.co.uk,
        sandipan@linux.vnet.ibm.com, linux@rasmusvillemoes.dk,
        Paul Lawrence <paullawrence@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>, ghackmann@android.com,
        stable@vger.kernel.org, Greg Hackmann <ghackmann@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>, avagin@openvz.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:58 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jul 31, 2018 at 10:02 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jul 31, 2018 at 9:48 AM, Nick Desaulniers
> > > On Tue, Jul 31, 2018 at 3:27 AM kbuild test robot <lkp@intel.com> wrote:
> > >>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c: In function 'iwl_trans_send_cmd':
> > >> >> drivers/net//wireless/intel/iwlwifi/iwl-trans.c:137:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
> > >>      if (!(cmd->flags & CMD_ASYNC))
> > >>      ^~
> > >>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c:138:1: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
> > >>       lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
> > >>     ^ ~
> > >>
> > >> vim +/if +137 drivers/net//wireless/intel/iwlwifi/iwl-trans.c
> > >>
> > >> 92fe8343 Emmanuel Grumbach 2015-12-01 @137      if (!(cmd->flags & CMD_ASYNC))
> > >> 92fe8343 Emmanuel Grumbach 2015-12-01  138              lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
> >
> > #define lock_map_acquire_read(l)
> > lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
> >
> > #define lock_acquire_shared_recursive(l, s, t, n, i)
> > lock_acquire(l, s, t, 2, 1, n, i)
> >
> > The config doesn't have CONFIG_LOCKDEP, so it's not:
> >
> > extern void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
> >                          int trylock, int read, int check,
> >                          struct lockdep_map *nest_lock, unsigned long ip);
> >
> > but rather:
> >
> > # define lock_acquire(l, s, t, r, c, n, i)      do { } while (0)
>
> This is tricky, if I preprocess that translation unit with the exact
> flags used during compilation, I get:
>
> ```
>  if (!(cmd->flags & CMD_ASYNC))
>
> #pragma GCC diagnostic push
>
> #pragma GCC diagnostic pop
>  do { } while (0);
> ```
>
> Which is not enough to trigger -Wmisleading-indentation alone.  It is
> curious that if we add braces to that if statement (as Nathan notes in
> a sibling post) or removing the pop (not shippable) seems to fix the
> warning.

Something fishy is going on here: https://godbolt.org/g/b5dsqH

It seems that gcc's warning is technically correct, but it seems to be
a miscompile as puts() in my reduced test case is called
unconditionally.  I've filed:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86765

In the meanwhile, I've reworked the patch to change _THIS_IP_ to a
only contain a function call, to a new static inline function which
does what the statement expression used to.  This now triggers
-Wreturn-local-addr warnings in gcc, which is a warning added in
gcc-4.8, so I need to add another __diag_ignore, and case for gcc 4.8
to include/linux/compiler-gcc.h.

At this point, I think I might as well consolidate current_text_addr()
and _THIS_IP_.  Stay tuned for v3.

--
Thanks,
~Nick Desaulniers
