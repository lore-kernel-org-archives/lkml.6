Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21037C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D791120818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="09Dzu24n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D791120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeKJCVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:21:55 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:45943 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeKJCVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:21:55 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wA9GePuK028545
        for <linux-kernel@vger.kernel.org>; Sat, 10 Nov 2018 01:40:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wA9GePuK028545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541781625;
        bh=0L0stTu4gShMldfu3OlyVchIeicgty6G2dHDInffH7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=09Dzu24n32LgBpieU8MyRSJoPcJqbnN31/OUeidr4MvG8Irvay7qbwYM6WCsNA9EV
         WXMMoZRgIaNiUT+jk48Qo38xZOt98tyRcA8+8PLknj1nwh3r7+Jv/JcdE+s/43iYLh
         YACOk/eWe92tDZ5HNpM7qiYRY0Vq0wlIbLi12TmUiCbGWs+NNI0UG7YtZ3kk5MDRcX
         ERrYs+5QwSFCA0aDcM7IvL8XG0vL97a2+Uo21xr6r8ahZYt8lxXhCIJ/f8+7Q2Wuom
         zK+051kjvY2pn5xeF1adJK9FHzhtrkvyG+YzuvjaZidoAR+sReYv6EXMsL8/mGYlV1
         8xNETGIIy244g==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id g68so1367775vsd.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:40:25 -0800 (PST)
X-Gm-Message-State: AGRZ1gItLH7e+rdJXt9zz0+Y3RC8GyHKLtqajEWmPxIhwuhtgdJdRhwL
        h7M8UkqtSC6syTz1vE6hBIKCcZ/Af7YZHVWD8pc=
X-Google-Smtp-Source: AJdET5evb5E6mvr38G1rEhBCThV+FPl4Ymtk0y98DF8xlsspPffX+RBAEk7kM4bozLkQvd8PNJWsbGYS6imOj291ZZs=
X-Received: by 2002:a67:a858:: with SMTP id r85mr3991690vse.215.1541781624409;
 Fri, 09 Nov 2018 08:40:24 -0800 (PST)
MIME-Version: 1.0
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 10 Nov 2018 01:39:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARwckFFe4kK2evU=y6xd+gd+PJwj0GNiRscnReGnpVbcA@mail.gmail.com>
Message-ID: <CAK7LNARwckFFe4kK2evU=y6xd+gd+PJwj0GNiRscnReGnpVbcA@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Genki Sky <sky@genki.is>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 3:39 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This reverts commit 6147b1cf19651c7de297e69108b141fb30aa2349.
>
> The reverted patch results in attempted write access to the source
> repository, even if that repository is mounted read-only.
>
> Output from "strace git status -uno --porcelain":
>
> getcwd("/tmp/linux-test", 129)          = 16
> open("/tmp/linux-test/.git/index.lock", O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0666) =
>         -1 EROFS (Read-only file system)
>
> While git appears to be able to handle this situation, a monitored build
> environment (such as the one used for Chrome OS kernel builds) may detect
> it and bail out with an access violation error. On top of that, the attempted
> write access suggests that git _will_ write to the file even if a build output
> directory is specified. Users may have the reasonable expectation that the
> source repository remains untouched in that situation.
>
> Fixes: 6147b1cf19651 ("scripts/setlocalversion: git: Make -dirty check more robust"
> Cc: Genki Sky <sky@genki.is>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Applied to linux-kbuild/fixes.


Thanks!


>  scripts/setlocalversion | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 79f7dd57d571..71f39410691b 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -74,7 +74,7 @@ scm_version()
>                 fi
>
>                 # Check for uncommitted changes
> -               if git status -uno --porcelain | grep -qv '^.. scripts/package'; then
> +               if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
>                         printf '%s' -dirty
>                 fi
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
