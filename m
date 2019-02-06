Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D98C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFAC218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZXOZp4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfBFVdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:33:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42996 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:33:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id m6so277853pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=3ScVk74bTcPqA4nBgZrKlXNYiYp/LJ5KXJCB8Gxqb88=;
        b=RZXOZp4nXYU9DvKx42qWYW58RfM1fAoJBGn4XT1/bW5OW+mSJ47b95YdvpvponQ6lH
         Xhortgy473EW0FFHUu7WlscaiN94n0UtPpqhgs9WnDIMuJnIbubn3QqyEM4tP8725Zzw
         be07q5XMmlDS4p1aCaEMSsCSf+M/L9aTKshXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=3ScVk74bTcPqA4nBgZrKlXNYiYp/LJ5KXJCB8Gxqb88=;
        b=aeo6LB5T4gNfNxxUJvbSzTIt3RR04gqzkxwt9qBfb8A0mgeU6liNKeU9JPzvIeijKn
         qbi+P4oc2NjFdrH6Uxm9rIhNaMqqR3yVO9jp5J7mYe2SRp9faNIKND4HQXfdEfrv+9/a
         wM5SV0NQflNS2ajETWpPDwy1ctuzWArn+1wqMAhhxqm+tR+w+vt56e/QkcNfH5X6CXUR
         KpEKUzDDXuFgEW/sfc9cQ7tgm9zSLCDxkzntvc3xR4mIDYF2ksflN5GKr+uFm+zDselS
         pTSk0nJIbpxrj7WWVmrC1N2IBRWm5TBQSu+KfCJqqFggDErZdGVosJX0ufU3UpjfHCaG
         N8fw==
X-Gm-Message-State: AHQUAuZ4aI6EzW6fFHJ9cbutUTVOkSJLZLRusEQnreT0vM9800AQ370F
        qc9lL8mxr34JAoKPOxJOptMwwg==
X-Google-Smtp-Source: AHgI3IYx3b8MRVUDMDdXNKqQANfqRu9CjBOK53mi3yWwp9e1vyeZpxSM8UhpF9DyDEs3hNb4Fz6mdQ==
X-Received: by 2002:a62:c505:: with SMTP id j5mr12581457pfg.149.1549488784967;
        Wed, 06 Feb 2019 13:33:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m9sm9727715pgr.7.2019.02.06.13.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 13:33:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20190205185902.106085-8-evgreen@chromium.org>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 7/8] phy: qcom: Utilize UFS reset controller
Message-ID: <154948878332.115909.8361746129233481633@swboyd.mtv.corp.google.com>
References: <20190205185902.106085-1-evgreen@chromium.org> <20190205185902.106085-8-evgreen@chromium.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-scsi@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 06 Feb 2019 13:33:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-02-05 10:59:01)
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c b/drivers/phy/q=
ualcomm/phy-qcom-ufs-qmp-20nm.c
> index aef40f7a41d4..b05f89d734f0 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c
> @@ -67,6 +67,16 @@ static int ufs_qcom_phy_qmp_20nm_init(struct phy *gene=
ric_phy)
>         bool is_rate_B =3D false;
>         int ret;
> =20
> +       ret =3D ufs_qcom_phy_get_reset(phy_common);
> +       if (ret)
> +               return ret;
> +
> +       if (phy_common->ufs_reset) {
> +               ret =3D reset_control_assert(phy_common->ufs_reset);

It looks like you can always call this and set phy_common->ufs_reset to
NULL when it should be a no-op. But it would never be NULL because we
would always fail earlier in ufs_qcom_phy_get_reset()?

> +               if (ret)
> +                       return ret;
> +       }
> +
>         if (phy_common->mode =3D=3D PHY_MODE_UFS_HS_B)
>                 is_rate_B =3D true;
> =20
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs.c b/drivers/phy/qualcomm/p=
hy-qcom-ufs.c
> index f2979ccad00a..9cc8aa0b7a4f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
> @@ -147,6 +147,22 @@ struct phy *ufs_qcom_phy_generic_probe(struct platfo=
rm_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(ufs_qcom_phy_generic_probe);
> =20
> +int ufs_qcom_phy_get_reset(struct ufs_qcom_phy *phy_common)
> +{
> +       struct reset_control *reset;
> +
> +       if (phy_common->ufs_reset)
> +               return 0;
> +
> +       reset =3D devm_reset_control_get_exclusive_by_index(phy_common->d=
ev, 0);
> +       if (IS_ERR(reset))
> +               return PTR_ERR(reset);
> +
> +       phy_common->ufs_reset =3D reset;
> +       return 0;

I find this API weird that it doesn't return the pointer to the reset
controller. It would be more kernel idiomatic if it returned the pointer
and used error pointers.

Are there now two places where we're getting the reset controller? I'm
confused now.

> +}
> +EXPORT_SYMBOL_GPL(ufs_qcom_phy_get_reset);
> +
>  static int __ufs_qcom_phy_clk_get(struct device *dev,
>                          const char *name, struct clk **clk_out, bool err=
_print)
>  {
> @@ -533,6 +549,14 @@ int ufs_qcom_phy_power_on(struct phy *generic_phy)
>         if (phy_common->is_powered_on)
>                 return 0;
> =20
> +       if (phy_common->ufs_reset) {
> +               err =3D reset_control_deassert(phy_common->ufs_reset);
> +               if (err) {
> +                       dev_err(dev, "Failed to assert UFS PHY reset");
> +                       return err;
> +               }
> +       }
> +
>         if (!phy_common->is_started) {
>                 err =3D ufs_qcom_phy_start_serdes(phy_common);
>                 if (err)
> @@ -620,6 +644,9 @@ int ufs_qcom_phy_power_off(struct phy *generic_phy)
> =20
>         ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_pll);
>         ufs_qcom_phy_disable_vreg(phy_common->dev, &phy_common->vdda_phy);
> +       if (phy_common->ufs_reset)
> +               reset_control_assert(phy_common->ufs_reset);

All these ifs can go away basically.

> +
>         phy_common->is_powered_on =3D false;
> =20
>         return 0;
