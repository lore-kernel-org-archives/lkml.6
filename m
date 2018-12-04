Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA94C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FD720851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcS28Jq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FD720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeLDUhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeLDUhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:37:22 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8AE20834;
        Tue,  4 Dec 2018 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543955841;
        bh=Ui7iY51nmAyKLnRnPfY2Dq1DqzdXLZpfF+Q8nfnuB40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DcS28Jq97Ju5b6cW5Twl7F7l2slGvYHRGIP64El8pgcnBFszS4BscOMOgrtKeK2mF
         MdYKuBgV2XQVWD6fFAjSBlW3JXaU7A04Vo4ouXtrZQmExnqMVkFGkJc9OXe3+blNt5
         39R3qYfHbTgF65+jjpGVcrjkacww+IZss0BXzoDQ=
Received: by mail-wr1-f54.google.com with SMTP id z5so17378177wrt.11;
        Tue, 04 Dec 2018 12:37:20 -0800 (PST)
X-Gm-Message-State: AA+aEWZYIVZzaaVaOvZ3SLeRw3pamVfFbyywT6XKZsbBIK/hEs13AENb
        Keat7hbI7I2n7U06qbpqe8+YY1EnVnfut5xbs74=
X-Google-Smtp-Source: AFSGD/U1xDnN/s7Gfo+oM7krukKgDupoe1Qxkiq4a5ikk6uoOxlHl65TMgS6NMBK9vms/M9CbSZyqUDN6oHTeqJPROs=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr18914533wrw.132.1543955839463;
 Tue, 04 Dec 2018 12:37:19 -0800 (PST)
MIME-Version: 1.0
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com> <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
In-Reply-To: <1543843974-4054-3-git-send-email-qii.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 4 Dec 2018 12:37:08 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrC4xLML0D-8tq+T-042=vMEZF7rSNDYzT7imcBYgt7wA@mail.gmail.com>
Message-ID: <CAGp9LzrC4xLML0D-8tq+T-042=vMEZF7rSNDYzT7imcBYgt7wA@mail.gmail.com>
Subject: Re: [PATCH 2/5] i2c: mediatek: remove useless code and replace definitions
To:     qii.wang@mediatek.com
Cc:     wsa@the-dreams.de, devicetree@vger.kernel.org,
        ryder.lee@mediatek.com, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<qii.wang@mediatek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=883=E6=97=A5 =E9=80=
=B1=E4=B8=80 =E4=B8=8A=E5=8D=885:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: qii wang <qii.wang@mediatek.com>
>
> Completion_done is useless when we don't use its return value,
> so we remove it. Different speeds have been defined by macros,
> so we use macros definitions.
>
> Signed-off-by: qii wang <qii.wang@mediatek.com>
Reviewed-by: Sean Wang <sean.wang@kernel.org>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt6=
5xx.c
> index a74ef76..660de1e 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -456,7 +456,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>
>         control_reg =3D readw(i2c->base + OFFSET_CONTROL) &
>                         ~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
> -       if ((i2c->speed_hz > 400000) || (left_num >=3D 1))
> +       if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >=3D 1))
>                 control_reg |=3D I2C_CONTROL_RS;
>
>         if (i2c->op =3D=3D I2C_MASTER_WRRD)
> @@ -465,7 +465,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>         writew(control_reg, i2c->base + OFFSET_CONTROL);
>
>         /* set start condition */
> -       if (i2c->speed_hz <=3D 100000)
> +       if (i2c->speed_hz <=3D I2C_DEFAULT_SPEED)
>                 writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
>         else
>                 writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> @@ -642,8 +642,6 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, s=
truct i2c_msg *msgs,
>                 return -ETIMEDOUT;
>         }
>
> -       completion_done(&i2c->msg_complete);
> -
>         if (i2c->irq_stat & (I2C_HS_NACKERR | I2C_ACKERR)) {
>                 dev_dbg(i2c->dev, "addr: %x, transfer ACK error\n", msgs-=
>addr);
>                 mtk_i2c_init_hw(i2c);
> --
> 1.7.9.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
