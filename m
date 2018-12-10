Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0160C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B2320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IEROJNbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B2320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeLJQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:29:27 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:40859 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeLJQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:29:26 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wBAGTJ10024901
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:29:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBAGTJ10024901
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544459360;
        bh=CXX+95DKqqnT35MwxNl8T/REB4ekxPgFR8Dewad1Jxk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEROJNbvlbn+wKqcKRc/YtSU/ceGhayJiJE0ujHrenxXEVThQlaU8eWFwnnt8DtIH
         7yeSRGsXu+Gv0vieDzBzJC91NN6CeaC3VQMtAuo1KnYONYhL/4p76j08paFpr72JYz
         E/zNdJ/knkTx22MvcxlO/r7SunUhW154Bf0Y8SoOj1cwd5+TLB0zS4TGReiGpjiZCl
         KnrFsddRs9ybiwIqiobEYhC6WXR4z8lk+h4v0HzE4yPgrwfb1TXiaCFHYRJOEySRH6
         jqmPMHGhI57xd6h8V5iRQzWISQ1ZcxJZDEwI1kqX7cHAbK8mVtXJssgIxSyX3Hjf5c
         Gya+IOdmoFrmQ==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id z11so4023825uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:29:19 -0800 (PST)
X-Gm-Message-State: AA+aEWbtGswqSeOfuCFuTBU4MljOzDxvAgPtQc+DylPntFELoAwyRPhf
        ZXcdTNTFgP0VQX2DgroWlnnQIoAWYUTPzVZW/cg=
X-Google-Smtp-Source: AFSGD/WNvgAjt0ApjwrM/hg2NEMhZD1oqIWVLdax0+xuN6WvgybiVf08Ub1knt/oTFxuNskny5su0vVNZJcAfRTe+iY=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr5711166uap.6.1544459358492;
 Mon, 10 Dec 2018 08:29:18 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAToKE7dv8UHOhQhJN+6Q6qVs=noQvLedGCEQszSgmVvXg@mail.gmail.com>
In-Reply-To: <CAK7LNASah-5o_sAUw=DDwfKhY=rYXZ1dmeX+d_HhKNMGqKLLAQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 11 Dec 2018 01:28:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNASV9cSq9xk-PuDi3TzhjAP8KQmMz+XJdz2HW98Uf48rsw@mail.gmail.com>
Message-ID: <CAK7LNASV9cSq9xk-PuDi3TzhjAP8KQmMz+XJdz2HW98Uf48rsw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.21
To:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:24 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Arnd, Olof,
>
> Please pull UniPhier DT updates for the v4.20 MW.
>
> In this cycle, I queued up all arm/arm64 changes
> into a single branch to avoid build errors.
>
> Thanks!


Sorry, please discard this.

Looks like I accidentally hit the send-button
before finishing it.




-- 
Best Regards
Masahiro Yamada
