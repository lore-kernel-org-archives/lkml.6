Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD8AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FA42147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUOcF/z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBHFvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:51:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41485 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBHFvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:51:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id p15so1800102edy.8;
        Thu, 07 Feb 2019 21:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4lH59NO+4XoIuJfVc2uOhVjVOoxLCynRZfX+m3dm3I8=;
        b=oUOcF/z28CVSVspQ/PyH6GsYv5nLPKgBS+CpnD49+nCiPucHsISSQmm63JiYGE3TkR
         xDt2Kl1q62gocZ/oNHZasGMgdQQQ9dpNBx2OmFq9vINKjZCVLnyEurQZxcDox9x8a3K/
         KIbzqrQSndquyvZDZPCNOQVC2I7ltICeFNil6tql13SmnDJ7qkpHIXaDEkCPE8Khrp+9
         Uu4fNQTe3rTtMDb9er511e4jbysVCmPRZtN7bnAMenl5f77wO+/Lnv/sUWXmq4XDNEwX
         Zwef5VhB+Bxe4HPkp5MTh30p4qFjCGgHxMxyFNf9l5NJdZbqI3FEB4GUeGRYehJxXQqI
         3nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4lH59NO+4XoIuJfVc2uOhVjVOoxLCynRZfX+m3dm3I8=;
        b=m5D+hroiIlbD6VyqlMTlkuLW19jL0xZT4EGKw6h/TIo1dIh2BStomHa0Rphxi7G+Wj
         CyR/dArgtlKc8xJJ1uYYb1f8K5k5R8de8Pn5w/+TFaRwrHoqjmiFSt+27HWTJJ7GK/Ff
         sUY77PCFsFRp1EdFdIA4FJNUE3JukRZldtKKq2h+9/8sgA2xjhtRlw4NTnnJHgS3IYkD
         ffSYY1WIgITgM5CRZL7ecX9QFwLnYhtAVDPhEJZeRfuhSeXm1JkIVOfL+uUMIpLFG11G
         TAPh3wmjx08Z4pKnvCN5HizEVCiEARjxn2D0vAi/oe+u9chARH6tWm9FGZwYclHO57Xi
         +sTQ==
X-Gm-Message-State: AHQUAuZLhpr37Vn1mUsm6O0LXoQWOu74rRmRliYF7L8H6arpRbcQ/HX5
        zfdPZo74eH3qw4WXFxOHWTs=
X-Google-Smtp-Source: AHgI3IZb4/tjFMsSs2w2KE7XgKp46jbVp1a10oq1l4/qLbLSBU9aSQBJzWLINtS9JM4LhsyA38rCFQ==
X-Received: by 2002:a50:b356:: with SMTP id r22mr15539424edd.164.1549605061448;
        Thu, 07 Feb 2019 21:51:01 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id k12sm794342ejz.4.2019.02.07.21.51.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 21:51:00 -0800 (PST)
Date:   Thu, 7 Feb 2019 22:50:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     ndesaulniers@google.com
Cc:     yamada.masahiro@socionext.com,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
Message-ID: <20190208055059.GD9647@archlinux-ryzen>
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207220155.81351-3-ndesaulniers@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:01:51PM -0800, ndesaulniers@google.com wrote:
> This is needed because clang doesn't select which linker to use based on
> $LD but rather -fuse-ld=$(LD). This is problematic especially for
> cc-ldoption, which checks for linker flag support via invoking the
> compiler, rather than the linker.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/342
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 0eae4277206e..6307c17259ea 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -502,6 +502,9 @@ endif
>  CLANG_FLAGS	+= -no-integrated-as
>  KBUILD_CFLAGS	+= $(CLANG_FLAGS)
>  KBUILD_AFLAGS	+= $(CLANG_FLAGS)
> +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> +CLANG_FLAGS	+= -fuse-ld=lld
> +endif

This section needs to be moved up above KBUILD_CFLAGS otherwise it never
actually gets passed along.

With that change, please add:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

>  export CLANG_FLAGS
>  endif
>  
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 
