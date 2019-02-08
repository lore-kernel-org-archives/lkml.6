Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA73EC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7971220869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Kf8CebBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBHCcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:32:17 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:49930 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBHCcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:32:17 -0500
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x182W6h3019830;
        Fri, 8 Feb 2019 11:32:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x182W6h3019830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549593127;
        bh=xtWcVX77MfZiWDRjN2wLTfoqFktVANKwHfXtMYJt5LA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kf8CebBE6fU10pqF+Xn92P+eiZUo1oAeqiv+g3ddeXyrtIHj4QZOlDB8BSgptg4+W
         I2b0FlJiNp9HMbnTocWeA0LnhZtk1RTBy9BkNgnegamYhqek88xNZNgmddSevw2GoD
         GmJ2k3YWOA8srWTGIatjjmOppqMSlQFy7LKTOcgxfvJiAZNKFsuwknAhtH5dJTYi+Q
         xnF+KO94C21Q7WMrGdXq74by+NgWajTt2uwfQ9o3CPz6zCIQK7pdfaXhbzOELFppw5
         PhayWGiyFdSAE3cwH95DWyJ/eoFeVMAh92/WoEH/Yn1C8DlYFRBSmH/bK5Q+rYmTEi
         +lnBk13/kYYsg==
X-Nifty-SrcIP: [209.85.222.52]
Received: by mail-ua1-f52.google.com with SMTP id w12so665149uaq.6;
        Thu, 07 Feb 2019 18:32:07 -0800 (PST)
X-Gm-Message-State: AHQUAuZoiZ1i8SVZo/xVbPSXdbC3qvzLlTa1uR6qAhZh8oiPFhLl78eG
        B0uliRmpIjYwr8pYWIcIGnbaMuRBjnF5tkdQa7M=
X-Google-Smtp-Source: AHgI3IafKUGdgurz2xw3TovwLQ9wrRhCN2PgHDXEkKvACVhZCZA8sC8SttgcQZb7wH8A6Ix1KGRxWEE4HzENId6eD7c=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr7388707uap.6.1549593126154;
 Thu, 07 Feb 2019 18:32:06 -0800 (PST)
MIME-Version: 1.0
References: <1549592723-18494-1-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1549592723-18494-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 8 Feb 2019 11:31:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMCT74HKroyR-Sx2pm7vVWzuNb2fRbDtCSQvKViszo=g@mail.gmail.com>
Message-ID: <CAK7LNATMCT74HKroyR-Sx2pm7vVWzuNb2fRbDtCSQvKViszo=g@mail.gmail.com>
Subject: Re: [PATCH] clk: uniphier: Fix update register for CPU-gear
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 11:25 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Need to set the update bit in UNIPHIER_CLK_CPUGEAR_UPD to update
> the CPU-gear value.
>
> Fixes: d08f1f0d596c ("clk: uniphier: add CPU-gear change (cpufreq) support")
> Cc: linux-stable@vger.kernel.org
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
