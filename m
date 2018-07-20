Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCEBECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697E620661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwH8Nuaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697E620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbeGTQMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:12:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53275 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbeGTQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:12:13 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so15171432itw.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Millr4p7z4Lx1AraIxVV5LY7eRZTQ5E0LQzAp7Vgbg=;
        b=JwH8NuazhS94612cBdudIqw50178aO+DsTQtxj2EBxPDxHARnxn088pLcYZy3syTP4
         5s5a5LEfa87pZ+zuHd/L2hjiztJb2wJP3zT1or0PqMhwBdHR39zs7tXCR2kaF73Po8FM
         wmbhFD/V57l88xpwQxAvIVD1OHl2vf2bOYjqYFg4LEW+rDV73GTerNKM2YpFdlFsu5t2
         KEfsUGTRSnvOmZKfl0MGVuAf9mWJz6U9vSEioMER46W9CN6xNvHLgmyinIE+G/kAPNTx
         Nxoll752QUvrLiE6rbAaLhcnqQ/SCvRUSSFiCo97z0wKXvSAAVd0WA2Fe6fn6Ly00rhv
         Xugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Millr4p7z4Lx1AraIxVV5LY7eRZTQ5E0LQzAp7Vgbg=;
        b=esnFvOsRWl/3KW3PwLBr581Sp4J4BcpXu11461sOuteDd3rhvIujTJMx89AUA3BnoF
         RLEsrSKhJw08bt0WxUlpBgW78d7loOSGYBFwQ0uPEBAAmTNZH4Cv/gnXo0qgRw4nonzr
         Q3kTi64KMWuNcp/ShyHVeRBqAJONmbKhOwRYIolHmpK9JwHgQh1z9GXDoqka0TczUuHg
         t5dxTyLoLTywtXLcfP++BmdMrVNQgR1TJtLOEG0tQPoX9egYIo0Yqd09RTy8UNphV83c
         vB23tN84V99YfgrL2lfS2KV4Pq/RIJZWRSH8tWqle6G+cDSNsAII+1oiIK8eI+ahx+av
         aqSw==
X-Gm-Message-State: AOUpUlGi7xZHe+rYEWmkX/egPdt0PafaeI1qkgy9B3AJnmjObL4EGkes
        Arn+tnvJRJHjXDizNKVaEpFa5HagCgbtQE1YEnQ=
X-Google-Smtp-Source: AAOMgpfK6Sq7qo/nWH6uomLNsfyn23B9s+B4IqYjbeK9mUYWpfoy0StH/TY1Eq1u/AWieJUBoZvU84K7Qa71wtGDluM=
X-Received: by 2002:a24:dc07:: with SMTP id q7-v6mr2239757itg.147.1532100206057;
 Fri, 20 Jul 2018 08:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180720110036.32251-1-jolsa@kernel.org> <20180720110036.32251-3-jolsa@kernel.org>
 <20180720145745.GB4329@kernel.org> <20180720151518.GC27176@krava>
In-Reply-To: <20180720151518.GC27176@krava>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Fri, 20 Jul 2018 18:22:49 +0300
Message-ID: <CAJ1xhMUeXAwZADxxJAALzwhnMFDQk0hMPeepRML+OLV92fmnJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf tools: Fix check-headers.sh output file variables
To:     jolsa@redhat.com
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, a.p.zijlstra@chello.nl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 6:16 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jul 20, 2018 at 11:57:45AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Jul 20, 2018 at 01:00:35PM +0200, Jiri Olsa escreveu:
> > > The warning message in check_w function uses wrongly
> > > the $file variable instead of $file1 and $file2.
> >
> > Humm,
> >
> > Before:
> >
> > Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'
> >
> > After:
> >
> > Warning: Kernel ABI header at '../arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at '../../arch/powerpc/include/uapi/asm/unistd.h'
> >
> >
> > The previous version is better, I can then just use:
> >
> > diff -u tools/arch/powerpc/include/uapi/asm/unistd.h arch/powerpc/include/uapi/asm/unistd.h
> >
> > and get what changed, with your change I have to go to tools/perf before
> > doing that diff, which is an unnecessary extra step in at least my
> > workflow.
>
> so all paths output based in kernel tree root then, will change
>
> jirka

I was going to ask about this in a separate email initially, but then
thought I'd use this email exchange instead, as my question is about
the code in question. Hope you don't mind.

If I'm reading this right, the intended behavoir of the block of code
below is to test file2 for existance, and if it exists, to evaluate $cmd.
If file1 and file2 are found to differ, print the warning.

test -f $file2 &&
  eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file'
differs from latest version at '$file'" >&2

The '||' path of execution is however also taken if file2 doesn't exist,
which is probably very unlikely to happen. See below.

% file1=file1; file2=file2
% cmd="echo diff $file1 $file2"
% test -f $file2 &&
eval $cmd || echo "Warning: Kernel ABI header at 'tools/$file1'
differs from latest version at '$file2'" >&2
Warning: Kernel ABI header at 'tools/file1' differs from latest
version at 'file2'

Is this something you would rather leave as is, or perhaps use something
along the lines of the code below instead:

test -f $file2 && {
eval $cmd ||
echo "Warning: Kernel ABI header at 'tools/$file' differs from latest
version at '$file'" >&2
}

Thanks.
