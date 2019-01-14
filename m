Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4635020657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvpnV7lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfANVYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:24:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39771 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfANVYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:24:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so443410oia.6;
        Mon, 14 Jan 2019 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xJ/ylT/19yqf+Ot3Aee8LaSfXMxQMuuJ5PmyBRGbruA=;
        b=uvpnV7lc9uS6VZ9ruXn2KvY062usNiEJ0gfJg2lUP7ZSTjbRLGCHY2VqnwRCDbA8Y9
         76adSIun/3m2Nz/s5sDnMQdE2IgSOxUm3siwSPjOKi9uF4le3Rf55OJ5KYWovIpzYbp8
         e+BffSMavR99vDSfkJnJ3KYSmSjMd0Ns/kdCTEnRQrt9jl1P0G6aTSNUB3c9pX3L/zGa
         7PsJ95RgTMXnOiCuGzjYgpNWte7hsCEP1LcXqtHy9H9l3M9hL4OQW9Tggx+R8acBJQpz
         3h9V2B5mmgTOZNJ/hqIKoSiiKaOsdo9xes9OZp4F4sLfEI5+cbohGHU2KACyoiODzyPQ
         CSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xJ/ylT/19yqf+Ot3Aee8LaSfXMxQMuuJ5PmyBRGbruA=;
        b=he7rOeNyIQofzZOc/rBeGNFVfUoJC3A5IwbFYM6TEsyN69OqHLRDNfNAViKSBqk12Q
         fn03pGZG5IXPC8qtbqvBO9wTfi1VrRxCg0hR99kUzoZ82+wOv6e7i0hLL7LMLyAH5od2
         7PnlbjYiyeGWo13QQEJfc0QGkVaQRA1y/f3rN9NxhCSmCJSMGLbf8Swz5cfvz+aBC9RN
         lU41CgIa3WHRiCWFajV1IgHpWZp8mqgwbhITFYXkig9RKZpn3ScRawvJDWonhDSoYHpM
         8Prt4FQvaoMcGhsXXy4/VI2uAhuXgmR2jaIP9aK3pgBSnVYvuqwbMpmT681b0VKioWqo
         78aA==
X-Gm-Message-State: AJcUukckIQK7IGIdTth+ehn4LvRMTotFUnlpDdIEDQrJMctX6xHruGnJ
        09woWM8EQNF6iqeB/9nzR3EyAsJdCSZWHhle0bo=
X-Google-Smtp-Source: ALg8bN5N4jDZxOfUbfmy3SVM+Qg9tXx2NRy+N+vGr+P7ImihHudriATHDu9nVTCFMBd460EiDlRKHo9SALR5f+/4pmg=
X-Received: by 2002:aca:6155:: with SMTP id v82mr230785oib.259.1547501042767;
 Mon, 14 Jan 2019 13:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20190110111535.11235-1-anders.roxell@linaro.org>
In-Reply-To: <20190110111535.11235-1-anders.roxell@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 14 Jan 2019 19:24:29 -0200
Message-ID: <CAOMZO5DGxXBCFbLgqeophv_Jw2nO5wiPXJXuth6CPEfSr9f9=w@mail.gmail.com>
Subject: Re: [PATCH] dma: ixm-dma: fix warning comparison of distinct pointer types
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On Thu, Jan 10, 2019 at 9:15 AM Anders Roxell <anders.roxell@linaro.org> wr=
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

There is a typo in the Subject: s/ixm/imx/ and the prefix should be
dmaengine instead:

dmaengine: imx-dma: fix warning comparison of distinct pointer types

With that fixed:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
