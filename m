Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF7CC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9B720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="C7GjDYxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9B720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbeLCWOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:14:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33464 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeLCWOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:14:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id o89so8424893qko.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tQRj7YtxJOLI8Nz3X9VVhFqSK8FkIZrTx2UbmzwihE=;
        b=C7GjDYxfLh2Ob9D56uUowuyLO8W0DY+VN4ISVR/GArE/4dA45oc+I4KFmQz7Klvm6m
         1rzcJqN/EZCtVWkNHbwIku91WkzttPj0oQnXSgwCjQtJsChsz39MTR0XfOOwr5mAsa76
         n3EhstuTziWg+N8s6iLR300efG4E/1IVrKD7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tQRj7YtxJOLI8Nz3X9VVhFqSK8FkIZrTx2UbmzwihE=;
        b=h4dzTFGgODFzdOoBiWSwmhSkUIcrsru9urg26d7yjTmWjXm7QZufz1odVUlDoHabmB
         Zi2NekCedC3AY5/J9RE7cxLyv1qk/P/dStj/V/X1BU+EMqDFp4f5+9Sz3WkoliXKaA87
         kBmZCYL5CBbz2+G83MvVsoCdgvbzOOvSXlY6CBiBX/E1vsGdAovLAAFzx2s8JTIZfPJ2
         XUOef3Pmt9CV8aQNFJkbNSj4wCaTUUdu3xoiY+uAypDRB7aunlvwSZjV1NtMffnRr9cL
         Sj5UDixJldQ5UpT30A8Lxpwa4sHmEmdpN1mk2pnwyw5NOAJNf0g6tFgdDuLv7qBaNEMx
         TPhQ==
X-Gm-Message-State: AA+aEWYWCDOQ+5FvSZtMWDmecKxEwd1LqcYt6hx0HAs6QsSdGm1FaKQX
        DD/Z5YdvGStvJCfKrzkol+8FNixUPjXBFihV4Vs=
X-Google-Smtp-Source: AFSGD/VOPJfpW1K8PArA2x7433o4go/0YHLtInmxXWri+wIbqOZ9BOYZcfNZYL5wRAcdSCEqMRMFuKR3zoc35aysQhs=
X-Received: by 2002:a37:781:: with SMTP id 123mr16494465qkh.231.1543875239356;
 Mon, 03 Dec 2018 14:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20181102004455.10157-1-joel@jms.id.au> <CAKwvOdni_iJ4beAWYkUUpZss_PYZezMGR7hN9k1rm9J0iB0gHQ@mail.gmail.com>
 <CACPK8XdbWzb=52iFV_fj0Y5KMWPgsRv_A8PZgfKn9vm96y3LOw@mail.gmail.com> <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
In-Reply-To: <CAKwvOdndyeRZApOqbp-6evEpYgzHyGo4qqaMKd_DQ4U9x8_5wA@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 4 Dec 2018 08:43:47 +1030
Message-ID: <CACPK8Xcz4YzfnFAHGOcJZkt0UFfQ02YabtEQDHXdSFsH57xRiQ@mail.gmail.com>
Subject: Re: [PATCH v2] raid6/ppc: Fix build for clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, Jinsong Ji <jji@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 05:15, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > +ifdef CONFIG_CC_IS_CLANG
> > > > +# clang ppc port does not yet support -maltivec when -msoft-float is
> > > > +# enabled. A future release of clang will resolve this
> > > > +# https://bugs.llvm.org/show_bug.cgi?id=31177
> > > > +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> > > > +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> > > > +endif
> > >
> > > Hi Joel, thanks for this patch!  My same thoughts about
> > > CONFIG_CC_IS_CLANG vs cc-option from
> > > https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-November/180939.html
> > > apply here as well.  I don't feel strongly about either though.  What
> > > are your thoughts?
> >
> > I'm not sure that we can test for this one with cc-option. The result
> > of having -maltivec with -msoft-float is a error about the internals
> > of clang, which isn't something that kbuild is set up to test for.
>
> As in clang itself crashes, and cc-option/kbuild can't handle that gracefully?

The developer gets something like this:

SplitVectorResult #0: t196: v16i8 = llvm.ppc.altivec.vcmpgtsb
TargetConstant:i64<4823>, t146, t195
fatal error: error in backend: Do not know how to split the result of
this operator!
clang-8: error: clang frontend command failed with exit code 70 (use
-v to see invocation)

>
> >
> > When clang is fixed to allow this combination we will still build this
> > code in the same way, so in that sense it fails "open".
> >
