Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36DFC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7659C21841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CNqS45Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbeLSPQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:16:05 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:33935 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbeLSPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:16:04 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wBJFFxsE025961
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 00:15:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBJFFxsE025961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545232559;
        bh=n+uNOKQMP1VfT3ymS5EYhCd8LfPtnRlWof0IYC/zJIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CNqS45FztnPnzSfsSB9u8hzQ7dijS1KZC781j53H+UIwU/v+i9w1jw1Wjq4rEn3T7
         CZlCP+r5y3TY3eUQn7H5490G9xH0J3WKT0uSw2Hzqsk36qLOO+Rnnwcx+qG3op06NP
         XcYlGVAVOiVa12fucVCcV3oiIkTasBg8rzuaUOXfpKwF4Cmg/m8v5q9/fLfr/oda2l
         NzvBFGESFbHlwzB8PZzCtSQOZsbs4dDl0fUbkd1u/JKgKNF8cBAoROIsejrKggUofK
         DQUXG67m2WL4ynnJdT2RyIJ4ZbI30Z0uUiNGqkTxwpdODBp7PfEt4v2Hb5AkVXHnIX
         Ry2cjhpvG8JEA==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id z11so7075921uaa.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 07:15:59 -0800 (PST)
X-Gm-Message-State: AA+aEWbeVWtaPH6RuM9hNUuEuS6tJDhd48DxZxhSeuL7Lq5mRYt4MnqH
        qHoSHZt31Sen8YLMTzORVIX2jn3YxjtQgg/V3Wg=
X-Google-Smtp-Source: AFSGD/U0VSpn0AqykwILjU30wSR2Ir/6Z6QA740HKvMWPxBtjM9lBUfpdJLqBR19ztgYN69mbOWygoCdAAVT7cLxhkg=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr10256498uad.55.1545232558294;
 Wed, 19 Dec 2018 07:15:58 -0800 (PST)
MIME-Version: 1.0
References: <1544969781-14506-1-git-send-email-yamada.masahiro@socionext.com> <C2D7FE5348E1B147BCA15975FBA23075014641FC6F@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014641FC6F@US01WEMBX2.internal.synopsys.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 20 Dec 2018 00:15:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJVGVJi_S99zfEpKe+HYWpk+TkfT4gCFZVVTibyP=ThA@mail.gmail.com>
Message-ID: <CAK7LNATJVGVJi_S99zfEpKe+HYWpk+TkfT4gCFZVVTibyP=ThA@mail.gmail.com>
Subject: Re: [PATCH] arc: remove redundant kernel-space generic-y
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

On Mon, Dec 17, 2018 at 2:07 PM Vineet Gupta <vineet.gupta1@synopsys.com> wrote:
>
> On 12/16/18 6:17 AM, Masahiro Yamada wrote:
> > This commit removes redundant generic-y defines in
> > arch/arc/include/asm/Kbuild.
> >
> > It is redundant to define generic-y when arch-specific implementation
> > exists in arch/$(ARCH)/include/asm/*.h
> >
> > Remove the following generic-y:
> >
> >     dma-mapping.h
> >     fb.h
> >     kmap_types.h
> >     pci.h
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Vineet Gupta <vgupta@synopsys.com>


Could you pick this up to your arc tree?


-- 
Best Regards
Masahiro Yamada
