Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB5DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B172244B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Piu7PBCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B172244B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbeHJUFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbeHJUFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:05:01 -0400
Received: from mail-qt0-f177.google.com (mail-qt0-f177.google.com [209.85.216.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D76242244B;
        Fri, 10 Aug 2018 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533922453;
        bh=xexaJaKN8Jd8Uk1lDhJ82rRvfauPvMV6C+w8qphCsgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Piu7PBCF9nCkcKZDXoyzcLA/qRmCpaTj2qizSOlb7smWw7Gs9Qg5ImOeQgVLN7LfH
         2Mij84KgaZ/KsNKaNCMY6QvPHfCoMeta40pPbQDBiVz+1GQDrQ7D8sRnAci6zp0Z3/
         8x24BNtU5Gvx8e1Gr5W6jb4u8QkEnYSH621BmEkM=
Received: by mail-qt0-f177.google.com with SMTP id q12-v6so11095128qtp.6;
        Fri, 10 Aug 2018 10:34:12 -0700 (PDT)
X-Gm-Message-State: AOUpUlHcexeqEYyuQkYkXpXJDlk1CTYNVzNkQbLtQVCHQvfCzo+8vOqV
        RcRhg4+/03rmqyeRpQz5pOkv6YM1VA4N3Kxe2A==
X-Google-Smtp-Source: AA+uWPzNCJ6lzWLUpSweuSQkyccYwcmZ9Dhd4vz/IMhpTpssdm+3N7GOBvFV1lRDcAJiZ+fBhUZvYQfAuYs4oA/mEFI=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr7698782qta.60.1533922452110;
 Fri, 10 Aug 2018 10:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqKNnfgESG6ON95D7nD8VNrcVy7-x6cGGnae_GbbGKAuPQ@mail.gmail.com>
 <20180805232651.10605-1-afaerber@suse.de>
In-Reply-To: <20180805232651.10605-1-afaerber@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Aug 2018 11:34:00 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
Message-ID: <CAL_Jsq+f5VMWZg9GNF=e-UmFjcjbVnE7Dr0EBF56E6gUrdTnuQ@mail.gmail.com>
Subject: Re: [RFC] serial: sc16is7xx: Use DT sub-nodes for UART ports
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, jringle@gridpoint.com,
        Michael Allwright <allsey87@gmail.com>,
        Jakub Kicinski <kubakici@wp.pl>, liuxuenetmail@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 5:27 PM Andreas F=C3=A4rber <afaerber@suse.de> wrote=
:
>
> This is to allow using serdev.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  drivers/tty/serial/sc16is7xx.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index 243c96025053..ad7267274f65 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1213,9 +1213,31 @@ static int sc16is7xx_probe(struct device *dev,
>                         SC16IS7XX_IOCONTROL_SRESET_BIT);
>
>         for (i =3D 0; i < devtype->nr_uart; ++i) {
> +#ifdef CONFIG_OF
> +               struct device_node *np;
> +               struct platform_device *pdev;
> +               char name[6] =3D "uartx";
> +#endif
> +
>                 s->p[i].line            =3D i;
>                 /* Initialize port data */
> +#ifdef CONFIG_OF
> +               name[4] =3D '0' + i;
> +               np =3D of_get_child_by_name(dev->of_node, name);
> +               if (IS_ERR(np)) {
> +                       ret =3D PTR_ERR(np);
> +                       goto out_ports;
> +               }
> +               pdev =3D of_platform_device_create(np, NULL, dev);

Ideally, you would use of_platform_default_populate here. I think
you'd have to add a compatible to the child nodes, but that wouldn't
be a bad thing. I could envision that the child nodes ultimately
become their own driver utilizing the standard 8250 driver and a
compatible string would be needed in that case.

You'd then have to loop over each child of 'dev' instead of the DT nodes.

> +               if (IS_ERR(pdev)) {
> +                       ret =3D PTR_ERR(pdev);
> +                       goto out_ports;
> +               }
> +               platform_set_drvdata(pdev, dev_get_drvdata(dev));
> +               s->p[i].port.dev        =3D &pdev->dev;
> +#else
>                 s->p[i].port.dev        =3D dev;
> +#endif
>                 s->p[i].port.irq        =3D irq;
>                 s->p[i].port.type       =3D PORT_SC16IS7XX;
>                 s->p[i].port.fifosize   =3D SC16IS7XX_FIFO_SIZE;
