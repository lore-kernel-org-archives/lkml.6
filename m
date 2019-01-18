Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C08C1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FgXCjUE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfARWjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:39:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39509 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729983AbfARWjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:39:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so6710195pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=I5SeoIlMVFQnmqo5kTGPoB9ahRptz+mc9GjJJ9ZvPk0=;
        b=FgXCjUE00oRLqKq+4laK23/RN34iNRQP4fSdU5PCmvVzIYmexQdR+8yTtlceOnDzRh
         YOIKkgdLbRVQneS+JVGAD1S29hReunrl1W2wleJ1aGMRZK9mV2ZSP2w4srSCPc9hTxUZ
         rNMEqCK+0ji3dS1539tH9Rq6LEnf4WQcKqng0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=I5SeoIlMVFQnmqo5kTGPoB9ahRptz+mc9GjJJ9ZvPk0=;
        b=e5a2W68NVo1N7miwBpKRjLd5EUhOIFd77dn6jzGgnjH5ju91jDcp4jZY8ieyKa+cm1
         zdk2oofUBcASX1ypQZjpIOoZ6ahOsfOUa/ori7Xz5IuXAnSvsmXlAKLZhO7fwbbweSLX
         zMkb3ubnHjXJo37JnAX5Ghk4a82gUM2/jmK/t200+2h5u73fHM8EwBC9B2lAIID/q/6j
         4Q24YpiAI6n29DIREX+kWxsoQ5OkYXNBAdTFLUsS7GKKCognzOEp3Y29pDjAkDmEseNw
         Zq7mE2gBA3qdwA/j1O2YlyMXlNhXsMRiB1WCLguggfZf6JDmbvCxqi3ThCsICtheC1ND
         /pMQ==
X-Gm-Message-State: AJcUukfAAud7L4FQkABfsZRofnWiYwY0IZwICoiOCiaouUxfFyYdVgRR
        NX78r1Ew8r85opRbs0yVW9rwWA==
X-Google-Smtp-Source: ALg8bN4IbL4DwHqGVWJnoGwKFAepuJN/8WU50MKXZWI+jOS+YTW+zbVEPV5SD+yPanPTTKSSSj7QJg==
X-Received: by 2002:a63:557:: with SMTP id 84mr19077204pgf.411.1547851143095;
        Fri, 18 Jan 2019 14:39:03 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v12sm5919314pgg.41.2019.01.18.14.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 14:39:02 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 7/8] phy: qcom-qmp: Move UFS phy to phy_poweron/off
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-8-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-8-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154785114149.169631.5500002081507832594@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 18 Jan 2019 14:39:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:28)
> For UFS, move the actual firing up of the PHY to phy_poweron and
> phy_poweroff callbacks, rather than init/exit. UFS calls
> phy_poweroff during suspend, so now all clocks and regulators for
> the phy can be powered down during suspend.
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
>=20
> ---
>=20
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 82 ++++++++---------------------
>  1 file changed, 23 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/p=
hy-qcom-qmp.c
> index eb1cac8f0fd4e..7766c6384d0a8 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1224,7 +1223,6 @@ static int qcom_qmp_phy_init(struct phy *phy)
>         int ret;
> =20
>         dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> -
>         if (cfg->has_ufsphy_reset) {
>                 /*
>                  * Get UFS reset, which is delayed until now to avoid a

Nitpick: Drop this hunk.

> @@ -1360,7 +1353,6 @@ static int qcom_qmp_phy_exit(struct phy *phy)
> =20
>         /* Put PHY into POWER DOWN state: active low */
>         qphy_clrbits(qphy->pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> -
>         if (cfg->has_lane_rst)
>                 reset_control_assert(qphy->lane_rst);
> =20

And this hunk.

> @@ -1371,44 +1363,6 @@ static int qcom_qmp_phy_exit(struct phy *phy)
>         return 0;
>  }
> =20
> -static int qcom_qmp_phy_poweron(struct phy *phy)
> -{
> -       struct qmp_phy *qphy =3D phy_get_drvdata(phy);
> -       struct qcom_qmp *qmp =3D qphy->qmp;
> -       const struct qmp_phy_cfg *cfg =3D qmp->cfg;
> -       void __iomem *pcs =3D qphy->pcs;
> -       void __iomem *status;
> -       unsigned int mask, val;
> -       int ret =3D 0;
> -
> -       if (cfg->type !=3D PHY_TYPE_UFS)
> -               return 0;
> -
> -       /*
> -        * For UFS PHY that has not software reset control, serdes start
> -        * should only happen when UFS driver explicitly calls phy_power_=
on
> -        * after it deasserts software reset.
> -        */
> -       if (cfg->no_pcs_sw_reset && !qmp->phy_initialized &&
> -           (qmp->init_count !=3D 0)) {
> -               /* start SerDes and Phy-Coding-Sublayer */
> -               qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], cfg->start_=
ctrl);
> -
> -               status =3D pcs + cfg->regs[QPHY_PCS_READY_STATUS];
> -               mask =3D cfg->mask_pcs_ready;
> -
> -               ret =3D readl_poll_timeout(status, val, !(val & mask), 1,
> -                                        PHY_INIT_COMPLETE_TIMEOUT);

So we never need to poll this bit anymore?

> -               if (ret) {
> -                       dev_err(qmp->dev, "phy initialization timed-out\n=
");
> -                       return ret;
> -               }
> -               qmp->phy_initialized =3D true;
> -       }
> -
> -       return ret;
> -}
> -
>  static int qcom_qmp_phy_set_mode(struct phy *phy,
>                                  enum phy_mode mode, int submode)
>  {
> @@ -1658,9 +1612,15 @@ static int phy_pipe_clk_register(struct qcom_qmp *=
qmp, struct device_node *np)
>  }
> =20
>  static const struct phy_ops qcom_qmp_phy_gen_ops =3D {
> -       .init           =3D qcom_qmp_phy_init,
> -       .exit           =3D qcom_qmp_phy_exit,
> -       .power_on       =3D qcom_qmp_phy_poweron,
> +       .init           =3D qcom_qmp_phy_enable,
> +       .exit           =3D qcom_qmp_phy_disable,
> +       .set_mode       =3D qcom_qmp_phy_set_mode,
> +       .owner          =3D THIS_MODULE,
> +};
> +
> +static const struct phy_ops qcom_qmp_ufs_ops =3D {
> +       .power_on       =3D qcom_qmp_phy_enable,
> +       .power_off      =3D qcom_qmp_phy_disable,
>         .set_mode       =3D qcom_qmp_phy_set_mode,
>         .owner          =3D THIS_MODULE,
>  };

So the UFS and the non-UFS phys will use the same single function, but
the callers of the phys will see that phy_power_on() powers on the phy
for UFS but does nothing for non-UFS devices? Do the users of this
common phy call the API differently between drivers? Kishon, is there
guidance on how phys are supposed to be used by drivers?

