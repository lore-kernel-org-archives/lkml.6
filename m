Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D49E2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fp+WpYXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D49E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeKQNKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:10:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:51345 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbeKQNKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:10:09 -0500
Received: by mail-it1-f196.google.com with SMTP id x19so788757itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 18:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orrQnCVUOEVegdcmBdAjv2xFygXMd3TNJYY5GzsGqcQ=;
        b=fp+WpYXIT/pz1YJQ/+k5tQBCN6f7ET0sCS8odn4P6bUvEIrjjzTh7zxnPk5Gp5FhE2
         U5TEeL04BRCxzXJRipQf6Mwe+eBmPJ9saxNIdJZ12OHJoENcEXnUKaQM8XDy7Y56r1RB
         dWYLsUchUIqw2CNKnd+uzGVzvK7GuV9NX+UHXCHhfBCuefZrZ5B39+1zBsu0AzU79c4r
         LwlqjbbQ1wZ18NRGu57Ay0lipeetSEYx7u+CP3tXINV3fP6g8S0ONHdOKdDDmw+hINHh
         GgWl8fs0ePbStjjfROD67xYr18rkc3Zko/iKnJuElIWfgOVKUwYwsJbrq11AVQB401fJ
         rsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orrQnCVUOEVegdcmBdAjv2xFygXMd3TNJYY5GzsGqcQ=;
        b=hYCJn35z1a60DZfYTiavjnKxjNouoGX3HKk3T631YUB/aBSypVS9gcXSib83ijI6cr
         q/vFUI5VKCngg60eMqpxgX3pVnzyxHCK0dsuJnWCaaOF60zEY5o197iohFmZ5Ac3B8hr
         dzHBnXZ5cR4PKNx/LRdrxvRJJAukXK/Z3qju8x8Tu+509eM21Dxxlu2MnnJ5Mm0otWxP
         Px3gU0/hi+LlKGkcfximL/oWhYf2S5Xk7L2zI0J8iFsKwB2QDNSujqm3fmyD1g5akli9
         +bq0yurWYnwncVMBMulZt5R5zV6zJhWmNjahNmCLzrweSauA/i3n8Uxfzoh4ao3z0ZxI
         21rQ==
X-Gm-Message-State: AA+aEWbrVPvCPqV6OKV5nyrVaP3ft7ZYVshSKWLdUyquD30ma7uFrG9o
        kUmkKcEcTeAA0+xYXWEeHFXsd5NnkgZjzZPEY/FM+HhngeI=
X-Google-Smtp-Source: AJdET5eHglyl5KjiCS127xIkKq1hRgLGDkRnzqe2tZ8BGrm62N53RLUFwuKXMUc8Z6nSqxai+OlmFNYEHsy9wl+EcFg=
X-Received: by 2002:a24:ccc3:: with SMTP id x186-v6mr691543itf.103.1542423306833;
 Fri, 16 Nov 2018 18:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20181117015456.101222-1-olof@lixom.net> <20181117022656.GB2470@brain-police>
In-Reply-To: <20181117022656.GB2470@brain-police>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 16 Nov 2018 18:54:55 -0800
Message-ID: <CAOesGMgXmsGGmOAkoL7L-tZhWC=s2WwdBqsrgeR3-0c_iEgW4g@mail.gmail.com>
Subject: Re: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 6:27 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Olof,
>
> On Fri, Nov 16, 2018 at 05:54:56PM -0800, Olof Johansson wrote:
> > Makes sparse happy. Before:
> >
> > arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  arch/arm64/include/asm/sysreg.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> The warning is bogus imo, but since it's harmless to fix it then we can do
> that. However, you've been beaten by:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/613179.html

Yeah, mostly bogus but still useful to silence warnings so you notice new ones.

Overlooked the duplicate, happy to ack that one instead.


-Olof
