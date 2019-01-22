Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0890CC37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87F120870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YeKQSxGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAVCCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:02:06 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56995 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfAVCCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:02:06 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x0M21ptg027105;
        Tue, 22 Jan 2019 11:01:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x0M21ptg027105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548122512;
        bh=3KjszKj7hQE/0MhMfckZri1t/eeBuLPzkQH2181wOFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YeKQSxGa1HkCdiLdGwkOso2NappFwj5TacZlzLBUuhYtmCXU/vkSBfg0tLaFste7A
         0i+b0Em/X2546+jWx4B8ymFFPJYbCz8JRFwemqhqJiNI1yhMnIniQqFyrn8WcwZhum
         84msA0BClqJWkBZFHaA17wsaS+X8iVe7Qm1F9qdXHY8aUh8e4WwMumbCJczGCBMRBs
         a+RtlxmihYJ5EYPv+kUGMRN2bzfdDjBsyIkulTHNKrarp/u5B0O8PrfgaHolOs6gZT
         AoPW4VsnzxNBfuz/Gd0QdUXuS2PL5AulzNb6R0GE6L6/xBTUvfW0w/zMP4YM+uh07o
         dI+xrYqLX079w==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id t8so7582124uap.0;
        Mon, 21 Jan 2019 18:01:51 -0800 (PST)
X-Gm-Message-State: AJcUukdOsrz1ru3Ab+pwN2qW5n5vi4mzth1RXozccm4hX5GNIB9+WLb2
        8Bsj1x1tUyAjjwRLWDY00QUh8lmW83yhwOzogsc=
X-Google-Smtp-Source: ALg8bN6ofMx0hznmVYRlUKKmEtSWP+zE+0hmQhIpNBnZI09dc3Tw8Im/utW/u3tYG/PLLzBu/QY49wsnhUu3B1iGWvg=
X-Received: by 2002:ab0:849:: with SMTP id b9mr12700737uaf.93.1548122510513;
 Mon, 21 Jan 2019 18:01:50 -0800 (PST)
MIME-Version: 1.0
References: <1548038929-11814-1-git-send-email-yamada.masahiro@socionext.com> <20190121174106.6tgokdtlo5f72hdx@pburton-laptop>
In-Reply-To: <20190121174106.6tgokdtlo5f72hdx@pburton-laptop>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 22 Jan 2019 11:01:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpVF=uHs+AxVomxQDwzpPtmKTT4-D4Hc7JphygF0BFKQ@mail.gmail.com>
Message-ID: <CAK7LNAQpVF=uHs+AxVomxQDwzpPtmKTT4-D4Hc7JphygF0BFKQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: remove meaningless generic-(CONFIG_GENERIC_CSUM) += checksum.h
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jan 22, 2019 at 2:44 AM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Masahiro,
>
> On Mon, Jan 21, 2019 at 11:48:49AM +0900, Masahiro Yamada wrote:
> > This line is weird in multiple ways.
> >
> > (CONFIG_GENERIC_CSUM) might be a typo of $(CONFIG_GENERIC_CSUM).
> >
> > Even if you add '$' to it, $(CONFIG_GENERIC_CSUM) is never evaluated
> > to 'y' because scripts/Makefile.asm-generic does not include
> > include/config/auto.conf. So, the asm-generic wrapper of checksum.h
> > is never generated.
> >
> > Even if you manage to generate it, it is never included by anyone
> > because MIPS has the checkin header with the same file name:
> >
> >   arch/mips/include/asm/checksum.h
> >
> > As you see in the top Makefile, the checkin headers are included before
> > generated ones.
> >
> >   LINUXINCLUDE    := \
> >                   -I$(srctree)/arch/$(SRCARCH)/include \
> >                   -I$(objtree)/arch/$(SRCARCH)/include/generated \
> >                   ...
> >
> > Commit 4e0748f5beb9 ("MIPS: Use generic checksum functions for MIPS R6")
> > already added the asm-generic fallback code in the checkin header:
> >
> >   #ifdef CONFIG_GENERIC_CSUM
> >   #include <asm/generic/checksum.h>
> >   #else
> >     ...
> >   #endif
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Good catch. Would you prefer to take this through your kbuild tree or
> that I take it through the MIPS tree?


Could you apply it to MIPS tree? Thanks.




-- 
Best Regards
Masahiro Yamada
