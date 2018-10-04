Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7F20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="fwle7fpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E7F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJDS7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:59:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46122 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeJDS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:59:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id d8-v6so9470426qtk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VbwHE1bXXqniZTPY+6B2Ii7QmdRY5vicNxdSSO9TY0=;
        b=fwle7fpaUg0plNQ8oNRkDsqParr9ec3l7Z0pXZwquBmXimcTAbStFViIVnjm+zVMHK
         e3gAhCBSCZzCwVECxau6hzypPwuH8bANK2UvkbAvX9Wzezv8TGQ+PJymMuf2mAhbcObM
         prEr7SV+gZxDsjAbvOt7NOSid4nhgc89GSHQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VbwHE1bXXqniZTPY+6B2Ii7QmdRY5vicNxdSSO9TY0=;
        b=nMBab86GhIu044lggb3jOxsy3IGi2cqbg9Hvat/LKdu5xUaFOkUwDHYnh0QxdQGscx
         dOpjAaQhTwFTRvZIxXQniAQeS/cg7sHJjuf0ISdozR4fMHOhipOtGHkh4dNaFnzMJu9f
         JVDL3oXs2Gid8b8hKNGViD68StNndlSHV5nS40G8BQAOy7YovRw97VmGabIQ8kWrb1RQ
         /B2kO1eEslKMGH7yOTUBdUJLZzFgrBq4G4S2nVOBm7DW5rY7VHdl0Q6yrL5v2qmCR3f8
         qLPnxnnPkq4O+l/FcpUDsd/S+NVeOTYyMoFyf5qNneRX2W/Z6rfGPXwU/y6czFim0v+q
         g4NQ==
X-Gm-Message-State: ABuFfoia29HNpfnaAvLAZz3ZMD19mdkr5de6exXNHC5pRybk9PqDPnd3
        SR1Ijfk/ZrKNrhauoN0AXpSO+KD1RgPmDKM1+HOlfQ==
X-Google-Smtp-Source: ACcGV63c51LJQ1u+BcKSaswSxCPLevrAxs4JbEcHWt3BcVOEb6PwtzL8S1mTcDog8rHbWNiPU4c48/0e1xsxsGfj6KI=
X-Received: by 2002:aed:210e:: with SMTP id 14-v6mr5132611qtc.9.1538654782228;
 Thu, 04 Oct 2018 05:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
 <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com> <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Thu, 4 Oct 2018 15:06:11 +0300
Message-ID: <CAMT6-xhP=2wjsKJFumKUsUGVL6U_BynMv6RE0cxXgk6cyfjJkw@mail.gmail.com>
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
To:     geert@linux-m68k.org
Cc:     sergei.shtylyov@cogentembedded.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 12:14 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, Oct 4, 2018 at 10:38 AM Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > On 10/3/2018 8:23 PM, Maksym Kokhan wrote:
> > > CONFIG_BUILTIN_DTB selection is duplicated in menu
> > > "Machine selection" under MIPS_MALTA.
> > >
> > > Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> > > Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> > > Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> > > ---
> > >   arch/mips/Kconfig | 1 -
> > >   1 file changed, 1 deletion(-)
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 3551199..71d6549 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -539,7 +539,6 @@ config MIPS_MALTA
> > >       select USE_OF
> > >       select LIBFDT
> > >       select ZONE_DMA32 if 64BIT
> > > -     select BUILTIN_DTB
> > >       select LIBFDT
> >
> >     LIBFDT seems duplicated too.
>
> Using random sort order doesn't help. Keep them sorted, please?

We are going to deal with it in the separate patch.

---
Regards,
Maksym Kokhan
