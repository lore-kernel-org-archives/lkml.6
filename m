Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCVE2m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 00:28:42 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40605 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeCVE2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 00:28:39 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180322042837epoutp016fefb4e972ecb3cb026be4b1dbfbab88~eI6VYRtHU1788217882epoutp01F
X-AuditID: b6c32a4a-de3ff70000001125-f2-5ab330f4b4f4
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] lz4: Implement lz4 with dynamic offset length.
Reply-To: maninder1.s@samsung.com
From: Maninder Singh <maninder1.s@samsung.com>
To: Yann Collet <cyan@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>, Vaneet Narang <v.narang@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180321195906.1260480-1-terrelln@fb.com>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180322042821epcms5p16b4dd6fc12a1563b5aea547f398dda40@epcms5p1>
Date: Thu, 22 Mar 2018 09:58:21 +0530
X-CMS-MailID: 20180322042821epcms5p16b4dd6fc12a1563b5aea547f398dda40
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180322042821epcms5p16b4dd6fc12a1563b5aea547f398dda40
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmpu4Xg81RBgd6dS0u7k612NqUZHH/
        3k8mi8u75rBZ3Huzlcni0YRJTBav/l1jszh0ci6jA4fHxOZ37B47Z91l9+jbsorR4/MmuQCW
        qFSbjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKAjlBTK
        EnNKgUIBicXFSvp2NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGRnomprFWRqZAJQmpGZfPz2Aq
        uDOVqeLn1YXsDYxn+pi6GDk4JARMJM6uKOhi5OIQEtjNKNG7exMjSJxXQFDi7w7hLkZODmEB
        d4n5k68wgthCAooSF2asASsRFjCQ+LVVAyTMJqAnsWrXHhYQW0QgXGLRlr1sICOZBWYxSSz7
        1ssMkpAQ4JWY0f6UBcKWlti+fCvYHE4Bc4ktzYUQYVGJPw0wJaIS74/NZ4SwRSRa752FGiMo
        8eDnbqi4jMTqzb0sILskBJoZJV4sbmGCcKYwSiw63soGUWUucf7kfLBuXgFfiUsntoHZLAKq
        Eqduz4Ga6iJx6ugvdhCbGejJKd0P2UGOYxbQlFi/Sx+iRFZi6ql1TBC2rcS6fXeYIcr5JHp/
        P2GC+XHHPBhbVaLl5gZWmH8/f/wI9ZiHxLm+s4wTGJVmIUJ6FpLFsxAWL2BkXsUomVpQnJue
        WmxaYJSXWq5XnJhbXJqXrpecn7uJEZwatbx2MC4753OIUYCDUYmHNyNnU5QQa2JZcWXuIUYJ
        DmYlEd5DmpujhHhTEiurUovy44tKc1KLDzGaAoNgIrOUaHI+MG3nlcQbmlgamJiZmRsaGFia
        KInzOga6RAkJpCeWpGanphakFsH0MXFwSjUwyj/+5K9VIhV96dOXXfOsnlTxbrn55ljUV5uJ
        LI5cj2evaXrbEPpl4y3flQozClqm3G2dbPXJdMPdR6Xmlh8/1DDuZ5sQtmnf6h7h9sfz/N79
        zE55aFJbuq1vzuO1049LdZ1StEg7bSBpLjFTvnKd+bkfAeuZLauuiP9QP7nwT27AlMjqN5l7
        CpRYijMSDbWYi4oTAX1nReujAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321195916epcas4p1e89e1cc5fd242ee8c348f92f1d1740b0
X-RootMTR: 20180321195916epcas4p1e89e1cc5fd242ee8c348f92f1d1740b0
References: <20180321195906.1260480-1-terrelln@fb.com>
        <1521607242-3968-2-git-send-email-maninder1.s@samsung.com>
        <CGME20180321195916epcas4p1e89e1cc5fd242ee8c348f92f1d1740b0@epcms5p1>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2M4TWrH010440

