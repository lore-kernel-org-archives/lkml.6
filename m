Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F6C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC102082D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhmkUrdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC102082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeLJJz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:55:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46510 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:55:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so9759044otm.13;
        Mon, 10 Dec 2018 01:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMcPA0ob+XfedqoJIIULHLRD9wmQcHKGn0mWTn8zXpo=;
        b=YhmkUrdl/bxr3Ay64gcsQSNx1Z99tA+eLteFwEpw9FtdxcG6mgceX6EJYhnqvb3msy
         NzUA5Etd2C3HvBEq+Vxg3ucuf8S7A7N/IRZfMiVQEPnQC8RAURh2vLAX+LpT21TxVAoI
         CRNQh3ineEuFsSlWwF5TUExuvcd5LK0Owufi+ytjnrjcVPNU5fewEBzU59r50mN4Zy6X
         lj2kFzuUidZs8zNNyP4/PpPy2M35fbwTlT4AvHQrgxvM3BUhjs3A25oNTe5Gt5/aadxV
         9NwRkOTRi+sLqyPqKCjLd7VUJ9j51576+4tnQwoVQbeCzwRJ8Gef5fGOeqBdYwCCItYV
         yhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMcPA0ob+XfedqoJIIULHLRD9wmQcHKGn0mWTn8zXpo=;
        b=KVAXHR+6zLwWFoyfwhSzDCUvQU6h+5/FMkc77n3FTBVNrr0uSQPT0FAlu520dbGczX
         ZSRPbXHgcFEXsrtzqyCDy6XKRMZ9CYKWMdD1gHcobjJqGFqcTwX0o2NQYFBijhEd2ykd
         EUHzgk1Xafy1VgSuoOOO4vGRT/g7PWgq3/nutmVSvMUxhHKq9buy5EoCNGvkKUn7jfLa
         gltHTMMppOBAR6645yIdOu7NdIYfYIVv9Cz7R4qgakSc9mPPYBqhYnq/vmaOZ4b0KlFw
         gwZxS0v8e5taxEO3KOoxcvnja9HBU4UjE6WcleRWAvDOOlfbKTxezwPf8QAsdc6biJj1
         QGTQ==
X-Gm-Message-State: AA+aEWYHBzsTGLMIhDmR9mF/2QkbVzTQndZhf5WgDA+H3hAuKp7sntZH
        UBuBIzNurtYVaBzW4UHrYlnjSfwuB+Spw+Uqjz4=
X-Google-Smtp-Source: AFSGD/U7Xxf8ypgt6BWr7FxYizqiKHZ/rYmZAAQFfMsy7DvYjc5DNLjLs5kXKqW4YORpePhSeYVBYnM213WNZK9KUdY=
X-Received: by 2002:a9d:401:: with SMTP id 1mr7909584otc.78.1544435726240;
 Mon, 10 Dec 2018 01:55:26 -0800 (PST)
MIME-Version: 1.0
References: <1544425869-8188-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544425869-8188-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 10 Dec 2018 07:55:19 -0200
Message-ID: <CAOMZO5AJv=DtqSsKKQLX10GQC64NNoWkmYKSs+sM0Jjb8ugFVQ@mail.gmail.com>
Subject: Re: [PATCH V2] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Dec 10, 2018 at 5:17 AM Anson Huang <anson.huang@nxp.com> wrote:

> +       data->vdd_reg = devm_regulator_get_optional(&client->dev, "vdd");
> +       if (!IS_ERR(data->vdd_reg)) {
> +               ret = regulator_enable(data->vdd_reg);
> +               if (ret) {
> +                       dev_err(&client->dev, "failed to enable VDD regulator\n");
> +                       return ret;
> +               }
> +       } else if (data->vdd_reg == ERR_PTR(-EPROBE_DEFER)) {
> +               return -EPROBE_DEFER;
> +       }
> +
> +       data->vddio_reg = devm_regulator_get_optional(&client->dev, "vddio");
> +       if (!IS_ERR(data->vddio_reg)) {
> +               ret = regulator_enable(data->vddio_reg);
> +               if (ret) {
> +                       dev_err(&client->dev, "failed to enable VDDIO regulator\n");
> +                       return ret;

In the case of error you should disable the vdd_reg regulator.

> +               }
> +       } else if (data->vddio_reg == ERR_PTR(-EPROBE_DEFER)) {
> +               return -EPROBE_DEFER;
> +       }
> +
>         ret = i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
>         if (ret < 0)
>                 return ret;

and here you should disable vddio_reg.
