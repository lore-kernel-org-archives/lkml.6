Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012A3C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7716218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbfA3Xai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:30:38 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.62]:35986 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfA3Xah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:30:37 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id EAA5EEA9D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 17:30:35 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ozJTgaxDR90onozJTg0q7z; Wed, 30 Jan 2019 17:30:35 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=57884 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gozJT-0017Wf-KM; Wed, 30 Jan 2019 17:30:35 -0600
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20190129233426.GA7999@embeddedor>
 <CAGXu5jJVqbUdF6bVAQYuw9r8emzvy=oJFNJWxM-iSu-t3igeYw@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] lib: zstd: Mark expected switch fall-throughs
Message-ID: <ac8f9634-e298-3daa-e85d-c4b2478ee0a2@embeddedor.com>
Date:   Wed, 30 Jan 2019 17:30:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJVqbUdF6bVAQYuw9r8emzvy=oJFNJWxM-iSu-t3igeYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gozJT-0017Wf-KM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:57884
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/19 1:58 AM, Kees Cook wrote:
> On Wed, Jan 30, 2019 at 12:34 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warnings:
>>
>> lib/zstd/bitstream.h:261:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/bitstream.h:262:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/bitstream.h:263:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/bitstream.h:264:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/bitstream.h:265:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/compress.c:3183:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/decompress.c:1770:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/decompress.c:2376:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/decompress.c:2404:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/decompress.c:2435:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
>> lib/zstd/huf_compress.c: In function ‘HUF_compress1X_usingCTable’:
>> lib/zstd/huf_compress.c:535:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>   if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 4 + 7) \
>>      ^
>> lib/zstd/huf_compress.c:558:54: note: in expansion of macro ‘HUF_FLUSHBITS_2’
>>   case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(&bitC);
>>                                                       ^~~~~~~~~~~~~~~
>> lib/zstd/huf_compress.c:559:2: note: here
>>   case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
>>   ^~~~
>> lib/zstd/huf_compress.c:531:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>   if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 2 + 7) \
>>      ^
>> lib/zstd/huf_compress.c:559:54: note: in expansion of macro ‘HUF_FLUSHBITS_1’
>>   case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
>>                                                       ^~~~~~~~~~~~~~~
>> lib/zstd/huf_compress.c:560:2: note: here
>>   case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&bitC);
>>   ^~~~
>>   AR      lib/zstd//built-in.a
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  lib/zstd/bitstream.h    | 5 +++++
>>  lib/zstd/compress.c     | 1 +
>>  lib/zstd/decompress.c   | 5 ++++-
>>  lib/zstd/huf_compress.c | 2 ++
>>  4 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/zstd/bitstream.h b/lib/zstd/bitstream.h
>> index a826b99e1d63..3a49784d5c61 100644
>> --- a/lib/zstd/bitstream.h
>> +++ b/lib/zstd/bitstream.h
>> @@ -259,10 +259,15 @@ ZSTD_STATIC size_t BIT_initDStream(BIT_DStream_t *bitD, const void *srcBuffer, s
>>                 bitD->bitContainer = *(const BYTE *)(bitD->start);
>>                 switch (srcSize) {
>>                 case 7: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[6]) << (sizeof(bitD->bitContainer) * 8 - 16);
>> +                       /* fall through */
>>                 case 6: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[5]) << (sizeof(bitD->bitContainer) * 8 - 24);
>> +                       /* fall through */
>>                 case 5: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[4]) << (sizeof(bitD->bitContainer) * 8 - 32);
>> +                       /* fall through */
>>                 case 4: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[3]) << 24;
>> +                       /* fall through */
>>                 case 3: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[2]) << 16;
>> +                       /* fall through */
>>                 case 2: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[1]) << 8;
>>                 default:;
>>                 }
>> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
>> index f9166cf4f7a9..5e0b67003e55 100644
>> --- a/lib/zstd/compress.c
>> +++ b/lib/zstd/compress.c
>> @@ -3182,6 +3182,7 @@ static size_t ZSTD_compressStream_generic(ZSTD_CStream *zcs, void *dst, size_t *
>>                                 zcs->outBuffFlushedSize = 0;
>>                                 zcs->stage = zcss_flush; /* pass-through to flush stage */
>>                         }
>> +                       /* fall through */
> 
> Perhaps reword the existing comment and move it down?
> 
>>
>>                 case zcss_flush: {
>>                         size_t const toFlush = zcs->outBuffContentSize - zcs->outBuffFlushedSize;
>> diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
>> index b17846725ca0..269ee9a796c1 100644
>> --- a/lib/zstd/decompress.c
>> +++ b/lib/zstd/decompress.c
>> @@ -1768,6 +1768,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity, c
>>                         return 0;
>>                 }
>>                 dctx->expected = 0; /* not necessary to copy more */
>> +               /* fall through */
>>
>>         case ZSTDds_decodeFrameHeader:
>>                 memcpy(dctx->headerBuffer + ZSTD_frameHeaderSize_prefix, src, dctx->expected);
>> @@ -2375,7 +2376,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
>>                         }
>>                         zds->stage = zdss_read;
>>                 }
>> -               /* pass-through */
>> +               /* fall through */
>>
>>                 case zdss_read: {
>>                         size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
>> @@ -2404,6 +2405,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
>>                         zds->stage = zdss_load;
>>                         /* pass-through */
>>                 }
>> +               /* fall through */
> 
> Same ("pass-through" exists a couple lines up)
> 
>>
>>                 case zdss_load: {
>>                         size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
>> @@ -2436,6 +2438,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
>>                                 /* pass-through */
>>                         }
>>                 }
>> +               /* fall through */
> 
> Same

Yeah. The thing is that the pass-though comment is embedded in two nested blocks of code. And GCC triggers
a warning if the fall-through comments are not placed at the very bottom of the case statement (some people
dislike this 'feature').

That's the reason why I didn't want to change any of the pass-through comments, and instead added the
fall-through comments at the bottom of every case.

What do you think about this 'feature'?

> 
>>
>>                 case zdss_flush: {
>>                         size_t const toFlushSize = zds->outEnd - zds->outStart;
>> diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
>> index 40055a7016e6..e727812d12aa 100644
>> --- a/lib/zstd/huf_compress.c
>> +++ b/lib/zstd/huf_compress.c
>> @@ -556,7 +556,9 @@ size_t HUF_compress1X_usingCTable(void *dst, size_t dstSize, const void *src, si
>>         n = srcSize & ~3; /* join to mod 4 */
>>         switch (srcSize & 3) {
>>         case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(&bitC);
>> +               /* fall through */
>>         case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
>> +               /* fall through */
>>         case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&bitC);
>>         case 0:
>>         default:;
>> --
>> 2.20.1
>>
> 
> Otherwise, yup, looks good.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thanks

--
Gustavo
