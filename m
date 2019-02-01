Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995D921872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 18:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="csI3b8OH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfBASAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 13:00:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40365 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfBASAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 13:00:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so3574856plq.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:from:message-id:cc
         :references:user-agent:to:in-reply-to:date;
        bh=lNKAqHWsug1zDVyHMVJ3Sq26yZLN+JGAIGN8MgKwUoM=;
        b=csI3b8OHAppNTcw9vPtScpAzYnkrghzM7geHzt++seaeRzJMbETNQz8RM+GI4UVBGq
         UIMCPhRvuIUKSVeLMstr96zOH80+AKNujgS21Z5DuCrfdR82rOK8wRD+uDz8NSsTeVWH
         CNLvJvicXEnCS845cSs9qk/cn9ssmQlAqduYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:message-id:cc:references:user-agent:to:in-reply-to:date;
        bh=lNKAqHWsug1zDVyHMVJ3Sq26yZLN+JGAIGN8MgKwUoM=;
        b=k00iLXdsZzfh7fyrC7wyQNy5PEZh4xgaBPciiGMkyihHaLk3SMa+zpH9O8xc01q70/
         REwoNmfgTDWivKdjTwUGj0DdSSvZuEnnBGexL5NZWRuQaEOka6e4XLPeoSfav8g2nAgc
         0gTijOp2K8O2+Ff1STo3BJE8VaFoVO5FamUvdgkFxVFMX8zR99MCyHusGVXbXA1slGq6
         l17Pk2FLwhQZdNe313vuTGmLWFK+70pMKXpmnVgvStS7aKVHLI15kcN/fk78HeRwx5/e
         v8s4gwGetvfstQoUIFBevQ04xfCwc07cwW9eFsp1zffKQLwaDiAqOpXpxihpj3MoQCFF
         Gb0Q==
X-Gm-Message-State: AJcUukcAXTriDosy5gBPo1EzDTba6XRfOH3h2EGnDEVUNLqXGYvgvS8O
        vR7ORKC26XNCMmE9B0PNQnklGA==
X-Google-Smtp-Source: ALg8bN4cmWPLi1BMhu/7PbcysfFrPG4qrpiMqVY/imJoaSM0wpvRZsYI3aPdGTh3iabXHxUVW4E7FA==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr40097538pla.136.1549044006983;
        Fri, 01 Feb 2019 10:00:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d21sm10442922pfo.162.2019.02.01.10.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:00:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 7/9] phy: qcom-qmp: Utilize UFS reset controller
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154904400541.169292.16178504232098968369@swboyd.mtv.corp.google.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
References: <20190123221137.41722-1-evgreen@chromium.org> <20190123221137.41722-8-evgreen@chromium.org>
User-Agent: alot/0.8
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20190123221137.41722-8-evgreen@chromium.org>
Date:   Fri, 01 Feb 2019 10:00:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-23 14:11:35)
> @@ -1144,6 +1150,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg =
=3D {
> =20
>         .is_dual_lane_phy       =3D true,
>         .no_pcs_sw_reset        =3D true,
> +
> +       .has_ufsphy_reset       =3D true,

Is this the same as .no_pcs_sw_reset implying that .has_ufsphy_reset? Or
it's possible to have no resets at all? I'd think there's a reset in the
phy or in the pcs and so we could just have one bit telling us which
type of reset to perform.

>  };
> =20
>  static const struct qmp_phy_cfg msm8998_usb3phy_cfg =3D {
> @@ -1314,6 +1322,9 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *q=
mp)
>                 return 0;
>         }
> =20
> +       if (qmp->ufs_reset)
> +               reset_control_assert(qmp->ufs_reset);
> +
>         if (cfg->has_phy_com_ctrl) {
>                 qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
>                              SERDES_START | PCS_START);
> @@ -1351,6 +1362,33 @@ static int qcom_qmp_phy_init(struct phy *phy)
> =20
>         dev_vdbg(qmp->dev, "Initializing QMP phy\n");
> =20
> +       if (cfg->has_ufsphy_reset) {
> +               /*
> +                * Get UFS reset, which is delayed until now to avoid a
> +                * circular dependency where UFS needs its PHY, but the P=
HY
> +                * needs this UFS reset.
> +                */
> +               if (!qmp->ufs_reset) {
> +                       qmp->ufs_reset =3D
> +                               devm_reset_control_get_exclusive(qmp->dev,
> +                                                                "ufsphy"=
);
> +
> +                       if (IS_ERR(qmp->ufs_reset)) {
> +                               dev_err(qmp->dev,
> +                                       "failed to get UFS reset: %d\n",
> +                                       PTR_ERR(qmp->ufs_reset));
> +
> +                               ret =3D PTR_ERR(qmp->ufs_reset);

Do this ret conversion once and then print it after?

> +                               qmp->ufs_reset =3D NULL;
> +                               return ret;
> +                       }
> +               }
> +
> +               ret =3D reset_control_assert(qmp->ufs_reset);
> +               if (ret)
> +                       goto err_lane_rst;
> +       }
> +
>         ret =3D qcom_qmp_phy_com_init(qphy);
>         if (ret)
>                 return ret;
