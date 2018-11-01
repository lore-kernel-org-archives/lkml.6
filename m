Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73599C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384BD20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKamKBN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384BD20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbeKBBJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:09:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33454 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbeKBBJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:09:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id q5-v6so5540333pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMrw8HVK6jGfR2DhUTHCWV+WpzQB8IOgQavwOC2eyKM=;
        b=AKamKBN44a0qgpFozWUUxMcT3t/S6Kh4Nb48t9WLwkEPcS8aLuPQ4i0ppB7xjk0RqH
         NSEZNJtlSqtkzecJMmjL4n4JMh99s7ZEQRMmNGLXgGeLEuyEiacekgNzAyRkWz9DdCUd
         ORXQYIvPVT9qyHqD1G3vyhmN0qBqOk7afDP0/flvYD183FGMIqJoFZKYczPTQ6vhmfsR
         rRbX+5xnz20DxVKq9VHt8wx9a6ompwuGpgqS6XnENKi+7hZAOLhpDP0UVJar8wLzCHSQ
         8bWR+gwfu5033mbyDpaIrBI4NPsph3/MOWLCl12eK1DDda38M8W5WeFQYWjz+qCrQODB
         DLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMrw8HVK6jGfR2DhUTHCWV+WpzQB8IOgQavwOC2eyKM=;
        b=gpj7F7boMF5KOS2L+D+8h54VbOSX+nDn+nPNxivclSy/PkkH/qH1QC7sU+0JCFiTz3
         1LYiXzpfYKqngJ4Iu6qq3XL9XIBmryp2UF2oTOVPD1Y75s5Af9hjwk9H/6ssBel4UoXz
         0OxRnXaCdag4VYUcA9Zw20DO2i09XDsMcnvuHw3Am/dzVQ6EXyBKAfrvTwsFoUhToeQy
         K2NedpC2hHM2jPZ+E5gqcYVNta5xjTOzzqPTYMjaEHU5kwtq9QC46mnCVhmvboYFhcba
         KX2vRuvaG15GFpPmHFW7aXETHyICaS+Ad3Z9oJQzQ1v5B48L3WHkY2jCCp2rG7pN2nuh
         JT5w==
X-Gm-Message-State: AGRZ1gIip5VkuJJ7VmoYqIFBE/ImikTi6Yojh84V5kAtniFZmouRnfim
        TFlt7VbyPJBFRnDHcKhDn4BJ2fK3Kjuul9Y7M0A8pA==
X-Google-Smtp-Source: AJdET5eoXK+W3sjCsFzF3em56oE9gR3q2hRRkV7GpbD8JpV8KwXSd/opxS6J+169dfl6d9sLxALHWuQgtLAU0mgunj4=
X-Received: by 2002:a63:a064:: with SMTP id u36mr4990902pgn.145.1541088341709;
 Thu, 01 Nov 2018 09:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181031032829.18131-1-joel@jms.id.au> <CAKwvOdm8rFNEG39_6f5voZo3nU1g9eC6M8uxeQPVE8=JUoB3mg@mail.gmail.com>
 <87y3ad76pg.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y3ad76pg.fsf@concordia.ellerman.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 1 Nov 2018 09:05:29 -0700
Message-ID: <CAKwvOdnSO8dXS6MXinFCwm5xu-PFU78GnZCzPKAOHTSPpF9pKg@mail.gmail.com>
Subject: Re: [PATCH] raid6/ppc: Fix build for clang
To:     mpe@ellerman.id.au
Cc:     joel@jms.id.au, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, jji@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 9:38 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Nick Desaulniers <ndesaulniers@google.com> writes:
> > On Tue, Oct 30, 2018 at 8:28 PM Joel Stanley <joel@jms.id.au> wrote:
> >>
> >> We cannot build these files with clang as it does not allow altivec
> >> instructions in assembly when -msoft-float is passed.
> >>
> >> Jinsong Ji <jji@us.ibm.com> wrote:
> >> > We currently disable Altivec/VSX support when enabling soft-float.  So
> >> > any usage of vector builtins will break.
> >> >
> >> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> >> > I guess this is currently a limitation.
> >> >
> >> > Removing -msoft-float will make it work (and we are lucky that no
> >> > floating point instructions will be generated as well).
> >>
> >> This is a workaround until the issue is resolved in clang.
> >>
> >> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> >> Link: https://github.com/ClangBuiltLinux/linux/issues/239
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >
> > Hopefully we can have this fixed up soon.  I'll try to see who works
> > on Clang+PPC here and see if they can help move that bug along. Thanks
> > for the patch!
> >
> >> ---
> >>  lib/raid6/Makefile | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> >> index 2f8b61dfd9b0..3a844e6fd01c 100644
> >> --- a/lib/raid6/Makefile
> >> +++ b/lib/raid6/Makefile
> >> @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
> >>
> >>  ifeq ($(CONFIG_ALTIVEC),y)
> >>  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> >> +
> >> +ifdef CONFIG_CC_IS_CLANG
> >
> > Note that the top level makefile detects clang via:
> >
> > ifeq ($(cc-name),clang)
> >
> > Does that not work here? I'd prefer to keep compiler detection in
> > Makefiles consistent, if it works?
>
> cc-name is being removed in favor of CONFIG_CC_IS_CLANG:
>
> https://lore.kernel.org/lkml/1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com/
>
> cheers

Cool, thanks for the link!

-- 
Thanks,
~Nick Desaulniers
