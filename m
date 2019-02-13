Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228E0C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADD82175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttUVBGtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbfBMCr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:47:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33962 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388986AbfBMCrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:47:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id 98so1554421oty.1;
        Tue, 12 Feb 2019 18:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :autocrypt:subject:to:cc:from:message-id;
        bh=n+0HFoSYnepK9yEAZMuZMDxMr2ODy5Uu9899vA8XEHs=;
        b=ttUVBGtwjnF8xDpIQ8QowrX0RQY9zvmb2HyItbsj75P3R2BrZpw2vcjZSyWbitXR+M
         Y5rWFWfcPxq3ZelRXyhvUz8bBq5lznUcAu+rjuR+mcs73YGoqJh3WxPeJGFaBtdCFe7X
         3563sTMfA+62DrVzJoV2zGp6Z57dM/x0QFbe8m+n7Qt2BYKxCoG2ivjqMHicAZhDyT/w
         Vkuxag6w2QJIs7Vlz3LAHcyCkzlxOQ1/mgTMYVJ6oo/v7JaTHHM8Gmkizm+ce50XhQU3
         SEq5IGpIQJ9WSSc+6tEHCmHwoGUTE7Q7jE8FSGPaueX3dfdFhS3RGusdIDVfsFVS+TV9
         ES5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:cc:from:message-id;
        bh=n+0HFoSYnepK9yEAZMuZMDxMr2ODy5Uu9899vA8XEHs=;
        b=CNf0N4Wf+4gXiknmY9a4Mtm/09MqjgRPhse/bjN2VJdvCcEikgklx0TeqNAG3g7iTk
         lwu7O1AAD4NXxivsstwF7QBZAGIFM3YorgubfOsygR8hY5LSbHf1N7t5Fi50weX0LOuE
         8EX91Dw8L7laoTb75w7fttHr1kz/oq/r/WusDzCktPi8WskGBk1sZJ8rJk8rhFIaL772
         v66a/yiIXOKrUISLtd6kn5kxcwoS1kIJy7YvQqSZMUSbdOgh32d6NZReTiqy/luobvFG
         GpvTAspunS4ZoJRIrzGOu7b1bapzmuh5K+Um1K0Um4h2C9FkmuWreVaGd7m+v9MIaDqn
         uAxw==
X-Gm-Message-State: AHQUAuZUs24CZdHmv7ITbpza/V+JFqNGz3D/OHqRNsFbZ9yl7S7ExZ4u
        +g+74g/PK7mSK4BZhw7aK30=
X-Google-Smtp-Source: AHgI3IY23C6TczCPaGVTtTf3OEDxvveHaDi1r+8ZDNTg6QxYSD8ubUbLMFCYl2qdxpVJJ3wtGZ1P3Q==
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr7567375otp.225.1550026072524;
        Tue, 12 Feb 2019 18:47:52 -0800 (PST)
Received: from localhost (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id k25sm3228825oic.27.2019.02.12.18.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 18:47:51 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:47:44 -0800
In-Reply-To: <1550021937-12202-1-git-send-email-justinpopo6@gmail.com>
References: <1550021937-12202-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: add GPIO support
To:     justinpopo6@gmail.com, linux-iio@vger.kernel.org
CC:     linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        david@lechnology.com, linux-kernel@vger.kernel.org,
        jic23@kernel.org, Justin Chen <justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <CE4AF546-6CC0-4292-B5F5-6715C3EE7B6A@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

This looks good, one comment below:


[snip]

>+static int ti_ads7950_init_gpio(struct ti_ads7950_state *st)
>+{
>+	int ret;
>+
>+	/* Initialize GPIO */
>+	mutex_lock(&st->slock);

Lock is acquired here=2E

>+
>+	/* Default to GPIO input */
>+	st->gpio_direction_bitmask =3D 0x0;
>+	st->single_tx =3D cpu_to_be16(TI_ADS7950_CR_GPIO |
>+				    (st->gpio_direction_bitmask &
>+				    TI_ADS7950_GPIO_MASK));
>+	ret =3D spi_sync(st->spi, &st->scan_single_msg);
>+	mutex_unlock(&st->slock);

then released here=2E

>+	if (ret)
>+		return ret;
>+
>+	/* Default to signal low */
>+	st->gpio_signal_bitmask =3D 0x0;
>+	st->single_tx =3D cpu_to_be16(TI_ADS7950_CR_MANUAL |
>+				    TI_ADS7950_CR_WRITE |
>+				    (st->gpio_signal_bitmask &
>+				    TI_ADS7950_GPIO_MASK));
>+	ret =3D spi_sync(st->spi, &st->scan_single_msg);
>+	mutex_unlock(&st->slock);

and here as well, presumably there should be a mutex_lock() guarding the s=
ignal bitmask and transaction, right?

Thanks!
--=20
Florian
