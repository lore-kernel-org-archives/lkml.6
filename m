Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A66C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF99220870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YodFXbBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF99220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeKSW5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:57:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33278 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbeKSW5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:57:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id r27so22259289eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P4erMxhSlJRHXScbxu8vIKD/vSBKXPVjgIvKfS8Ijts=;
        b=YodFXbBTQ2ZanMQVqU8ai4IiO685Ihr5vU5mZLnBHBeWDGmRcktqUxUAnwaOMil1RL
         BO2JHTf7UmE49WqY4jWaUrYVqmZveq9F1Htw5Pb3V2GxoxTvotSqNjNdCgkk6ExzeKae
         PXxo4p5f8FwNiYvpI/pQS4tj8D43BEdqXloAFCv5WYYY2AGSzFOnoRlTekmM11wakBU8
         +OCD4L6Qt0omCYbznhfA8QMufn+jfGckpxGVZn0tVLAacZ2oONMKLE92GQxMDBbBrf9M
         E1nfdJSV3nzQMTHPiFJuiSQ8zWGV2AuTRHYVIMXlDJ2c/H7rykw+A7s2i67iPZrszyGq
         4kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P4erMxhSlJRHXScbxu8vIKD/vSBKXPVjgIvKfS8Ijts=;
        b=RDb6dGEr0YkUtTMwTk+kX+G2c/lQSoxDuTN5zwVuYoL4lHZCdf3Rgn6J1u2PwFhvCR
         dpOB7T/i2t+/BBKnQSuOaU6YOdKBMNMi/vtwYzpbXCH/u3tX7CGQBvr8vuUmIFA6xgmZ
         aBreqWi61IAsbt/3pgNimQL9+h5RCGErf3OqEeJD2Lj0XSGao8UzARL/xH0NkMpKlFmT
         twhkuhxI8i/wNfOvQDPP5UHezNk+pHtpdDDymCTIYDCKBxnRUh7Zw07boJEByE2zHUX0
         7JhlSxjcT5XFm3CfqVDsZro6fipv9YZpBaiqgXCuUpyS/L12wNczzdWDBx03byQIOQQm
         cFLw==
X-Gm-Message-State: AGRZ1gKxF+j67btUYEqD1wgfjDCWvDChBiwrw9ywYGEmEz1fhE3q0MD8
        Bv+icGUuAjL/Ykj2NBr4Akk=
X-Google-Smtp-Source: AJdET5dsaSP8dL9fkpTkY5Y7qt1YDOSPQFQ2tuQ+99Sazk6v1pgam6GnqaS+rQzjbkPZkJ/OZpnUFQ==
X-Received: by 2002:a17:906:2452:: with SMTP id a18-v6mr16304675ejb.17.1542630817836;
        Mon, 19 Nov 2018 04:33:37 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40bc:4d00:b8ae:204:75e7:9858])
        by smtp.gmail.com with ESMTPSA id x58sm9840318edm.10.2018.11.19.04.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 04:33:37 -0800 (PST)
Date:   Mon, 19 Nov 2018 13:33:36 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v3 1/3] compiler_types.h: make
 __builtin_types_compatible_p() noop for Sparse
Message-ID: <20181119123334.6xr23ok4uy5cflzy@ltop.local>
References: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542623503-3755-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:31:41PM +0900, Masahiro Yamada wrote:
> When I tried to delete BUILD_BUG_ON stubs for sparse, the kbuild test
> robot reported lots of Sparse warnings from container_of(), which
> seem false positive.
> 
> The following checker in container_of() seems to be causing something
> strange for Sparse.
> 
>   BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
>                    !__same_type(*(ptr), void),                    \
>                    "pointer type mismatch in container_of()");    \
> 
> I narrowed down the problem into the following test code:
> 
>   --------------------(test_code.c begin)--------------------
>   struct foo {
>           int (*callback)(void);
>   };
> 
>   void assert(int);
> 
>   static inline struct foo *get_foo(void)
>   {
>           assert(__builtin_types_compatible_p(void, void));
> 
>           return (struct foo *)0;
>   }
> 
>   int test(void);
>   int test(void)
>   {
>           return get_foo()->callback();
>   }
>   ---------------------(test_code.c end)---------------------
> 
> Of course, GCC (and Clang as well) can compile it:
> 
>   $ gcc -Wall -c -o test_code.o test_code.c
> 
> However, Sparse complains about this obviously correct code:
> 
>   $ sparse test_code.c
>   test_code.c:9:45: warning: unknown expression (4 0)
>   test_code.c:9:51: warning: unknown expression (4 0)
> 
> Interstingly, just removing the 'inline' keyword in the test code
> makes Sparse happy.
> 
> I concluded that Sparse cannot handle __builtin_types_compatible_p()
> correctly.

I think it's only caused by comparing 'void' (which is never
an l-value).
I'll investigate. Thanks for the small test-case.

> Make it no-op.

...

> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 4a3f9c0..9e7da0b 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -23,6 +23,7 @@
>  extern void __chk_user_ptr(const volatile void __user *);
>  extern void __chk_io_ptr(const volatile void __iomem *);
>  # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
> +# define __builtin_types_compatible_p(t1, t2)	(1)

Now, BUILD_BUG_ON() becomes a no-op for sparse but all the other usages
of __builtin_types_compatible_p() become potentially wrong and can now
create their onw false warnings.

Regards,
-- Luc
