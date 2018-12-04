Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC44C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7312082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t66LeFoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7312082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeLDACo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:02:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37627 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDACo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:02:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so13466488oth.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahw4gQwLvsmvV1zqofEEtSGIGNpYJZgQPEmRreWh4Ug=;
        b=t66LeFoeiVsceyTItnEJaMZBTEW3J1/kCDeNlU2TChD25kycQWLXBp2ewy0s2d+HYS
         xYVQ5d34XxU91YGYKyuR8gWXy5sEkck0AL6/tDjNbY8b5m65XpL0CUDpm4PgVAPYFY7N
         bPknRuB2bz9rZZ+Gx82ROtY5kPbySIia53Lz2LMPqnqDRf/U0s+d6ylgSie4SjuYtrTU
         kGnE1rXvWkw5XPMI3apfsdMVXRyawVLANnpX0T3iRTGEYtXdWnjUUf7NNMszmxW0ury2
         BQFc1Sd8Sbml3644mi/1+oOsZ1isnXvvp6tm2+BW3rBtaNJTWQ4BW8CSgKalv0A2XYzs
         fTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahw4gQwLvsmvV1zqofEEtSGIGNpYJZgQPEmRreWh4Ug=;
        b=Xf/OcoOTDNSnoBrrHM1ZJLf/P4Jb/pY2l++2jZDuP38P940OC5IelNThfJJwJW60cb
         0EtlEaJ3aIQgtW/LBvNwRC3IpdWJqoMOdo3T+w3zybAx3AHnTrdjJtHLDJJVbrPwp+XC
         L5beXsxDMYPHSzGGFUYWtpMY/eOAO9dwpBfOr5sJMbzQTJAei0ovpjuhMbf4D6mzenfZ
         ZBA1dcgT53/ZFPT1v0smXJds0Ln2TdF5hh3xWWus4xXb8MHmhK2OA7U+SMCO5s/XWq5z
         4KQu7XekCq2n8ryg7U7TUhs9w9Lxs5W5myzSBF+QbtEL2Xbo+q7rAHVjhqTaMdUPRXtq
         cXyA==
X-Gm-Message-State: AA+aEWZlsTMYlTn2gtvTs95UKRTmShhdfkh2WN6e11TsNj1mtVYoaYbI
        FRfcG8wqX4gp0aNPO5mwd2u53jZXNL7uOqk/e/K89Q==
X-Google-Smtp-Source: AFSGD/Wc35K87HZq9TdXKn1wnrVi5iRwzFZ7uaeINhcG7HMGFULmA1ak6g5fCY7uKLH+Ssfby8hfkiG0LHRqnnlbRZg=
X-Received: by 2002:a9d:638f:: with SMTP id w15mr10850019otk.230.1543881763067;
 Mon, 03 Dec 2018 16:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-17-brendanhiggins@google.com> <20181130034623.GQ18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130034623.GQ18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 16:02:31 -0800
Message-ID: <CAFd5g463cxzsF+DJ06aL=mjGzNX1NcE5Xp8b584U2TAJ5joQKw@mail.gmail.com>
Subject: Re: [RFC v3 16/19] arch: um: make UML unflatten device tree when testing
To:     mcgrof@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 7:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 11:36:33AM -0800, Brendan Higgins wrote:
> > Make UML unflatten any present device trees when running KUnit tests.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  arch/um/kernel/um_arch.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> > index a818ccef30ca2..bd58ae3bf4148 100644
> > --- a/arch/um/kernel/um_arch.c
> > +++ b/arch/um/kernel/um_arch.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/kmsg_dump.h>
> > +#include <linux/of_fdt.h>
> >
> >  #include <asm/pgtable.h>
> >  #include <asm/processor.h>
> > @@ -347,6 +348,9 @@ void __init setup_arch(char **cmdline_p)
> >       read_initrd();
> >
> >       paging_init();
> > +#if IS_ENABLED(CONFIG_OF_UNITTEST)
> > +     unflatten_device_tree();
> > +#endif
>
> *Why?*

Whoops, I didn't realize how bad that looked. In anycase, doing what
Rob suggested as a separate patch should clear this up.
