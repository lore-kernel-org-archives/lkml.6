Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41522C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0570920818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i33tU8Ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0570920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeKJHzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:55:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41056 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeKJHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:55:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id g188-v6so2768118oif.8;
        Fri, 09 Nov 2018 14:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3TazYu5zm1v6Ve1U8ojkKqE2lybsI7vFy/T109l8pQ=;
        b=i33tU8ExcNCBucp89hhdlu/rZBfz9FDPPkbKT1SWpUhH0rvCK+IaToiAfb4Xz1Hr2H
         CEXOol9cTh5rMivzAdjApFgFO62VLc3PSNLHJiThr7kgjilp1+pBX3cDHWvroAfRdkFC
         AmJlDiHjhE0V9EqbgTbzByHeIr8PCpRvUYA+a1nTudeXXs8aXl+4Ip35QForak+RVB2r
         IkLhvMJOLhLZoFO8ypAB6jp7gb9jGIPmHpHImbN0HclnnA9zyRJtj2XM4UqCppDbwrwB
         UVjOmp+8kRwQ6yYob2No09aZbkyk8kV86EPOQ3SRgg2IS40Iy1uWHHLXn1QV89a+MiXI
         f9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3TazYu5zm1v6Ve1U8ojkKqE2lybsI7vFy/T109l8pQ=;
        b=QAqUwdq35KjBPwTK2WuRVjWEKkp3I3EiEDnuvoRw5azVdw1IaKSTIlzLleYLxntaeR
         X1j21jwqRmgc5JqiLFBsJ+e79TtlvT2pBTPpJFOqGMzsGxFE78pUclM3NhRYYIWcbjCe
         iAijVOEffAydZedVOLUb0A7uB3+4mpmIJWAh/aLQ8YvENEUqk+OXIETAhtpzBFyjuf4/
         UGjNHMKRH6oZifY4xU5+F8jpRcEk9NmFnad3FsC/PVERaRkVNQ9G5n76up7hfIbQ+iso
         sCGa5mSmT5WnJoD8dtQKvUoqPVDNHi04ysQEYUEVNL9MRFn+t1YhT3aZIw8hBh1dcG6V
         na3Q==
X-Gm-Message-State: AGRZ1gKYl9wQ+q9gsG6MtwlG2HjSnCg03SokV8HI2erx7KFY9iW32kNx
        F4Y95ZXhutuA+9YzvQa29P/UQht96lmsSd5x/MI=
X-Google-Smtp-Source: AJdET5dOF2NgRXlyRPhZgEQF2ElfCDY+biwtEHxXMMeWywvKZNYC0C8wxVLjs326uJqZniLVyxCGxA53sZRQHSKuRzQ=
X-Received: by 2002:aca:4d14:: with SMTP id a20-v6mr5699372oib.43.1541801591595;
 Fri, 09 Nov 2018 14:13:11 -0800 (PST)
MIME-Version: 1.0
References: <20181109220044.24843-1-matheus.bernardino@usp.br> <20181109220044.24843-6-matheus.bernardino@usp.br>
In-Reply-To: <20181109220044.24843-6-matheus.bernardino@usp.br>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 9 Nov 2018 20:13:05 -0200
Message-ID: <CAOMZO5DVr7TBoNtB7Bwjv1rpaCdOyg8+iU=iCwBRjSD4iWeBUw@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add SPDX license identifier
To:     matheus.bernardino@usp.br
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com, alexandru.ardelean@analog.com,
        victorcolombo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

On Fri, Nov 9, 2018 at 8:01 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> This patch adds the SPDX GPL-2.0-only license identifier to ad2s90.c,
> which solves the checkpatch.pl warning:
> "WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  drivers/staging/iio/resolver/ad2s90.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index 949ff55ac6b0..f439da721df8 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only

This should be:
// SPDX-License-Identifier: GPL-2.0