CC: Vaneet Narang.

 
On (03/21/18 10:10), Maninder Singh wrote:
> diff --git a/lib/lz4/lz4_compress.c b/lib/lz4/lz4_compress.c
> index cc7b6d4..185c358 100644
> --- a/lib/lz4/lz4_compress.c
> +++ b/lib/lz4/lz4_compress.c
> @@ -183,7 +183,8 @@ static FORCE_INLINE int LZ4_compress_generic(
>          const tableType_t tableType,
>          const dict_directive dict,
>          const dictIssue_directive dictIssue,
> -        const U32 acceleration)
> +        const U32 acceleration,
> +        const Dynamic_Offset dynOffset)
>  {
>          const BYTE *ip = (const BYTE *) source;
>          const BYTE *base;
> @@ -199,6 +200,7 @@ static FORCE_INLINE int LZ4_compress_generic(
>
>          BYTE *op = (BYTE *) dest;
>          BYTE * const olimit = op + maxOutputSize;
> +        int max_distance = dynOffset ? MAX_DISTANCE_DYN : MAX_DISTANCE;
 
Lets mark this variable `const`. If the compiler doesn't realize that this
variable and `dynOffset` are compile time constants, I expect the speed to
be impacted.
 
>
>          U32 forwardH;
>          size_t refDelta = 0;
> @@ -245,6 +247,7 @@ static FORCE_INLINE int LZ4_compress_generic(
>          for ( ; ; ) {
>                  const BYTE *match;
>                  BYTE *token;
> +                int curr_offset;
>
>                  /* Find a match */
>                  {
> @@ -285,7 +288,7 @@ static FORCE_INLINE int LZ4_compress_generic(
>                                          : 0)
>                                  || ((tableType == byU16)
>                                          ? 0
> -                                        : (match + MAX_DISTANCE < ip))
> +                                        : (match + max_distance < ip))
>                                  || (LZ4_read32(match + refDelta)
>                                          != LZ4_read32(ip)));
>                  }
> @@ -328,8 +331,26 @@ static FORCE_INLINE int LZ4_compress_generic(
>
>  _next_match:
>                  /* Encode Offset */
> -                LZ4_writeLE16(op, (U16)(ip - match));
> -                op += 2;
> +                if (dynOffset) {
> +                        curr_offset = (U16)(ip - match);
> +
> +                        /*
> +                         * If Ofsset is greater than 127, we need 2 bytes
> +                         * to store it. Otherwise 1 byte is enough.
> +                         */
> +                        if (curr_offset > 127) {
> +                                curr_offset = (curr_offset << 1) | DYN_BIT;
> +                                LZ4_writeLE16(op, (U16)curr_offset);
> +                                op += 2;
> +                        } else {
> +                                curr_offset = curr_offset << 1;
> +                                *op = (BYTE)curr_offset;
> +                                op++;
> +                        }
 
The standard way to do variable sized integers is to use the high-bit as
the control bit, not the low-bit. Do you have benchmarks to show that using
the low-bit is faster than using the high-bit? If so, lets comment in the
code, if not lets use the high-bit.
 
> +                } else {
> +                        LZ4_writeLE16(op, (U16)(ip - match));
> +                        op += 2;
> +                }
>
>                  /* Encode MatchLength */
>                  {
> @@ -480,39 +501,70 @@ static int LZ4_compress_fast_extState(
>                          return LZ4_compress_generic(ctx, source,
>                                  dest, inputSize, 0,
>                                  noLimit, byU16, noDict,
> -                                noDictIssue, acceleration);
> +                                noDictIssue, acceleration, NoDynOffset);
>                  else
>                          return LZ4_compress_generic(ctx, source,
>                                  dest, inputSize, 0,
>                                  noLimit, tableType, noDict,
> -                                noDictIssue, acceleration);
> +                                noDictIssue, acceleration, NoDynOffset);
>          } else {
>                  if (inputSize < LZ4_64Klimit)
>                          return LZ4_compress_generic(ctx, source,
>                                  dest, inputSize,
>                                  maxOutputSize, limitedOutput, byU16, noDict,
> -                                noDictIssue, acceleration);
> +                                noDictIssue, acceleration, NoDynOffset);
>                  else
>                          return LZ4_compress_generic(ctx, source,
>                                  dest, inputSize,
>                                  maxOutputSize, limitedOutput, tableType, noDict,
> -                                noDictIssue, acceleration);
> +                                noDictIssue, acceleration, NoDynOffset);
>          }
>  }
>
> +static int LZ4_compress_fast_extState_dynamic(
> +        void *state,
> +        const char *source,
> +        char *dest,
> +        int inputSize,
> +        int maxOutputSize,
> +        int acceleration)
> +{
> +        LZ4_stream_t_internal *ctx = &((LZ4_stream_t *)state)->internal_donotuse;
> +
> +        LZ4_resetStream((LZ4_stream_t *)state);
> +
> +        if (acceleration < 1)
> +                acceleration = LZ4_ACCELERATION_DEFAULT;
> +
> +        if (maxOutputSize >= LZ4_COMPRESSBOUND(inputSize))
> +                return LZ4_compress_generic(ctx, source,
> +                        dest, inputSize, 0,
> +                        noLimit, byU16, noDict,
> +                        noDictIssue, acceleration, DynOffset);
> +        else
> +                return LZ4_compress_generic(ctx, source,
> +                        dest, inputSize,
> +                        maxOutputSize, limitedOutput, byU16, noDict,
> +                        noDictIssue, acceleration, DynOffset);
> +}
> +
>  int LZ4_compress_fast(const char *source, char *dest, int inputSize,
> -        int maxOutputSize, int acceleration, void *wrkmem)
> +        int maxOutputSize, int acceleration, void *wrkmem, bool dynOffset)
>  {
> -        return LZ4_compress_fast_extState(wrkmem, source, dest, inputSize,
> +        if (!dynOffset)
> +                return LZ4_compress_fast_extState(wrkmem, source, dest, inputSize,
> +                        maxOutputSize, acceleration);
> +
> +        return LZ4_compress_fast_extState_dynamic(wrkmem, source, dest, inputSize,
>                  maxOutputSize, acceleration);
>  }
>  EXPORT_SYMBOL(LZ4_compress_fast);
>
>  int LZ4_compress_default(const char *source, char *dest, int inputSize,
> -        int maxOutputSize, void *wrkmem)
> +        int maxOutputSize, void *wrkmem, bool dynOffset)
>  {
>          return LZ4_compress_fast(source, dest, inputSize,
> -                maxOutputSize, LZ4_ACCELERATION_DEFAULT, wrkmem);
> +                maxOutputSize, LZ4_ACCELERATION_DEFAULT, wrkmem, dynOffset);
>  }
>  EXPORT_SYMBOL(LZ4_compress_default);
>
> @@ -900,12 +952,12 @@ int LZ4_compress_fast_continue(LZ4_stream_t *LZ4_stream, const char *source,
>                          result = LZ4_compress_generic(
>                                  streamPtr, source, dest, inputSize,
>                                  maxOutputSize, limitedOutput, byU32,
> -                                withPrefix64k, dictSmall, acceleration);
> +                                withPrefix64k, dictSmall, acceleration, NoDynOffset);
>                  } else {
>                          result = LZ4_compress_generic(
>                                  streamPtr, source, dest, inputSize,
>                                  maxOutputSize, limitedOutput, byU32,
> -                                withPrefix64k, noDictIssue, acceleration);
> +                                withPrefix64k, noDictIssue, acceleration, NoDynOffset);
>                  }
>                  streamPtr->dictSize += (U32)inputSize;
>                  streamPtr->currentOffset += (U32)inputSize;
> @@ -921,12 +973,12 @@ int LZ4_compress_fast_continue(LZ4_stream_t *LZ4_stream, const char *source,
>                          result = LZ4_compress_generic(
>                                  streamPtr, source, dest, inputSize,
>                                  maxOutputSize, limitedOutput, byU32,
> -                                usingExtDict, dictSmall, acceleration);
> +                                usingExtDict, dictSmall, acceleration, NoDynOffset);
>                  } else {
>                          result = LZ4_compress_generic(
>                                  streamPtr, source, dest, inputSize,
>                                  maxOutputSize, limitedOutput, byU32,
> -                                usingExtDict, noDictIssue, acceleration);
> +                                usingExtDict, noDictIssue, acceleration, NoDynOffset);
>                  }
>                  streamPtr->dictionary = (const BYTE *)source;
>                  streamPtr->dictSize = (U32)inputSize;
> diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
> index 141734d..337a828 100644
> --- a/lib/lz4/lz4_decompress.c
> +++ b/lib/lz4/lz4_decompress.c
> @@ -71,7 +71,9 @@ static FORCE_INLINE int LZ4_decompress_generic(
>           /* only if dict == usingExtDict */
>           const BYTE * const dictStart,
>           /* note : = 0 if noDict */
> -         const size_t dictSize
> +         const size_t dictSize,
> +         /* offset == 1; dynamic offset */
> +         const Dynamic_Offset dynOffset
>           )
>  {
>          /* Local Variables */
> @@ -141,8 +143,8 @@ static FORCE_INLINE int LZ4_decompress_generic(
>                  /* copy literals */
>                  cpy = op + length;
>                  if (((endOnInput) && ((cpy > (partialDecoding ? oexit : oend - MFLIMIT))
> -                        || (ip + length > iend - (2 + 1 + LASTLITERALS))))
> -                        || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH))) {
> +                        || (ip + length > iend - (2 + LASTLITERALS))))
> +                        || ((!endOnInput) && (cpy > oend - WILDCOPYLENGTH - 1))) {
>                          if (partialDecoding) {
>                                  if (cpy > oend) {
>                                          /*
> @@ -188,13 +190,31 @@ static FORCE_INLINE int LZ4_decompress_generic(
>                          break;
>                  }
>
> -                LZ4_wildCopy(op, ip, cpy);
> +                if (dynOffset && length < 4)
> +                        LZ4_copy4(op, ip);
> +                else
> +                        LZ4_wildCopy(op, ip, cpy);
> +
 
The LZ4 format enforces that the last 5 bytes are literals so that
LZ4_wildCopy() can be used here. I suspect that having this extra branch
here for `dynOffset` mode hurts decompression speed.
 
>                  ip += length;
>                  op = cpy;
>
>                  /* get offset */
> -                offset = LZ4_readLE16(ip);
> -                ip += 2;
> +                if (dynOffset) {
> +                        /*
> +                         * Check if DYN_BIT is set, means 2 Byte Offset,
> +                         * else 1 Byte Offset.
> +                         */
> +                        if (*ip & DYN_BIT) {
> +                                offset = LZ4_readLE16(ip) >> 1;
> +                                ip += 2;
> +                        } else {
> +                                offset = *ip >> 1;
> +                                ip += 1;
 
If we use the high-bit as the control bit, this branch simply becomes
`offset = *ip`, though the long offset branch becomes a bit longer.
 
> +                        }
> +                } else {
> +                        offset = LZ4_readLE16(ip);
> +                        ip += 2;
> +                }
>                  match = op - offset;
>
>                  if ((checkOffset) && (unlikely(match < lowLimit))) {
> @@ -335,11 +355,11 @@ static FORCE_INLINE int LZ4_decompress_generic(
>  }
>
>  int LZ4_decompress_safe(const char *source, char *dest,
> -        int compressedSize, int maxDecompressedSize)
> +        int compressedSize, int maxDecompressedSize, bool dynOffset)
>  {
>          return LZ4_decompress_generic(source, dest, compressedSize,
>                  maxDecompressedSize, endOnInputSize, full, 0,
> -                noDict, (BYTE *)dest, NULL, 0);
> +                noDict, (BYTE *)dest, NULL, 0, dynOffset);
 
You'll need to use the same trick that LZ4_compress_fast() uses, by hard
coding `dynOffset`. We want the compiler to generate too version of
LZ4_decompress_generic(), one with `dynOffset` and one with `!dynOffset`.
That way the tight loop won't the branches that check `dynOffset`.
 
        if (dynOffset)
                return LZ4_decompress_generic(..., true);
        else
                return LZ4_decompress_generic(..., false);
 
Without this trick, I expect that this patch causes a regression to both
LZ4 and LZ4_DYN decompression speed.
 
>  }
>
>  int LZ4_decompress_safe_partial(const char *source, char *dest,
> @@ -347,14 +367,14 @@ int LZ4_decompress_safe_partial(const char *source, char *dest,
>  {
>          return LZ4_decompress_generic(source, dest, compressedSize,
>                  maxDecompressedSize, endOnInputSize, partial,
> -                targetOutputSize, noDict, (BYTE *)dest, NULL, 0);
> +                targetOutputSize, noDict, (BYTE *)dest, NULL, 0, NoDynOffset);
>  }
>
>  int LZ4_decompress_fast(const char *source, char *dest, int originalSize)
>  {
>          return LZ4_decompress_generic(source, dest, 0, originalSize,
>                  endOnOutputSize, full, 0, withPrefix64k,
> -                (BYTE *)(dest - 64 * KB), NULL, 64 * KB);
> +                (BYTE *)(dest - 64 * KB), NULL, 64 * KB, NoDynOffset);
>  }
>
>  int LZ4_setStreamDecode(LZ4_streamDecode_t *LZ4_streamDecode,
> @@ -392,7 +412,7 @@ int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
>                          endOnInputSize, full, 0,
>                          usingExtDict, lz4sd->prefixEnd - lz4sd->prefixSize,
>                          lz4sd->externalDict,
> -                        lz4sd->extDictSize);
> +                        lz4sd->extDictSize, NoDynOffset);
>
>                  if (result <= 0)
>                          return result;
> @@ -406,7 +426,7 @@ int LZ4_decompress_safe_continue(LZ4_streamDecode_t *LZ4_streamDecode,
>                          compressedSize, maxOutputSize,
>                          endOnInputSize, full, 0,
>                          usingExtDict, (BYTE *)dest,
> -                        lz4sd->externalDict, lz4sd->extDictSize);
> +                        lz4sd->externalDict, lz4sd->extDictSize, NoDynOffset);
>                  if (result <= 0)
>                          return result;
>                  lz4sd->prefixSize = result;
> @@ -427,7 +447,7 @@ int LZ4_decompress_fast_continue(LZ4_streamDecode_t *LZ4_streamDecode,
>                          endOnOutputSize, full, 0,
>                          usingExtDict,
>                          lz4sd->prefixEnd - lz4sd->prefixSize,
> -                        lz4sd->externalDict, lz4sd->extDictSize);
> +                        lz4sd->externalDict, lz4sd->extDictSize, NoDynOffset);
>
>                  if (result <= 0)
>                          return result;
> @@ -440,7 +460,7 @@ int LZ4_decompress_fast_continue(LZ4_streamDecode_t *LZ4_streamDecode,
>                  result = LZ4_decompress_generic(source, dest, 0, originalSize,
>                          endOnOutputSize, full, 0,
>                          usingExtDict, (BYTE *)dest,
> -                        lz4sd->externalDict, lz4sd->extDictSize);
> +                        lz4sd->externalDict, lz4sd->extDictSize, NoDynOffset);
>                  if (result <= 0)
>                          return result;
>                  lz4sd->prefixSize = originalSize;
> @@ -463,19 +483,19 @@ static FORCE_INLINE int LZ4_decompress_usingDict_generic(const char *source,
>          if (dictSize == 0)
>                  return LZ4_decompress_generic(source, dest,
>                          compressedSize, maxOutputSize, safe, full, 0,
> -                        noDict, (BYTE *)dest, NULL, 0);
> +                        noDict, (BYTE *)dest, NULL, 0, NoDynOffset);
>          if (dictStart + dictSize == dest) {
>                  if (dictSize >= (int)(64 * KB - 1))
>                          return LZ4_decompress_generic(source, dest,
>                                  compressedSize, maxOutputSize, safe, full, 0,
> -                                withPrefix64k, (BYTE *)dest - 64 * KB, NULL, 0);
> +                                withPrefix64k, (BYTE *)dest - 64 * KB, NULL, 0, NoDynOffset);
>                  return LZ4_decompress_generic(source, dest, compressedSize,
>                          maxOutputSize, safe, full, 0, noDict,
> -                        (BYTE *)dest - dictSize, NULL, 0);
> +                        (BYTE *)dest - dictSize, NULL, 0, NoDynOffset);
>          }
>          return LZ4_decompress_generic(source, dest, compressedSize,
>                  maxOutputSize, safe, full, 0, usingExtDict,
> -                (BYTE *)dest, (const BYTE *)dictStart, dictSize);
> +                (BYTE *)dest, (const BYTE *)dictStart, dictSize, NoDynOffset);
>  }
>
>  int LZ4_decompress_safe_usingDict(const char *source, char *dest,
> diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
> index 00a0b58..9451a73 100644
> --- a/lib/lz4/lz4defs.h
> +++ b/lib/lz4/lz4defs.h
> @@ -75,6 +75,7 @@
>  #define WILDCOPYLENGTH 8
>  #define LASTLITERALS 5
>  #define MFLIMIT (WILDCOPYLENGTH + MINMATCH)
> +#define DYN_BIT 0x1
>
>  /* Increase this value ==> compression run slower on incompressible data */
>  #define LZ4_SKIPTRIGGER 6
> @@ -87,6 +88,7 @@
>
>  #define MAXD_LOG 16
>  #define MAX_DISTANCE ((1 << MAXD_LOG) - 1)
> +#define MAX_DISTANCE_DYN ((1 << (MAXD_LOG - 1)) - 1)
>  #define STEPSIZE sizeof(size_t)
>
>  #define ML_BITS        4
> @@ -147,6 +149,13 @@ static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
>  #endif
>  }
>
> +static FORCE_INLINE void LZ4_copy4(void *dst, const void *src)
> +{
> +        U32 a = get_unaligned((const U32 *)src);
> +
> +        put_unaligned(a, (U32 *)dst);
> +}
> +
>  /*
>   * customized variant of memcpy,
>   * which can overwrite up to 7 bytes beyond dstEnd
> @@ -224,4 +233,6 @@ static FORCE_INLINE unsigned int LZ4_count(
>  typedef enum { endOnOutputSize = 0, endOnInputSize = 1 } endCondition_directive;
>  typedef enum { full = 0, partial = 1 } earlyEnd_directive;
>
> +typedef enum { NoDynOffset = 0, DynOffset = 1 } Dynamic_Offset;
> +
>  #endif
> --
> 1.7.1
 
 
