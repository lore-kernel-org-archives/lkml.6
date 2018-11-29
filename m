Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F423208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZxa50Tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F423208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeK2LX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:23:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32863 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeK2LX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:23:56 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so182937qtp.0;
        Wed, 28 Nov 2018 16:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WDk9I4R2UQTMIPoqUt9uHnpJM1NWRv6jGUDTj14jyE=;
        b=HZxa50TbQhQJXonPrrYEqnm+LVuAGfE1LexIWO1TLlqU7vsPduESyzV/4H2aVds8zV
         orF9Vi70Rt4zRi7uVy8Su6uxsULqUw4MRLECQqvRHvMW2TnNPgZVheDXL3FfQuJWf1aq
         BA1kUErRK7ehYb20jS3852M7LCfQxEIQpZRd6fyCHcvwqb5LpiXG5ehsXu5ptcUjDqvO
         0aIaVVO9gkDm7mkfDKd29kYrk716MuDwc3xaH/zmRGyqoeDT3HQA8i2Z8Em+Ph809Fzc
         aIkxGXDvpJT+CHspeRn0uOZ8+DVXom2nEpxCwVLvGjZWPyja2oLINA+ImTPgewsZEH2V
         A+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WDk9I4R2UQTMIPoqUt9uHnpJM1NWRv6jGUDTj14jyE=;
        b=Ci73fuBvjfHQaFjS2ePuU5CIarVjD6jqgdeDb3oOniMbOm20rUtghi2XqdRFm1hz2n
         /lZFsQ1zEcmn6lzvOncInbG36zKvnml9mX+tJbBwwaREfxp1gjUV/N9NWw8rrAA3sTAA
         8kCr9rRwtUF//UY8P69IKWHBbSHl2r4gv9wtrWzvN8/i2AYkVjavl7QVfxuRQRGq1Fo1
         ESyQu/zWl0yrCirtrpcEn62WoYJSG/PNdzu7Bwmj3MbsL67xyvzgVbVzxzxbUTpdO3cT
         iBHkz+cHkKhco77nbNXlof8Stcqsenw94S04x2HPy1TLeA3mzNH5yiIVhybJB+I7wJlO
         dmNw==
X-Gm-Message-State: AA+aEWZ3HNax6mYgRw1k3B+ng9uh8GNXyQ4piEFVQi73QeBIx/iNsNZ+
        nzWyR1ikX8/75RFEMgxTQChMdanLXYA5Mdu6k6I=
X-Google-Smtp-Source: AFSGD/X7KgvEsvAPyUM2F+w5imj1B3aIPc08nLSj7AnQSrmTBH06pmlbxdO7XNFBQ17AOwqVO2D062XYT5+B+uk5Ws4=
X-Received: by 2002:a0c:d80f:: with SMTP id h15mr37735977qvj.228.1543450829657;
 Wed, 28 Nov 2018 16:20:29 -0800 (PST)
MIME-Version: 1.0
References: <CANWdNRAD2XBnztZN760mOX+LfXY_uAvsRqEnkTJnqwrZCBK92w@mail.gmail.com>
 <20181127133054.GE15747@kernel.org> <CANWdNRDdSMeQ1RHpHMoG7-aRVjufG79jyrZqYqho2_3gX3hrfw@mail.gmail.com>
 <20181128130438.GB31608@kernel.org>
In-Reply-To: <20181128130438.GB31608@kernel.org>
From:   Ivan Babrou <ibobrik@gmail.com>
Date:   Wed, 28 Nov 2018 16:20:03 -0800
Message-ID: <CANWdNRBxserM6h_u1WNXgW0qiBzoAWM433aU-RT4+WGmZ=wPmQ@mail.gmail.com>
Subject: Re: eBPF program symbols in perf top
To:     arnaldo.melo@gmail.com
Cc:     linux-perf-users@vger.kernel.org, daniel@iogearbox.net,
        ast@kernel.org, davem@davemloft.net, dsahern@gmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 5:04 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Nov 27, 2018 at 11:41:19PM -0800, Ivan Babrou escreveu:
