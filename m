Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC5FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453272445C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rw0MKNL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453272445C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeGBOnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:43:46 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38671 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeGBOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:43:42 -0400
Received: by mail-yw0-f194.google.com with SMTP id r3-v6so75474ywc.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjprifdxSiKHrnWlfhNRxh5ZE7VyCQPgycwdC6B4qmQ=;
        b=Rw0MKNL3lzcH7opgUDikOB+1jpvq3UmEotItyLkk/Si+9dPDGNv3n0nu4JB3lxZMPt
         VLRosRG92R88/my7pXBJ6/wQf8G4A+KVIkyMtlMHl8HQTcCJ1Yo9ZOi1M7y33zne4+Py
         H6HTbh1cJO1hHXr6gJCy90VBKdbarNaKR5zoIdKufKSUe1t6QmW5otf+c4u9mwddQTfq
         NPrbLSeh9X1zagc1i6gHadH42oTd7jAEJiQEwuRC2sCd0py6/ez6TPlr/nale83R5K4d
         VcGafCX5u0HKX43HVzso2Ci1csqHToEoRl0jtbIJaKmjOL5jw3p8QDdMJpQKOuxY+RKR
         5rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjprifdxSiKHrnWlfhNRxh5ZE7VyCQPgycwdC6B4qmQ=;
        b=g7R6M/uKmluiey6kVD9xpyP9KJ0rO5Mp4QG7RHUTDxQ68C0UY+whhw0CZPIpvlTeTm
         qN4gMhvz8uYgAgf9OX+qn5UYwUpjYJAS5DsL94cd6UAd6WyiNCChHbr7F2GX406a0qD7
         0O+shaoxTvoMOT6f6o94SORaSONDIzPGlKdFtxwP4dx1sqDu5JS7lndlpsFeSl/g07Qj
         tyabtV10tZpNyRnCofJHLll2M9/WMH63opQlbCoe+61MKAYy7uSG/p049gNrPc5CIQaJ
         5yRRmKo6PlXiLCcas8ZTj8CZvSF9mI/yxQqktTrAT3Nj/Vo+1IuJHur23Oh4hG+x8WP0
         dTDg==
X-Gm-Message-State: APt69E2vdPJ4TwGTfSsNTEsTl7MjfVpvEvBJ8N2xC+oLogBKFUxNHIoK
        P7Q4qhfEwYRtm01rD8IOgtJ3+j40hiosh0hh/f4REw==
X-Google-Smtp-Source: AAOMgpdaPleW47ZVi3+u2X/lR6NTepOBFRv7b2M5TnnnDYIKdZr0ZC29ZeBeFByDqw1u1ZnUf1jxcC2ZLaWMa8LZ4Rk=
X-Received: by 2002:a81:6bc6:: with SMTP id g189-v6mr7982117ywc.267.1530542621565;
 Mon, 02 Jul 2018 07:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180702102201.13461-1-enric.balletbo@collabora.com> <20180702102201.13461-4-enric.balletbo@collabora.com>
In-Reply-To: <20180702102201.13461-4-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 2 Jul 2018 07:43:30 -0700
Message-ID: <CABXOdTfLS-x_sPWBi2mmjkUTtN0Spd9ObEy5fYtEB-hoLJTPEg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Input: keyboard: Fix ChromeOS EC keyboard help message.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>, kgene@kernel.org,
        krzk@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The cros-ec I2C and SPI transport drivers have been moved from MFD
> subsystem to platform/chrome, at the same time, the config symbol
> has been renamed and lost the MFD_ prefix So, update the help message
> accordingly.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 6bd97ffee761..4713957b0cbb 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -721,7 +721,7 @@ config KEYBOARD_CROS_EC
>         help
>           Say Y here to enable the matrix keyboard used by ChromeOS devices
>           and implemented on the ChromeOS EC. You must enable one bus option
> -         (MFD_CROS_EC_I2C or MFD_CROS_EC_SPI) to use this.
> +         (CROS_EC_I2C or CROS_EC_SPI) to use this.
>
>           To compile this driver as a module, choose M here: the
>           module will be called cros_ec_keyb.
> --
> 2.18.0
>
