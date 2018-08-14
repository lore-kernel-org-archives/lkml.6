Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6451AC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128562172F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEzx/yqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128562172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbeHNTwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:52:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36218 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbeHNTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:52:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so21899292qtn.3;
        Tue, 14 Aug 2018 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hwcz69zsYXmG3IcMIDADTpBUdB+YA/0mi5qWgX+U1uo=;
        b=aEzx/yqnXMydQu0XmN9nGhy1Z2tYQcL6OGRdRIqTg/OuYZU0sgT9GJrx93Xt66SEsS
         QIjv2GHCf/UtfgYPrhuBCx9tjhVXSEN5JnK/pwOB5532MvYAVRhU1+G5M3oSp2EQcO+s
         mRrlT1YTtbw6WVpJJaGWJERbU5ft30y1OLPivIjzzjHV+25p31VJgYOHWEQScLoYlwLl
         7DKqyPbVJC9I4VdE0ytAp3y62PFdNhOaOUovfJ8EN5BJLsIhkbm3C26NoIRLU/0q/DiG
         FY4LmYgMvl3YrbqHdwMhdwACMre+l9lZHzPU37BYLp7gtRn4QFH38gtnYOQaCAk6tF8r
         QBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hwcz69zsYXmG3IcMIDADTpBUdB+YA/0mi5qWgX+U1uo=;
        b=I/FOQ5CGsZcsTGYxYW2TW4jG59aI3dwaVWxIMZpp+LKp0kUYvAhAa3Yy+9+vd8bBwe
         FQMJfVBdQLRH9VzRjZlPHZW1TktXcRNEvjpLQVHJBGeh/B8v660kiJIIzSsP+Zu1jJEK
         4VmbwHGdxAQ05idcuY/lJhV8wwNd382gCd9pa87+v+DkZBEinas3cTbk+fdLch3vTGnE
         wyU0s8ibSecagT8yXSUQPJK0gOyeoNGZrElo546hIgMFzCRWITcgG1bx+javqeZY8wnV
         l6Thk8KBivjlasyXZj3V4gLQ55L4qEoZTmHaCKSTfjX32bEuTyBxCYcSm8DaByANVjx3
         Vnuw==
X-Gm-Message-State: AOUpUlHcOGzYywnOl7+7tNoEFsrQ+5/Iwq4DhmT+V9oY9KnHD6wE611I
        jAhhaJld79IY1R2BLH6oBSL/OPiiwiAPZ+cmtqw=
X-Google-Smtp-Source: AA+uWPxlGwPlYy+0Va4AOkBVkxe2DvY16fU63LIc9siylz3zYfbVWRGsNE1O9e11xWrqfuRTCIWxf81H3bzyzISJhZQ=
X-Received: by 2002:ac8:2a18:: with SMTP id k24-v6mr21727300qtk.219.1534266250443;
 Tue, 14 Aug 2018 10:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180810131349.3883-1-fparent@baylibre.com> <20180810131349.3883-2-fparent@baylibre.com>
In-Reply-To: <20180810131349.3883-2-fparent@baylibre.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 14 Aug 2018 19:03:59 +0200
Message-ID: <CAFqH_524YXayrzJC5hpYDyo8dcF7KirVphsTpM6Hp3Nfv_9QMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mfd: cros: add charger port count command definition
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, gpain@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Missatge de Fabien Parent <fparent@baylibre.com> del dia dv., 10 d=E2=80=99=
ag.
2018 a les 15:17:
>
> A new more command has been added to the ChromeOS embedded controller
> that allows to get the number of charger port count. Unlike
> EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
> port if present.
>
> This command will be used to expose the dedicated charger port
> in the ChromeOS charger driver.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Seems you missed my Reviewed-by tag, not a problem :), in any case,
for if it helps to land adding again

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> V1 -> V2:
>   * No change
> ---
>  include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index 0d926492ac3a..e3187f8bdb7e 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -3005,6 +3005,16 @@ struct ec_params_usb_pd_info_request {
>         uint8_t port;
>  } __packed;
>
> +/*
> + * This command will return the number of USB PD charge port + the numbe=
r
> + * of dedicated port present.
> + * EC_CMD_USB_PD_PORTS does NOT include the dedicated ports
> + */
> +#define EC_CMD_CHARGE_PORT_COUNT 0x0105
> +struct ec_response_charge_port_count {
> +       uint8_t port_count;
> +} __packed;
> +
>  /* Read USB-PD Device discovery info */
>  #define EC_CMD_USB_PD_DISCOVERY 0x0113
>  struct ec_params_usb_pd_discovery_entry {
> --
> 2.18.0
>
