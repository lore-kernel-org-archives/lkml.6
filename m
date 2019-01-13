Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B72C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EEF20663
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="TOfZ3G/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfAMUN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:13:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53553 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAMUN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:13:56 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so10252744ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tBEaCQcsIQTc8v6Be/2Rjso4xya55Sm4Y5LoVasWh1k=;
        b=TOfZ3G/tzVZzTUjTji3MO0Mc/ZclNQccKN39Yl3KMAYkTgatbK1XMoZHInqS9pjxzV
         oQj//kxKOV66yqW4Eej5+vfluY5MT31GzV3nwqyXKnIYcoQm3IoAJXsBc/LjLIIR2nPj
         Uid9rRx58HFyOLjuL4F5IG7IyD75oaRzfje4aIHJOiulKt5xzJIivaxNkN60qEiklT5t
         hlRo8xdCzl61xUej6S9/VS5YEbedt6k/UtPPCgIRfscKs0kHjWHm10tUK2nAKQ1N13XA
         MpjFI/A7Ap3P+clGPRARkOpEzoQj2mWu1AmeAnfmHAnQC7UH800e7Me7RHKTco1/6c6G
         aNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tBEaCQcsIQTc8v6Be/2Rjso4xya55Sm4Y5LoVasWh1k=;
        b=iWheOrxFm/SxSZfi3D0cFSZPnQK/hCeOUtKGllGDUxzhgrcvej3+H+1jveRlnXJ1Hr
         eU1IOAgUitncawKD5tcXyk8IuzonBRx8+ehwY8yoaVIyrbalBHcj1S4gneWfcOMApuf7
         qi1SiPRpq78QlUngRn+RgOqUTvjJwzgdNqteqT+YE2NvSlR7QazG02/z+X6JjrBg2OkL
         qEXRHmli7SPMgD/MIvZYR2pbOlbrmIsYnJGFj7CaYX2GihXF5gKFsf/rNTPHacU3i0p5
         W5sFr8TM/Ec4SsHAl1pmisVLzzofu3fnwAoHfzcH2budANBPu/TlSEMcKiokT6yL6Rby
         1j4A==
X-Gm-Message-State: AJcUukckihIrFlbutFPWd36rBTgZnakUnYWb5qOx0Zv5EXKQYoX45njD
        CZauMKVTsq5LOqgBt/ogQgOHuDMdVJG35n/Ka/F61TJFBS4=
X-Google-Smtp-Source: ALg8bN7LSVkMEEwBogZ0IDhesKc+PXzLrwPtBlBOSdsHZSmrh7LR0F+M5n3CaXoqrS2nulvBEoH+j5w2BSkI6xI0ogA=
X-Received: by 2002:a02:63c9:: with SMTP id j192mr16187795jac.10.1547404551140;
 Sun, 13 Jan 2019 10:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20190110111535.11235-1-anders.roxell@linaro.org>
In-Reply-To: <20190110111535.11235-1-anders.roxell@linaro.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 13 Jan 2019 10:35:40 -0800
Message-ID: <CAOesGMjo1cj7nOABKTM8a+7o_z6c=sMXDfyxcxz7kvT861cnyw@mail.gmail.com>
Subject: Re: [PATCH] dma: ixm-dma: fix warning comparison of distinct pointer types
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 3:15 AM Anders Roxell <anders.roxell@linaro.org> wr=
ote:
>
> The warning got introduced by commit 930507c18304 ("arm64: add basic
> Kconfig symbols for i.MX8"). Since it got enabled for arm64. The warning
> haven't been seen before since size_t was 'unsigned int' when built on
> arm32.
>
> ../drivers/dma/imx-dma.c: In function =E2=80=98imxdma_sg_next=E2=80=99:
> ../include/linux/kernel.h:846:29: warning: comparison of distinct pointer=
 types lacks a cast
>    (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
>                              ^~
> ../include/linux/kernel.h:860:4: note: in expansion of macro =E2=80=98__t=
ypecheck=E2=80=99
>    (__typecheck(x, y) && __no_side_effects(x, y))
>     ^~~~~~~~~~~
> ../include/linux/kernel.h:870:24: note: in expansion of macro =E2=80=98__=
safe_cmp=E2=80=99
>   __builtin_choose_expr(__safe_cmp(x, y), \
>                         ^~~~~~~~~~
> ../include/linux/kernel.h:879:19: note: in expansion of macro =E2=80=98__=
careful_cmp=E2=80=99
>  #define min(x, y) __careful_cmp(x, y, <)
>                    ^~~~~~~~~~~~~
> ../drivers/dma/imx-dma.c:288:8: note: in expansion of macro =E2=80=98min=
=E2=80=99
>   now =3D min(d->len, sg_dma_len(sg));
>         ^~~
>
> Rework so that we use min_t and pass in the size_t that returns the
> minimum of two values, using the specified type.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

'now' should probably also be a size_t, but it can be done separately.
imxdma_sg_next()'s return value is never checked anywhere, so the
function can be changed to void as well.

That being said, I think this specific patch should go in now to keep
warnings out of our standard builds. The more we keep around, the
harder it is to spot when a new legitimate one shows up.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
