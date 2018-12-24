Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB410C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742052184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nZZdFOyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLXPUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:20:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:40758 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbeLXPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:20:09 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wBOFK0Cc017082;
        Tue, 25 Dec 2018 00:20:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBOFK0Cc017082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545664800;
        bh=gOUYoeH5geP1+ADgqQaGGarIvWwkli5DhgqspBjSAGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nZZdFOyIY6Pctj3KbzkoCvwhCJ7VWxYL16rU3e/2jkuV8LNqQ+hQMPr0z1un8xCb1
         o3oWsBkdORwLBO3dRGe/WD6b4xQYVWgD66hSZBYy+hDPazPAS1FwCsVMTvKc6ph1gi
         rqXMjCTq89RmvTdEIIE5cn4KAv+WLTrOTUAGyuEKHnRFrdT6y5YFAOopSVcAmZyg8r
         y/NErLykMEFxDl3/EpYmyPVhIupnEbV6x77NUswowBeWFkcK+rM4q6HlOOLa+B5cKe
         +OlfV8aymXPnmbk3+eifDVW1DczYVBIWmEm3w91WODu7UgYdkxMwTW7w/S5eM414Bv
         XZRH03Yt8pqcA==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id e7so7416408vsc.2;
        Mon, 24 Dec 2018 07:20:00 -0800 (PST)
X-Gm-Message-State: AA+aEWZ6NMJVPVpq/7PP5UMmNDvXU+6iWknkGIBtGTvYr8EhFESh9QXF
        pg9M6WkbhCN8B1070kkMhE1tjz9h+ncxpsHUuvA=
X-Google-Smtp-Source: AFSGD/WsaAKLu04Mm3mYm9ESfy5EkuLZLPzwH+J+4lX7LXABKcjjXYy8W/1m42Y6SRU2Q8kkPbhRvM88MtSQnNlngms=
X-Received: by 2002:a67:f1c2:: with SMTP id v2mr5407011vsm.181.1545664799586;
 Mon, 24 Dec 2018 07:19:59 -0800 (PST)
MIME-Version: 1.0
References: <1545373382-29088-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1545373382-29088-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 25 Dec 2018 00:19:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATfbaLn55=MKnJb0RJym_tUfiOeO4Xq3+46n59f8yJ7iA@mail.gmail.com>
Message-ID: <CAK7LNATfbaLn55=MKnJb0RJym_tUfiOeO4Xq3+46n59f8yJ7iA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: remove unused "file" field of yylval union
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 5:59 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This has never been used.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild/kconfig.


>  scripts/kconfig/zconf.y | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> index 8a4d029..60ee8e7 100644
> --- a/scripts/kconfig/zconf.y
> +++ b/scripts/kconfig/zconf.y
> @@ -36,7 +36,6 @@ static struct menu *current_menu, *current_entry;
>  %union
>  {
>         char *string;
> -       struct file *file;
>         struct symbol *symbol;
>         struct expr *expr;
>         struct menu *menu;
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
