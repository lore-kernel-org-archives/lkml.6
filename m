Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D873C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EAC2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQszKic6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfBVUxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:53:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35476 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:53:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so4130513qtk.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gYho+SJDci46ogfWP8rDdUoa1XSG+4uKQXvcAClE7Cg=;
        b=BQszKic6rPVGucLmlFn0JZDC0vFo/A+jxXyQdt8Vh7hQcZtXND/8jIwq8E5JA//Ymp
         cN2wWS+9doF3ejiEdYAseGqctGv18k1Psa8N9aoxZhEqiCDo4uV6sQksPwVf5EmO0ULP
         HfAn6tYvbCD0kyrW/sXlUUG8ww6FrGuRagIARjNHwCHE/JMK1jym7J9X86u+1fLH84Hj
         KYbci9unE/EWPs4fB6VGeygocefir1uNKI7If09Za1rQNO80eDQYvQAdxyD9VXUBoZ16
         DPhh7Kkk/ygjVktOJir/rB09dQ85bCP1WJvPUUkbKeURnlXVGcIZQjFfaINWGhCLcTFh
         ddwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gYho+SJDci46ogfWP8rDdUoa1XSG+4uKQXvcAClE7Cg=;
        b=f4xAu4WDqZwGSDkZ307LPor1ovpPORcnjJMDcv5DmaEnn6Bs5j9R5eECa7XWcPTpy8
         7viUTmLrUATjQB37iReURLLaI8MopbkVPwPN8i+LPXDfpsDf2AeiC8h8b8RL+D9usr+O
         lSCo+IaywAELgWvH6Tb/i/1lQ81Rbt5MhJHldQ9jzDYxey9JecKY/vTA1cb438QwR0+m
         967sUiCTehQ/sA6fF2ZAUdejHLZKCnTMGhiGMRpu4chkQm2Crk9MPk/Jfb5NLR1cZ/ey
         onb5WzlEuscaWyamD9L8blIt1A0eCY/5JZf0Vgj7U37R0EtrMNu4lJraYzxUt/u5yolk
         uUhA==
X-Gm-Message-State: AHQUAuYZUsXZ8vM8yi+py1AkakHMNAT1plUX6ubtlp86d2RZO3Q8m4ZF
        Lao/qRw5C/eUMQo3iyhyGpY=
X-Google-Smtp-Source: AHgI3IaJiIJrdJZGjiyrLzeA3BjUPQHIupJL2JfWcST8NUB1cmZBWvBP2U88Po2vBir3Q53doObK8w==
X-Received: by 2002:a0c:8b50:: with SMTP id d16mr4553656qvc.233.1550868823313;
        Fri, 22 Feb 2019 12:53:43 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j68sm1394651qkf.84.2019.02.22.12.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:53:41 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 067CF410E0; Fri, 22 Feb 2019 17:53:33 -0300 (-03)
Date:   Fri, 22 Feb 2019 17:53:33 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] perf thread-stack: Hide x86 retpolines
Message-ID: <20190222205333.GG26132@kernel.org>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
 <20190109091835.5570-7-adrian.hunter@intel.com>
 <20190222194244.GF26132@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222194244.GF26132@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 22, 2019 at 04:42:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 09, 2019 at 11:18:35AM +0200, Adrian Hunter escreveu:
> > +static int thread_stack__x86_retpoline(struct thread_stack *ts,
> > +				       struct perf_sample *sample,
> > +				       struct addr_location *to_al)
> > +{
> > +	struct thread_stack_entry *tse = &ts->stack[ts->cnt - 1];
> > +	struct call_path_root *cpr = ts->crp->cpr;
> > +	struct symbol *sym = tse->cp->sym;
> > +	struct symbol *tsym = to_al->sym;
> > +	struct call_path *cp;
> > +
> > +	if (sym && sym->name && is_x86_retpoline(sym->name)) {
> 
> 
>   CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
>   CC       /tmp/build/perf/util/intel-pt.o
>   CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
> util/thread-stack.c:780:18: error: address of array 'sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>         if (sym && sym->name && is_x86_retpoline(sym->name)) {
>                 ~~ ~~~~~^~~~
> 1 error generated.
> mv: cannot stat '/tmp/build/perf/util/.thread-stack.o.tmp': No such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:96: /tmp/build/perf/util/thread-stack.o] Error 1
> 
> 
> [acme@quaco perf]$ pahole -C symbol ~/bin/perf
> struct symbol {
> 	struct rb_node             rb_node;              /*     0    24 */
> 	u64                        start;                /*    24     8 */
> 	u64                        end;                  /*    32     8 */
> 	u16                        namelen;              /*    40     2 */
> 	u8                         type:4;               /*    42: 4  1 */
> 	u8                         binding:4;            /*    42: 0  1 */
> 	u8                         idle:1;               /*    43: 7  1 */
> 	u8                         ignore:1;             /*    43: 6  1 */
> 	u8                         inlined:1;            /*    43: 5  1 */
> 
> 	/* XXX 5 bits hole, try to pack */
> 
> 	u8                         arch_sym;             /*    44     1 */
> 	_Bool                      annotate2;            /*    45     1 */
> 	char                       name[0];              /*    46     0 */
> 
> 	/* size: 48, cachelines: 1, members: 12 */
> 	/* bit holes: 1, sum bit holes: 5 bits */
> 	/* padding: 2 */
> 	/* last cacheline: 48 bytes */
> };
> [acme@quaco perf]$
> 
> I'm removing that sym->name test.

For completeness sake, this was one of the compilers where this failed:

clang version 7.0.1 (Fedora 7.0.1-2.fc30)

The systems where it broke:

  18 debian:9                      : FAIL
  19 debian:experimental           : FAIL
  29 fedora:25                     : FAIL
  30 fedora:26                     : FAIL
  31 fedora:27                     : FAIL
  32 fedora:28                     : FAIL
  33 fedora:29                     : FAIL
  34 fedora:30                     : FAIL
  35 fedora:rawhide                : FAIL
  45 opensuse:tumbleweed           : FAIL
  51 ubuntu:16.04                  : FAIL
  58 ubuntu:17.10                  : FAIL
  59 ubuntu:18.04                  : FAIL
  70 ubuntu:18.10                  : FAIL
  71 ubuntu:19.04                  : FAIL

- Arnaldo
