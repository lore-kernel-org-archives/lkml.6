Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ACEC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91668217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 00:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EQVaNHHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfADAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 19:25:21 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:21573 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfADAZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 19:25:21 -0500
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x040Ot6K006206
        for <linux-kernel@vger.kernel.org>; Fri, 4 Jan 2019 09:24:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x040Ot6K006206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546561495;
        bh=Z+Gv25mzqE+Yw75/hsSqQ+Lf4AxdSw/wX4Y1Bj16CpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQVaNHHDafyS2BJK3wguTYIEaLy4ikXivrk8+Wc1sfLqE3NuXo//OJjaqIO+Rvw6M
         Ib+LHCKkm9H00yxIUGy5Zehh5s4+V9Ct13/PHLigzV4gPL6Te1K0oLwBvr/kyhaUDE
         giaLtBobveiB+I+shc/G7nfwXDYLU3jhr+8IOwk2S41CtOO8ujqKvjnil3idBih/oS
         vGGE0dBnJWbnjatpAYuUBuH+c9Ih64bW+4SRWZqwtQRo8ty5Tne5xkMKt9Md9wVS9I
         bRWEaXwt7NjFUxRtSW0ldr8H0fkLQjg/Jrac4U/Qklrhx16Xk00iNS92YHOQUCqA1C
         3U5ztUlI2RUaQ==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id b18so7621393vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 16:24:55 -0800 (PST)
X-Gm-Message-State: AJcUukfmy21H1Ppcw63p4cmtf3TaPCX0DiZoJhTeMA6FifTqOA8p9Mjj
        gPhXtvGULYlmeq5ETUYteySxwUoKRG5Mc9TeHE8=
X-Google-Smtp-Source: ALg8bN5/Z8Gy2QTgsmOI6Dc3eiuMgamPh/YzM+FyZaHzoOCOlluYvoQ6qFDFiRFsbFujpONs7lctNE9ym1D5n3StmzY=
X-Received: by 2002:a1f:27d7:: with SMTP id n206mr18601814vkn.0.1546561494352;
 Thu, 03 Jan 2019 16:24:54 -0800 (PST)
MIME-Version: 1.0
References: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
 <20181214095155.GA1872@edgewater-inn.cambridge.arm.com> <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
 <20181214103721.GC1872@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181214103721.GC1872@edgewater-inn.cambridge.arm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 4 Jan 2019 09:24:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARztSNM1XwqxcZrZ7Y5GKs_53R3LnbPGhDSLOr_1awoKg@mail.gmail.com>
Message-ID: <CAK7LNARztSNM1XwqxcZrZ7Y5GKs_53R3LnbPGhDSLOr_1awoKg@mail.gmail.com>
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

On Fri, Dec 14, 2018 at 7:40 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Dec 14, 2018 at 07:35:57PM +0900, Masahiro Yamada wrote:
> > Hi Will,
> >
> > On Fri, Dec 14, 2018 at 6:54 PM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Fri, Dec 14, 2018 at 01:01:52PM +0900, Masahiro Yamada wrote:
> > > > Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
> > > > same.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > ---
> > > >
> > > >  arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
> > > >  1 file changed, 29 insertions(+), 30 deletions(-)
> > >
> > > I'm fine with this patch, but I think I'd prefer to apply it at -rc1 so
> > > we don't end up with lots of silly conflicts in the Makefile for any new
> > > files added during the merge window.
> > >
> > > Is that ok with you?
> >
> > Sure!
>
> Brill. Please poke me again in January if it hasn't landed by then ;)
>
> Will


I just sent v2.

https://lore.kernel.org/patchwork/patch/1028882/


Thanks.

-- 
Best Regards
Masahiro Yamada
