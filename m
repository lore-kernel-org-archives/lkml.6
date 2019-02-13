Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F95C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD80222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/qbU+Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbfBMGqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:46:06 -0500
Received: from mail-vs1-f47.google.com ([209.85.217.47]:33234 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfBMGqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:46:06 -0500
Received: by mail-vs1-f47.google.com with SMTP id k11so792366vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaaxK45HV6J0S+JnMGC2Qo7gtVUUN33pe4tyM79VtP4=;
        b=a/qbU+GognQORXcmvesxZJBaXDZICAGSXmNCJ6HWOl05sI413tTu/ckYQDGD2oHXsu
         rHMpxPo5sWU8UZUOJvncdThZFQZ+o7+OVwcx8/e9FxVBuDMrEjRuNbZsl/oS0Ktw+huC
         TVIlyX7JAwfNJZKD28OfMotpeDnLBQxA01l9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaaxK45HV6J0S+JnMGC2Qo7gtVUUN33pe4tyM79VtP4=;
        b=E+mIXt9go2/UwBuZNi6As7wVB4GIZRzweEBEjmg8fgNzEIvs4zowuGqnxRaZhdlqkG
         H8Tgy2t9iQIuBhzMxTwZI+8UOAnsqrEsxoNGlrd7Psrv9xaHuiQzaluoqkL5O4vgygSU
         vs6YIIULRjLgj4hwo10CcTkOsI/2Q99HRk/gyr0WQgyNU+xyoWDf1+mJJQtjEyNoFTSS
         fzmXZAUyQ2CWaBN8yvQHXdkwjOvQsB2DFWMoTUIfC0OZgJOidQrOr+ZRM6ilP3UTmAHX
         A5RYS/zKswQFLuuYRGB4DXc8UP28S6eY5ZTYmP4tcjmbNU8DXDGzRliFlg5QRVCpObga
         hcUg==
X-Gm-Message-State: AHQUAuapXaltvx8USjDE4LvPNOH/KrMiwk+k8dLUbUHitXm8N8s6VG62
        pES9WN+fG64Bvy1sUrkf/7TszaEQTPzP8vc2Z+ejRQ==
X-Google-Smtp-Source: AHgI3IbPdXQjUC7jJlo1ltGJL6RmmODEqk3mNjiz70/VwD6au4fXC9a7QW2mGxH/NfBAmEYSHKzn8gvyO7Cukx85Gl0=
X-Received: by 2002:a67:d20d:: with SMTP id y13mr3198767vsi.163.1550040365072;
 Tue, 12 Feb 2019 22:46:05 -0800 (PST)
MIME-Version: 1.0
References: <20190213062956.146536-1-weiyongjun1@huawei.com>
In-Reply-To: <20190213062956.146536-1-weiyongjun1@huawei.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Wed, 13 Feb 2019 14:45:38 +0800
Message-ID: <CAFv8NwLSGmKEYeGgo_DQFJAWV8rJrgxR2Rv-f9gv3SkrT8eKMg@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: cros_ec_codec: Make symbol 'cros_ec_dai' static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 2:16 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> Fixes the following sparse warning:
>
> sound/soc/codecs/cros_ec_codec.c:209:27: warning:
>  symbol 'cros_ec_dai' was not declared. Should it be static?
>
> Fixes: b291f42a3718 ("ASoC: cros_ec_codec: Add codec driver for Cros EC")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/codecs/cros_ec_codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index b14100b6a939..99a3af8a15ff 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -206,7 +206,7 @@ static const struct snd_soc_dai_ops cros_ec_i2s_dai_ops = {
>         .set_fmt = cros_ec_i2s_set_dai_fmt,
>  };
>
> -struct snd_soc_dai_driver cros_ec_dai[] = {
> +static struct snd_soc_dai_driver cros_ec_dai[] = {
>         {
>                 .name = "cros_ec_codec I2S",
>                 .id = 0,
>
>
>
Hi Wei,
  Yes you are right. Thanks for the fix!
