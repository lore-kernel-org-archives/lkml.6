Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5DAC1B0FD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F812054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gRBg6j3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfARWbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:31:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41336 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbfARWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:31:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so6925395plm.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=Lon7pxiXPK4Kc0hwgz6kpt12oRXb/iCf600j1lywq3c=;
        b=gRBg6j3m0ToSCYrx2rFR/n3GHZXlgDwjrTpn5F3CL5vCC5W7kWHhdM9NmE1w6ktyOT
         yzgotACoGUHMN6cCrBc+mdzEpT+RkJ58NrXmx6GSKVlsbsxAn3D5eNJ8lsseZmMEAmo+
         ZjcVLkWhv+HHm263JTTkAlhjM52uAzGKkV9g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=Lon7pxiXPK4Kc0hwgz6kpt12oRXb/iCf600j1lywq3c=;
        b=TMGJPwI1rE4qOAUX/V2fN7Xr3z/mqhv0c6cn634BElgcCni3OXHDkGFgH9U4TFtwUS
         p+cf+QScMLRniCamkkdzWIpTTF/nefZN36LPYfHNvOktNek/9gs7Tj0dRUfCKQFsbgk9
         l3czFkYWTbWRHC4UIfFwV/8/PzPiuHZDDZOIwRj2Cy5AAjqbQB2Q0Ng2Gm+xW1gLEf8H
         t4DHntdxJQ+FmWDJFSJynHGmcvZbEFXMj9FaM1nttSmawYlRtdLFhNzsB5WMeiYYsPz2
         UrOAyCAA4IEyZNwasfO02L6puadxLbEtUTP6PD0fudufMU+sfDZWIzjEhbFbkZRkQJ8l
         hHJw==
X-Gm-Message-State: AJcUukdNdFXTkDuKKoSEf1LgrJGalaKp2mwqENeiVf5Orizsad+zdQU0
        UWhILR9bLRNIx5LHvdNeYXfMkQ==
X-Google-Smtp-Source: ALg8bN4t4omHQH9yqQ2q8Vu4vhtCNFGKgG8FYNlBVyIwSVydI+MLw1JI5+xV342K1Y0J9CSe0sBZzQ==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr20741577pld.240.1547850664015;
        Fri, 18 Jan 2019 14:31:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n21sm8538958pfg.84.2019.01.18.14.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 14:31:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 5/8] scsi: ufs: qcom: Expose the reset controller for PHY
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-6-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-6-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154785066196.169631.9228316876601255899@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 18 Jan 2019 14:31:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:26)
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 3aeadb14aae1e..db46f9a64b54c 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -16,6 +16,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
> +#include <linux/reset.h>

Shouldn't this be <linux/reset-controller.h>?

> =20
>  #include "ufshcd.h"
>  #include "ufshcd-pltfrm.h"
> @@ -255,11 +261,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba=
 *hba)
>         if (is_rate_B)
>                 phy_set_mode(phy, PHY_MODE_UFS_HS_B);
> =20
> -       /* Assert PHY reset and apply PHY calibration values */
> -       ufs_qcom_assert_reset(hba);
> -       /* provide 1ms delay to let the reset pulse propagate */
> -       usleep_range(1000, 1100);
> -
>         /* phy initialization - calibrate the phy */
>         ret =3D phy_init(phy);
>         if (ret) {
> @@ -268,15 +269,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba=
 *hba)