> > Hey Arnaldo,
> >
> > Thanks for the quick response. I've tried your patch and it works as
> > expected with perf top.
>
> Ok, I'll add the patch to my perf/core branch with your Reported-by and
> Tested-by, is that ok with you?

Sounds good to me.

> > What are the reasons for not giving kallsyms precedence at this moment?
>
> The use of vmlinux for these things predates having many of the code
> modifications that are performed in a live kernel these days, also
> pre-dates eBPF, etc, etc, so using vmlinux, when found, was better
> because ELF symtabs are more expressive, kallsyms have just the start of
> a symbol, for instance, etc.
>
> Having that said, with the advent of things like Intel PT, etc using
> /proc/kcore + /proc/kallsyms became a requirement, there is even code to
> stash copies of those in ~/.debug/ for post processing (off-site using
> 'perf archive' even, etc).
>
> I _think_ that switch to using /proc/kallsyms as default now is becoming
> a requirement, just haven't thought thru all possible implications of
> doing that.

I'm looking forward to having it enabled by default, also happy to apply
a patch and start using it internally when you have it.

> I don't recall if there is a way to set kallsyms precedence in
> ~/.perfconfig, have to look at that.
>
> - Arnaldo
>
> > On Tue, Nov 27, 2018 at 5:30 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Mon, Nov 26, 2018 at 04:21:15PM -0800, Ivan Babrou escreveu:
> > > > It's possible to see eBPF programs in "perf report" and "perf script"
> > > > started with "--kallsyms=/proc/kallsyms", if net.core.bpf_jit_kallsyms
> > > > sysctl is set to 1. However, it's not possible to pass "--kallsyms" to
> > > > "perf top".
> > >
> > >
> > > So, the first step, I think, is to check if having 'perf top
> > > --kallsyms=..." would help, i.e. to check the patch that introduced
> > > '--kallsyms' to 'perf report' and see if that would be difficult to have
> > > the same functionality in 'perf top', the cset where it is introduced
> > > is:
> > >
> > >   b226a5a72901b ("perf report: Allow user to specify path to kallsyms file"
> > >
> > > Below is the resulting patch, can you please check if with that you get
> > > the result you want? We can then go from there to some simplification,
> > > perhaps give precedence to kallsyms.
> > >
> > > diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> > > index 808b664343c9..44d89fb9c788 100644
> > > --- a/tools/perf/Documentation/perf-top.txt
> > > +++ b/tools/perf/Documentation/perf-top.txt
> > > @@ -70,6 +70,9 @@ Default is to monitor all CPUS.
> > >  --ignore-vmlinux::
> > >         Ignore vmlinux files.
> > >
> > > +--kallsyms=<file>::
> > > +       kallsyms pathname
> > > +
> > >  -m <pages>::
> > >  --mmap-pages=<pages>::
> > >         Number of mmap data pages (must be a power of two) or size
> > > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > > index aa0c73e57924..1252d1759064 100644
> > > --- a/tools/perf/builtin-top.c
> > > +++ b/tools/perf/builtin-top.c
> > > @@ -1289,6 +1289,8 @@ int cmd_top(int argc, const char **argv)
> > >                    "file", "vmlinux pathname"),
> > >         OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
> > >                     "don't load vmlinux even if found"),
> > > +       OPT_STRING(0, "kallsyms", &symbol_conf.kallsyms_name,
> > > +                  "file", "kallsyms pathname"),
> > >         OPT_BOOLEAN('K', "hide_kernel_symbols", &top.hide_kernel_symbols,
> > >                     "hide kernel symbols"),
> > >         OPT_CALLBACK('m', "mmap-pages", &opts->mmap_pages, "pages",
>
> --
>
> - Arnaldo
