Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7823FC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5EF20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHHT8flL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5EF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGK3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:29:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33701 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:29:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so3369765otl.0;
        Fri, 07 Dec 2018 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KGex2yMlsN+vgL6Rv6Gp2x2aw4JWWLlzNzyfbMwfu2o=;
        b=rHHT8flLGjd8L8H+OeZIkDx9HAAvOGSImJBnf9g/E8FTJZnyc39I87zuiU3Bdirx12
         iMcU1t7FDM9waK5UsSIawdxjttHl/BBtjHu76x7ddCEGwPPXk+tTxz5scRBehK9+HBAz
         LTcMTblbmdRwMqpfcZdL0y/8TqsoGF8vgmvEIeiZbLj6VKff7ziuEYuaZ0KeBvBibqMg
         NboMXNYQRIalyuc6+ljUCp8q9/TNo16YnKjo5TkDkgOh8MiMCu2gvGtGs7t2duc7vKY5
         CVmPq5vqc6LRmC10g9lx0Cy1XwE2h8DPF/281IvAe0oBN4lME8iTr7RkhYxaIyyske1j
         W+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KGex2yMlsN+vgL6Rv6Gp2x2aw4JWWLlzNzyfbMwfu2o=;
        b=UgXI29lD+aUFOIylxYlPY6pL0b/3Nw5heeVpmPlY5uiTIIbzBt55Up8BxLJK/0H84A
         wYojIbHBPfva+6V+IBShzDwKBrqSDTZ8yqbIlYX1OZVGRNpXXeEiwS0OXlaNJP9Bdl6e
         aJvtm+W7NGoVBsHhtaCGdYcaDPjkL+b25hfQg7RZLr4+IpewrfMPwM9ehwJsh87j6q6h
         1J+VnHCHJDMNbOaWphzy9zNGwLxxKx0CaUDZ/qGyLQ8Oi/+HN4Q/8jIUYElyl1a/Vuzu
         sSYXEzYWBdXZxx+x7SjJylDx5TO20RlnxALYQwvN0JN3Z79WeQ3bWdDcRKXRjBjz2bPt
         OjHA==
X-Gm-Message-State: AA+aEWY2Pn5pq+JAfiNKcGRW0x2+77dum9TOBiiYUxI/iX9d7o3GSsLk
        BgftTgz86fXz1t5CQdzHC2QRi/vp/ZN83Pk1PWo=
X-Google-Smtp-Source: AFSGD/Ufe2W94LjXwAcQN+NJx33NwfexI2qNrN4dh7tieft0fFXx9ua2RPY7KOvaqH8XkPkCgjf0tnT3MZGLuVtyqfk=
X-Received: by 2002:a9d:401:: with SMTP id 1mr1047802otc.78.1544178572602;
 Fri, 07 Dec 2018 02:29:32 -0800 (PST)
MIME-Version: 1.0
References: <1544065798-4465-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544065798-4465-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 7 Dec 2018 08:29:23 -0200
Message-ID: <CAOMZO5Be-RzekcsigNKrss-7DGV0F8yU2yhT11n+eAmqP1euKw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: isl29018: add optional vcc regulator
 operation support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Thu, Dec 6, 2018 at 1:17 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> The light sensor's power supply could be controlled by regulator
> on some platforms, such as i.MX6Q-SABRESD board, the light sensor
> isl29023's power supply is controlled by a GPIO fixed regulator,
> need to make sure the regulator is enabled before any operation of
> sensor, this patch adds optional vcc regulator operation support.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/iio/light/isl29018.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index b45400f..47a55c8 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -23,6 +23,7 @@
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -95,6 +96,7 @@ struct isl29018_chip {
>         struct isl29018_scale   scale;
>         int                     prox_scheme;
>         bool                    suspended;
> +       struct regulator        *vcc_reg;
>  };
>
>  static int isl29018_set_integration_time(struct isl29018_chip *chip,
> @@ -735,6 +737,15 @@ static int isl29018_probe(struct i2c_client *client,
>
>         mutex_init(&chip->lock);
>
> +       chip->vcc_reg = devm_regulator_get_optional(&client->dev, "vcc");
> +       if (!IS_ERR(chip->vcc_reg)) {
> +               err = regulator_enable(chip->vcc_reg);
> +               if (err) {
> +                       dev_err(&client->dev, "failed to enable VDD regulator\n");

You call the regulator as "vcc", but in the error message you mention
"VDD", which is confusing.

Same comment as in the previous patch.

There is no VCC regulator as per the datasheet. There are VDDD and
VDDA power supplies, so better represent both and with the same name
they appear in the datasheet.
