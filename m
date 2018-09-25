Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B2AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BBE20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ChDEkvWY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="muL6AQec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BBE20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeIYP7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:59:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41268 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIYP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:59:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5006060274; Tue, 25 Sep 2018 09:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537869173;
        bh=S6E+vS43wLIvnVw8aajgG9/2eFPazue3fGJd9GQ6NxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ChDEkvWYxwE3N/yzr6QJHVNYiFVDjSWOwxHOiNEF8x6fNgw3Y6Z6y5sSNty05JvT/
         q25B1r4vnkqmNKG8azOBJUTQ36ogayJFaS0bUjPccbXMlkyHlVM84jf+2e5Shn0GP5
         PAX2mQIAQ8S6MHrIIXflfufi5fxQ9/OUCCwwpnZY=
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF961606DC;
        Tue, 25 Sep 2018 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537869172;
        bh=S6E+vS43wLIvnVw8aajgG9/2eFPazue3fGJd9GQ6NxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=muL6AQecEmZT8V+VqD5VfDbAlrY5gjCXuTApKGD/sX2yhmsmju3nD6NRd4K+l/EHG
         cCXAeUXYSeuKnRlHjXNQLwEpcpdfbXXES977GldvMTJzhA/ES5LmUuX8eONYMJU76b
         NxLji5x++48X4ESLu+r+Tw3MJN0G970BFhPzfnaQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF961606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f181.google.com with SMTP id q20-v6so8748266qkc.12;
        Tue, 25 Sep 2018 02:52:51 -0700 (PDT)
X-Gm-Message-State: ABuFfoj5U9dq3HisuRX4SlFM2ukGmjoheHxfibIRI7MSw9Eeh8VK2pLq
        cqzezQL7rJKp3IQQ4K57w6GmvyxKACzs3j7pZl4=
X-Google-Smtp-Source: ACcGV60fyjGRXPFWFwcOp0hg3uWPUs9CZ0SqXEiWk3TskllyjZ8pPRGC7S6c17vnBed2MCYN3FnIs6UVHyeON/PuVkQ=
X-Received: by 2002:a37:4b82:: with SMTP id y124-v6mr146970qka.118.1537869171263;
 Tue, 25 Sep 2018 02:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
 <20180904101719.18049-3-vivek.gautam@codeaurora.org> <20180924172432.GL1367@tuxbook-pro>
In-Reply-To: <20180924172432.GL1367@tuxbook-pro>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Tue, 25 Sep 2018 15:22:38 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFPOGRAToBrV44VDNYG4DP2c6_+8QZbKsDmM4SF57NGfQ@mail.gmail.com>
Message-ID: <CAFp+6iFPOGRAToBrV44VDNYG4DP2c6_+8QZbKsDmM4SF57NGfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] scsi/ufs: qcom: Remove ufs_qcom_phy_*() calls from host
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kishon <kishon@ti.com>, Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, open list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        evgreen@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, Sep 24, 2018 at 10:51 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 04 Sep 03:17 PDT 2018, Vivek Gautam wrote:
>
> > The host makes direct calls into phy using ufs_qcom_phy_*()
> > APIs. These APIs are only defined for 20nm qcom-ufs-qmp phy
> > which is not being used by any architecture as yet. Future
> > architectures too are not going to use 20nm ufs phy.
> > So remove these ufs_qcom_phy_*() calls from host to let further
> > change declare the 20nm phy as broken.
> > Also remove couple of stale enum defines for ufs phy.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Regards,
> Bjorn

Kishon is looking to pick this series through linux-phy tree.
Will you please consider giving your ack for this patch? Thanks.

Best regards
Vivek

