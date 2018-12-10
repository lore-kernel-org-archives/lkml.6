Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FBBC65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1367120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfiIj21i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1367120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeLJOq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:46:26 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35919 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeLJOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:46:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so10610989otk.3;
        Mon, 10 Dec 2018 06:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8v8joAtLtbQz45WSH3svSJ/xIYvrhVCTJ3ubUyBE/Mo=;
        b=kfiIj21iB0BbSIRMDFWsdDq30wwYgfnq9BnMwYlpg8SjTzHBDCs3J6h6dcMszOu1mv
         aVePY6cN7pyhyy08EclWMS+jKouoVMIhOS88af/o2kbREQ4irBeNJQY1tUnwWBQ6OfFs
         E9Z+VehTAP8G+P6O7Fw8mpsoi6B21OhRiV9w9hLkRMP0pbRdBw/7K32lkPwuXvxGjDTj
         0XbTaNoRL2Xjw37Owl1IkuhXz6YEGkAox5r7GhfbcSbGKfHGBNLehNH4i/fyX+h32QEx
         BVAPNPrr5+tTaO3O/9ODxSW4MbLq1bVK5EWjeP1kptcIfIQOm0PKY0RTgkQhu03dPqSW
         1q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8v8joAtLtbQz45WSH3svSJ/xIYvrhVCTJ3ubUyBE/Mo=;
        b=HDkwYbXSysMTaH/OdQ8aaIrpb+EBBa7jQH9RhxktZhWUW9jamA+6suoe8KN2W66UJM
         IMZLfqQuTYliSbsxi+jvrvAmlcIDlpVksWQaCJ0cVcOmqlOT1B5GqUBZVMUc8juebRnc
         VzFNk/hzskvCV50D+kkCyXEDIIpZ174c9N+P+5ja3t/oQVXIU3z1eZcN7VrVFgR42gV5
         omZfnQ2TRVflWcR3WHcl8A8NrxitW3BPpHjS1Nd2PGZXCEPIblV2z2GqU1TKdo47Tht5
         4XEEc92KxYZ7VDrhLEcnn4n0YxnuWEokJXzislHXkNPYQ9yBxAjbsUk3V2zLZxqFRwci
         yYtw==
X-Gm-Message-State: AA+aEWa4E46KiWBOlFuw4FPPTtQJiOXYu/9NTSsVNbL4tf/BXimyN6Ri
        1wRHml+zjE7dBL5ypRQdxKidn0fl3mXUqHTvErs=
X-Google-Smtp-Source: AFSGD/X9cQC+3EZ0UDUdXTzQPOj0k3NorkMDiCMXekQ7u3F9A8Z3FtrV89mUuEzC+inROD2vWhYF6uyvgMtrofKIHWI=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr9513039otp.225.1544453184260;
 Mon, 10 Dec 2018 06:46:24 -0800 (PST)
MIME-Version: 1.0
References: <1544426368-16415-1-git-send-email-Anson.Huang@nxp.com> <1544426368-16415-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544426368-16415-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 10 Dec 2018 12:46:17 -0200
Message-ID: <CAOMZO5DT-cRYpCWShQqE7oX7v262s6K1G=R3PfBHs9RHXiiH6A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] iio: accell: mma8452: add optional vdd/vddio
 regulator operation support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rtresidd@electromag.com.au,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>, martink@posteo.de,
        linux-iio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:25 AM Anson Huang <anson.huang@nxp.com> wrote:

> @@ -1533,6 +1536,27 @@ static int mma8452_probe(struct i2c_client *client,
>         data->client = client;
>         mutex_init(&data->lock);
>         data->chip_info = match->data;
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

As mentioned in your other patch: you should disable the previously
enabled regulator in the error path.
