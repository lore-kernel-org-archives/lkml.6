Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB49AC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACED4222A0
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0RWYh0N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfAFBlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 20:41:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:28596 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfAFBlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 20:41:50 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x061fgoA003415;
        Sun, 6 Jan 2019 10:41:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x061fgoA003415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546738903;
        bh=gWJAl3gourNSTPYpOk0Vo+A8mut8xLJhVB0tkrVLYPg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0RWYh0N1ePVEnkkKud+gwHvPM36jKwK563sxwFm39ZpaRObJedSupfLXvSGpvH0th
         Ig6ThATJnxYxT7z/AFM2m1tcyE1mElsCozgPX/ElpIRdCIbWZHmQxtI0PnPaYyqC6r
         cv3u0Lf0iRcVBHgtQHUbkctD3DnKhHvv8Wng8OMnxPxTjeKjrOy5QV5ZVTxzFtWT0Y
         i0FmiMmjFQho/LFdLlz5pAtTz1YuDe0wmBprvvQfRc/6oY3UAolge8cEQYR1lhH9yy
         0r17gk7y3Jt5s3N8lHzib0HUL9k/+xdYHffmqsZ85CP6fF/1kfuvvcJx7YaIApJgKz
         fIduBr4/sxrBQ==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id x64so24828913vsa.5;
        Sat, 05 Jan 2019 17:41:43 -0800 (PST)
X-Gm-Message-State: AJcUukeRdYy4NZEMgy+zC4LvMvKHE03SrK6tljhCkpYP6OiDdYJMIXxi
        SfOB2Vu+JbXANTS3klBqOzUorLgyG5XdvtJKaTo=
X-Google-Smtp-Source: ALg8bN6Wc4X7RiBNab7ffSI+3XJ4mBIxY8KlC1dEZi+ktXHW+M14futbIJVh9AVGuSxHhX/n0SNUXmRgd/INXw5nFLU=
X-Received: by 2002:a67:385a:: with SMTP id f87mr23102960vsa.179.1546738902123;
 Sat, 05 Jan 2019 17:41:42 -0800 (PST)
MIME-Version: 1.0
References: <1546008541-3175-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1546008541-3175-1-git-send-email-Julia.Lawall@lip6.fr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 6 Jan 2019 10:41:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBxp8osBd7np5p7m699CaUVHD--r_-5-dCQvdJpQBpzg@mail.gmail.com>
Message-ID: <CAK7LNATBxp8osBd7np5p7m699CaUVHD--r_-5-dCQvdJpQBpzg@mail.gmail.com>
Subject: Re: [PATCH] scripts/coccinelle: check for redeclaration
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <zx2c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 10:32 AM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Avoid reporting on the use of an iterator index variable when
> the variable is redeclared.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> ---


Applied to linux-kbuild. Thanks!


>  scripts/coccinelle/iterators/use_after_iter.cocci |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> index ce8cc9c..66a1140 100644
> --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> @@ -35,6 +35,7 @@ iterator name hlist_for_each_entry_from;
>  iterator name hlist_for_each_entry_safe;
>  statement S;
>  position p1,p2;
> +type T;
>  @@
>
>  (
> @@ -125,6 +126,8 @@ sizeof(<+...c...+>)
>  |
>   &c->member
>  |
> +T c;
> +|
>  c = E
>  |
>  *c@p2
>


-- 
Best Regards
Masahiro Yamada
