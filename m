Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBBEC32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC412082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9zAgsyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC412082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeKCJNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:13:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37301 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeKCJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:13:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id c10-v6so1636179pgq.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWVRItPUEY4choLv3/OZckRO26T04smLrnUBelRMItI=;
        b=D9zAgsyXEz8xEBLeWMV/J5z0HotqUgDxP2XlLXl2/XKzbws17HqfbzDs/hjvMImCcl
         o9vSoxMrkpvAHiMSYPWlF7rlqOlYajCRb6czJwIYhBoZu1sgyRRnKrcgS3cC2N0KUI8D
         P3QwS0bSg070s3I94Ds5dtEQgrNX+p3ZepcNjMTsBQzJyNUnVCobTwiDUzFru4P0cTvj
         XQwDgAcZ3qoDkwd9OOlXXQz3f+pNn8mH8RlLp9Ry09zkbG+MzgNxXLPrlMN7dwEyWOlA
         F8s6wbx79taSj3DvgoM81GJQrDi75ncF5/YB5HvX7WFOrsDLitzNvyRswPN5MRVkNEzf
         jkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWVRItPUEY4choLv3/OZckRO26T04smLrnUBelRMItI=;
        b=V5fDQ5uUCCxKLUYQdQX2il6+ZdF6d4o8Qp+vONQelXRs4Q2NYNHqg8tmKOaU//7Dg2
         pGSxAcncvoIHbkw85ANOZiP/rscyb2jn3X33qNoEn0KIvwwFUyvJfquJv3Qv3xWlxGK/
         DdLo11gW3c/tG9+19/Rxa9dIS4Al8h7DvEilVCMHp0yUUvmmPCi6kDujx6ZH5J/Rx2GI
         g9ibnEqAeUR/JNN3X0ATZ7Xt1gml/dCNbUfua3DBYSKwjE+zczxoDOxezV/ZJD+DY2nC
         p+GD2m7TjT2zUtItmwWIEN/Sh2k9ufS9jIbl+xt/wMk2GM7dUqhTitS29KwLk38Oh9wA
         /46A==
X-Gm-Message-State: AGRZ1gLFySz5RrSDmD+2haUHWdi/8CKvllrxRyBFLyWbA9bXOa4jvVyh
        TOotfvVrhR4lOqaciy5JcY8=
X-Google-Smtp-Source: AJdET5f9oL7z9820FqrsYImhMdju8CVIbtBePboH788MRCWmUhdVL6u4lScCOcpoRINUwlW3yWZErA==
X-Received: by 2002:a63:3287:: with SMTP id y129mr12729253pgy.337.1541203440600;
        Fri, 02 Nov 2018 17:04:00 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id t64-v6sm25128375pfd.127.2018.11.02.17.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 17:04:00 -0700 (PDT)
Date:   Sat, 3 Nov 2018 00:03:58 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Changbin Du <changbin.du@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_{to,from}_user(): fix compile-time sanity checks
 with gcc -Og
Message-ID: <20181103000357.delj5z56zxrkcpeg@mail.google.com>
References: <20181102155710.2299475-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102155710.2299475-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:56:58PM +0100, Arnd Bergmann wrote:
> When CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is set, we get countless warnings
> like
> 
> In function 'check_copy_size',
>     inlined from 'copy_from_user' at include/linux/uaccess.h:146:6,
>     inlined from '__copy_siginfo_from_user' at kernel/signal.c:3032:6:
> include/linux/thread_info.h:147:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
> 
> It seems that constant propagation doesn't work well enough to make
> this code reliable, so turn it off for that configuration.
> 
This is caused by __compiletime_warning() and fixed by below change
already. Could you try the latest kbuild tree?

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -86,8 +86,10 @@
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)

 #ifndef __CHECKER__
+#ifndef CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
+#endif

> Cc: Changbin Du<changbin.du@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/thread_info.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
> index 8d8821b3689a..762f379bdf5d 100644
> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -138,6 +138,11 @@ static __always_inline bool
>  check_copy_size(const void *addr, size_t bytes, bool is_source)
>  {
>  	int sz = __compiletime_object_size(addr);
> +
> +	/* constant propagation doesn't work well with -Og */
> +	if (IS_ENABLED(CONFIG_CC_OPTIMIZE_FOR_DEBUGGING))
> +		return true;
> +
>  	if (unlikely(sz >= 0 && sz < bytes)) {
>  		if (!__builtin_constant_p(bytes))
>  			copy_overflow(sz, bytes);
> -- 
> 2.18.0
> 

-- 
Thanks,
Changbin Du
