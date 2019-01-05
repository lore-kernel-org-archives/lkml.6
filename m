Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7461C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F262070B
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yc3y4A4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfAEQMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:12:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37338 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfAEQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 11:12:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id g125so23186967qke.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 08:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=I+U7fwl8CskayCBqp51KRo+AoACBcx3zcCyqUVTTByQ=;
        b=Yc3y4A4fS/hGIQnv4Y4KHRjx+WjpJ37UxAvF11MAInrQAW0v/VoSFyNmfMQZkT2VUq
         8JwuauCkPUHX+F+FttndqFVIdw655ezZuqrO4iI8PkTjNPRTv6Rsbwknn0JUJFknCPzH
         J0IEdpK6AUT3hVWO52a87do0n/TSquEjDluis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=I+U7fwl8CskayCBqp51KRo+AoACBcx3zcCyqUVTTByQ=;
        b=Q41jzv6jlcDZgwuiUvzr9+I6BKvNnSTraR/sp8K5JvTc4AqgVJT59g7i/oh4TUUAwg
         7TY0fVrZ/ySODUnSPXeg6uQv3uTTa4qFTAT3wUwHZ+7dQxL0iEVqRMHvR55taxlkbgoB
         RBrbRAUusVcyFXP6AA4re5aIYvcRlU1FkCB/PIyLMfn6GFvTq/ToN4+da9UoISiyzH28
         4xeR4Im87pr+79/bz+yngoBTYv/L1IpPPBcKXWw6+uR+7sHyVkqnYTYbguoG6aVLACFK
         2Sa4ab//TfMNDiaE5TnQZ8tVnvVrWHX0HAbTspX8BHLT0A7C9SOlh3CmV1OFPrK2p3Zb
         reoA==
X-Gm-Message-State: AJcUukdtr9imwBlN6o6smdaq5bX6J7V/n1nN4xx6/G7/5+c9MoN672mw
        XF5e84BbwpGUNobo6NpE6Kdzkw==
X-Google-Smtp-Source: ALg8bN4/h+nRdBJ4Kvu4RQSkfUjjcAKV2Dao3qR6EQiSmy2ta1hPyBCzaTu8qci3ceu3oBy9y66tQw==
X-Received: by 2002:a37:5686:: with SMTP id k128mr48700405qkb.29.1546704741229;
        Sat, 05 Jan 2019 08:12:21 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id m20sm24347580qkk.66.2019.01.05.08.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 08:12:20 -0800 (PST)
Date:   Sat, 5 Jan 2019 11:12:18 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Stefan Agner <stefan@agner.ch>
cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ARM: uaccess: use unified assembler language
 syntax
In-Reply-To: <5ef2acc655abfbe8bfa2cd30ecc5c2286b8fdfa3.1546551693.git.stefan@agner.ch>
Message-ID: <nycvar.YSQ.7.76.1901051106410.1783@knanqh.ubzr>
References: <cover.1546551693.git.stefan@agner.ch> <5ef2acc655abfbe8bfa2cd30ecc5c2286b8fdfa3.1546551693.git.stefan@agner.ch>
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
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v1:
> - Explicitly use unified syntax for inline assembly
> 
> 
>  arch/arm/include/asm/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 6390a40f16e7..a50f9b4e2574 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -86,7 +86,8 @@ static inline void set_fs(mm_segment_t fs)
>  #define __range_ok(addr, size) ({ \
>  	unsigned long flag, roksum; \
>  	__chk_user_ptr(addr);	\
> -	__asm__("adds %1, %2, %3; sbcccs %1, %1, %0; movcc %0, #0" \
> +	__asm__(".syntax unified\n" \
> +		"adds %1, %2, %3; sbcscc %1, %1, %0; movcc %0, #0" \

Instead of sprinkling ".syntax unified" around, you could consider 
including <asm/unified.h> when needed.


Nicolas
