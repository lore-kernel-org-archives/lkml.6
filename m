Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB5C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBE8222CB
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bIR5BWhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfAFBmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 20:42:05 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44491 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfAFBmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 20:42:04 -0500
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x061ftRi010911;
        Sun, 6 Jan 2019 10:41:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x061ftRi010911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546738916;
        bh=xFudEcZwUcMHAVkTucvrEEMuZDp9b36sey9gk7TgVrk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bIR5BWhnrlpKxud+OqwcJ/h3RsTbrI2UKRVosLCvdwVSBbPtG28ijWb8ufoYpod6G
         6QOGDzYTei2fnljRLS1r4AW9S3pG6MI3rasyW2/vBUmSCbqrCFL2WAX2EpWO5vL8GU
         VH4JE7xnufLh+/iPBFfTOqA1YcWg4YRSkTeyt5TmoyujqawW1+n6OFG5UrlSL85KEb
         f1ltBH0Ps4/EQxv00f4hK0J4bAJDd8CO8XS/sUyaS+GRXiBUbHnUB6FNKl76VN9U71
         99uC5hW7F5Cl5L3nsyLtyuOJemVUIPw5ki7ZrBBIyM5yBUgxlFo10dccsKC9j5GFRz
         ML/Q4u0iWzCEg==
X-Nifty-SrcIP: [209.85.221.179]
Received: by mail-vk1-f179.google.com with SMTP id d201so8728337vka.0;
        Sat, 05 Jan 2019 17:41:55 -0800 (PST)
X-Gm-Message-State: AJcUukdGj7fo/1WMZxD0AP2/GT5cpV/+rUmL52sgn/qzz3oy8mcAJ++c
        j46OXDusbR4894NbD2vA73AiSv/eO884/pism6c=
X-Google-Smtp-Source: ALg8bN79JUFfnyfEJZQbgPMj1g95RZ/VwMrq8W6vkTuGQSoNETATuNDqTCnpCJk3a4TVnZDO8zTqpMD+eYXkmiJDTQ4=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr19667050vkd.64.1546738914555;
 Sat, 05 Jan 2019 17:41:54 -0800 (PST)
MIME-Version: 1.0
References: <1546064056-15569-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1546064056-15569-1-git-send-email-Julia.Lawall@lip6.fr>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 6 Jan 2019 10:41:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARH8-96wcZhMmgZCzxQCMQpQPaqmDHVSYbGkHnHhjQtCw@mail.gmail.com>
Message-ID: <CAK7LNARH8-96wcZhMmgZCzxQCMQpQPaqmDHVSYbGkHnHhjQtCw@mail.gmail.com>
Subject: Re: [PATCH] scripts: coccinelle: boolinit: drop warnings on named constants
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 10:14 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Coccinelle doesn't always have access to the values of named
> (#define) constants, and they may likely often be bound to true
> and false values anyway, resulting in false positives.  So stop
> warning about them.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to linux-kbuild. Thanks!


> ---
>  scripts/coccinelle/misc/boolinit.cocci |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
> index b0584a3..aabb581 100644
> --- a/scripts/coccinelle/misc/boolinit.cocci
> +++ b/scripts/coccinelle/misc/boolinit.cocci
> @@ -136,9 +136,14 @@ position p1;
>  @r4 depends on !patch@
>  bool b;
>  position p2;
> +identifier i;
>  constant c != {0,1};
>  @@
> +(
> + b = i
> +|
>  *b@p2 = c
> +)
>
>  @script:python depends on org@
>  p << r1.p;
>


-- 
Best Regards
Masahiro Yamada
