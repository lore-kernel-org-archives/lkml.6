Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EABEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7620817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl0dzeIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC7620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeK0Gbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:31:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37160 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeK0Gbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:31:40 -0500
Received: by mail-ot1-f67.google.com with SMTP id 40so17782714oth.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=eUvKoxvllilS8RAwlb2OPwqR06skVtVxk65VhQd25vw=;
        b=Zl0dzeIjchfFdOfVOBrXyNXBwGJF5DcBctJq3YWOhLareMWJEemLppTHQdHzBE4Po9
         lre4XJrd1dNRAXPizFHIUu8X1V0DCYkV6ulWRJ9RR7/aIhNE0yWBl1Uu6bK/RN4qrbdL
         b6Om6aEc4+Qzwv1FVtQNWsH0tYvyzwdT+m0rgxALrsLD3ltFB+ys+LGYDdXB6o714HJl
         KHA9DzCQBmkRGEoI8zUY4yQwhOOo33IRdZiTTEqAm4PhStSmRkW8CIjRz2OmXgm0YW60
         hPQY9WqmH/maEFAGgKIoMmL0VPy1azWR33jDOmT2q0cRUPCLTf0C+mbs36qu5LEitatj
         XbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=eUvKoxvllilS8RAwlb2OPwqR06skVtVxk65VhQd25vw=;
        b=e2/0RoJ8a/MSu2d/LAyN/orah6SHqQ6X3BIzRFNKDA20MD3rIpqe1RuZx5fKZTykKN
         lY513TDdGrD9fbgy+p1uB3p18QKChvQDxqMnzbdhjtUfeX7toFArDRCCmvBdVZE63DiV
         Bsx/1Y3sdN2fWE9mdeuDe1n4EDmsYRVpyW1hxRRRqni9EcgRlRG04tDzQ1YFZ7vXfwYB
         eFA/HYseNzS0Pv476WciugEf1hJa+qEK1HEi+t4j5xN2umodwkGwjJXNWJtDbzEvnDtP
         oAm2fPITOdbmt9VtsVS54Qcat5VHnyip9Q/j5BJ3e0qD/oDkptf90ljCkWqKQmfKm7MK
         SfFw==
X-Gm-Message-State: AA+aEWZWmSUhk0SNBA2Pq0zn7hiBEUrYXXaELbkMMeLjL9qX8zSF4au8
        4eZh8qt2WQkI19MyVex74Rd1rW6MZc/SYw7ZWHI=
X-Google-Smtp-Source: AFSGD/XZFOzKCNCp26gqMsUHipWepa9nZc3qDa6UwJnHR3mf/hIOYmbo+r5PhFg/Rgk/JJejX8oyQQ/EZ8IEAzSrNew=
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr16400470otb.18.1543260991862;
 Mon, 26 Nov 2018 11:36:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+XhMqyR1wMEnEE2cCnoGj2RatxTbFuNH2jOj1-50iYso67rAw@mail.gmail.com>
 <20181126113724.svbv6np25fzxkhrm@gmail.com>
In-Reply-To: <20181126113724.svbv6np25fzxkhrm@gmail.com>
From:   David CARLIER <devnexen@gmail.com>
Date:   Mon, 26 Nov 2018 19:36:19 +0000
Message-ID: <CA+XhMqz9igfiZqRgwvfQ0c=FVyWf=ZUD0xjypEgzO27qwmBNeA@mail.gmail.com>
Subject: Re: [PATCH] Little memset_explicit optimisation
To:     joeypabalinas@gmail.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, aryabinin@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I m not used yet at all to LKML rules.

So here a slight difference in assembly generated between the two
versions (amd64) :
`
     .loc 1 7 7
     leaq    -12(%rbp), %rax
     movq    %rax, -8(%rbp)
-    .loc 1 11 2
+    .loc 1 9 6
     movq    -8(%rbp), %rax
     movl    $4, %edx
     movl    $0, %esi
     movq    %rax, %rdi
     call    memset@PLT
+    movq    %rax, -8(%rbp)
     .loc 1 13 23
     movq    -8(%rbp), %rax
     movl    (%rax), %eax
`
On Mon, 26 Nov 2018 at 11:37, Joey Pabalinas <joeypabalinas@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 12:35:43PM +0000, David CARLIER wrote:
> > Using the return value of memset for save/load sake.
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  lib/string.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index 38e4ca08e757..92da04a0213b 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -720,7 +720,7 @@ EXPORT_SYMBOL(memset);
> >   */
> >  void memzero_explicit(void *s, size_t count)
> >  {
> > -       memset(s, 0, count);
> > +       s = memset(s, 0, count);
> >         barrier_data(s);
> >  }
> >  EXPORT_SYMBOL(memzero_explicit);
>
> Could you elaborate on the optimization that this patch performs?
>
> --
> Cheers,
> Joey Pabalinas
