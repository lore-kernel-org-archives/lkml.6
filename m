Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836F9C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2004120831
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="shAoRxGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2004120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeJ2BWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:22:08 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:48540 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeJ2BWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:22:08 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w9SGaubM010814;
        Mon, 29 Oct 2018 01:36:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w9SGaubM010814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540744617;
        bh=7IeUpMjdW9uf63UW+8cpT8GngkY24s0QcDAQeUGUJIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shAoRxGeph+Ku2og3vB9JC+jiKYrSxrGozkqtKKDsi14bJA2z4/05HiHr8aK/4d/b
         2mGg0wn7jIrAO0DsWtIf1qhqhpBakpcdjEc8jRPhHizSPX2duc5ubvVhRUCjjHNa+G
         WPee7GEJf+bmjWUYaNzXN+8hoh1w4or8NAOKCZmLOQZIQtRDglF4+/hd218M7f9BxW
         wlIKVGTBfHJ+oT8+/qsHaFaxtdUnHz8M2uD5wYfWS5TTkidayFfswDprfm7ceXn4B9
         CZiDNv2FX7BeIZi2BNtysmpYlACqi+ntI1YF3fgYpqj17nnPGCgdauLgIuAuMEuBsM
         lmKaUKmfvl3rg==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id v205so1144584vsc.3;
        Sun, 28 Oct 2018 09:36:57 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLDJ3UllhFo+MURoi5aEB8e8A6a3Rgbugudn1z4DAsev2Np3XkT
        iwB3HIsQYxZxHlffK0ml/rP53HOb/V7KR5TaCpo=
X-Google-Smtp-Source: AJdET5cJtvbPGGqhD8Oj8rDhgFP7PVLxmAClDUyDxjZ6AMGCxs1wngJ9nJxYnE5qPr47ZWO3L2McnOMr6n2w1GWee80=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr4647180vsm.181.1540744616135;
 Sun, 28 Oct 2018 09:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181024040354.24879-1-leobras.c@gmail.com> <20181024040354.24879-3-leobras.c@gmail.com>
In-Reply-To: <20181024040354.24879-3-leobras.c@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 01:36:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfo=hw6r6GtdcLdkKCGVFpXUASvSst6WO5tcFbaZ-X0Q@mail.gmail.com>
Message-ID: <CAK7LNASfo=hw6r6GtdcLdkKCGVFpXUASvSst6WO5tcFbaZ-X0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] kbuild: Removes unnecessary shadowed local variable.
To:     =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc:     lkcamp@lists.libreplanetbr.org, Borislav Petkov <bp@alien8.de>,
        David.Laight@aculab.com, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:04 PM Leonardo Bras <leobras.c@gmail.com> wrote:
>
> Removes an unnecessary shadowed local variable (start).
> It was used only once, with the same value it was started before
> the if block.
>
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>



Applied to linux-kbuild
with some fixups in the subject.

Please do not add a period to the end of the subject.






> ---
>  scripts/asn1_compiler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> index c146020fc783..1b28787028d3 100644
> --- a/scripts/asn1_compiler.c
> +++ b/scripts/asn1_compiler.c
> @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
>
>                         /* Handle string tokens */
>                         if (isalpha(*p)) {
> -                               const char **dir, *start = p;
> +                               const char **dir;
>
>                                 /* Can be a directive, type name or element
>                                  * name.  Find the end of the name.
> --
> 2.19.1
>


-- 
Best Regards
Masahiro Yamada
