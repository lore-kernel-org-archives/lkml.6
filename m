Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453DAC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0817921473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6aK/P9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfA3H6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:58:16 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34100 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3H6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:58:16 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so5157679vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2+V/2eP7cpSyDnC+qg1kCiKmtNthe2VPeFd4bfbfcck=;
        b=a6aK/P9rpzb7oLJuraIKlJoNCQmgUycg7IvJz7I94jRX+VhfV0PQxkdEltKk89FNJ5
         azdSeG2XXYt9+k69G0zWL3PMssGGTCSFG1q3y7PIQerqvn2AhoMFTeQo2Df8BTuuuxfq
         TAI0X8i36oQ60uj5yMnTXWpr8E9ZX8TbOLBl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+V/2eP7cpSyDnC+qg1kCiKmtNthe2VPeFd4bfbfcck=;
        b=TcTpMfojjjyNPfJO8YIvWFs5FQCJyTuk+lxa/2VApl3p99XoQtzBVdqtce/x+ODvm9
         6NvyrNJQJKY/Om2T259m0w79Y+A2MSbNXxKI2RavKMfmvlb+ar5mC8C6UohvUiwg0hAL
         aJHy+ncl5xuoFNEJP+1bjQ8SJGkaaO9I6CRiRQjcsnnCIrtwvqG0EKZOKAT6eKmfdA7V
         KEwXq8qIUPYe0WuOB+GdRboYSftaeMxUH0ZWUW9laBds3ZyLFDe6TOh6fRcZR1Tn94lY
         UfCkzA4e32++AJL4zO9nPQfK81O31xQIu6bEC9eKJLo1nNilIqj1TZDKlG0l4UsajeOp
         8epA==
X-Gm-Message-State: AJcUukeJQGR8kYY/cHIQxkROv7TW/T0uqv9oUf78VbH0uv15W3U4P1Je
        3Fulzw64Q8e4aMAStcDI6ihtH+9PT/4=
X-Google-Smtp-Source: ALg8bN45x1v7EydPV/A8zBn7LHAvyzw3ZCXDV4InQXetfakxy22Mj3KGNeUIfPpwAuDs18n9B9AnCw==
X-Received: by 2002:a1f:2f48:: with SMTP id v69mr12078563vkv.20.1548835094104;
        Tue, 29 Jan 2019 23:58:14 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id l197sm789378vke.18.2019.01.29.23.58.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 23:58:13 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id v24so7770727uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:58:12 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr12528245uac.122.1548835092521;
 Tue, 29 Jan 2019 23:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20190129233426.GA7999@embeddedor>
