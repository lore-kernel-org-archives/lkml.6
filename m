Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BFBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0EA206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tl7G5gW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfBWGrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:47:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44131 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBWGrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:47:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id g1so3799915otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 22:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WQYYwfUsX8qHp6XM/w6vKCS0c1JT3xEjAhAsJrtdcZ4=;
        b=tl7G5gW29fuRrjAS6amSLkWYSqeCnpPvuEZ3OTlqoCz1IFS670kyNnr2rY4BBLTXQp
         YAdGFqIp/i/+NcSq42p2BGj83xVZJV/SdPrkWo0g9vLxHSNSFPSiL5VJMmLKnTzmft+f
         8noYcij/8hND6yVlg6HFFn6KFB9hY5NvOugjIAOfqPG3EC4STDdk7IuB7kz9wzDMqK0m
         aZhk8fV/9WQLREpTup0Sh4cVFCEBn50C7i/hZ/Cp97pHqsr1c+lzJ0Rc1NWrbV4WhK25
         gDuxbZd9lx1tmeeO89nTgbUmmEUL3o6lNo6KwDgTNL7EU1mGV1ZfkMd1S8BFlzQfOCAz
         U7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WQYYwfUsX8qHp6XM/w6vKCS0c1JT3xEjAhAsJrtdcZ4=;
        b=uS6/uVYYdccL6E8omhpu5YD0kKJ6uonF0FNHeTLvxvV6P1rncg2ha0wefgMJa8otYn
         T2bI38uYistZLJRMjfGlhi5qTMrNghO/0O72jdOZiQRHJO4jx2BdSActBd4B+zHwDLW5
         CSz5RjxE6+cDTiKAm9cqvoxR5vs1BYqsQifldYGChVtTZgLSH+c8E3plgyrDnZXjkI+E
         cYuyliU/5ni/CulDvhMlpMZLJDypoYoM7dUtJOpqRvhfE1Ka0U/tUxkcLgZci09EepWT
         eHD9cEk83DxJrHEXdyqbP7zJr9dz5B/l1ICwBhiqIoYAWTO9JD67xZlOSSjXjz6zPURb
         Jxhg==
X-Gm-Message-State: AHQUAubaW+KOFtZnj3LCpSG5DCsdl2RGT0Khd5ej6WvommlMDFsCGwgk
        bNpdBrPU/fcQ/aH3E4qEpAaROXWLz051a06CDLE=
X-Google-Smtp-Source: AHgI3Ia4Md2xmpMmXTMwpeGg6Gs6DKK0a8liTv2y7nrTSvnGFqSyhJeA7TVsyp0N2jX7W5ab3KLI1B8Le43trcATiGo=
X-Received: by 2002:a9d:130:: with SMTP id 45mr5323041otu.355.1550904427850;
 Fri, 22 Feb 2019 22:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20190223063939.18261-1-tsu.yubo@gmail.com>
In-Reply-To: <20190223063939.18261-1-tsu.yubo@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 23 Feb 2019 07:46:56 +0100
Message-ID: <CAMhs-H9L7fB7eC_TJ1HR3G=vyjc6eEanwN82qH0ExCV1C1b1dw@mail.gmail.com>
Subject: Re: [PATCH] staging/ks7070: Removed unused varibale
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, quytelda@tamalin.org,
        devel@driverdev.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>, yuzibode@126.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bo,

On Sat, Feb 23, 2019 at 7:39 AM Bo YU <tsu.yubo@gmail.com> wrote:
>
> From: Bo Yu <tsu.yubo@gmail.com>
>
> Compiling the kernel with W=3D1 results in the following warning:
>
> drivers/staging/ks7010/ks_hostif.c:465:6: warning: variable =E2=80=98mib_=
val_type=E2=80=99
> set but not used [-Wunused-but-set-variable]
>   u16 mib_val_type;
>
> drivers/staging/ks7010/ks_hostif.c:464:6: warning: variable =E2=80=98mib_=
val_size=E2=80=99
> set but not used [-Wunused-but-set-variable]
>     u16 mib_val_size;
>
> drivers/staging/ks7010/ks_hostif.c:786:6: warning: variable =E2=80=98resu=
lt_code=E2=80=99
> set but not used [-Wunused-but-set-variable]
>       u16 result_code;
>
> Remove these variables.
>
> Rebase on next-20190222
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Quytelda Kahja <quytelda@tamalin.org>
>
> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/=
ks_hostif.c
> index d938b0997a53..913d8996437a 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -461,13 +461,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *=
priv)
>         struct net_device *dev =3D priv->net_dev;
>         u32 mib_status;
>         u32 mib_attribute;
> -       u16 mib_val_size;
> -       u16 mib_val_type;
>
>         mib_status =3D get_dword(priv);
>         mib_attribute =3D get_dword(priv);
> -       mib_val_size =3D get_word(priv);
> -       mib_val_type =3D get_word(priv);
>
>         if (mib_status) {
>                 netdev_err(priv->net_dev, "attribute=3D%08X, status=3D%08=
X\n",
> @@ -783,9 +779,7 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_priva=
te *priv)
>  static
>  void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
>  {
> -       u16 result_code;
>
> -       result_code =3D get_word(priv);
>         priv->infra_status =3D 1; /* infrastructure mode set */
>         hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);
>  }
> --
> 2.11.0
>

PATCH commit message is wrong: format, typos and driver name:

[PATCH] staging/ks7070: Removed unused varibale

Should be "staging: ks7010: removed unused variables"

Thanks,
    Sergio Paracuellos
