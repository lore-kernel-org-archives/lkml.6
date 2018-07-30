Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C31C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F9220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ1eGbwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F9220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbeG3UQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:16:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53518 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3UQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:16:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so419299wmh.3;
        Mon, 30 Jul 2018 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dy2/1v92GsVuswJmc/08WkcNSB9yfEwS4X8bImpFzKo=;
        b=dJ1eGbwppW4RkxoC/w5Y7qzq3PdLRoPhWahlBx8FkMlZth9RtRJSRGUEZNoYWHf0bB
         HXJylNsEoFQVvJTgnX+dwVhmAqVJE09zhEN5ookH5OwXJ/087TYgVsGSY/spY4GWoqvv
         X8o3TValFaPfvfdYP4DZ/VQyA6zXvC6kPxtHhIr90xcnkMB6WHOe+T3w1j96O9YVgp0S
         4s/elrJedqJ1AHVEePPR+xovug9Scd+ACqQ0RBeesxLdkoQ6ppLGNFTLvhpjQ/PvAABU
         wXBHFXWJZUr8PCJsKYcfzk9BwpgYKGq59EaN6XMyfGr7pg1SUu8VnnK/CUEmuwoTOsED
         86ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dy2/1v92GsVuswJmc/08WkcNSB9yfEwS4X8bImpFzKo=;
        b=trgUMZ8YWtQg2XZwi+JM9mOgEBIEUwoMlRzZ5lb4hG/VStQLanSduh4KDzB/AjUM4t
         /SYYoNO6yybIfrsfOW3HIc5GJWkibP+pdRfN8TdMEZHQ81jBxdRtr/xxo6HoS/5MFWEg
         6910MXYwT4qVm4gWyrAs3kKCJMm4E+LgmfYLfmIngv/h2LOzcWj/zMC3lTq2zuWhZrNT
         4gQewupnsLcBCIV1pZBTbibxlbgRpb6EBgY+RBvEUre8s+SkeO0roUaf74nMXRTRKlb2
         3qB5PCnfDRJj0GzvQCGUOGDL2NBGKOJz/TDdeUbs/avjM/YwYERp6YaDhaifHyMFtt1z
         JlfA==
X-Gm-Message-State: AOUpUlERAzLzkmTCgDNZGzjtx2Wvk/MM/zagqGboeGoWOBYrbZq5BF+G
        VVJV7niinmsObHT1PU7SEM4vo46ZPGA=
X-Google-Smtp-Source: AAOMgpe7LpfzTXh5uNGa1dHO7GkX4OjKefXUdBkAgbsmIC3T5VqgY6gZFBMJsgCKssCEBfWAxKR3Mw==
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr279766wmb.118.1532975985712;
        Mon, 30 Jul 2018 11:39:45 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f8-v6sm18250997wrj.9.2018.07.30.11.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:39:44 -0700 (PDT)
Date:   Mon, 30 Jul 2018 11:39:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, mka@chromium.org, ghackmann@android.com,
        ghackmann@google.com, stable@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        NeilBrown <neilb@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
Message-ID: <20180730183943.GA9221@flashbox>
References: <20180730170622.99349-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730170622.99349-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:06:20AM -0700, Nick Desaulniers wrote:
> Starting with Clang-7.0, _THIS_IP_ generates -Wreturn-stack-address
> warnings for almost every translation unit. In general, I'd prefer to
> leave this on (returning the address of a stack allocated variable is in
> general a bad idea) and disable it only at whitelisted call sites.
> 
> We can't do something like:
>  #pragma clang diagnostic push
>  #pragma clang diagnostic ignored "-Wreturn-stack-address"
>  <code>
>  #pragma clang diagnostic pop
> 
> in a GNU Statement Expression or macro, hence we use _Pragma, which is
> its raison d'être: https://gcc.gnu.org/onlinedocs/cpp/Pragmas.html
> 
> Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/kernel.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 941dc0a5a877..5906f5727f90 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -168,7 +168,15 @@
>  
>  
>  #define _RET_IP_		(unsigned long)__builtin_return_address(0)
> -#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> +#define _THIS_IP_  (							\
> +{									\
> +	_Pragma("clang diagnostic push")				\
> +	_Pragma("clang diagnostic ignored \"-Wreturn-stack-address\"")	\
> +	__label__ __here;						\
> +__here: (unsigned long)&&__here;					\
> +	_Pragma("clang diagnostic pop")					\
> +}									\
> +)
>  
>  #ifdef CONFIG_LBDAF
>  # include <asm/div64.h>
> -- 
> 2.18.0.233.g985f88cf7e-goog
> 

This generates a ton of warnings with GCC:

In file included from ./include/linux/spinlock.h:58,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/slab.h:15,
                 from ./include/linux/crypto.h:24,
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/bottom_half.h: In function ‘local_bh_disable’:
./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
  __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);

./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]   
./include/linux/bottom_half.h:19: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]                             
./include/linux/bottom_half.h: In function ‘local_bh_enable’:
./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
  __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);

./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
./include/linux/bottom_half.h:32: error: ignoring #pragma clang diagnostic [-Werror=unknown-pragmas]
cc1: all warnings being treated as errors
make[1]: *** [Kbuild:56: arch/x86/kernel/asm-offsets.s] Error 1
make: *** [Makefile:1081: prepare0] Error 2

A proper solution is probably going to involve what was done for the
-Wattribute-alias warnings from GCC 8 in commits 8793bb7f4a9d ("kbuild:
add macro for controlling warnings to linux/compiler.h") and
bee20031772a ("disable -Wattribute-alias warning for SYSCALL_DEFINEx()")

I'll take a look at it in a bit unless someone beats me to it.

Thanks!
Nathan
