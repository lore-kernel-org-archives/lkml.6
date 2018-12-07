Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673B2C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E58A20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he5/fwmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E58A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGK0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:26:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35456 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGK0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:26:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so3001667oif.2;
        Fri, 07 Dec 2018 02:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGLqBv9VTx+Qkeh6OznZaxEk9vgKm95sjYiJmxdO18g=;
        b=he5/fwmZ+9HTN6QXrnWVRKUKud3dVGiAHDir/H6xFoRK14BiFYP31n5VMRVk+LwFJI
         85Eb/JI+Lz6qGkRx03m2vvceGC7ld/3AnhVwSnj1tl3ZlDNPaOwm09HEyjcq9UhE7HBm
         uGPUxsGiLPI+TOnrhhAvx6UnDspre96pu4bH8NtYnHf863wqzdKuv2mtqfq/E7QqpAIl
         NmnVwnW8KNGMU/AKFdaDXu6/t6UQSz6bdyz3o1/4ao56HKOVtGxhFmw4xIzWGAF98V4p
         FC/l72AUXw7IvaQj7prKhr2nSwBI/Uccm4qrbp/Hs6NWNAInvhNzQKf/gsJZOMkplOhe
         YUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGLqBv9VTx+Qkeh6OznZaxEk9vgKm95sjYiJmxdO18g=;
        b=MZRXpmM07kUxeGA0eVhVbz2c66VV5AN/X07G8/yADaTqs1Mrt68BxH5/PynVJ2YdSg
         AiKFiMuvSKGiVg9J6jVsGWwOeLFX5/ZZf5DS8Grx+10oQq+GNg3LgGTDJTDnTKjp3i/1
         BfQx8ufV1aXLnVBIOyf/cnSisCuJ/M0vTTT1yeKUUOo219gyv/AAyMdYVktvWpEDu984
         ejU/YaAwO/EROWEgmxYoEu7ND1a5Rkzmp82j7L17XL9cg4bl0m86CPngEChuKDsrCAmW
         8mFZ6vQlIrXPLvXQ/N8gXWR8vls6ZziukmPq0gRtISplnATBASyBvS10uHmpBhGbDXY2
         iGJw==
X-Gm-Message-State: AA+aEWZwxO+7I7veaCnPrduZwjqvBmRTtT+poZMMZ7Gp26TQKYuzl4o4
        JXow+KWjs5z/R2F6+diKz7bfdZht+WgFJYso2uA=
X-Google-Smtp-Source: AFSGD/UYaRGcSCWuuJ4hi27297yC7y7TDBDlQY6Cmly7DFl+ZSh/i6IiZ81ClIB12qd/sAQoWmfTkXkLThOfKleD+Rc=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr975973oig.266.1544178409303;
 Fri, 07 Dec 2018 02:26:49 -0800 (PST)
MIME-Version: 1.0
References: <1544072280-26932-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544072280-26932-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Dec 2018 08:26:40 -0200
Message-ID: <CAOMZO5Dw1CU6v8OkVC6iJpgbSom9yD7g5ToEdZQ-V_FoYngoDw@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: mag3110: add optional vcc regulator
 operation support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, rtresidd@electromag.com.au,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Thu, Dec 6, 2018 at 3:05 AM Anson Huang <anson.huang@nxp.com> wrote:

>  static int mag3110_request(struct mag3110_data *data)
> @@ -469,17 +471,27 @@ static int mag3110_probe(struct i2c_client *client,
>         struct iio_dev *indio_dev;
>         int ret;
>
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data = iio_priv(indio_dev);
> +
> +       data->vcc_reg = devm_regulator_get_optional(&client->dev, "vcc");
> +       if (!IS_ERR(data->vcc_reg)) {
> +               ret = regulator_enable(data->vcc_reg);
> +               if (ret) {
> +                       dev_err(&client->dev, "failed to enable VCC regulator\n");

Same comment as in the previous patch.

There is no VCC regulator as per the datasheet. There are VDD and
VDDIO power supplies, so better represent both and with the same name
they appear in the datasheet.
