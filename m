Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F665C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE213208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=net.com.org.es header.i=@net.com.org.es header.b="RMpLYaYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE213208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net.com.org.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeKOKdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:33:00 -0500
Received: from delany.relativists.org ([176.31.98.17]:52764 "EHLO
        delany.relativists.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeKOKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:32:56 -0500
Received: from geertz.rel (geertz.rel [192.168.82.3])
        by delany.relativists.org (Postfix) with ESMTPSA id 7FDCE2AD;
        Wed, 14 Nov 2018 21:27:21 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=net.com.org.es;
        s=delany-v1; t=1542241642;
        bh=WbwERtiRBKkIMEcQtOTwDPsfNlJpfJdjI7n4MinHCFE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
         From;
        b=RMpLYaYAn4QBqz7Uf1R8vFn0ix6fE9TZhlq7mqpPgweBo3XErCQWUVmhjSYsfj0RG
         J48nkXR88kT+o08gHnZj+ghFBan1iumDlP8WAZ7qVUuguZNP6zcs2cv/wcTBB7YbuV
         ijOgDu2YRDpR29tp7jLTSQc1gRsRR31hs/1veI4I=
Received: by geertz.rel (Postfix, from userid 1000)
        id 62E438006C; Wed, 14 Nov 2018 21:27:19 -0300 (-03)
From:   =?UTF-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Chris Mason <clm@fb.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/zstd: mark several internal functions as static
Date:   Wed, 14 Nov 2018 21:27:18 -0300
Message-Id: <0ba48478013532f20856dca7d90c343d93901d54.1542240915.git.dato@net.com.org.es>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences -Wmissing-prototypes.

Signed-off-by: Adeodato Simó <dato@net.com.org.es>
---
It was suggested in the kernel-janitors mailing list that silencing
-Wmissing-prototypes would make for a worthy cause.

    https://www.spinics.net/lists/linux-kernel-janitors/msg43981.html

I know the original commit for zstd says (73f3d1b48f50):

> We would like to avoid as much further manual modification to the
> source code as possible, so it will be easier to keep the kernel
> zstd up to date.

so you may have to help me figure out if this is worth doing at this
stage. (I hope it is!)

Thanks for considering.

 lib/zstd/compress.c     |  7 +++++--
 lib/zstd/decompress.c   | 10 +++++-----
 lib/zstd/huf_compress.c |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index f9166cf4f7a9..3eee699e1fd6 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -2249,7 +2249,10 @@ void ZSTD_compressBlock_lazy_extDict_generic(ZSTD_CCtx *ctx, const void *src, si
 	}
 }
 
-void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize) { ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0); }
+static void ZSTD_compressBlock_greedy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
+{
+	ZSTD_compressBlock_lazy_extDict_generic(ctx, src, srcSize, 0, 0);
+}
 
 static void ZSTD_compressBlock_lazy_extDict(ZSTD_CCtx *ctx, const void *src, size_t srcSize)
 {
@@ -2979,7 +2982,7 @@ size_t ZSTD_CStreamWorkspaceBound(ZSTD_compressionParameters cParams)
 	return ZSTD_CCtxWorkspaceBound(cParams) + ZSTD_ALIGN(sizeof(ZSTD_CStream)) + ZSTD_ALIGN(inBuffSize) + ZSTD_ALIGN(outBuffSize);
 }
 
-ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
+static ZSTD_CStream *ZSTD_createCStream_advanced(ZSTD_customMem customMem)
 {
 	ZSTD_CStream *zcs;
 
diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
index b17846725ca0..ead0292be308 100644
--- a/lib/zstd/decompress.c
+++ b/lib/zstd/decompress.c
@@ -123,7 +123,7 @@ size_t ZSTD_decompressBegin(ZSTD_DCtx *dctx)
 	return 0;
 }
 
-ZSTD_DCtx *ZSTD_createDCtx_advanced(ZSTD_customMem customMem)
+static ZSTD_DCtx *ZSTD_createDCtx_advanced(ZSTD_customMem customMem)
 {
 	ZSTD_DCtx *dctx;
 
@@ -391,7 +391,7 @@ typedef struct {
 
 /*! ZSTD_getcBlockSize() :
 *   Provides the size of compressed block from block header `src` */
-size_t ZSTD_getcBlockSize(const void *src, size_t srcSize, blockProperties_t *bpPtr)
+static size_t ZSTD_getcBlockSize(const void *src, size_t srcSize, blockProperties_t *bpPtr)
 {
 	if (srcSize < ZSTD_blockHeaderSize)
 		return ERROR(srcSize_wrong);
@@ -429,7 +429,7 @@ static size_t ZSTD_setRleBlock(void *dst, size_t dstCapacity, const void *src, s
 
 /*! ZSTD_decodeLiteralsBlock() :
 	@return : nb of bytes read from src (< srcSize ) */
-size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx *dctx, const void *src, size_t srcSize) /* note : srcSize < BLOCKSIZE */
+static size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx *dctx, const void *src, size_t srcSize) /* note : srcSize < BLOCKSIZE */
 {
 	if (srcSize < MIN_CBLOCK_SIZE)
 		return ERROR(corruption_detected);
@@ -791,7 +791,7 @@ static size_t ZSTD_buildSeqTable(FSE_DTable *DTableSpace, const FSE_DTable **DTa
 	}
 }
 
-size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx *dctx, int *nbSeqPtr, const void *src, size_t srcSize)
+static size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx *dctx, int *nbSeqPtr, const void *src, size_t srcSize)
 {
 	const BYTE *const istart = (const BYTE *const)src;
 	const BYTE *const iend = istart + srcSize;
@@ -1494,7 +1494,7 @@ size_t ZSTD_insertBlock(ZSTD_DCtx *dctx, const void *blockStart, size_t blockSiz
 	return blockSize;
 }
 
-size_t ZSTD_generateNxBytes(void *dst, size_t dstCapacity, BYTE byte, size_t length)
+static size_t ZSTD_generateNxBytes(void *dst, size_t dstCapacity, BYTE byte, size_t length)
 {
 	if (length > dstCapacity)
 		return ERROR(dstSize_tooSmall);
diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
index 40055a7016e6..1f4bc4b010c6 100644
--- a/lib/zstd/huf_compress.c
+++ b/lib/zstd/huf_compress.c
@@ -79,7 +79,7 @@ unsigned HUF_optimalTableLog(unsigned maxTableLog, size_t srcSize, unsigned maxS
  * Note : all elements within weightTable are supposed to be <= HUF_TABLELOG_MAX.
  */
 #define MAX_FSE_TABLELOG_FOR_HUFF_HEADER 6
-size_t HUF_compressWeights_wksp(void *dst, size_t dstSize, const void *weightTable, size_t wtSize, void *workspace, size_t workspaceSize)
+static size_t HUF_compressWeights_wksp(void *dst, size_t dstSize, const void *weightTable, size_t wtSize, void *workspace, size_t workspaceSize)
 {
 	BYTE *const ostart = (BYTE *)dst;
 	BYTE *op = ostart;
-- 
2.19.1

