Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A62CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4FC2070B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iBjqCOFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfAEQNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:13:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40651 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAEQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:13:34 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so43541611qtf.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wJQD+3taV+2dRWcSlIQEBzhFTwRN7ox4H4SOm0Qzovw=;
        b=iBjqCOFozSEyig3gjqV151FE6BJi1rXa1LokArmqdy3Ch48OVYicb/RHA1FKaS3aac
         Vrx1Rw4rUblUPUu7BfyjwQp0yA5WGixKY1XoyhAj75K+5jHdUj1MaUF70ptI7fG54wfc
         CR4p7ft9x5KviGXEUqm568EHrLYHmdZWt8YYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wJQD+3taV+2dRWcSlIQEBzhFTwRN7ox4H4SOm0Qzovw=;
        b=HnfCxa/LbBwaAk8a2YZlIfjwD8Xfa4qMLodZYGTr0UEBtpAzGxlTQpbbrrtHJrs8BJ
         Xb/uJ1fRidqDTeeeAojYKlEkPgAQ18fxC2k6nd8IZSGn4Z98DpgX80K7VnRQ+xoWrrfz
         l4WeckYmyt7koRhq1Q8Ugblwn/HXgvvQ29dc3ZAF1MRsQnCoxPhlMV8RDpdovkT8vmQ0
         bAM7F84GgUEq8sZb7EiR6CFmLXha8ZBdJSvC1VI9BqaBcUBtv7A5pPvNlw7lEf2xSCCx
         RjcIt8W/oE/iaDbO3CMD2Doz7hs0Cub1NtxHMQedoHVofA+E9jnHMkSKIG45zrY4uZcT
         IceA==
X-Gm-Message-State: AA+aEWbhllWh9RsgMwHbYmDzOZ20xlBUbU7SjDXadCzhL3oz7ppsBU7l
        5ffqjD5HlP73XzdcJ3jJ/SKwYw==
X-Google-Smtp-Source: AFSGD/XfVuLl5QnAXyQyf/EkTyBh9c4XiLRnWbd6xX5742752HW3EiwVQ1Vx31lj4wg1NDfLXm4m+w==
X-Received: by 2002:ac8:2b99:: with SMTP id m25mr53867090qtm.36.1546704813228;
        Sat, 05 Jan 2019 08:13:33 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id q54sm31019163qtb.64.2019.01.05.08.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 08:13:32 -0800 (PST)
Date:   Sat, 5 Jan 2019 11:13:30 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: spinlock: use unified assembler language
 syntax
In-Reply-To: <ad0fbab91f337ec99e3a2a3d60886a785da34366.1546551693.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1901051112560.1783@knanqh.ubzr>
References: <cover.1546551693.git.stefan@agner.ch> <ad0fbab91f337ec99e3a2a3d60886a785da34366.1546551693.git.stefan@agner.ch>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019, Stefan Agner wrote:

> Convert the conditional infix to a postfix to make sure this inline
> assembly is unified syntax. Since gcc assumes non-unified syntax
> when emitting ARM instructions, make sure to define the syntax as
> unified.
> 
> This allows to use LLVM's integrated assembler.

Same comment as for patch 2/3.


> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v1:
> - Explicitly use unified syntax for inline assembly
> 
> 
>  arch/arm/include/asm/spinlock.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index 099c78fcf62d..8f009e788ad4 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -210,11 +210,12 @@ static inline void arch_read_lock(arch_rwlock_t *rw)
>  
>  	prefetchw(&rw->lock);
>  	__asm__ __volatile__(
> +"	.syntax unified\n"
>  "1:	ldrex	%0, [%2]\n"
>  "	adds	%0, %0, #1\n"
>  "	strexpl	%1, %0, [%2]\n"
>  	WFE("mi")
> -"	rsbpls	%0, %1, #0\n"
> +"	rsbspl	%0, %1, #0\n"
>  "	bmi	1b"
>  	: "=&r" (tmp), "=&r" (tmp2)
>  	: "r" (&rw->lock)
> -- 
> 2.20.1
> 
> 
