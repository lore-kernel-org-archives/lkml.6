Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC6C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424E4246D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lAXRtZCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424E4246D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeFVRnP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:43:15 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:35845 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932973AbeFVRnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:43:13 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5MHh7Dl024851;
        Sat, 23 Jun 2018 02:43:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5MHh7Dl024851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529689388;
        bh=RGlq7n9pW8JF0NwzigVhWYRPxcVrmBYsG1qHL1Tcf5s=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lAXRtZCswXNimJR+zYgrSMfvs2QcyqB+GptZoWjsboM61fc1YQIMT6kh/KIsEXbL0
         enTGfhFtdu4yiOW4uuFft7+NtB4Sy28sKMSRkpXSgkfp/m+2M07MJ7TnBr+I81leXa
         iFtY6jlycvbycoy1IX4ksyqHtpvowR14CeaCkRJAH4nL2UqvT2ZrsRZp3dKv/BvWBF
         tZ1TX4zjByYn2FVLN5axCZJzrA5tp/ZkNg7lBP+ZWdaNwwtivbs7uFXhZeNLbBfYOe
         dtxviEZQVQASakNDB7SIYFWsYo3qFlLrNnIcy+OcxDc91ogYb569jBFfuOPD9yXZtT
         Y8fp0AadcymEw==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id x18-v6so4789348uaj.9;
        Fri, 22 Jun 2018 10:43:08 -0700 (PDT)
X-Gm-Message-State: APt69E1YWha/I0rmxiAZPEePUzoTk5oRu2hBh3fBDQ5Jnc8j94IlGWSp
        zbGR3ehknXwdYFz5yVyWvG4zo7z+oWMFJdxEq6o=
X-Google-Smtp-Source: ADUXVKLkVpxuucqus8lPOG6ZybpgPB+sYr9vzaYnAIYSUu00iVzDGhwY8mFxkQgN7Nywuwd4cYCXruUOgHH5VCcGSJ4=
X-Received: by 2002:ab0:1048:: with SMTP id g8-v6mr1578635uab.52.1529689387251;
 Fri, 22 Jun 2018 10:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 10:42:26
 -0700 (PDT)
In-Reply-To: <20180608214746.136554-1-gthelen@google.com>
References: <20180608214746.136554-1-gthelen@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 23 Jun 2018 02:42:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARngmBXa5w3XFfuA7pEv39vWjJVNJ+3XVLPYd9QLH+f-A@mail.gmail.com>
Message-ID: <CAK7LNARngmBXa5w3XFfuA7pEv39vWjJVNJ+3XVLPYd9QLH+f-A@mail.gmail.com>
Subject: Re: [PATCH] trace: fix SKIP_STACK_VALIDATION=1 build
To:     Greg Thelen <gthelen@google.com>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-09 6:47 GMT+09:00 Greg Thelen <gthelen@google.com>:
> Non gcc-5 builds with CONFIG_STACK_VALIDATION=y and
> SKIP_STACK_VALIDATION=1 fail.
> Example output:
>   /bin/sh: init/.tmp_main.o: Permission denied
>
> commit 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace"),
> added a mismatched endif.  This causes cmd_objtool to get mistakenly
> set.
>
> Relocate endif to balance the newly added -record-mcount check.
>
> Fixes: 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace")
> Signed-off-by: Greg Thelen <gthelen@google.com>
> ---

Applied to linux-kbuild/fixes. Thanks!



>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 34d9e9ce97c2..e7889f486ca1 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -239,6 +239,7 @@ cmd_record_mcount =                                         \
>              "$(CC_FLAGS_FTRACE)" ]; then                       \
>                 $(sub_cmd_record_mcount)                        \
>         fi;
> +endif # -record-mcount
>  endif # CONFIG_FTRACE_MCOUNT_RECORD
>
>  ifdef CONFIG_STACK_VALIDATION
> @@ -263,7 +264,6 @@ ifneq ($(RETPOLINE_CFLAGS),)
>    objtool_args += --retpoline
>  endif
>  endif
> -endif
>
>
>  ifdef CONFIG_MODVERSIONS
> --
> 2.18.0.rc1.242.g61856ae69a-goog
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
