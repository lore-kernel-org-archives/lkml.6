Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CFC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550942083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAt8rMBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550942083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLGKXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:23:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44612 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGKXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:23:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so2944947oig.11;
        Fri, 07 Dec 2018 02:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZroL3aBf3tYBxP6oquRCrNuoIHV01FxwRV4lB9IaYc=;
        b=nAt8rMBjKwUcdx1SxXMr9WmtJ1S95lbAYv647BItBaqcohl7vePaC8yTTzg7ik9Voa
         IxCZd+vq18Woj5yVsWi6gzmsg/o8AzSEb1rrM317ZhqLAFvZ9LM4g8/Um69WY1+GSqI/
         0x4pkihMaBB4hXvi68rVxRimmgXA1MuR18i+9iEwWGg4JVnAJzAkJp0n+d86mUzGAvEs
         Ln0SCN4eBEaPI/U1XiGQ9tmn2gp9j8SuNE1FBtB2fWzI15UqSTi15rBSb6J4HM/C9mi+
         4K5jJndUHZEqKrogKXhg8+vMWs4uxB4Dip2CKIcPud+BT4FoGejXWkWUG20KDnCyQJ3v
         jo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZroL3aBf3tYBxP6oquRCrNuoIHV01FxwRV4lB9IaYc=;
        b=fN+6wGoewI0BgVhQ9eVBOcQyWFcMUyJeAzn3wyAFEGQLCfe9I6RJPh8VfPOIpmgzcQ
         nviJc54oCSr5CTVjPKixTEum61eClb2O74/JAMMDMPhBZeVjMMxcNnzUD/ZwBAGGGuyA
         ZU6mxb9RlzAAtmSf4VgZOeKoSUrDk9aOSMLC1KwtH0Xr0Vy1BlaYnVCVCgf4flIQnWku
         3G149gS/yjAQGLGmqZS0lJpREFoYXwnQwz53x45lhxgTnWhN9xPGTWTgo4RsY+FoOFXc
         +N6RQLDucCEBzBNzRtPOsUXvnUFz0M8i34abIMtkuJpAN71kHkrPwt1QNZzWnCQEIqMp
         +CQg==
X-Gm-Message-State: AA+aEWZ1wTyST0XA0OZrpOinVxnd1ovPA7idQRJgI7xHLGPClGpiH0JX
        LJ97dAsrr02D2VeMLeUd3+0j7fFiMjFC/gz0P2A=
X-Google-Smtp-Source: AFSGD/WZ/3Bs6J4LNSkcK82bkAS22y2HjnLP/3XW7bsvwgSFjx9JG0ChaVx2Nq/GjoSzYmNdzGeJluVoVdMVZXxma6w=
X-Received: by 2002:aca:cdd0:: with SMTP id d199mr971350oig.266.1544178213078;
 Fri, 07 Dec 2018 02:23:33 -0800 (PST)
MIME-Version: 1.0
References: <1544077059-4471-1-git-send-email-Anson.Huang@nxp.com> <1544077059-4471-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544077059-4471-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Dec 2018 08:23:24 -0200
Message-ID: <CAOMZO5AoJ4rxu31gQTLQcVwhuqJdhUOVRsTig0oE2a5vF2QESg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: accell: mma8452: add optional vcc regulator
 operation support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, harinath922@gmail.com,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        martink@posteo.de, rtresidd@electromag.com.au,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
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

Hi Anson,

On Thu, Dec 6, 2018 at 4:25 AM Anson Huang <anson.huang@nxp.com> wrote:

> @@ -1533,6 +1535,14 @@ static int mma8452_probe(struct i2c_client *client,
>         data->client = client;
>         mutex_init(&data->lock);
>         data->chip_info = match->data;
> +       data->vcc_reg = devm_regulator_get_optional(&client->dev, "vcc");

MMA8452 datasheet shows two power supplies: VDD and VDDIO, so if you
are adding support for the regulators, IMHO it is better to represent
both supplies and with the same name they appear in the datasheet.
