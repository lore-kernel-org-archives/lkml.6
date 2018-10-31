Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0005EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537F0205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+iM/21d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537F0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeJaU0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:26:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38290 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeJaU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:26:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id q186-v6so1114840ljb.5;
        Wed, 31 Oct 2018 04:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o51IdstyW044OQNNFJDVwnL9cssd26e6vg+ax2xgBCw=;
        b=Z+iM/21d/qh2wHREg8x/7i8Kwl7AT4WY+G75HJW5ccz9kIu8JD/G4wG7gr5PA6qpO7
         kPx8CzcFlsqQBcstoJPI7dz5bgqZxM7889rYbI5n4+JFQRuJ2KHQS868pU0MiQz5tEIi
         +dnAAmlC5xFgDmnzO37IEstnF+sRsuuVO8FQtMWEH8q1cWozNqS+hwH1BsqiQ61G1kDI
         CPp0z2F7wzznK7C/Fg0xF+hnWfjVMv9wh3bPXm4G1248Lq0aKasjr2ET108ua2Oz6v+A
         w5qMrSWLe2TAHwJSIBXc5+OcrQcvr+7AnXxDob4n3VcO+A+5HhoVwEuaOAz7Mv/kxidn
         Cnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o51IdstyW044OQNNFJDVwnL9cssd26e6vg+ax2xgBCw=;
        b=dSrOgZ/fRRrTRr/qnxeXY1YJlfQqELtCw7uBsw7sUne+dX2MD/R5ZtClzbx72ffJ84
         0E+L316w8MLAP7d/XoKYG4iyTqKXOghr6xWtoHpF2Ke2LWh5HLNNNa4BBvuDbnql1bz3
         zzTGhkHYXc3hyUY/7YIR1BcNNwq2GwQAAvHmGqylnC32CMH27OgeWrrhRQXt1agCqzWl
         x9DJeOkr6lDomQdka/utz6kX/VQXt3hsk6HBuI7XWIspaD9v4+QO7IGmCdVQ/Ats39E4
         lpvVRG/xCEhR6+IPFH1YvYcpOUcOzZIgTmg8Bfqc9UrlGqtDIFZaEsQq2iFBshv/zLWJ
         sA3w==
X-Gm-Message-State: AGRZ1gL5pYXX0AH2cTlQ5muCa8Nvrm7d4wVu6CFR6cNgGEzqSEMgdAKk
        IMqCFpWqrg/A/kIOgRLPJXZ8CequCNk5w7CtPp4=
X-Google-Smtp-Source: AJdET5fjd+l4bUzTWn7cY2tW7dyAYbRHGWWs/WRrnZzEFOoMKzvMix0AaPc8xY1oFKZBAXk7hGe7CtowNxFwWG+G8l0=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr1934569ljh.139.1540985310579;
 Wed, 31 Oct 2018 04:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181031111444.3472-1-malat@debian.org>
In-Reply-To: <20181031111444.3472-1-malat@debian.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 Oct 2018 12:28:19 +0100
Message-ID: <CANiq72mj_iHvxqAEqhGoLT61Tc04-zN6f7Gv1jyNeb6d0R2LGw@mail.gmail.com>
Subject: Re: [PATCH] remove old GCC version implementation
To:     malat@debian.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:18 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> GCC 4.6 is the minimum supported now.
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  scripts/mod/file2alias.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 28a61665bb9c..4b59564d4706 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -83,11 +83,7 @@ extern struct devtable *__start___devtable[], *__stop___devtable[];
>  #endif /* __MACH__ */
>
>  #if !defined(__used)
> -# if __GNUC__ == 3 && __GNUC_MINOR__ < 3
> -#  define __used                       __attribute__((__unused__))
> -# else
> -#  define __used                       __attribute__((__used__))
> -# endif
> +#define __used                 __attribute__((__used__))
>  #endif
>

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

By the way, is it possible that scripts/ and similar stuff uses
directly include/linux/compiler_attributes.h (whenever it hits
mainline, see https://github.com/ojeda/linux/blob/compiler-attributes/include/linux/compiler_attributes.h
)? It is a header that does not depend on anything, so it could easily
be shared; and would avoid having to maintain two sets of attributes.
Let me know, I can take a look at it if you think it is a good idea.

Cheers,
Miguel
