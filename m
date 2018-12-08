Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844EFC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519982083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5k8dxxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519982083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLHS46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:56:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43050 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLHS46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:56:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so4384285qkr.10;
        Sat, 08 Dec 2018 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3+gtrZ67Yxyc72MwkXKY+SOxgD0IYq/zkilwBO7NEZI=;
        b=h5k8dxxkiaJkfnVup3qTaiL7i943iW030J1QhjexDJpeEpgyOUt50vPagpPaXu8zqY
         v8sce/9pdMjl/nly6CFsfIijuegPxGdBMgvkLtlJscSzohefP+nOMmHLoQk+BM/5bMsx
         mZEVA7I5EqduzCIQ7nINzfNTtkclAT6rwLt5WlX96gjqeirS5mq3A3r7M8ECeFcLw4p/
         LX+VXbO9FCsA88KoDvvM8qVv7RY5dNV+7ywHy1MW0o+wPq4HPSAbWKIwxE7gVBEsJZ3G
         CCo5gAEAh2pa8ddNOhs5q/ws6Pd12PNuW7pQ36EM6W7RZKaZExZ9CRkuQUYJPOuYJ7l8
         36mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3+gtrZ67Yxyc72MwkXKY+SOxgD0IYq/zkilwBO7NEZI=;
        b=AJsNILmT6pwgOo//reUdN2Fo4EMfdfMKtUNZ2xLsUweheYtjFIParHSPrnV6pl0udr
         rUlDbIHXBEi54I5njZnzul392JPFVqx3RpinUjomm4tWtV4YThft3Sl6mnsDWtDLW2Zk
         3zn0ltTlZn5rzfBcbQYQzvV7dZ33rg/xCra+bx5bvnD47UJU1KDpPw7WnkKotPY8JRbL
         MLbBhAIM8BovRRe33EGyHzWABXaLUgrfrKUH4br+t/7OoikdZ9zqCmgyIDfPlPAcKrDs
         3IbWkb48hTiNLQliS8vosdxh/BcOftzx26z7Ns6acI8ezheUHeaKgTMrali1+Dklf/PZ
         2mtg==
X-Gm-Message-State: AA+aEWZIDlH+O9pgCllq8DBt+MUaLuxodHO0RaPF7a+kyXWKJsqGna9N
        os5M0h7eQnNKn4NxVQm0oPTzUhGr2rxqbAx91LQ=
X-Google-Smtp-Source: AFSGD/UUnIxUPOLkXeCPs+SCeaOOnfTZ4xB+4/nqe1PYu9JkjD5qxDOTS4rTokrAqzpTbzgHG589WBGYVQnEurDEAPE=
X-Received: by 2002:a37:aa91:: with SMTP id t139mr5946951qke.139.1544295417093;
 Sat, 08 Dec 2018 10:56:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Date:   Sat, 8 Dec 2018 16:56:45 -0200
Message-ID: <CAAX=9sVrbu2U9go_d1G5=rGRa9AYT+betx9gyKWNXXU4adg4Bg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add devicetree support for ad5933
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of this work came from contributions of Alexandru Ardelean and
Dragos Bogdan, I and Gabriel would like to thank for the insights
provided by their previous patches. Maybe it would be the case to add
them as co-authors of this patch set.
We also wanted to thank Jhonatan Cameron for giving us the pieces of
advice needed for this work.

Thanks,
Marcelo

Em s=C3=A1b, 8 de dez de 2018 =C3=A0s 16:18, Marcelo Schmitt
<marcelo.schmitt1@gmail.com> escreveu:
>
> This series of patches change voltage regulator error handling for the
> ad5933.
> It also add an option to specify external clock reference using a clock
> framework and remove the old platform data structure.
> Finally it adds binding documentation for devicetree.
>
> Marcelo Schmitt (3):
>   staging: iio: ad5933: change regulator binging for vref
>   staging: iio: ad5933: use clock framework for clock reference
>   staging: iio: ad5933: add binding doc for ad5933
>
>  .../iio/impedance-analyzer/ad5933.txt         | 26 +++++++++
>  .../staging/iio/impedance-analyzer/ad5933.c   | 57 +++++++++----------
>  2 files changed, 54 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/impedance-analy=
zer/ad5933.txt
>
> --
> 2.17.1
>
