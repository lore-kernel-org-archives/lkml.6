Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABABC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD81214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="QXeEsZbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD81214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLFPtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:49:40 -0500
Received: from mail.servus.at ([193.170.194.20]:49700 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeLFPtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:49:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 4E7EA3000692;
        Thu,  6 Dec 2018 16:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1544111373; x=1545925774; bh=ZSzkmWWOQLURqbSfsEvLnhhC4Hh/fxO/fEv
        /oKaxCyA=; b=QXeEsZbVdEHVc8g9zzZMTPood5lkUjympvBJ7RmuOWy19A3F6sa
        MpQzSMdch4bMxN3HfkoxfoU+TfryF7x4dDSKITv6dfMRwFfslz/F4u68/NEe0m7q
        3X4EfyCsXWU2fQOwV4Zfm4gJCdcUh3Fp/qKM5Lp0r8732bvlGE5LDBIA=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MQe4eUr4ETuZ; Thu,  6 Dec 2018 16:49:33 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id 24CC1300069A;
        Thu,  6 Dec 2018 16:49:27 +0100 (CET)
Subject: Re: [PATCH 1/8] lib/lzo: tidy-up ifdefs
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181130142600.13782-2-dave.rodgman@arm.com>
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
Message-ID: <5C094506.7040501@oberhumer.com>
Date:   Thu, 6 Dec 2018 16:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181130142600.13782-2-dave.rodgman@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>


On 2018-11-30 15:26, Dave Rodgman wrote:
> Modify the ifdefs in lzodefs.h to be more consistent with normal kernel
> macros (e.g., change __aarch64__ to CONFIG_ARM64).
> 
> Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Nitin Gupta <nitingupta910@gmail.com>
> Cc: Richard Purdie <rpurdie@openedhand.com>
> Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Matt Sealey <matt.sealey@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  lib/lzo/lzodefs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
> index 4edefd2f540c..497f9c9f03a8 100644
> --- a/lib/lzo/lzodefs.h
> +++ b/lib/lzo/lzodefs.h
> @@ -15,7 +15,7 @@
>  
>  #define COPY4(dst, src)	\
>  		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
> -#if defined(__x86_64__)
> +#if defined(CONFIG_X86_64)
>  #define COPY8(dst, src)	\
>  		put_unaligned(get_unaligned((const u64 *)(src)), (u64 *)(dst))
>  #else
> @@ -25,12 +25,12 @@
>  
>  #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
>  #error "conflicting endian definitions"
> -#elif defined(__x86_64__)
> +#elif defined(CONFIG_X86_64)
>  #define LZO_USE_CTZ64	1
>  #define LZO_USE_CTZ32	1
> -#elif defined(__i386__) || defined(__powerpc__)
> +#elif defined(CONFIG_X86) || defined(CONFIG_PPC)
>  #define LZO_USE_CTZ32	1
> -#elif defined(__arm__) && (__LINUX_ARM_ARCH__ >= 5)
> +#elif defined(CONFIG_ARM) && (__LINUX_ARM_ARCH__ >= 5)
>  #define LZO_USE_CTZ32	1
>  #endif
>  
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
