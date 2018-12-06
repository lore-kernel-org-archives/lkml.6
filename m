Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE0CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84FF214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="gmoOc53U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84FF214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeLFP5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:57:05 -0500
Received: from mail.servus.at ([193.170.194.20]:51094 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbeLFP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:57:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id 6DF53300069A;
        Thu,  6 Dec 2018 16:57:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1544111818; x=1545926219; bh=Xp18Hc3VBMXFQy3DnTFF79s+UhVAIlAiUsF
        kDR0fihI=; b=gmoOc53UMzN2D0x4xxyd4w8IXmMaEDF4NSA7qfeTZfaN3xU9FAM
        QScPwyswvNROMC83L/wcrIhf1wf7A5z5rJcpFU1JCoOYwLj+myjuaBVwX6Fva7Bp
        2S0q4BrfumU0sHUpVRvMoBN67THOYX7+Dir/ceqWgCacrDf7StMaqY5Q=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fhcTsSLcWsnI; Thu,  6 Dec 2018 16:56:58 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id CF2DE3000694;
        Thu,  6 Dec 2018 16:56:53 +0100 (CET)
Subject: Re: [PATCH 6/8] lib/lzo: implement run-length encoding
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181130142600.13782-7-dave.rodgman@arm.com>
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
Message-ID: <5C0946C5.3060300@oberhumer.com>
Date:   Thu, 6 Dec 2018 16:56:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181130142600.13782-7-dave.rodgman@arm.com>
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
> When using zram, we frequently encounter long runs of zero bytes.
> This adds a special case which identifies runs of zeros and encodes
> them using run-length encoding.
> 
> This is faster for both compression and decompresion. For
> high-entropy data which doesn't hit this case, impact is minimal.
> 
> Compression ratio is within a few percent in all cases.
> 
> This modifies the bitstream in a way which is backwards compatible
> (i.e., we can decompress old bitstreams, but old versions of lzo
> cannot decompress new bitstreams).
> 
> Link: http://lkml.kernel.org/r/20181127161913.23863-7-dave.rodgman@arm.com
> Signed-off-by: Dave Rodgman <dave.rodgman@arm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Markus F.X.J. Oberhumer <markus@oberhumer.com>
> Cc: Matt Sealey <matt.sealey@arm.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <nitingupta910@gmail.com>
> Cc: Richard Purdie <rpurdie@openedhand.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Documentation/lzo.txt           |  35 ++++++++---
>  include/linux/lzo.h             |   2 +-
>  lib/lzo/lzo1x_compress.c        | 100 ++++++++++++++++++++++++++++----
>  lib/lzo/lzo1x_decompress_safe.c |  75 ++++++++++++++++--------
>  lib/lzo/lzodefs.h               |  12 +++-
>  5 files changed, 181 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/lzo.txt b/Documentation/lzo.txt
> index 6fa6a93d0949..306c60344ca7 100644
> --- a/Documentation/lzo.txt
> +++ b/Documentation/lzo.txt
> @@ -78,16 +78,30 @@ Description
>       is an implementation design choice independent on the algorithm or
>       encoding.
>  
> +Versions
> +
> +0: Original version
> +1: LZO-RLE
> +
> +Version 1 of LZO implements an extension to encode runs of zeros using run
> +length encoding. This improves speed for data with many zeros, which is a
> +common case for zram. This modifies the bitstream in a backwards compatible way
> +(v1 can correctly decompress v0 compressed data, but v0 cannot read v1 data).
> +
>  Byte sequences
>  ==============
>  
>    First byte encoding::
>  
> -      0..17   : follow regular instruction encoding, see below. It is worth
> -                noting that codes 16 and 17 will represent a block copy from
> -                the dictionary which is empty, and that they will always be
> +      0..16   : follow regular instruction encoding, see below. It is worth
> +                noting that code 16 will represent a block copy from the
> +                dictionary which is empty, and that it will always be
>                  invalid at this place.
>  
> +      17      : bitstream version. If the first byte is 17, the next byte
> +                gives the bitstream version. If the first byte is not 17,
> +                the bitstream version is 0.
> +
>        18..21  : copy 0..3 literals
>                  state = (byte - 17) = 0..3  [ copy <state> literals ]
>                  skip byte
> @@ -140,6 +154,11 @@ Byte sequences
>             state = S (copy S literals after this block)
>             End of stream is reached if distance == 16384
>  
> +        In version 1, this instruction is also used to encode a run of zeros if
> +        distance = 0xbfff, i.e. H = 1 and the D bits are all 1.
> +           In this case, it is followed by a fourth byte, X.
> +           run length = ((X << 3) | (0 0 0 0 0 L L L)) + 4.
> +
>        0 0 1 L L L L L  (32..63)
>             Copy of small block within 16kB distance (preferably less than 34B)
>             length = 2 + (L ?: 31 + (zero_bytes * 255) + non_zero_byte)
> @@ -165,7 +184,9 @@ Authors
>  =======
>  
>    This document was written by Willy Tarreau <w@1wt.eu> on 2014/07/19 during an
> -  analysis of the decompression code available in Linux 3.16-rc5. The code is
> -  tricky, it is possible that this document contains mistakes or that a few
> -  corner cases were overlooked. In any case, please report any doubt, fix, or
> -  proposed updates to the author(s) so that the document can be updated.
> +  analysis of the decompression code available in Linux 3.16-rc5, and updated
> +  by Dave Rodgman <dave.rodgman@arm.com> on 2018/10/30 to introduce run-length
> +  encoding. The code is tricky, it is possible that this document contains
> +  mistakes or that a few corner cases were overlooked. In any case, please
> +  report any doubt, fix, or proposed updates to the author(s) so that the
> +  document can be updated.
> diff --git a/include/linux/lzo.h b/include/linux/lzo.h
> index 2ae27cb89927..547a86c71e1b 100644
> --- a/include/linux/lzo.h
> +++ b/include/linux/lzo.h
> @@ -18,7 +18,7 @@
>  #define LZO1X_1_MEM_COMPRESS	(8192 * sizeof(unsigned short))
>  #define LZO1X_MEM_COMPRESS	LZO1X_1_MEM_COMPRESS
>  
> -#define lzo1x_worst_compress(x) ((x) + ((x) / 16) + 64 + 3)
> +#define lzo1x_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)
>  
>  /* This requires 'wrkmem' of size LZO1X_1_MEM_COMPRESS */
>  int lzo1x_1_compress(const unsigned char *src, size_t src_len,
> diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
> index 82fb5571ce5e..03834b99a5a1 100644
> --- a/lib/lzo/lzo1x_compress.c
> +++ b/lib/lzo/lzo1x_compress.c
> @@ -20,7 +20,7 @@
>  static noinline size_t
>  lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  		    unsigned char *out, size_t *out_len,
> -		    size_t ti, void *wrkmem)
> +		    size_t ti, void *wrkmem, signed char *state_offset)
>  {
>  	const unsigned char *ip;
>  	unsigned char *op;
> @@ -35,27 +35,85 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  	ip += ti < 4 ? 4 - ti : 0;
>  
>  	for (;;) {
> -		const unsigned char *m_pos;
> +		const unsigned char *m_pos = NULL;
>  		size_t t, m_len, m_off;
>  		u32 dv;
> +		u32 run_length = 0;
>  literal:
>  		ip += 1 + ((ip - ii) >> 5);
>  next:
>  		if (unlikely(ip >= ip_end))
>  			break;
>  		dv = get_unaligned_le32(ip);
> -		t = ((dv * 0x1824429d) >> (32 - D_BITS)) & D_MASK;
> -		m_pos = in + dict[t];
> -		dict[t] = (lzo_dict_t) (ip - in);
> -		if (unlikely(dv != get_unaligned_le32(m_pos)))
> -			goto literal;
> +
> +		if (dv == 0) {
> +			const unsigned char *ir = ip + 4;
> +			const unsigned char *limit = ip_end
> +				< (ip + MAX_ZERO_RUN_LENGTH + 1)
> +				? ip_end : ip + MAX_ZERO_RUN_LENGTH + 1;
> +#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && \
> +	defined(LZO_FAST_64BIT_MEMORY_ACCESS)
> +			u64 dv64;
> +
> +			for (; (ir + 32) <= limit; ir += 32) {
> +				dv64 = get_unaligned((u64 *)ir);
> +				dv64 |= get_unaligned((u64 *)ir + 1);
> +				dv64 |= get_unaligned((u64 *)ir + 2);
> +				dv64 |= get_unaligned((u64 *)ir + 3);
> +				if (dv64)
> +					break;
> +			}
> +			for (; (ir + 8) <= limit; ir += 8) {
> +				dv64 = get_unaligned((u64 *)ir);
> +				if (dv64) {
> +#  if defined(__LITTLE_ENDIAN)
> +					ir += __builtin_ctzll(dv64) >> 3;
> +#  elif defined(__BIG_ENDIAN)
> +					ir += __builtin_clzll(dv64) >> 3;
> +#  else
> +#    error "missing endian definition"
> +#  endif
> +					break;
> +				}
> +			}
> +#else
> +			while ((ir < (const unsigned char *)
> +					ALIGN((uintptr_t)ir, 4)) &&
> +					(ir < limit) && (*ir == 0))
> +				ir++;
> +			for (; (ir + 4) <= limit; ir += 4) {
> +				dv = *((u32 *)ir);
> +				if (dv) {
> +#  if defined(__LITTLE_ENDIAN)
> +					ir += __builtin_ctz(dv) >> 3;
> +#  elif defined(__BIG_ENDIAN)
> +					ir += __builtin_clz(dv) >> 3;
> +#  else
> +#    error "missing endian definition"
> +#  endif
> +					break;
> +				}
> +			}
> +#endif
> +			while (likely(ir < limit) && unlikely(*ir == 0))
> +				ir++;
> +			run_length = ir - ip;
> +			if (run_length > MAX_ZERO_RUN_LENGTH)
> +				run_length = MAX_ZERO_RUN_LENGTH;
> +		} else {
> +			t = ((dv * 0x1824429d) >> (32 - D_BITS)) & D_MASK;
> +			m_pos = in + dict[t];
> +			dict[t] = (lzo_dict_t) (ip - in);
> +			if (unlikely(dv != get_unaligned_le32(m_pos)))
> +				goto literal;
> +		}
>  
>  		ii -= ti;
>  		ti = 0;
>  		t = ip - ii;
>  		if (t != 0) {
>  			if (t <= 3) {
> -				op[-2] |= t;
> +				op[*state_offset] |= t;
>  				COPY4(op, ii);
>  				op += t;
>  			} else if (t <= 16) {
> @@ -86,6 +144,17 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  			}
>  		}
>  
> +		if (unlikely(run_length)) {
> +			ip += run_length;
> +			run_length -= MIN_ZERO_RUN_LENGTH;
> +			put_unaligned_le32((run_length << 21) | 0xfffc18
> +					   | (run_length & 0x7), op);
> +			op += 4;
> +			run_length = 0;
> +			*state_offset = -3;
> +			goto finished_writing_instruction;
> +		}
> +
>  		m_len = 4;
>  		{
>  #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && defined(LZO_USE_CTZ64)
> @@ -168,7 +237,6 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  
>  		m_off = ip - m_pos;
>  		ip += m_len;
> -		ii = ip;
>  		if (m_len <= M2_MAX_LEN && m_off <= M2_MAX_OFFSET) {
>  			m_off -= 1;
>  			*op++ = (((m_len - 1) << 5) | ((m_off & 7) << 2));
> @@ -205,6 +273,9 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
>  			*op++ = (m_off << 2);
>  			*op++ = (m_off >> 6);
>  		}
> +		*state_offset = -2;
> +finished_writing_instruction:
> +		ii = ip;
>  		goto next;
>  	}
>  	*out_len = op - out;
> @@ -219,6 +290,12 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
>  	unsigned char *op = out;
>  	size_t l = in_len;
>  	size_t t = 0;
> +	signed char state_offset = -2;
> +
> +	// LZO v0 will never write 17 as first byte,
> +	// so this is used to version the bitstream
> +	*op++ = 17;
> +	*op++ = LZO_VERSION;
>  
>  	while (l > 20) {
>  		size_t ll = l <= (M4_MAX_OFFSET + 1) ? l : (M4_MAX_OFFSET + 1);
> @@ -227,7 +304,8 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
>  			break;
>  		BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
>  		memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
> -		t = lzo1x_1_do_compress(ip, ll, op, out_len, t, wrkmem);
> +		t = lzo1x_1_do_compress(ip, ll, op, out_len,
> +					t, wrkmem, &state_offset);
>  		ip += ll;
>  		op += *out_len;
>  		l  -= ll;
> @@ -240,7 +318,7 @@ int lzo1x_1_compress(const unsigned char *in, size_t in_len,
>  		if (op == out && t <= 238) {
>  			*op++ = (17 + t);
>  		} else if (t <= 3) {
> -			op[-2] |= t;
> +			op[state_offset] |= t;
>  		} else if (t <= 18) {
>  			*op++ = (t - 3);
>  		} else {
> diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_safe.c
> index aa95d3066b7d..b8f88d5ea3ff 100644
> --- a/lib/lzo/lzo1x_decompress_safe.c
> +++ b/lib/lzo/lzo1x_decompress_safe.c
> @@ -46,11 +46,23 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
>  	const unsigned char * const ip_end = in + in_len;
>  	unsigned char * const op_end = out + *out_len;
>  
> +	unsigned char bitstream_version;
> +
>  	op = out;
>  	ip = in;
>  
>  	if (unlikely(in_len < 3))
>  		goto input_overrun;
> +
> +	if (likely(*ip == 17)) {
> +		bitstream_version = ip[1];
> +		ip += 2;
> +		if (unlikely(in_len < 5))
> +			goto input_overrun;
> +	} else {
> +		bitstream_version = 0;
> +	}
> +
>  	if (*ip > 17) {
>  		t = *ip++ - 17;
>  		if (t < 4) {
> @@ -151,32 +163,49 @@ int lzo1x_decompress_safe(const unsigned char *in, size_t in_len,
>  			m_pos -= next >> 2;
>  			next &= 3;
>  		} else {
> -			m_pos = op;
> -			m_pos -= (t & 8) << 11;
> -			t = (t & 7) + (3 - 1);
> -			if (unlikely(t == 2)) {
> -				size_t offset;
> -				const unsigned char *ip_last = ip;
> +			NEED_IP(2);
> +			next = get_unaligned_le16(ip);
> +			if (((next & 0xfffc) == 0xfffc) &&
> +			    ((t & 0xf8) == 0x18) &&
> +			    likely(bitstream_version)) {
> +				NEED_IP(3);
> +				t &= 7;
> +				t |= ip[2] << 3;
> +				t += MIN_ZERO_RUN_LENGTH;
> +				NEED_OP(t);
> +				memset(op, 0, t);
> +				op += t;
> +				next &= 3;
> +				ip += 3;
> +				goto match_next;
> +			} else {
> +				m_pos = op;
> +				m_pos -= (t & 8) << 11;
> +				t = (t & 7) + (3 - 1);
> +				if (unlikely(t == 2)) {
> +					size_t offset;
> +					const unsigned char *ip_last = ip;
>  
> -				while (unlikely(*ip == 0)) {
> -					ip++;
> -					NEED_IP(1);
> -				}
> -				offset = ip - ip_last;
> -				if (unlikely(offset > MAX_255_COUNT))
> -					return LZO_E_ERROR;
> +					while (unlikely(*ip == 0)) {
> +						ip++;
> +						NEED_IP(1);
> +					}
> +					offset = ip - ip_last;
> +					if (unlikely(offset > MAX_255_COUNT))
> +						return LZO_E_ERROR;
>  
> -				offset = (offset << 8) - offset;
> -				t += offset + 7 + *ip++;
> -				NEED_IP(2);
> +					offset = (offset << 8) - offset;
> +					t += offset + 7 + *ip++;
> +					NEED_IP(2);
> +					next = get_unaligned_le16(ip);
> +				}
> +				ip += 2;
> +				m_pos -= next >> 2;
> +				next &= 3;
> +				if (m_pos == op)
> +					goto eof_found;
> +				m_pos -= 0x4000;
>  			}
> -			next = get_unaligned_le16(ip);
> -			ip += 2;
> -			m_pos -= next >> 2;
> -			next &= 3;
> -			if (m_pos == op)
> -				goto eof_found;
> -			m_pos -= 0x4000;
>  		}
>  		TEST_LB(m_pos);
>  #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> diff --git a/lib/lzo/lzodefs.h b/lib/lzo/lzodefs.h
> index 06fa83a38e0a..682359058b3c 100644
> --- a/lib/lzo/lzodefs.h
> +++ b/lib/lzo/lzodefs.h
> @@ -13,6 +13,12 @@
>   */
>  
>  
> +/* Version
> + * 0: original lzo version
> + * 1: lzo with support for RLE
> + */
> +#define LZO_VERSION 1
> +
>  #define COPY4(dst, src)	\
>  		put_unaligned(get_unaligned((const u32 *)(src)), (u32 *)(dst))
>  #if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> @@ -31,6 +37,7 @@
>  #elif defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
>  #define LZO_USE_CTZ64	1
>  #define LZO_USE_CTZ32	1
> +#define LZO_FAST_64BIT_MEMORY_ACCESS
>  #elif defined(CONFIG_X86) || defined(CONFIG_PPC)
>  #define LZO_USE_CTZ32	1
>  #elif defined(CONFIG_ARM)
> @@ -45,7 +52,7 @@
>  #define M1_MAX_OFFSET	0x0400
>  #define M2_MAX_OFFSET	0x0800
>  #define M3_MAX_OFFSET	0x4000
> -#define M4_MAX_OFFSET	0xbfff
> +#define M4_MAX_OFFSET	0xbffe
>  
>  #define M1_MIN_LEN	2
>  #define M1_MAX_LEN	2
> @@ -61,6 +68,9 @@
>  #define M3_MARKER	32
>  #define M4_MARKER	16
>  
> +#define MIN_ZERO_RUN_LENGTH	4
> +#define MAX_ZERO_RUN_LENGTH	(2047 + MIN_ZERO_RUN_LENGTH)
> +
>  #define lzo_dict_t      unsigned short
>  #define D_BITS		13
>  #define D_SIZE		(1u << D_BITS)
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
