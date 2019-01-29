Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F30C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2215C2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfA2Xea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:34:30 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.212]:14409 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfA2Xea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:34:30 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id CFB4B400D31F7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:34:28 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id octggFWM42qH7octggqK3m; Tue, 29 Jan 2019 17:34:28 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=54974 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1goctg-0037cW-1C; Tue, 29 Jan 2019 17:34:28 -0600
Date:   Tue, 29 Jan 2019 17:34:26 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] lib: zstd: Mark expected switch fall-throughs
Message-ID: <20190129233426.GA7999@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1goctg-0037cW-1C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:54974
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

lib/zstd/bitstream.h:261:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/bitstream.h:262:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/bitstream.h:263:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/bitstream.h:264:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/bitstream.h:265:30: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/compress.c:3183:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/decompress.c:1770:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/decompress.c:2376:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/decompress.c:2404:15: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/decompress.c:2435:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
lib/zstd/huf_compress.c: In function ‘HUF_compress1X_usingCTable’:
lib/zstd/huf_compress.c:535:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
  if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 4 + 7) \
     ^
lib/zstd/huf_compress.c:558:54: note: in expansion of macro ‘HUF_FLUSHBITS_2’
  case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(&bitC);
                                                      ^~~~~~~~~~~~~~~
lib/zstd/huf_compress.c:559:2: note: here
  case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
  ^~~~
lib/zstd/huf_compress.c:531:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
  if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 2 + 7) \
     ^
lib/zstd/huf_compress.c:559:54: note: in expansion of macro ‘HUF_FLUSHBITS_1’
  case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
                                                      ^~~~~~~~~~~~~~~
lib/zstd/huf_compress.c:560:2: note: here
  case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&bitC);
  ^~~~
  AR      lib/zstd//built-in.a

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 lib/zstd/bitstream.h    | 5 +++++
 lib/zstd/compress.c     | 1 +
 lib/zstd/decompress.c   | 5 ++++-
 lib/zstd/huf_compress.c | 2 ++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/zstd/bitstream.h b/lib/zstd/bitstream.h
index a826b99e1d63..3a49784d5c61 100644
--- a/lib/zstd/bitstream.h
+++ b/lib/zstd/bitstream.h
@@ -259,10 +259,15 @@ ZSTD_STATIC size_t BIT_initDStream(BIT_DStream_t *bitD, const void *srcBuffer, s
 		bitD->bitContainer = *(const BYTE *)(bitD->start);
 		switch (srcSize) {
 		case 7: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[6]) << (sizeof(bitD->bitContainer) * 8 - 16);
+			/* fall through */
 		case 6: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[5]) << (sizeof(bitD->bitContainer) * 8 - 24);
+			/* fall through */
 		case 5: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[4]) << (sizeof(bitD->bitContainer) * 8 - 32);
+			/* fall through */
 		case 4: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[3]) << 24;
+			/* fall through */
 		case 3: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[2]) << 16;
+			/* fall through */
 		case 2: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[1]) << 8;
 		default:;
 		}
diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index f9166cf4f7a9..5e0b67003e55 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -3182,6 +3182,7 @@ static size_t ZSTD_compressStream_generic(ZSTD_CStream *zcs, void *dst, size_t *
 				zcs->outBuffFlushedSize = 0;
 				zcs->stage = zcss_flush; /* pass-through to flush stage */
 			}
+			/* fall through */
 
 		case zcss_flush: {
 			size_t const toFlush = zcs->outBuffContentSize - zcs->outBuffFlushedSize;
diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
index b17846725ca0..269ee9a796c1 100644
--- a/lib/zstd/decompress.c
+++ b/lib/zstd/decompress.c
@@ -1768,6 +1768,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity, c
 			return 0;
 		}
 		dctx->expected = 0; /* not necessary to copy more */
+		/* fall through */
 
 	case ZSTDds_decodeFrameHeader:
 		memcpy(dctx->headerBuffer + ZSTD_frameHeaderSize_prefix, src, dctx->expected);
@@ -2375,7 +2376,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 			}
 			zds->stage = zdss_read;
 		}
-		/* pass-through */
+		/* fall through */
 
 		case zdss_read: {
 			size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
@@ -2404,6 +2405,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 			zds->stage = zdss_load;
 			/* pass-through */
 		}
+		/* fall through */
 
 		case zdss_load: {
 			size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
@@ -2436,6 +2438,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 				/* pass-through */
 			}
 		}
+		/* fall through */
 
 		case zdss_flush: {
 			size_t const toFlushSize = zds->outEnd - zds->outStart;
diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
index 40055a7016e6..e727812d12aa 100644
--- a/lib/zstd/huf_compress.c
+++ b/lib/zstd/huf_compress.c
@@ -556,7 +556,9 @@ size_t HUF_compress1X_usingCTable(void *dst, size_t dstSize, const void *src, si
 	n = srcSize & ~3; /* join to mod 4 */
 	switch (srcSize & 3) {
 	case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(&bitC);
+		/* fall through */
 	case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
+		/* fall through */
 	case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&bitC);
 	case 0:
 	default:;
-- 
2.20.1