In-Reply-To: <20190129233426.GA7999@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 30 Jan 2019 20:58:00 +1300
X-Gmail-Original-Message-ID: <CAGXu5jJVqbUdF6bVAQYuw9r8emzvy=oJFNJWxM-iSu-t3igeYw@mail.gmail.com>
Message-ID: <CAGXu5jJVqbUdF6bVAQYuw9r8emzvy=oJFNJWxM-iSu-t3igeYw@mail.gmail.com>
Subject: Re: [PATCH] lib: zstd: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:34 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> lib/zstd/bitstream.h:261:30: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
> lib/zstd/bitstream.h:262:30: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
> lib/zstd/bitstream.h:263:30: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
> lib/zstd/bitstream.h:264:30: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
> lib/zstd/bitstream.h:265:30: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
> lib/zstd/compress.c:3183:16: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
> lib/zstd/decompress.c:1770:18: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
> lib/zstd/decompress.c:2376:15: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
> lib/zstd/decompress.c:2404:15: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
> lib/zstd/decompress.c:2435:16: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
> lib/zstd/huf_compress.c: In function =E2=80=98HUF_compress1X_usingCTable=
=E2=80=99:
> lib/zstd/huf_compress.c:535:5: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
>   if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 4 + 7) \
>      ^
> lib/zstd/huf_compress.c:558:54: note: in expansion of macro =E2=80=98HUF_=
FLUSHBITS_2=E2=80=99
>   case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(&bi=
tC);
>                                                       ^~~~~~~~~~~~~~~
> lib/zstd/huf_compress.c:559:2: note: here
>   case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bi=
tC);
>   ^~~~
> lib/zstd/huf_compress.c:531:5: warning: this statement may fall through [=
-Wimplicit-fallthrough=3D]
>   if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 2 + 7) \
>      ^
> lib/zstd/huf_compress.c:559:54: note: in expansion of macro =E2=80=98HUF_=
FLUSHBITS_1=E2=80=99
>   case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bi=
tC);
>                                                       ^~~~~~~~~~~~~~~
> lib/zstd/huf_compress.c:560:2: note: here
>   case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&bitC=
);
>   ^~~~
>   AR      lib/zstd//built-in.a
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enabling -Wimplicit-fallthro=
ugh.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  lib/zstd/bitstream.h    | 5 +++++
>  lib/zstd/compress.c     | 1 +
>  lib/zstd/decompress.c   | 5 ++++-
>  lib/zstd/huf_compress.c | 2 ++
>  4 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/lib/zstd/bitstream.h b/lib/zstd/bitstream.h
> index a826b99e1d63..3a49784d5c61 100644
> --- a/lib/zstd/bitstream.h
> +++ b/lib/zstd/bitstream.h
> @@ -259,10 +259,15 @@ ZSTD_STATIC size_t BIT_initDStream(BIT_DStream_t *b=
itD, const void *srcBuffer, s
>                 bitD->bitContainer =3D *(const BYTE *)(bitD->start);
>                 switch (srcSize) {
>                 case 7: bitD->bitContainer +=3D (size_t)(((const BYTE *)(=
srcBuffer))[6]) << (sizeof(bitD->bitContainer) * 8 - 16);
> +                       /* fall through */
>                 case 6: bitD->bitContainer +=3D (size_t)(((const BYTE *)(=
srcBuffer))[5]) << (sizeof(bitD->bitContainer) * 8 - 24);
> +                       /* fall through */
>                 case 5: bitD->bitContainer +=3D (size_t)(((const BYTE *)(=
srcBuffer))[4]) << (sizeof(bitD->bitContainer) * 8 - 32);
> +                       /* fall through */
>                 case 4: bitD->bitContainer +=3D (size_t)(((const BYTE *)(=
srcBuffer))[3]) << 24;
> +                       /* fall through */
>                 case 3: bitD->bitContainer +=3D (size_t)(((const BYTE *)(=
srcBuffer))[2]) << 16;
> +                       /* fall through */
>                 case 2: bitD->bitContainer +=3D (size_t)(((const BYTE *)(=
srcBuffer))[1]) << 8;
>                 default:;
>                 }
> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
> index f9166cf4f7a9..5e0b67003e55 100644
> --- a/lib/zstd/compress.c
> +++ b/lib/zstd/compress.c
> @@ -3182,6 +3182,7 @@ static size_t ZSTD_compressStream_generic(ZSTD_CStr=
eam *zcs, void *dst, size_t *
>                                 zcs->outBuffFlushedSize =3D 0;
>                                 zcs->stage =3D zcss_flush; /* pass-throug=
h to flush stage */
>                         }
> +                       /* fall through */

Perhaps reword the existing comment and move it down?

>
>                 case zcss_flush: {
>                         size_t const toFlush =3D zcs->outBuffContentSize =
- zcs->outBuffFlushedSize;
> diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
> index b17846725ca0..269ee9a796c1 100644
> --- a/lib/zstd/decompress.c
> +++ b/lib/zstd/decompress.c
> @@ -1768,6 +1768,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, voi=
d *dst, size_t dstCapacity, c
>                         return 0;
>                 }
>                 dctx->expected =3D 0; /* not necessary to copy more */
> +               /* fall through */
>
>         case ZSTDds_decodeFrameHeader:
>                 memcpy(dctx->headerBuffer + ZSTD_frameHeaderSize_prefix, =
src, dctx->expected);
> @@ -2375,7 +2376,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZST=
D_outBuffer *output, ZSTD_inB
>                         }
>                         zds->stage =3D zdss_read;
>                 }
> -               /* pass-through */
> +               /* fall through */
>
>                 case zdss_read: {
>                         size_t const neededInSize =3D ZSTD_nextSrcSizeToD=
ecompress(zds->dctx);
> @@ -2404,6 +2405,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZST=
D_outBuffer *output, ZSTD_inB
>                         zds->stage =3D zdss_load;
>                         /* pass-through */
>                 }
> +               /* fall through */

Same ("pass-through" exists a couple lines up)

>
>                 case zdss_load: {
>                         size_t const neededInSize =3D ZSTD_nextSrcSizeToD=
ecompress(zds->dctx);
> @@ -2436,6 +2438,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZST=
D_outBuffer *output, ZSTD_inB
>                                 /* pass-through */
>                         }
>                 }
> +               /* fall through */

Same

>
>                 case zdss_flush: {
>                         size_t const toFlushSize =3D zds->outEnd - zds->o=
utStart;
> diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
> index 40055a7016e6..e727812d12aa 100644
> --- a/lib/zstd/huf_compress.c
> +++ b/lib/zstd/huf_compress.c
> @@ -556,7 +556,9 @@ size_t HUF_compress1X_usingCTable(void *dst, size_t d=
stSize, const void *src, si
>         n =3D srcSize & ~3; /* join to mod 4 */
>         switch (srcSize & 3) {
>         case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS=
_2(&bitC);
> +               /* fall through */
>         case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS=
_1(&bitC);
> +               /* fall through */
>         case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS=
(&bitC);
>         case 0:
>         default:;
> --
> 2.20.1
>

Otherwise, yup, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

--=20
Kees Cook
