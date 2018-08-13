Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461D3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87FE2183C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mB1QkDMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87FE2183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeHMKLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:11:42 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:44276 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbeHMKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:11:42 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7D7UN0F026091;
        Mon, 13 Aug 2018 16:30:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7D7UN0F026091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534145424;
        bh=ZAp12j8ZgQtNVs6MYDWVimf4wurxQMqOv09T+vgnvbE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mB1QkDMvnRAg3ODQPPaQEZWmp0gxXbMhxULqg8IGyyQYs62mZ2ez+w8eexL3FNsyT
         6wiSefwz0dKaJ/bov8sMtiSFGP7AHkVOiFOi7urVy5bCZOiJMoU8lrVYC1oQWTUqxe
         Pqa3AcBUSeoyQz4b0mnJ82xLbHXqaeKpQCIq/mahVtHKLFIh6LU9RhAsdzT7zwMEe0
         f6Uz4wA7ZXhccolWtDEyZSv8WLIEjFgfb+HOB41hcJ+LL8PP8cT43OFG+I9f+VMxlM
         CaxrOXPFR1KAv+RwT+zFGx3w+jR/ohe552LCoZx0kBok5yrlYRY2X4ePZ/Hlcujbfh
         4dliNXp+xuEEA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id m13-v6so8140518uaq.7;
        Mon, 13 Aug 2018 00:30:24 -0700 (PDT)
X-Gm-Message-State: AOUpUlEyZmmtqSP8dkwjyE4GIwH5gJu5cM0sYDcT28io3ZQvbKMbweH4
        y3d4mnmbubspwCvWfoCBADle3r+c1m/krzHKJXk=
X-Google-Smtp-Source: AA+uWPxHyw7C1+XloCOF4WhfUYIIOb9mU52pzU8rd6lCacR2iuRDciPPl8Edot6B4xOvvS6qLyOwzRrGgFsItXwOxxY=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr10622859uaf.199.1534145423409;
 Mon, 13 Aug 2018 00:30:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 00:29:42
 -0700 (PDT)
In-Reply-To: <1533313931-3639-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1533313931-3639-1-git-send-email-Julia.Lawall@lip6.fr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 13 Aug 2018 16:29:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeY08JV9kEm9M9O5O1WkxoxKFWTd+BLXe0_pjBs92fcw@mail.gmail.com>
Message-ID: <CAK7LNATeY08JV9kEm9M9O5O1WkxoxKFWTd+BLXe0_pjBs92fcw@mail.gmail.com>
Subject: Re: [PATCH] Coccinelle: doubletest: reduce side effect false positives
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        zhong jiang <zhongjiang@huawei.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        John Garry <john.garry@huawei.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-04 1:32 GMT+09:00 Julia Lawall <Julia.Lawall@lip6.fr>:
> Ensure that the cited expression is not a function call or an
> assignment to reduce the chance of false positives.
>
> Slightly modify the warning message to indicate another source
> of false positves.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>


Applied to linux-kbuild. Thanks!


(Please send a reminder
if there are more coccinelle patches I missed.)




> ---
>  scripts/coccinelle/tests/doubletest.cocci |   34 ++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/coccinelle/tests/doubletest.cocci b/scripts/coccinelle/tests/doubletest.cocci
> index 78d74c2..7af2ce7 100644
> --- a/scripts/coccinelle/tests/doubletest.cocci
> +++ b/scripts/coccinelle/tests/doubletest.cocci
> @@ -1,6 +1,7 @@
>  /// Find &&/|| operations that include the same argument more than once
> -//# A common source of false positives is when the argument performs a side
> -//# effect.
> +//# A common source of false positives is when the expression, or
> +//# another expresssion in the same && or || operation, performs a
> +//# side effect.
>  ///
>  // Confidence: Moderate
>  // Copyright: (C) 2010 Nicolas Palix, DIKU.  GPLv2.
> @@ -20,20 +21,37 @@ position p;
>  @@
>
>  (
> -* E@p
> -  || ... || E
> + E@p || ... || E
>  |
> -* E@p
> -  && ... && E
> + E@p && ... && E
>  )
>
> -@script:python depends on org@
> +@bad@
> +expression r.E,e1,e2,fn;
> +position r.p;
> +assignment operator op;
> +@@
> +
> +(
> +E@p
> +&
> + <+... \(fn(...)\|e1 op e2\|e1++\|e1--\|++e1\|--e1\) ...+>
> +)
> +
> +@depends on context && !bad@
> +expression r.E;
> +position r.p;
> +@@
> +
> +*E@p
> +
> +@script:python depends on org && !bad@
>  p << r.p;
>  @@
>
>  cocci.print_main("duplicated argument to && or ||",p)
>
> -@script:python depends on report@
> +@script:python depends on report && !bad@
>  p << r.p;
>  @@
>
>



-- 
Best Regards
Masahiro Yamada
