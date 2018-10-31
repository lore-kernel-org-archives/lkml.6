Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5FCECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F8920657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQY4FgS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F8920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeKAEyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:54:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42880 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeKAEyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:54:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so8121135pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46d64IHoNhXANyIrt6w+MMKJEMStKIEctNagK9GxHFk=;
        b=uQY4FgS2njnX/3V8ewtVEgDS8wNzkB8V5oYN/dli87lTtjSvAQ+iyLokNWSEymakYC
         CuC6nWtVFmPOaZozSgLmIRZTKz4YYUoIUJ60pcM9xzV0YuxyCON/eG0NohxhEjqvSHmf
         kYTRK2fWPdeMN5frR5hzlC14ai1rme4Ct81qLo7Q2PJ6kLMn4JhyS9grZX4QKV2yLtYS
         uMDIssFxArkVuyBRVxiI8fVCRwglhxE6qbafphZEE07ywv661zsB/KP7ukqskl6z4/mo
         lWF+47nreiXvCdxFZUpQ4fSaQNYeCSB3LZGVSIIEzsynZvYOiF1dFp4qXHjM8hcBqV7/
         A38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46d64IHoNhXANyIrt6w+MMKJEMStKIEctNagK9GxHFk=;
        b=RVmQR66ytDNyym2F3kvm6lmCuRfJu31P67+VoT0i1aHZDIesOBaVhVj4AMJEQ79v2B
         6fwk+8WAphWUDKROpFup1N+3RNXGqA1DcPE87mXIWfUcUeTamZ7uc1DpcLOn6wSjO2UD
         9l/5SVPWYcLF/JavCmcdXf63B5Nt+M1G40+GFj11cpynwDJR7jcVFdv79Za8wiF/lyJs
         djOYfxzmLLLe2NKMPsyN6mMBY+T2e3WbBvzPW6fIaifo48RVuZ1CQJz6ETwh174Aag0L
         xtBhRnlJtyPZuG+07Bz/ldBSscHGZe6p0JQfGJzVlO25Z/yaYIGB93mocLSwtGtyaWK+
         Nq1g==
X-Gm-Message-State: AGRZ1gKTIQzQS16YdUKuhO6x1hv1aAeVFpRXz765G8iiLNgPuh3YY2Nz
        AaxRVdGhfyZO5swoB89h0LbxNfHOMXDG49LH2Mt0bA==
X-Google-Smtp-Source: AJdET5dgh/Pl8QD0yN8b+eAwtHVBQi4BWLAxP4Bi/jWcMxvHdMeoWSPjXXS0/2y6DVOM2V+CDpha1/UqNOgwVxyZPaU=
X-Received: by 2002:a65:4806:: with SMTP id h6-v6mr4512221pgs.302.1541015707933;
 Wed, 31 Oct 2018 12:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181031032829.18131-1-joel@jms.id.au>
In-Reply-To: <20181031032829.18131-1-joel@jms.id.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 31 Oct 2018 12:54:57 -0700
Message-ID: <CAKwvOdm8rFNEG39_6f5voZo3nU1g9eC6M8uxeQPVE8=JUoB3mg@mail.gmail.com>
Subject: Re: [PATCH] raid6/ppc: Fix build for clang
To:     joel@jms.id.au
Cc:     mpe@ellerman.id.au, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, jji@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 8:28 PM Joel Stanley <joel@jms.id.au> wrote:
>
> We cannot build these files with clang as it does not allow altivec
> instructions in assembly when -msoft-float is passed.
>
> Jinsong Ji <jji@us.ibm.com> wrote:
> > We currently disable Altivec/VSX support when enabling soft-float.  So
> > any usage of vector builtins will break.
> >
> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> > I guess this is currently a limitation.
> >
> > Removing -msoft-float will make it work (and we are lucky that no
> > floating point instructions will be generated as well).
>
> This is a workaround until the issue is resolved in clang.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> Link: https://github.com/ClangBuiltLinux/linux/issues/239
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Hopefully we can have this fixed up soon.  I'll try to see who works
on Clang+PPC here and see if they can help move that bug along. Thanks
for the patch!

> ---
>  lib/raid6/Makefile | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index 2f8b61dfd9b0..3a844e6fd01c 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
>
>  ifeq ($(CONFIG_ALTIVEC),y)
>  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> +
> +ifdef CONFIG_CC_IS_CLANG

Note that the top level makefile detects clang via:

ifeq ($(cc-name),clang)

Does that not work here? I'd prefer to keep compiler detection in
Makefiles consistent, if it works?

> +# clang ppc port does not yet support -maltifec when -msoft-float is
> +# enabled. A future release of clang will resolve this
> +# https://bugs.llvm.org/show_bug.cgi?id=31177
> +CFLAGS_REMOVE_altivec1.o  += -msoft-float
> +CFLAGS_REMOVE_altivec2.o  += -msoft-float
> +CFLAGS_REMOVE_altivec4.o  += -msoft-float
> +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> +CFLAGS_REMOVE_altivec8.o  += -msoft-float
> +CFLAGS_REMOVE_vpermxor1.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor2.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor4.o += -msoft-float
> +CFLAGS_REMOVE_vpermxor8.o += -msoft-float
> +endif
>  endif
>
>  # The GCC option -ffreestanding is required in order to compile code containing
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
