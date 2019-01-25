Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3409CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4E320820
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="UyMi9bUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfAYICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:02:04 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36042 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:02:03 -0500
Received: by mail-vs1-f65.google.com with SMTP id v205so5179627vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 00:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrrcXfru/4lvnsV8JBplsSMBax92l6y6thStoW0EF6Y=;
        b=UyMi9bUDkBthVwyTn8NVyK9XwgQZ8kuZTkuMwZRstv41EqeZL0TClEyn8T58Dku28x
         4ZIjHwNBccAx4EfvyJXavtxpUxN8WTkKFO21BF4jSl8dHwXmxWGedBcti496WJvEPghl
         YhR8LoQ0+26Nhgrdd/h/ySGQAqxBp82CyOfofYx3mYmD/VN24DJuepcmAbLj5UK2x1HM
         ZKjGVq5tPZ4ZggneiFRaY382EiBr/EvVV1AFrnMJ7UuEfpTF0lWSssrM1qlbFhqH7tiS
         kEO2raLn8KTm3+fqlY3wBFCItxJ3DcMTJUWZa3lu9F5OTXCtxz18zHWheYiUsq1Tb3ws
         Bf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrrcXfru/4lvnsV8JBplsSMBax92l6y6thStoW0EF6Y=;
        b=Hp3PaLB/n8f3p/Z0PkbRLNJ2Os4Z1WfNbJfZEo+N/k8KqWnOArrMXZQ6dgoFDQXLeZ
         tQ9Gp3wDxB6b8gEfGLN2iKV9xEI+mYm2FEg+AgB31QtnO52lfmGCJjj7mQibluU+6De+
         8LbLtiwgEkEjMPH2Ga0BPntvxfXgKvLhXckBD+rVDwX4ciixYR3yHanyEdph+2ZhvnDz
         8gB6Tqqo4KB6z+c7J9JwnIL4Xzp/0lsaWIyo5+UBji/tnRh/For2+Kgrkwvyo9kykVyD
         +5vDkrlj+OAPxdaEDQNbSjpWQciaBca7XCgvp9d2EJ6LaDh1PyYYeN5+6eFx4Dzfp8qL
         8+3A==
X-Gm-Message-State: AJcUukfbJKVhqoLndzpMuqhM316yBtHx6qswcgiet0PhGMsY+o5BOa32
        eM+Febjudkf2222WvRAKxESfAggZ3JWvpAyM84KDtQ==
X-Google-Smtp-Source: ALg8bN7Jarmz6IH16Z3tmStvAU6ONAt7WC5d8+3J5VpH+uZF/Wy2MLiDGi6hgoWpelRXvcXM4jpVxzSOf5D/LLajAjU=
X-Received: by 2002:a67:2584:: with SMTP id l126mr4109258vsl.153.1548403322368;
 Fri, 25 Jan 2019 00:02:02 -0800 (PST)
MIME-Version: 1.0
References: <1548401030-28860-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1548401030-28860-1-git-send-email-yamada.masahiro@socionext.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 25 Jan 2019 09:01:51 +0100
Message-ID: <CANr-nt0=gw90vBLA_FMjmD7duNVYJcGmcqfk9HiQpdKxHV-A+g@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: pblk: fix TRACE_INCLUDE_PATH
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 8:35 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As the comment block in include/trace/define_trace.h says,
> TRACE_INCLUDE_PATH should be a relative path to the define_trace.h
>
> ../../drivers/lightnvm is the correct relative path.
>
> ../../../drivers/lightnvm is working by coincidence because the top
> Makefile adds -I$(srctree)/arch/$(SRCARCH)/include as a header
> search path, but we should not rely on it.

Nice catch, thanks!

Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/lightnvm/pblk-trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
> index 679e5c45..9534503 100644
> --- a/drivers/lightnvm/pblk-trace.h
> +++ b/drivers/lightnvm/pblk-trace.h
> @@ -139,7 +139,7 @@ TRACE_EVENT(pblk_state,
>  /* This part must be outside protection */
>
>  #undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH ../../../drivers/lightnvm
> +#define TRACE_INCLUDE_PATH ../../drivers/lightnvm
>  #undef TRACE_INCLUDE_FILE
>  #define TRACE_INCLUDE_FILE pblk-trace
>  #include <trace/define_trace.h>
> --
> 2.7.4
>
