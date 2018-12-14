Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4CC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394E720879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lLUFHlMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394E720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbeLNKgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:36:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38633 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:36:50 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wBEAaY0A021498
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 19:36:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wBEAaY0A021498
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544783794;
        bh=meTjuBm6sFTr2VERfIwVMjSI41p3Nzae54futWY6fdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lLUFHlMZLXkulpG57oUhSrGJ+FNwW2uAxfqmixm1eqDXg/4RIH1Vf+Y+JHHZtECVL
         B0rDXxcwhrWszDPWfa6xWt3Ph1Vkjg46GsRxRM23dWRJxcHLADBTREyUOnDPcsQHo+
         k5xaJ/1UYtQc/RH9ZnIF53tj9K2y5oztUAiGfRJFd3/Q9oa6FwTsL+25ZWhD91NWcE
         C2PYEqvCiLdLLRquGsl1a3Y/epJMo9Xz1PUj4SUrNDCxJZxo/cQ3HrIH/Uqhvx3ej1
         JtNDS7N3rBzHN9pU+17Qyxo7ZfOT5gxXfml33EQ7P+6z7TwGTSxfU00pVFb1ZwrJ8a
         p8WwK+Jh0rksg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id k10so1815435ual.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:36:34 -0800 (PST)
X-Gm-Message-State: AA+aEWZkQYPkRH5Qm4PLsaa5PnvuKl08RtZXfLSl34Bh5QuEx/4smsBq
        hSVWpaMa9p4M/fMIo6+nAuxzXoV46MTHBtrK+Fg=
X-Google-Smtp-Source: AFSGD/XDFykXpre42kb1bxTPQh59y4OKWYd5PXGgwWwRkiJSOYH3JRQvLRspXi4VPKbwTG7lryBy4zwMkK2Z6SMj6Dg=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr1056112uad.55.1544783793506;
 Fri, 14 Dec 2018 02:36:33 -0800 (PST)
MIME-Version: 1.0
References: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com> <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 14 Dec 2018 19:35:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
Message-ID: <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
Subject: Re: [PATCH] arm64: replace arm64-obj-* in Makefile with obj-*
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Dec 14, 2018 at 6:54 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Masahiro,
>
> On Fri, Dec 14, 2018 at 01:01:52PM +0900, Masahiro Yamada wrote:
> > Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
> > same.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 30 deletions(-)
>
> I'm fine with this patch, but I think I'd prefer to apply it at -rc1 so
> we don't end up with lots of silly conflicts in the Makefile for any new
> files added during the merge window.
>
> Is that ok with you?

Sure!



-- 
Best Regards
Masahiro Yamada
