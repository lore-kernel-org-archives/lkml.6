Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F0AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354AC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k49H+EvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354AC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGaBCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:02:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41606 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeGaBCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:02:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so14628415wrr.8;
        Mon, 30 Jul 2018 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f4kwbNe8TZKfamTjX/ryewOIGwKFhhGu3uhxZWFopDs=;
        b=k49H+EvVAcwCrqwjUQUGIguw6YTV2KsBUXaXYVO9upjLXVATHx9/OVkO0zzqgov4Hy
         Ujlcc4JJIYmM9WMsYIz3khMT5lX9YoDDLJCwlO0NDP3erVIYUeoIrptbGaICcvBjSj6k
         QElvrqzmmmzmpZuHH6qzLqhK66KX0iu/9zmTolO/jZihVCORkLiImhGuvRZgBxsLIIVF
         O+4o3cjKL7qWQqHMYyVurSLL3kuNtsQtnctivFapB6qWBp2SYRxWcC7sGDNadjUy2ySH
         CnfozpzqEVBMlwdTrErPYjbzwcQfHlZlNH4AYovzd8FBM2QfPQ64HNE426BYAMaKGyAA
         0nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f4kwbNe8TZKfamTjX/ryewOIGwKFhhGu3uhxZWFopDs=;
        b=HVM2MGbzzxdcUjjPn/xccdfXECQRUNHGs50E39Cka5x49BWXiPOterjX6yBWBWV3MV
         cmE2+DdF8oEu5WYLq4tNcjvX2E51zP2jiI45ZYFA5b3jpZAUhkYt4XZi76oHUAGVwQZR
         QiVuoVdTTAAFiJZs+lnQThDEcSS4wEwMWBEzbo04euJF/USpf/bYqiJz2zH9RLkYTWbs
         5/uoEo5G15NTlvCAdKpXhzaRZC9wgIRCxpBhHNNLYFagpstcsNns1fnxSx6A1VT3l6V/
         4/Z2u3rChjV4mjwGHecPDqxiQ0S/upk+BhBO7ldjlMZZB7GyojRgDz6EqDope5IfInZi
         VqRw==
X-Gm-Message-State: AOUpUlEMyX1v/EwiLrXioVQvOoSKP8V6JnV6bQ15YtcS1+/QUe1njY2M
        COLQPAWaseYhlzrC3+1JaAQ=
X-Google-Smtp-Source: AAOMgpc9eP3TUdO+4BWm4ZGHOBLVQtRtEDVveh9lgDSIa7DLVN9+m3Vvhr1K2pe+bJo/21LayZR7gg==
X-Received: by 2002:adf:992d:: with SMTP id x42-v6mr18995480wrb.81.1532993114797;
        Mon, 30 Jul 2018 16:25:14 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o10-v6sm13467603wrw.79.2018.07.30.16.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:25:14 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:25:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de, paul.burton@mips.com,
        christophe.leroy@c-s.fr, shorne@gmail.com,
        yamada.masahiro@socionext.com, keescook@chromium.org,
        mingo@kernel.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        rdunlap@infradead.org, bp@suse.de, neilb@suse.com,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dwmw@amazon.co.uk, sandipan@linux.vnet.ibm.com,
        linux@rasmusvillemoes.dk, paullawrence@google.com,
        andreyknvl@google.com, will.deacon@arm.com, ghackmann@android.com,
        stable@vger.kernel.org, ghackmann@google.com, mka@chromium.org,
        jpoimboe@redhat.com, wvw@google.com, avagin@openvz.org
Subject: Re: [PATCH v2 2/2] kernel.h: Disable -Wreturn-stack-address for
 _THIS_IP_
Message-ID: <20180730232512.GA1688@flashbox>
References: <20180730213412.242849-1-ndesaulniers@google.com>
 <20180730213412.242849-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730213412.242849-3-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:34:12PM -0700, Nick Desaulniers wrote:
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
> We also can't use compiler specific pragma's without triggering
> -Werror=unknown-pragmas in other compilers, so use __diag.
> 
> Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Tested-and-reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  include/linux/kernel.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 941dc0a5a877..909bb771c0ca 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -168,7 +168,15 @@
>  
>  
>  #define _RET_IP_		(unsigned long)__builtin_return_address(0)
> -#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
> +#define _THIS_IP_  (							\
> +{									\
> +	__label__ __here;						\
> +	__diag_push()							\
> +	__diag_ignore(CLANG, 7, "-Wreturn-stack-address", "")		\
> +__here: (unsigned long)&&__here;					\
> +	__diag_pop()							\
> +}									\
> +)
>  
>  #ifdef CONFIG_LBDAF
>  # include <asm/div64.h>
> -- 
> 2.18.0.345.g5c9ce644c3-goog
> 
