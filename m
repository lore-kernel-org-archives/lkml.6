Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F44AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6D0215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="pNsd28UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6D0215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLFPxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:05 -0500
Received: from mail.servus.at ([193.170.194.20]:50480 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeLFPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:53:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id BD525300069D;
        Thu,  6 Dec 2018 16:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1544111578; x=1545925979; bh=11tgiztIiA5g9ExtSH92y71GYVh6tNgkiEN
        ua057D1c=; b=pNsd28UPPazFnWoSzxIHXbQ7P7BEn1YvKRsYhxhN8XJSrgZxzDq
        F3w4JkE0vGGcTgXLSq7JT8nUvf0R78wpasHNTZ1VP9yH+Mv0KDuSOmgxDaxtcUTh
        lOUTf4PKAKEzCuvttQ7BgFn/24AZiY05+u2z0YYv4mWor44phKXO0lNA=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FFqv0QMgt-NP; Thu,  6 Dec 2018 16:52:58 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id C26D7300069A;
        Thu,  6 Dec 2018 16:52:57 +0100 (CET)
Subject: Re: [PATCH 4/8] lib/lzo: 64-bit CTZ on arm64
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181130142600.13782-5-dave.rodgman@arm.com>
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
Message-ID: <5C0945D9.3030500@oberhumer.com>
Date:   Thu, 6 Dec 2018 16:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181130142600.13782-5-dave.rodgman@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Markus F.X.J. Oberhumer <markus@oberhumer.com>



On 2018-11-30 15:26, Dave Rodgman wrote:
> From: Matt Sealey <matt.sealey@arm.com>
> 
> LZO leaves some performance on the table by not realising that arm64 can
> optimize count-trailing-zeros bit operations.
> 
> Add CONFIG_ARM64 to the checked definitions alongside CONFIG_X86_64 to
> enable the use of rbit/clz instructions on full 64-bit quantities.
> 
> Link: http://lkml.kernel.org/r/20181127161913.23863-5-dave.rodgman@arm.com
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
>  lib/lzo/lzodefs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
> index c0193f726db0..c8965dc181df 100644
> --- a/lib/lzo/lzodefs.h
> +++ b/lib/lzo/lzodefs.h
> @@ -28,7 +28,7 @@
>  
>  #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
>  #error "conflicting endian definitions"
> -#elif defined(CONFIG_X86_64)
> +#elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
>  #define LZO_USE_CTZ64	1
>  #define LZO_USE_CTZ32	1
>  #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
