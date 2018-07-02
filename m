Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB6EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97010245C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h1WwlcZ/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h1WwlcZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97010245C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753123AbeGBRAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:00:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56088 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeGBRAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:00:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4972601EA; Mon,  2 Jul 2018 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530550820;
        bh=w8EmznJUqUgym3D8x6kU88PXJ+EHMC/2ayG/XbjXqfE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=h1WwlcZ/VxmGQ03zQRDTdXMhWP0d2+ZZe2CntPF6iPJFS4a9pDRhKq+NC+38KoyNW
         YFInJUwrlZIT9FrvAKFZRGar3uzvusG8qudol7bAulX4pV99/CXwW4yIfZCGUuHvLy
         CUyxU1YPMfyMKbIHtc9zU7bQNFeLjSfFwyEKlE6U=
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com [209.85.220.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 490FE607EB;
        Mon,  2 Jul 2018 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530550820;
        bh=w8EmznJUqUgym3D8x6kU88PXJ+EHMC/2ayG/XbjXqfE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=h1WwlcZ/VxmGQ03zQRDTdXMhWP0d2+ZZe2CntPF6iPJFS4a9pDRhKq+NC+38KoyNW
         YFInJUwrlZIT9FrvAKFZRGar3uzvusG8qudol7bAulX4pV99/CXwW4yIfZCGUuHvLy
         CUyxU1YPMfyMKbIHtc9zU7bQNFeLjSfFwyEKlE6U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 490FE607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk0-f182.google.com with SMTP id z74-v6so8988974qkb.10;
        Mon, 02 Jul 2018 10:00:20 -0700 (PDT)
X-Gm-Message-State: APt69E2bXm8xaE4T2SkDFVo9U55TjIQU/PeoL+G/T9RpnTBMOQlzJDsm
        MQPjwUAMThys7pZx/wG0yzsXdy104j0FLigwDYA=
X-Google-Smtp-Source: AAOMgpfRC/BOSrU9brUa7zUr732MJmdUovGJc40/eUK4Gp/pZG/jIy93HYVjkEEL1BNd5ZJyjdEN0wSdzXqvdDPMa24=
X-Received: by 2002:a37:7a46:: with SMTP id v67-v6mr21863057qkc.32.1530550819546;
 Mon, 02 Jul 2018 10:00:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:1082:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:00:19 -0700 (PDT)
In-Reply-To: <20180619083647.10116-2-cang@codeaurora.org>
References: <20180619083647.10116-1-cang@codeaurora.org> <20180619083647.10116-2-cang@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 2 Jul 2018 22:30:19 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHxu2GYAn8ftDuHfE1Hj=aQvd6Rum9zjEe-G1WHsAkZuw@mail.gmail.com>
Message-ID: <CAFp+6iHxu2GYAn8ftDuHfE1Hj=aQvd6Rum9zjEe-G1WHsAkZuw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] phy: Update PHY power control sequence
To:     Can Guo <cang@codeaurora.org>
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        asutoshd@codeaurora.org, Manu Gautam <mgautam@codeaurora.org>,
        kishon <kishon@ti.com>, "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 2:06 PM, Can Guo <cang@codeaurora.org> wrote:
> All PHYs should be powered on before register configuration starts. And
> only PCIe PHYs need an extra power control before deasserts reset state.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index 97ef942..ccb8578 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -935,10 +935,12 @@ static void qcom_qmp_phy_configure(void __iomem *base,
>         }
>  }
>
> -static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
> +static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>  {
> +       struct qcom_qmp *qmp = qphy->qmp;
>         const struct qmp_phy_cfg *cfg = qmp->cfg;
>         void __iomem *serdes = qmp->serdes;
> +       void __iomem *pcs = qphy->pcs;
>         void __iomem *dp_com = qmp->dp_com;
>         int ret, i;
>
> @@ -979,10 +981,6 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
>                 goto err_rst;
>         }
>
> -       if (cfg->has_phy_com_ctrl)
> -               qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
> -                            SW_PWRDN);
> -
>         if (cfg->has_phy_dp_com_ctrl) {
>                 qphy_setbits(dp_com, QPHY_V3_DP_COM_POWER_DOWN_CTRL,
>                              SW_PWRDN);
> @@ -1000,6 +998,12 @@ static int qcom_qmp_phy_com_init(struct qcom_qmp *qmp)
>                              SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
>         }
>
> +       if (cfg->has_phy_com_ctrl)
> +               qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
> +                            SW_PWRDN);
> +       else
> +               qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> +
>         /* Serdes configuration */
>         qcom_qmp_phy_configure(serdes, cfg->regs, cfg->serdes_tbl,
>                                cfg->serdes_tbl_num);
> @@ -1090,7 +1094,7 @@ static int qcom_qmp_phy_init(struct phy *phy)
>
>         dev_vdbg(qmp->dev, "Initializing QMP phy\n");
>
> -       ret = qcom_qmp_phy_com_init(qmp);
> +       ret = qcom_qmp_phy_com_init(qphy);
>         if (ret)
>                 return ret;
>
> @@ -1127,7 +1131,8 @@ static int qcom_qmp_phy_init(struct phy *phy)
>          * Pull out PHY from POWER DOWN state.
>          * This is active low enable signal to power-down PHY.
>          */
> -       qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
> +       if(cfg->type == PHY_TYPE_PCIE)
> +               qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
>
>         if (cfg->has_pwrdn_delay)
>                 usleep_range(cfg->pwrdn_delay_min, cfg->pwrdn_delay_max);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

Looks good.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Best regards
Vivek
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