>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-ufs-i.h |  2 +-
> >  drivers/scsi/ufs/ufs-qcom.c           | 28 +---------------------------
> >  drivers/scsi/ufs/ufs-qcom.h           |  5 -----
> >  include/linux/phy/phy-qcom-ufs.h      | 24 ------------------------
> >  4 files changed, 2 insertions(+), 57 deletions(-)
> >  delete mode 100644 include/linux/phy/phy-qcom-ufs.h
> >
> > diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> > index 822c83b8efcd..681644e43248 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> > +++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> > @@ -17,9 +17,9 @@
> >
> >  #include <linux/module.h>
> >  #include <linux/clk.h>
> > +#include <linux/phy/phy.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> > -#include <linux/phy/phy-qcom-ufs.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> >  #include <linux/delay.h>
> > diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> > index 75ee5906b966..3dc4501c6945 100644
> > --- a/drivers/scsi/ufs/ufs-qcom.c
> > +++ b/drivers/scsi/ufs/ufs-qcom.c
> > @@ -16,7 +16,6 @@
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/phy/phy.h>
> > -#include <linux/phy/phy-qcom-ufs.h>
> >
> >  #include "ufshcd.h"
> >  #include "ufshcd-pltfrm.h"
> > @@ -189,22 +188,9 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
> >
> >  static int ufs_qcom_link_startup_post_change(struct ufs_hba *hba)
> >  {
> > -     struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > -     struct phy *phy = host->generic_phy;
> >       u32 tx_lanes;
> > -     int err = 0;
> > -
> > -     err = ufs_qcom_get_connected_tx_lanes(hba, &tx_lanes);
> > -     if (err)
> > -             goto out;
> >
> > -     err = ufs_qcom_phy_set_tx_lane_enable(phy, tx_lanes);
> > -     if (err)
> > -             dev_err(hba->dev, "%s: ufs_qcom_phy_set_tx_lane_enable failed\n",
> > -                     __func__);
> > -
> > -out:
> > -     return err;
> > +     return ufs_qcom_get_connected_tx_lanes(hba, &tx_lanes);
> >  }
> >
> >  static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
> > @@ -932,10 +918,8 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> >  {
> >       u32 val;
> >       struct ufs_qcom_host *host = ufshcd_get_variant(hba);
> > -     struct phy *phy = host->generic_phy;
> >       struct ufs_qcom_dev_params ufs_qcom_cap;
> >       int ret = 0;
> > -     int res = 0;
> >
> >       if (!dev_req_params) {
> >               pr_err("%s: incoming dev_req_params is NULL\n", __func__);
> > @@ -1002,12 +986,6 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
> >               }
> >
> >               val = ~(MAX_U32 << dev_req_params->lane_tx);
> > -             res = ufs_qcom_phy_set_tx_lane_enable(phy, val);
> > -             if (res) {
> > -                     dev_err(hba->dev, "%s: ufs_qcom_phy_set_tx_lane_enable() failed res = %d\n",
> > -                             __func__, res);
> > -                     ret = res;
> > -             }
> >
> >               /* cache the power mode parameters to use internally */
> >               memcpy(&host->dev_req_params,
> > @@ -1264,10 +1242,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
> >               }
> >       }
> >
> > -     /* update phy revision information before calling phy_init() */
> > -     ufs_qcom_phy_save_controller_version(host->generic_phy,
> > -             host->hw_ver.major, host->hw_ver.minor, host->hw_ver.step);
> > -
> >       err = ufs_qcom_init_lane_clks(host);
> >       if (err)
> >               goto out_variant_clear;
> > diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
> > index 295f4bef6a0e..c114826316eb 100644
> > --- a/drivers/scsi/ufs/ufs-qcom.h
> > +++ b/drivers/scsi/ufs/ufs-qcom.h
> > @@ -129,11 +129,6 @@ enum {
> >       MASK_CLK_NS_REG                     = 0xFFFC00,
> >  };
> >
> > -enum ufs_qcom_phy_init_type {
> > -     UFS_PHY_INIT_FULL,
> > -     UFS_PHY_INIT_CFG_RESTORE,
> > -};
> > -
> >  /* QCOM UFS debug print bit mask */
> >  #define UFS_QCOM_DBG_PRINT_REGS_EN   BIT(0)
> >  #define UFS_QCOM_DBG_PRINT_ICE_REGS_EN       BIT(1)
> > diff --git a/include/linux/phy/phy-qcom-ufs.h b/include/linux/phy/phy-qcom-ufs.h
> > deleted file mode 100644
> > index 9dd85071bcce..000000000000
> > --- a/include/linux/phy/phy-qcom-ufs.h
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -/*
> > - * Copyright (c) 2013-2015, Linux Foundation. All rights reserved.
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 and
> > - * only version 2 as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > - *
> > - */
> > -
> > -#ifndef PHY_QCOM_UFS_H_
> > -#define PHY_QCOM_UFS_H_
> > -
> > -#include "phy.h"
> > -
> > -int ufs_qcom_phy_set_tx_lane_enable(struct phy *phy, u32 tx_lanes);
> > -void ufs_qcom_phy_save_controller_version(struct phy *phy,
> > -                     u8 major, u16 minor, u16 step);
> > -
> > -#endif /* PHY_QCOM_UFS_H_ */
> > --
> > QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> > of Code Aurora Forum, hosted by The Linux Foundation
> >



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
