Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024FEC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A952820823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4ybcfV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A952820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJ3UPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:15:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39906 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3UPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:15:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id a28-v6so7935405ljd.6;
        Tue, 30 Oct 2018 04:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VX+Bq9XeuwywpXaCbL56kjQLxVXpOVKB1A9wyS/dM1M=;
        b=H4ybcfV7FFYJ/SkmlyoiJk7mSDLPIfdqdynmTOv2RkPyvo2khHP24Q144t2WA6lVnt
         7iMqzeb9jLsxuPy4iXPqqCAJ03E/+HLpeUR82Bq/CevOx64OEQPOvoRnDu+vExsa5245
         i0E823A8v7QEUREeIwHTdXM7kQKIh7rwhkHDaX8DU4KoyMJDkkgAYzcUnndVa8KLG+NU
         0ffzr7y+cSNO+pqt4NvaHHLlg9A5fi/XGOJq3wWYTzUZbK2Nd8IknMiiglVCZkXtW9/m
         dmUN928aAw+p7hIR3tefPRTJXI3Zm1DPPbXHaSPQTI5xmdZ2Pfvl3JNOt3un7P0/eOlZ
         n71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX+Bq9XeuwywpXaCbL56kjQLxVXpOVKB1A9wyS/dM1M=;
        b=s0TD4sAoqZizfZg30ijLkv4mRJsOfkbeuW4meo9MFXnJSPWhC52mm/IPO1vno4OXIM
         iO3AqAWDgUIUIqr0BM5itnmBj/nx/lc7Gu2rg5SRyrsTrwl8GBAFIcHAWdU810nG5KUM
         rnOIOeX0FG8WS86sD6HMu2YDTcoN8UT0HEVkk0C0IC491+huEAadJUcZar25bU0//9Vx
         2BOs9UoLCDTs7n3ElYPMOB+nyRtzVqB2nsO7wo5Jzq37pYMIO9xEeg+6Gqj8hbaz9GcQ
         ohWxr3PZ82q8mVm+hf8MHMeRYFlIzg4vE6ZwIt2XO686l17qjFkLwgph3NexiYXzm4+z
         EZrA==
X-Gm-Message-State: AGRZ1gJ2EYxAt11Kz80zkabFC5TCwXK/+KpoTKY6VH3f5RLMhj4IeHLx
        Xjpz8n8E4m3ufrLsKpGaKl/VGqOyN7oe2r4pI5E=
X-Google-Smtp-Source: AJdET5dbv8qdGBF8FhyPE9D3xN+gKa4+AK/TwEY3xsvq7/cWXRBrO6fmii7YkpJZ0B4GrwVdeWnHjzuFH7tFMqFtrxs=
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr8925765ljf.127.1540898523561;
 Tue, 30 Oct 2018 04:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181030104637.382c26d0@canb.auug.org.au> <20181030104941.4fef7dad@canb.auug.org.au>
In-Reply-To: <20181030104941.4fef7dad@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 30 Oct 2018 12:21:52 +0100
Message-ID: <CANiq72k2w2T0Cy0D--OEmE+sOPkjZtXpukBm+Mz1_xY6MCGg0A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the compiler-attributes tree with the
 kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        changbin.du@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Tue, 30 Oct 2018 10:46:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the compiler-attributes tree got a conflict
> > in:
> >
> >   include/linux/compiler-gcc.h
> >
> > between commit:
> >
> >   94c7dfd01652 ("kernel hacking: support building kernel with -Og optimization level")
> >
> > from the kbuild tree and commits:
> >
> >   5c67a52f3da0 ("Compiler Attributes: always use the extra-underscores syntax")
> >   989bd5000f36 ("Compiler Attributes: remove unneeded sparse (__CHECKER__) tests")
> >
> > from the compiler-attributes tree.
> >
> > I fixed it up (the latter just removed the __CHECKER__ check, so I did
> > that) and can carry the fix as necessary. This is now fixed as far as
>
> On reflection, that may not have been the correct resolution ...

From a quick look, it seems we want:

#ifndef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
#define __compiletime_warning(message) __attribute__((__warning__(message)))
#define __compiletime_error(message) __attribute__((__error__(message)))
#endif

i.e. kbuild tree added the CONFIG_CC_OPTIMIZE_FOR_DEBUGGING guard,
while the compiler-attributes tree removed the __CHECKER__ one, so we
still need the former.

By the way, I think 94c7dfd01652 is wrong: it changes the guard also
for __latent_entropy (and it does not change the corresponding comment
at "#endif /* __CHECKER__ */").

Also, the commit message does not mention __compiletime_warning --
should that one be guarded too by CONFIG_CC_OPTIMIZE_FOR_DEBUGGING?

Cheers,
Miguel
