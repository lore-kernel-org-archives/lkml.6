Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F58C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3632089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3632089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeGIXYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:24:48 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34494 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbeGIXYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:24:46 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so10644079qkj.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+yx5hOi2AhOrRpdA6UC/SOPS5EfiO9n1/h3Cj14YXc=;
        b=eklahAv+yWKxrK/tPdgWj4vByqRrI2C33oEVKMfQS4PpddS0QOnF3ZgTmNSbuIXhD1
         TgPVgTbACbfsprNMuen94JIVuk0rS1UB2d51Y4LCKlrfItjV4/nJsaBMJpGEbY94my0o
         7kda7lUvLlwOeX6Lbmj+GnOnjwqGVndgoA89aHB4qNZZn5nLxLJsyf8p3j9E66HKkGn7
         ZMMHtS1nwpGvgxd+HxphbI1HoI7d5y49uj9MAt3wHhqvzlgHz2hxoxRz1jugV6wC5q71
         MFh+RAVBuSGKL4cfRgqAI45L0FhiYw+gzMuV0ImGe/OkkR+HIVzTM+84xSfqYOZjUlsp
         89Kw==
X-Gm-Message-State: APt69E3Db/IqQY+Mk05PZhcYFAmA9LLjLr80Mj1ZjVmnIwNtWDr9FtVd
        IfIJMZTfD4PuWR9IVTk3+qNlKsLppck=
X-Google-Smtp-Source: AAOMgpc25i1tcn66dZ/pnPYMOVhCxtGYrgU3dXFo3/rhgsUJinpq0cl6BoJZSlIr4WKjNQP9BJleoA==
X-Received: by 2002:a37:849:: with SMTP id 70-v6mr19677882qki.200.1531178685737;
        Mon, 09 Jul 2018 16:24:45 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::1941? ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id 3-v6sm12599037qts.31.2018.07.09.16.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 16:24:44 -0700 (PDT)
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
To:     Will Deacon <will.deacon@arm.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180709200956.31158-1-labbott@redhat.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <aadf9529-1236-ea8f-3110-f41b318fb60a@redhat.com>
Date:   Mon, 9 Jul 2018 16:24:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709200956.31158-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 01:09 PM, Laura Abbott wrote:
> This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.
> 
> This breaks compilation with Fedora gcc-8 tool chains:
> 
>    CHK     include/generated/compile.h
>    LD [M]  arch/arm64/crypto/sha512-ce.o
> aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
> make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
> make: *** [Makefile:1029: arch/arm64/crypto] Error 2
> 
> Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> A bit rushed and I'm still debugging but I wanted to send this out
> before anyone else gets hit since it is -rc4. Seeing this on both native
> and cross compiles.

The answer appears to be that Fedora binutils does not package the assembly
scripts. The logic behind this is not immediately obvious but it's been
removed since 2004. Obviously this is a packaging issue on Fedora's side
but I'd still like to revert since it is a build breakage and fixing
this might require some coordination. I'll send a v2 with clarified
commit text if there's agreement.

Thanks,
Laura

> ---
>   arch/arm64/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 7976d2d242fa..f476d52ad8d6 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>   KBUILD_CPPFLAGS	+= -mbig-endian
>   CHECKFLAGS	+= -D__AARCH64EB__
>   AS		+= -EB
> -LDFLAGS		+= -EB -maarch64elfb
> +LDFLAGS		+= -EB -maarch64linuxb
>   UTS_MACHINE	:= aarch64_be
>   else
>   KBUILD_CPPFLAGS	+= -mlittle-endian
>   CHECKFLAGS	+= -D__AARCH64EL__
>   AS		+= -EL
> -LDFLAGS		+= -EL -maarch64elf
> +LDFLAGS		+= -EL -maarch64linux
>   UTS_MACHINE	:= aarch64
>   endif
>   
> 

