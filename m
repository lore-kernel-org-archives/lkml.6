Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F76C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB34F214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="zMKafuEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB34F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeLFPwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:52:03 -0500
Received: from mail.servus.at ([193.170.194.20]:50262 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeLFPwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:52:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id CD4C3300069E;
        Thu,  6 Dec 2018 16:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1544111517; x=1545925918; bh=QmL4OZ7E57qNCjThXRFnbX27/8HSvmaella
        gz6iYVSE=; b=zMKafuEiChcVPh9XOYoXddQwUsWy2Cz5FxslJ6tvy5pV74R8VCI
        A68KCKaYdBMIqVXN2wOhHH5OD2X3jn8kgdn2XDSg/EH+vnHvrDhbHLyoc9+t735e
        WpcHuwAntuG2Y7Nw+dCC+LdaQjjYO/28t8D/TIbdLrrqq40oV0hHRVPM=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yh_VonA4ekXi; Thu,  6 Dec 2018 16:51:57 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id 7A35E300069D;
        Thu,  6 Dec 2018 16:51:55 +0100 (CET)
Subject: Re: [PATCH 3/8] lib/lzo: enable 64-bit CTZ on Arm
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181130142600.13782-4-dave.rodgman@arm.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
From:   "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
Message-ID: <5C09459B.5090201@oberhumer.com>
Date:   Thu, 6 Dec 2018 16:51:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181130142600.13782-4-dave.rodgman@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think that LZO_USE_CTZ64 should only be defined for ARM64 and
not for 32-bit ARM.


On 2018-11-30 15:26, Dave Rodgman wrote:
> From: Matt Sealey <matt.sealey@arm.com>
> 
> ARMv6 Thumb state introduced an RBIT instruction which, combined with CLZ
> as present in ARMv5, introduces an extremely fast path for counting
> trailing zeroes.
> 
> Enable the use of the GCC builtin for this on ARMv6+ with
> CONFIG_THUMB2_KERNEL to ensure we get the 'new' instruction usage.
> 
> We do not bother enabling LZO_USE_CTZ64 support for ARMv5 as the builtin
> code path does the same thing as the LZO_USE_CTZ32 code, only with more
> register pressure.
> 
> Link: http://lkml.kernel.org/r/20181127161913.23863-4-dave.rodgman@arm.com
> Signed-off-by: Matt Sealey <matt.sealey@arm.com>
> Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <nitingupta910@gmail.com>
> Cc: Richard Purdie <rpurdie@openedhand.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  lib/lzo/lzodefs.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
> index e1b3cf6459a9..c0193f726db0 100644
> --- a/lib/lzo/lzodefs.h
> +++ b/lib/lzo/lzodefs.h
> @@ -33,9 +33,14 @@
>  #define LZO_USE_CTZ32	1
>  #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
>  #define LZO_USE_CTZ32	1
> -#elif defined(CONFIG_ARM) && (__LINUX_ARM_ARCH__ >= 5)
> +#elif defined(CONFIG_ARM)
> +#if (__LINUX_ARM_ARCH__ >= 5)
>  #define LZO_USE_CTZ32	1
>  #endif
> +#if (__LINUX_ARM_ARCH__ >= 6) && defined(CONFIG_THUMB2_KERNEL)
> +#define LZO_USE_CTZ64	1
> +#endif
> +#endif
>  
>  #define M1_MAX_OFFSET	0x0400
>  #define M2_MAX_OFFSET	0x0800
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
