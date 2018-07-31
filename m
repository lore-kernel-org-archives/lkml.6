Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D917DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E120844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHnDGMtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2E120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGaSvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:51:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39684 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeGaSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:51:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so6415244pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXrPRXFuCy1+/s26vdiNhGXvfpUY2x/j3+ERvEv4MG8=;
        b=LHnDGMtZ1/1qTcWkzQCi3A1yqqWG6oO4qPkP7++Ln6ctl67/1/2Y2uFvcb8zDpL/GO
         nmh7ZkC50bWPouVqIU2hqeZJyn2D5X1ok/yjKnOOHstsIsNznxw3MIftE005S4T6/Vug
         vK/LQ2LjANhOTfvY+Yp+E5P9IqVCkF8xtmUJnI5Kt3ZP4pxShPGrPyKNC+pMGD+u5ByJ
         Qrg/DGG+xm/LI7JNf3ZPk39ERvQfThBRBSrYNP3hqDWw0qgg/7jbfOJhXD/yEeIqM+/3
         dIUJ+UhMGCoPAoN2b5lcCWGm56pe8BX+ZI7bpvX0ay4m6+HZpoZrOyXqq7m+5oGS9bMi
         dk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXrPRXFuCy1+/s26vdiNhGXvfpUY2x/j3+ERvEv4MG8=;
        b=ehpIR0Cq/jkN/Lo3VNopEpJrwlikCNcvdpw3vy+tNGHn0lNd1Gp1I8Q/x0+QgTk0OB
         I++h+9soYm7xaKge7AD+7JPe8d1Pf7EPOqu4b5+d/LQiEvtIa6H6uWWeE8C0v4HgV7wT
         hnuGXhe0i8+c0efSj+vtmk4MUh653WHt9I8YS70rJ+vRjxksYL0ksqz+8z+zX4Zrx4yb
         xGzL04AmpxxGFFM8nTNfpEOVzhjQfwVJAhlDzuwThYym2u9GpuIXJvtvSQiVYxDF26GQ
         JkGm09w85tV/8pE0ybRUPXzxkprL6um1vWqtHm43aQojcTdqIsHnUxOUarPog5ic3mBk
         mqiw==
X-Gm-Message-State: AOUpUlHU9525NfqhDddGKThdqHS4Ee9UfZcJZ2Fw8QFtXsJqWbOfOg2B
        sv+bnxNY5P7Ga8ZMxuYwf5E3OemhdhY6dVSd4DNLcw==
X-Google-Smtp-Source: AAOMgpcbk4+G+Wd8nhJnmDMyAELQsKuY1eNxUTUS6+rroWr0JPUzFyToo6T3H6/Ptus8Ht6+B0i9w/Y9OvyTavAE8Js=
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr22892697pfg.69.1533056997046;
 Tue, 31 Jul 2018 10:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180730213412.242849-3-ndesaulniers@google.com>
 <201807311827.UpeCrGPC%fengguang.wu@intel.com> <CAKwvOd=rwib91mnXs=PCP460hkCWTE5anNFgvRPBrbagetCbzw@mail.gmail.com>
 <CAGXu5jJFdbcmSMZi-uz0QySJ5c6uqUKEazztDfCWDeQOMF-T-Q@mail.gmail.com>
In-Reply-To: <CAGXu5jJFdbcmSMZi-uz0QySJ5c6uqUKEazztDfCWDeQOMF-T-Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 10:09:45 -0700
Message-ID: <CAKwvOdkE5sV_8=rOLE8Py3ym2n4uu8AOit=vSCVCaZo=ZV_ATg@mail.gmail.com>
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

On Tue, Jul 31, 2018 at 10:02 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jul 31, 2018 at 9:48 AM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > Does anyone understand this error?  The code looks just fine to me,
> > and the source file doesn't conflict with any of the macros I've added
> > (certainly not in any way that could cause an indentation error as
> > reported here).
>
> It does _use_ the macro, but yeah, I'm stumped...
>
> > On Tue, Jul 31, 2018 at 3:27 AM kbuild test robot <lkp@intel.com> wrote:
> >>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c: In function 'iwl_trans_send_cmd':
> >> >> drivers/net//wireless/intel/iwlwifi/iwl-trans.c:137:2: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
> >>      if (!(cmd->flags & CMD_ASYNC))
> >>      ^~
> >>    drivers/net//wireless/intel/iwlwifi/iwl-trans.c:138:1: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
> >>       lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
> >>     ^ ~
> >>
> >> vim +/if +137 drivers/net//wireless/intel/iwlwifi/iwl-trans.c
> >>
> >> 92fe8343 Emmanuel Grumbach 2015-12-01 @137      if (!(cmd->flags & CMD_ASYNC))
> >> 92fe8343 Emmanuel Grumbach 2015-12-01  138              lock_map_acquire_read(&trans->sync_cmd_lockdep_map);
>
> #define lock_map_acquire_read(l)
> lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
>
> #define lock_acquire_shared_recursive(l, s, t, n, i)
> lock_acquire(l, s, t, 2, 1, n, i)
>
> The config doesn't have CONFIG_LOCKDEP, so it's not:
>
> extern void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>                          int trylock, int read, int check,
>                          struct lockdep_map *nest_lock, unsigned long ip);
>
> but rather:
>
> # define lock_acquire(l, s, t, r, c, n, i)      do { } while (0)
>
> If you build with the same gcc and config, does it reproduce for you?

Indeed, gcc 6, 7, or 8 + the provided config reproduce the issue.

-- 
Thanks,
~Nick Desaulniers
