Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBFD206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAXGlboE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbfBWHez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:34:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42642 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfBWHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:34:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id s16so3555623oih.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 23:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=odhp/8XXFG+hv1+3VVaZ1sBHS3feR+ZpFjJZAyYVhG8=;
        b=BAXGlboEd2zUbifpJuxLT3sOEAqeUeZjIomNz8KtKsMDZLUuDnsqedQ4Djr5B/32cH
         iCDdeuktyA+yCAsVNM9EAARUx2IVZG1VWGWADuTtGp1ybFRxNQ9yIr6eOWVwP6U92xpq
         e9SUy5Mf65+7vW0Rfpsm18+oufAJDF1LOaKopBdVMHD+lRejiVBEt1T8V+UGFEPYoQVi
         z3gyMCwjFYen2Spv9xGcKJDt8A6RKPN97Ei++aMZuBhOEJkyXd4LgFkkoPPmOl0jlPDy
         sYsf5up7HKlDElYckO3A/Nh75eTPDFYlSjPoMglNStHxmWpm+KctnJngmIgcj2U3qawv
         1mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=odhp/8XXFG+hv1+3VVaZ1sBHS3feR+ZpFjJZAyYVhG8=;
        b=DHOIZD5fGGkGkIa6rKtC/iRA2ccBQlUYePU7vmUCs467hSOW+qOFGQxUUw8tT8MmRj
         SGNCZ53/xNFSvzgM7Cr+Aoawb1ilF9rDH7D06hCzPNpc9RNe94Szyyj1Qr1YBkNdb05V
         BuofVbpLxPKEMdpDUdTW6fpJHOOQ65z1jED2NV7iJGo+hDteeyh4yLHjuDzYbKbZXDaY
         eqK98eVHl8NDUkvitRx0ZO5eIiQbVUK+0QmJ0ZGyNK95isVOm8iuirEGSaZDX+yeRil3
         TfwbIGjHQzshOj+1SaqedgbzGStZdtBRlmbOSSlzjAiPxhfD+tzzc307DyndwO8gETVI
         Td6Q==
X-Gm-Message-State: AHQUAuZhm57eCXg4gkMMSkpomVmwvGrg2aO6OiTmZNe4Yx6OcJsA7Emg
        R5RdQ/xt07uhNBBfMxOj3WZBjT26814jln0h4sU=
X-Google-Smtp-Source: AHgI3IbnCjOy+EIS1JsyJy9aIfHYsbCf/wFelqNFp7lClUwTNruFYP7slTTwib5DecM6m7W876p6FA/ikW0N+wjZ4RQ=
X-Received: by 2002:aca:d746:: with SMTP id o67mr5066777oig.100.1550907294056;
 Fri, 22 Feb 2019 23:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20190223072712.18422-1-tsu.yubo@gmail.com>
In-Reply-To: <20190223072712.18422-1-tsu.yubo@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 23 Feb 2019 08:34:42 +0100
Message-ID: <CAMhs-H_7-S-r+ZE_eB8HUr8Z-G=YqugY8rT5YXujUxoXVFT=0A@mail.gmail.com>
Subject: Re: [PATCH V2] staging: ks7070: removed unused varibales
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

On Sat, Feb 23, 2019 at 8:27 AM Bo YU <tsu.yubo@gmail.com> wrote:
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
> V2: fix patch format

As Dan has just said, this two rebase and v2 stuff is not needed in
the changelog.
Please, put it under the --- cut off line.

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

The commit message is still wrong. The driver name is not called
ks7070 is called ks7010, right? and
also the typo with "varibales" is still wrong... Let's do all changes
right at once, please :)

Best regards,
    Sergio Paracuellos
