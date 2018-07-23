Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A895C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117B020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="w6Z2xi4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117B020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbeGWCtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 22:49:11 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:46974 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731151AbeGWCtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 22:49:11 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w6N1oM0t007936;
        Mon, 23 Jul 2018 10:50:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w6N1oM0t007936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532310623;
        bh=yT+nFniF9SnJGzUJ4pO96a61OLr01ReysJuuGJ4IFjw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=w6Z2xi4Uq+8kjQ7z/V2sGem5Z1vcDeycpd5X+BRh0QWqT3steIWf6D8Ys8TFM1tox
         9rqS78UjFaQTVbYWoePAXGCFHWHGM9O3vYLQfus8D5eDvSAsXM4e2EbQZnFi37XH6I
         TlCXua1dnsfENTsdP0VGY/rLycbsEy8Lm18rjjb91CPdE6KQmi5kzXH2fJMCH+yoqD
         7o/Kz0yUHxQp6PXsGZo8mas+4xSvTISzPOc5hxm9X+1s1+1cG9sysB1ea60slgYj8f
         /XVdRp/dJLPwIpFqMhVE3OpJy7XrTgmp6ndMtfWsXI1fi0ltqRPwfub7wce2ChI1F+
         dBMJ6Eck5ssIQ==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id s17-v6so8500581vke.10;
        Sun, 22 Jul 2018 18:50:22 -0700 (PDT)
X-Gm-Message-State: AOUpUlHm5KgggwKpdv0/HuuQ0fLQgS5kkePcV5bo+eibnx6eCGwayJCg
        t023leBahJsXpq/6eM4Wu5mas+kdZeKVhEvBKMo=
X-Google-Smtp-Source: AAOMgpeG6q3p8dMzoG+jCHKNTJkRdZAOQ9CkmKc56Mk7zFs5YjCWMAYTYyiTxH3OJTetSDzx9AGK8Ca5DvTqUvP3C3M=
X-Received: by 2002:a1f:420d:: with SMTP id p13-v6mr6548017vka.10.1532310621735;
 Sun, 22 Jul 2018 18:50:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Sun, 22 Jul 2018 18:49:41
 -0700 (PDT)
In-Reply-To: <20180718091336.4540-1-dirk@gouders.net>
References: <20180718091336.4540-1-dirk@gouders.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 23 Jul 2018 10:49:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATV+HW6=gX+Ax2RjS+8mOZ=tsM10ENXCd7qJK383tOg5g@mail.gmail.com>
Message-ID: <CAK7LNATV+HW6=gX+Ax2RjS+8mOZ=tsM10ENXCd7qJK383tOg5g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: if_changed: document single use per target limitation
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-18 18:13 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
> Users of if_changed could easily feel invited to use it to divide a
> recipe into parts like:
>
> a: prereq FORCE
>         $(call if_changed,do_a)
>         $(call if_changed,do_b)
>
> But this is problematic, because if_changed should not be used more
> than once per target: in the above example, if_changed stores the
> command-line of the given command in .a.cmd and when a is up-to-date
> with respect to prereq, the file .a.cmd contains the command-line for
> the last command executed, i.e. do_b.
>
> When the recipe is then executed again, without any change of
> prerequisites, the command-line check for do_a will fail, do_a will be
> executed and stored in .a.cmd.  The next check, however, will still see
> the old content (the file isn't re-read) and if_changed will skip
> do_b, because the command-line test will not recognize a change.  On
> the next execution of the recipe the roles will flip: do_a is OK but
> do_b not and it will be executed.  And so on...
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---

Applied.  Thanks!


>  Documentation/kbuild/makefiles.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> index 048fc39a6b91..01fae5a01ce7 100644
> --- a/Documentation/kbuild/makefiles.txt
> +++ b/Documentation/kbuild/makefiles.txt
> @@ -1105,6 +1105,12 @@ When kbuild executes, the following steps are followed (roughly):
>                 target: source(s) FORCE
>         #WRONG!#        $(call if_changed, ld/objcopy/gzip/...)
>
> +        Note: if_changed should not be used more than once per target.
> +              It stores the executed command in a corresponding .cmd
> +        file and multiple calls would result in overwrites and
> +        unwanted results when the target is up to date and only the
> +        tests on changed commands trigger execution of commands.
> +
>      ld
>         Link target. Often, LDFLAGS_$@ is used to set specific options to ld.
>
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
