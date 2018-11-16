Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E86C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6982146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Y1cj+kmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6982146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbeKPLsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:48:25 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:37599 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeKPLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:48:25 -0500
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAG1btOZ010604;
        Fri, 16 Nov 2018 10:37:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAG1btOZ010604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542332276;
        bh=1NdtcIOUsWj7ZpMaN0l2aGw6fT/KcTkkQjgoB2Ug0Sw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1cj+kmuZHaG7NQq186NRb/WiWtXgNePv3okSNu0y4hJAdDBhFwwHLocFdqxwnglb
         jrnQY6PGu5+q4pv+76ZDxuizX9svyz5pl5Q66+9W20sfPikiBpQ58YtqmQC2xtmAhv
         4d1CxU8tTpf5gqGT38M6M7BxG6nn7M0CyAYU9qPiPkGxURE7afSOp3474zJMU5kMpe
         gAxeywS6OuwTndEflFmHaGJy8e35aJ4nD1VLKI1ZU42yRKxwf8CScgQim1DgL4Dlu6
         XszoWJt9UAPalSnFZxhViSjl72SzkFjT6EDA2OCHZ8B6VTHgUhU2+NNeVTKROUPXo8
         LmWjLcBCcWlvw==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id y27so12903389vsi.1;
        Thu, 15 Nov 2018 17:37:55 -0800 (PST)
X-Gm-Message-State: AGRZ1gKIdc1w9pzUo5Ud2Zmt7Nb1bBZPWcyBTqXs9i7b3/bNgQluKdYZ
        AUH8Su7u9Ku8aH1t/NTfiIVYf3On8s9GY86lV0Q=
X-Google-Smtp-Source: AJdET5eMIDEfe8Ku0qWG+W8jngaKVTfg/gB652s6wYqUDoBRjIl+DSB3120XxA2pB0XqYJQzP1g/u8udFjhwJoQM6kk=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr3631240vsm.181.1542332274614;
 Thu, 15 Nov 2018 17:37:54 -0800 (PST)
MIME-Version: 1.0
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-6-git-send-email-yamada.masahiro@socionext.com> <6ee62b52-5d6d-c540-5f01-f522b6986c4d@rasmusvillemoes.dk>
In-Reply-To: <6ee62b52-5d6d-c540-5f01-f522b6986c4d@rasmusvillemoes.dk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 16 Nov 2018 10:37:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5CKoT_4jk6BB5zs_EtXtj2HNjZ76FeOFBRA01nrQhUQ@mail.gmail.com>
Message-ID: <CAK7LNAS5CKoT_4jk6BB5zs_EtXtj2HNjZ76FeOFBRA01nrQhUQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] kbuild: change if_changed_rule to accept multi-line recipe
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 6:12 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 15/11/2018 09.27, Masahiro Yamada wrote:
> > GNU Make supports 'define' ... 'endef' directive, which can describe
> > a recipe that consists of multiple lines.
> >
> >   endef
> >
> > This does not actually exploit the benefits of 'define' ... 'endef'
> > form. All shell commands must be concatenated with '; \' so that it
> > looks like a single command from the Makefile point of view. '@' can
> > only appear before the first action.
> >
> > The root cause of this misfortune is the '@set -e;' in if_changed_rule.
> > It is easily solvable by moving '@set -e' to the 'cmd' macro.
> >
> > The combo of $(call echo-cmd,*) $(cmd_*) in rule_cc_o_c and rule_as_o_S
> > were replaced with $(call cmd,*). The tailing back-slashes went away.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  define rule_cc_o_c
> > -     $(call echo-cmd,checksrc) $(cmd_checksrc)                         \
> > -     $(call cmd_and_fixdep,cc_o_c)                                     \
> > -     $(cmd_gen_ksymdeps)                                               \
> > -     $(cmd_checkdoc)                                                   \
> > -     $(call echo-cmd,objtool) $(cmd_objtool)                           \
> > -     $(cmd_modversions_c)                                              \
> > -     $(call echo-cmd,record_mcount) $(cmd_record_mcount)
> > +     $(call cmd,checksrc)
> > +     @$(call cmd_and_fixdep,cc_o_c)
> > +     $(call cmd,gen_ksymdeps)
> > +     $(call cmd,checkdoc)
> > +     $(call cmd,objtool)
> > +     $(call cmd,modversions_c)
> > +     $(call cmd,record_mcount)
> >  endef
>
> Does this mean that Make now spawns a new shell for each of these
> commands,


Yes and No.

Basically, each line is run in an independent sub-shell,
but things are a little bit complex.

GNU Make, if possible, runs the command directly
instead of forking a shell process.

That is what I understood according to the following document:


http://wanderinghorse.net/computing/make/book/ManagingProjectsWithGNUMake-3.1.3.pdf

See "chapter 7: commands"
  ---------->8----------
  Commands are essentially one-line shell scripts.
  In effect, make grabs each line and passes it to a subshell for execution.
  In fact, make can optimize this (relatively) expensive fork/exec algorithm
  if it can guarantee that omitting the shell will not change the behavior of
  the program. It checks this by scanning each command line for shell special
  characters, such as wildcard characters and i/o redirection. If none are
  found, make directly executes the command without passing it to a subshell.
  ---------->8----------





> and if so, what's the performance impact? Or am I just
> misreading things? If this does change the semantics (one shell instance
> versus many), I think that's worth mentioning explicitly in the
> changelog, regardless of whether there's no measuarable performance impact.


Last night, I checked 'perf stat' of x86 defconfig build,
which enables cmd_objtool.



Without this commit:


 Performance counter stats for 'make -j8' (10 runs):

     125.499068713 seconds time elapsed
          ( +-  0.10% )


With this commit:

 Performance counter stats for 'make -j8' (10 runs):

     125.618321667 seconds time elapsed
          ( +-  0.24% )



I did not get noticeable performance regression.



-- 
Best Regards
Masahiro Yamada
