Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0C5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A9F264EE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9qcBb1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A9F264EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935655AbeFZNSt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:18:49 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43419 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934063AbeFZNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:18:46 -0400
Received: by mail-vk0-f68.google.com with SMTP id d74-v6so9978054vke.10;
        Tue, 26 Jun 2018 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iUNLSbEqacKffS9XcCC8/Tdf0F5xPPIFvnNdromEtow=;
        b=Y9qcBb1pGQTqYxB4h06q7f/KbPTB5BYX7ulS7Nj9oG9VNT45ClluVlygBYaQm4cWc+
         Yb23a2H341Zb2idZ5mRx4nWkgwx0c96UOwN0vAAEOAW+gMfqIUwH9a21oDXcaxSNKc1+
         Dba/nArbOu3zythK1Rvn12eHdAJh/SvdvmUx/L730fzQ75xgmWzaWDV9c/8Pi7UVQLN2
         ER1F7JxXvGU8u9j9/ARVBofSZGi8Ke9xROe5Euxhf9Vxj6LCUVYTSxtYN01rhcgfXCPy
         mRz5aZ92qKwzaO3/f+Gd/Ot93jNAjLErNVa07rCaA84UE4sY6WmWKICyUQgSoeGVl31K
         zl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iUNLSbEqacKffS9XcCC8/Tdf0F5xPPIFvnNdromEtow=;
        b=Is9N3Xut3bGrxY1Wk1rfN0YfCyQRG841/xE2J0ha7QSDPawJRKAA7A/jLC7G3PEtAR
         2E1kOaVKNDNhrC2j6f4L4fHvJ4AJin/wXRviWU+2sypy2G1IlkEZRdzKFd+B2QMPOttT
         GCWKhaSi70P+ehj2MhdPW2GiDgyaGNofwAbBQwd6FmhJSZvF6Ra/W+jHLSXwkbYsfYB2
         JhCyEeRnzMJovIWRxUDiWmldftjY3wqdYYaT7/3T2GWWTMtc/VsvgR5tmWRpYTUAOXqg
         zL0bWjRS3tdn3ZnMVF/wFYXfmuVRqMkB/k6cwGVXJOR7qreqSwAbo6SHjdddtTLeuqt8
         /BLA==
X-Gm-Message-State: APt69E1jWEn+19ejLjojeIn/m6J2Af252Y3iu8C4z+wRX4E96Aj/Hj4A
        jwVjcq3C/70bGkFB8IjbrmHLfmwLeVPZRa4pMB8=
X-Google-Smtp-Source: AAOMgpewbVEqrHPbBny3MktmPsqusDSehXmr58Y87FvcF1M5eNEhDnZzEYo78lpzPYqYShd3ZpTppq8nWPviSvlhlKM=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr909984vkg.131.1530019125189;
 Tue, 26 Jun 2018 06:18:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 06:18:44
 -0700 (PDT)
In-Reply-To: <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com> <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 16:18:44 +0300
Message-ID: <CAHp75VfskABz+KrnLzDTYH=1cESimi++3HwQ2a1tiWkPTqf=HQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI controller
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 3:26 PM, Frieder Schrempf
<frieder.schrempf@exceet.de> wrote:
> On 08.06.2018 22:27, Andy Shevchenko wrote:
>> On Fri, Jun 8, 2018 at 2:54 PM, Yogesh Narayan Gaur
>> <yogeshnarayan.gaur@nxp.com> wrote:

>>> +static int fsl_qspi_check_buswidth(struct fsl_qspi *q, u8 width) {

>>> +       switch (width) {
>>> +       case 1:
>>> +       case 2:
>>> +       case 4:
>>> +               return 0;
>>> +       }

>> if (!is_power_of_2(width) || width >=3D 8)
>>   return -E...;
>>
>> return 0;
>>
>> ?

> Your proposition is a bit shorter, but I think it's slightly harder to re=
ad.

OK.

>>> +
>>> +       return -ENOTSUPP;
>>> +}


>>> +       for (i =3D 0; i < op->data.nbytes; i +=3D 4) {
>>> +               u32 val =3D 0;
>>> +
>>> +               memcpy(&val, op->data.buf.out + i,

>>> +                      min_t(unsigned int, op->data.nbytes - i, 4));

>> You may easily avoid this conditional on each iteration.

> Do you mean something like this, or are there better ways?
>
> u32 val =3D 0;
>
> for (i =3D 0; i < ALIGN_DOWN(op->data.nbytes, 4); i +=3D 4)
> {
>         memcpy(&val, op->data.buf.out + i, 4);
>         val =3D fsl_qspi_endian_xchg(q, val);
>         qspi_writel(q, val, base + QUADSPI_TBDR);
> }
>
> memcpy(&val, op->data.buf.out + i, op->data.nbytes);
> val =3D fsl_qspi_endian_xchg(q, val);
> qspi_writel(q, val, base + QUADSPI_TBDR);

Something like this, though last part should go under

if (IS_ALIGNED(...))

(My comment was about moving out an invariant conditional)

>>> +               val =3D fsl_qspi_endian_xchg(q, val);
>>> +               qspi_writel(q, val, base + QUADSPI_TBDR);
>>> +       }

>>> +MODULE_AUTHOR("Freescale Semiconductor Inc."); MODULE_AUTHOR("Boris
>>> +Brezillion <boris.brezillon@bootlin.com>"); MODULE_AUTHOR("Frieder
>>> +Schrempf <frieder.schrempf@exceet.de>"); MODULE_LICENSE("GPL v2");

>> Wrong indentation.

> What is wrong? Some newlines are missing here between the MODULE_ macros,
> but in my original patch it seems correct.

It should be like

MODULE_FOO(...);
MODULE_BAR(...);
MODULE_BAZ(...);

One macro =E2=80=94 one line.

--=20
With Best Regards,
Andy Shevchenko
