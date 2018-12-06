Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B2C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BFB214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="NgWIP6ty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BFB214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeLFP4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:56:45 -0500
Received: from mail.servus.at ([193.170.194.20]:51026 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLFP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:56:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 38AE73000692;
        Thu,  6 Dec 2018 16:56:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1544111801; x=1545926202; bh=lusPzV2J21zrgkYgt8BeLqy09YeAfsM2KA+
        w6hcI8MM=; b=NgWIP6tyhvQ2XCxCx3AConzVoUpf7+X1f+wQySxaMurA5TT0/Bb
        hqZCQsqKgAykOaDmGTqXWjSlqTTcXWZXrS8uKpOjrd/Y3MYVwQKy10zoZgQjRhjl
        W6geX/aD1SA+4AF54CgnCdsTWWfll1I8WVL5iY3fRa4j5mdJalA6seuM=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Im8cKxdUIRkb; Thu,  6 Dec 2018 16:56:41 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id 7623C3000694;
        Thu,  6 Dec 2018 16:56:38 +0100 (CET)
Subject: Re: [PATCH 2/8] lib/lzo: clean-up by introducing COPY16
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181130142600.13782-3-dave.rodgman@arm.com>
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
Message-ID: <5C0946B6.5010409@oberhumer.com>
Date:   Thu, 6 Dec 2018 16:56:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181130142600.13782-3-dave.rodgman@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*NOT* acked by Markus Oberhumer, original author of the LZO data compression
library and author of the current Linux kernel LZO implementation.

Please see my email reply to the patch series header for more info.


On 2018-11-30 15:26, Dave Rodgman wrote:
> From: Matt Sealey <matt.sealey@arm.com>
> 
> Most compilers should be able to merge adjacent loads/stores of sizes
> which are less than but effect a multiple of a machine word size (in
> effect a memcpy() of a constant amount). However the semantics of the
> macro are that it just does the copy, the pointer increment is in the
> code, hence we see
> 
>     *a = *b
>     a += 8
>     b += 8
>     *a = *b
>     a += 8
>     b += 8
> 
> This introduces a dependency between the two groups of statements which
> seems to defeat said compiler optimizers and generate some very strange
> sequences of addition and subtraction of address offsets (i.e. it is
> overcomplicated).
> 
> Since COPY8 is only ever used to copy amounts of 16 bytes (in pairs),
> just define COPY16 as COPY8,COPY8. We leave the definition to preserve
> the need to do unaligned accesses to machine-sized words per the
> original code intent, we just don't use it in the code proper.
> 
> COPY16 then gives us code like:
> 
>     *a = *b
>     *(a+8) = *(b+8)
>     a += 16
>     b += 16
> 
> This seems to allow compilers to generate much better code by using
> base register writeback or simply positively incrementing offsets which
> seems to positively affect performance. It is, at least, fewer
> instructions to do the same job.
> 
> Link: http://lkml.kernel.org/r/20181127161913.23863-3-dave.rodgman@arm.com
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
>  lib/lzo/lzo1x_compress.c        |  9 +++------
>  lib/lzo/lzo1x_decompress_safe.c | 18 ++++++------------
>  lib/lzo/lzodefs.h               |  3 +++
>  3 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> index 236eb21167b5..82fb5571ce5e 100644
> --- a/lib/lzo/lzo1x_compress.c
> +++ b/lib/lzo/lzo1x_compress.c
> @@ -60,8 +60,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  				op += t;
>  			} else if (t <= 16) {
>  				*op++ = (t - 3);
> -				COPY8(op, ii);
> -				COPY8(op + 8, ii + 8);
> +				COPY16(op, ii);
>  				op += t;
>  			} else {
>  				if (t <= 18) {
> @@ -76,8 +75,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  					*op++ = tt;
>  				}
>  				do {
> -					COPY8(op, ii);
> -					COPY8(op + 8, ii + 8);
> +					COPY16(op, ii);
>  					op += 16;
>  					ii += 16;
>  					t -= 16;
> @@ -255,8 +253,7 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
>  			*op++ = tt;
>  		}
>  		if (t >= 16) do {
> -			COPY8(op, ii);
> -			COPY8(op + 8, ii + 8);
> +			COPY16(op, ii);
>  			op += 16;
>  			ii += 16;
>  			t -= 16;
> diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_safe.c
> index a1c387f6afba..aa95d3066b7d 100644
> --- a/lib/lzo/lzo1x_decompress_safe.c
> +++ b/lib/lzo/lzo1x_decompress_safe.c
> @@ -86,12 +86,9 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
>  					const unsigned char *ie = ip + t;
>  					unsigned char *oe = op + t;
>  					do {
> -						COPY8(op, ip);
> -						op += 8;
> -						ip += 8;
> -						COPY8(op, ip);
> -						op += 8;
> -						ip += 8;
> +						COPY16(op, ip);
> +						op += 16;
> +						ip += 16;
>  					} while (ip < ie);
>  					ip = ie;
>  					op = oe;
> @@ -187,12 +184,9 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
>  			unsigned char *oe = op + t;
>  			if (likely(HAVE_OP(t + 15))) {
>  				do {
> -					COPY8(op, m_pos);
> -					op += 8;
> -					m_pos += 8;
> -					COPY8(op, m_pos);
> -					op += 8;
> -					m_pos += 8;
> +					COPY16(op, m_pos);
> +					op += 16;
> +					m_pos += 16;
>  				} while (op < oe);
>  				op = oe;
>  				if (HAVE_IP(6)) {
> diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
> index 497f9c9f03a8..e1b3cf6459a9 100644
> --- a/lib/lzo/lzodefs.h
> +++ b/lib/lzo/lzodefs.h
> @@ -23,6 +23,9 @@
>  		COPY4(dst, src); COPY4((dst) + 4, (src) + 4)
>  #endif
>  
> +#define COPY16(dst, src) \
> +	do { COPY8(dst, src); COPY8((dst) + 8, (src) + 8); } while (0)
> +
>  #if defined(__BIG_ENDIAN) && defined(__LITTLE_ENDIAN)
>  #error "conflicting endian definitions"
>  #elif defined(CONFIG_X86_64)
> 


-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
