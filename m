Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9047720863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zQGOazaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9047720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbeK3Bln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:41:43 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:34232 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbeK3Bln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:41:43 -0500
Received: by mail-io1-f44.google.com with SMTP id f6so1757525iob.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BbMjSXvyEiVgTrfDLCRDKFqc3tlupVRo56Ow4AxVR70=;
        b=zQGOazaZu7YLHsl8b/c7pvg9/xaNVfd2aWj7kmeZWV4tdBxWa/j0yX2Wj8LoZVAK5r
         IBf/YiOWlcvSThHrh4iOq+k6YcFZlw9D/5EmeYpCvPQFwY8tLtHlpSg7s1c4IOeEA8IO
         zoNLQuRaaHhd8QjH7jVyBzUBbP3zc9Qlrq4SHi1j+r8mJGoASvplyg85oxKP0XWn+h9y
         LB5NhOiEp8RfLShCaKzlTwM+QBPO7Qt4Hw79QbdbgqGXmCxr4ECXGLdjXci1nYRSQ+8Y
         zlp9VMIPkuJ3SUYXHhiSU72MXATFwQ3IY+GtRjALLu2TXAwh0Ta2JMaco6ELQkgdE3UH
         qsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BbMjSXvyEiVgTrfDLCRDKFqc3tlupVRo56Ow4AxVR70=;
        b=AFy+k5ms/WV7Sz+N27VLBdSj/DIfkpdow+7NO+han7Etl6SMX/FU5wiLx86QVAT5ju
         /Mn2B6mxRALB3/Q3EVNWxoqYO1MN8csLJL6XwfJv6jt3HD99jBBVztqqzepFoxG1z4IK
         XVRY6FhUUgK2DYQNNbv5BMIXDHH75h7he2kAF5p8ormdTkQIjhdygUPhEMtgpa3bVVxg
         8J4arCT1CchH3GWjEdUUdPoYBEw/MIOP6RPSKqMwL4PSxIyzPciGpM1WYMOpaZAjr6ZK
         abXXvU2cItYbr2UctjfTUjf6XCHUlyVeSLOLiFlSRwhO7lufQdXaOGqNprxI4yKCgNYe
         sVFg==
X-Gm-Message-State: AA+aEWYsB1eUT1/b8kK0bvbubf1tdQy2OwNtxP5zcd8/H2qsDW1iT3r4
        KxgJUK4pVMTvM1s3nB1oibral1u0WU+tnivKfE0wBg==
X-Google-Smtp-Source: AFSGD/Ujfk/ZUXnrd0Etzbpo0gRA4YUfa7NwldI9+BB/QFp+rkP7lEBVM162UmwDfTd3sP8tbtr/bJ6f3TgRYCxVnCE=
X-Received: by 2002:a5e:8d13:: with SMTP id m19mr1389169ioj.258.1543502169066;
 Thu, 29 Nov 2018 06:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20181113140133.17385-1-brgl@bgdev.pl> <20181113140133.17385-2-brgl@bgdev.pl>
 <CAMRc=MeRJ60gcYz00C828PBqnEdC-9onOKOadfackdzHiC1WOA@mail.gmail.com> <b8f08722-d3d5-6ddf-5845-15eb5079094c@linaro.org>
In-Reply-To: <b8f08722-d3d5-6ddf-5845-15eb5079094c@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 29 Nov 2018 15:35:58 +0100
Message-ID: <CAMRc=Md4PbYDhmBNx5Rk5F9OZw2Om3D6F21iV6za-+dq0NshYw@mail.gmail.com>
Subject: Re: [PATCH v2 01/25] nvmem: add new config option
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 29 lis 2018 o 15:32 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
> >
> > Hi Srinivas,
> >
> > if there are no objections - can you Ack this patch for Greg to pick
> > up into char-misc?
>
> Patch is fine for me. I normally send all the nvmem patches just before r=
c5.
>
> --srini
> >
> > Bart
> >

Boris, are you fine with Srinivas sending the MTD patch as well so
that they stay together?

Bart