>                 goto out;
>         }
> =20
> -       /* De-assert PHY reset and start serdes */
> -       ufs_qcom_deassert_reset(hba);
> -
> -       /*
> -        * after reset deassertion, phy will need all ref clocks,
> -        * voltage, current to settle down before starting serdes.
> -        */
> -       usleep_range(1000, 1100);
> -
>         /* power on phy - start serdes and phy's power and clocks */
>         ret =3D phy_power_on(phy);
>         if (ret) {
> @@ -290,7 +282,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba =
*hba)
>         return 0;
> =20
>  out_disable_phy:
> -       ufs_qcom_assert_reset(hba);
>         phy_exit(phy);
>  out:
>         return ret;
> @@ -554,21 +545,10 @@ static int ufs_qcom_suspend(struct ufs_hba *hba, en=
um ufs_pm_op pm_op)
>                 ufs_qcom_disable_lane_clks(host);
>                 phy_power_off(phy);
> =20
> -               /* Assert PHY soft reset */
> -               ufs_qcom_assert_reset(hba);
> -               goto out;
> -       }
> -
> -       /*
> -        * If UniPro link is not active, PHY ref_clk, main PHY analog pow=
er
> -        * rail and low noise analog power rail for PLL can be switched o=
ff.

We lost this comment?

> -        */
> -       if (!ufs_qcom_is_link_active(hba)) {
> +       } else if (!ufs_qcom_is_link_active(hba)) {
>                 ufs_qcom_disable_lane_clks(host);
> -               phy_power_off(phy);

And now this looks similar to the above if statement, so can they be
combined?

> =20
> -out:
>         return ret;
>  }
> =20
> @@ -578,21 +558,26 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enu=
m ufs_pm_op pm_op)
>         struct phy *phy =3D host->generic_phy;
>         int err;
> =20
> -       err =3D phy_power_on(phy);
> -       if (err) {
> -               dev_err(hba->dev, "%s: failed enabling regs, err =3D %d\n=
",
> -                       __func__, err);
> -               goto out;
> -       }
> +       if (ufs_qcom_is_link_off(hba)) {
> +               err =3D phy_power_on(phy);
> +               if (err) {
> +                       dev_err(hba->dev, "%s: failed enabling regs, err =
=3D %d\n",

Not a problem with this translation, but I would expect this error to
say something more like 'failed to power on phy' instead of 'enabling
regs'.

> +                               __func__, err);
> +                       return err;
> +               }
> =20
> -       err =3D ufs_qcom_enable_lane_clks(host);
> -       if (err)
> -               goto out;
> +               err =3D ufs_qcom_enable_lane_clks(host);
> +               if (err)
> +                       return err;
> =20
> -       hba->is_sys_suspended =3D false;
> +       } else if (!ufs_qcom_is_link_active(hba)) {
> +               err =3D ufs_qcom_enable_lane_clks(host);
> +               if (err)
> +                       return err;
> +       }
> =20
> -out:
> -       return err;
> +       hba->is_sys_suspended =3D false;
> +       return 0;
>  }
> =20
>  struct ufs_qcom_dev_params {
> @@ -1118,8 +1103,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hb=
a, bool on,
>                 return 0;
> =20
>         if (on && (status =3D=3D POST_CHANGE)) {
> -               phy_power_on(host->generic_phy);
> -

How is it ok to remove this call here?

>                 /* enable the device ref clock for HS mode*/
>                 if (ufshcd_is_hs_mode(&hba->pwr_info))
>                         ufs_qcom_dev_ref_clk_ctrl(host, true);
> @@ -1131,9 +1114,6 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hb=
a, bool on,
>                 if (!ufs_qcom_is_link_active(hba)) {
>                         /* disable device ref_clk */
>                         ufs_qcom_dev_ref_clk_ctrl(host, false);
> -
> -                       /* powering off PHY during aggressive clk gating =
*/
> -                       phy_power_off(host->generic_phy);

And here?

>                 }
> =20
>                 vote =3D host->bus_vote.min_bw_vote;
> @@ -1147,6 +1127,39 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *h=
ba, bool on,
>         return err;
>  }
> =20
> +static int
> +ufs_qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long =
id)
> +{
> +       struct ufs_qcom_host *host =3D rcdev_to_ufs_host(rcdev);
> +
> +       WARN_ON(id);

Nitpick: Add a comment explaining that there's only one reset expected?

> +       ufs_qcom_assert_reset(host->hba);
> +       /* provide 1ms delay to let the reset pulse propagate */
> +       usleep_range(1000, 1100);
> +       return 0;
> +}
> +
> +static int
> +ufs_qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned lon=
g id)
> +{
> +       struct ufs_qcom_host *host =3D rcdev_to_ufs_host(rcdev);
> +
> +       WARN_ON(id);

Same nitpick.

> +       ufs_qcom_deassert_reset(host->hba);
> +
> +       /*
> +        * after reset deassertion, phy will need all ref clocks,
> +        * voltage, current to settle down before starting serdes.
> +        */
> +       usleep_range(1000, 1100);
> +       return 0;
> +}
> +
> +const struct reset_control_ops ufs_qcom_reset_ops =3D {

Can it be static?

> +       .assert =3D ufs_qcom_reset_assert,
> +       .deassert =3D ufs_qcom_reset_deassert,
> +};
> +
>  #define        ANDROID_BOOT_DEV_MAX    30
>  static char android_boot_dev[ANDROID_BOOT_DEV_MAX];
> =20
