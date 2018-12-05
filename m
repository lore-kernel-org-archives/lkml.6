Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E01CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4262084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mT+miy/I";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mT+miy/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4262084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeLEGIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:08:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLEGIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:08:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B50D26028B; Wed,  5 Dec 2018 06:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543990083;
        bh=VW95LIG7I1iOe6p9U9kcZRxLDuZCFsjT6uTPka6QzZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mT+miy/IQJdK7HQ+8HdyHvrzuRp0Gu67ZVgViRpaFb/HwO75SRkWuZuwr0KQUOfGT
         L5U9StTsG3df+Wimto0uCAvi3S4pv+Aw8GIxz+EjVfssfjj+hYwTbKS9gV3UjZI5Ci
         s6SfHEZcQXkSBUiy+HaGEQuA1/k501Aoe1aQcO9o=
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E13D0607B5;
        Wed,  5 Dec 2018 06:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543990083;
        bh=VW95LIG7I1iOe6p9U9kcZRxLDuZCFsjT6uTPka6QzZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mT+miy/IQJdK7HQ+8HdyHvrzuRp0Gu67ZVgViRpaFb/HwO75SRkWuZuwr0KQUOfGT
         L5U9StTsG3df+Wimto0uCAvi3S4pv+Aw8GIxz+EjVfssfjj+hYwTbKS9gV3UjZI5Ci
         s6SfHEZcQXkSBUiy+HaGEQuA1/k501Aoe1aQcO9o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E13D0607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f179.google.com with SMTP id o89so11231290qko.0;
        Tue, 04 Dec 2018 22:08:02 -0800 (PST)
X-Gm-Message-State: AA+aEWbtVtsU9w/927G9H3vhMjwC4qV5tdO7ZK3QAIxB8N3Ngoujtk0b
        cnnrsjG2u1kcvfM0XB/6DcF71RkhdY2OQwaCve4=
X-Google-Smtp-Source: AFSGD/UaXvsrh3RSPkCTaILjW6cVa0fVhbx8P6L6TprMUzj6Tla0n5o0TzQRqbYSynDeNn8oXuiR3fj126V6qkxDWAs=
X-Received: by 2002:a37:b8a:: with SMTP id 132mr21390572qkl.140.1543990082141;
 Tue, 04 Dec 2018 22:08:02 -0800 (PST)
MIME-Version: 1.0
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org> <1540269361-28185-5-git-send-email-cang@codeaurora.org>
In-Reply-To: <1540269361-28185-5-git-send-email-cang@codeaurora.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Wed, 5 Dec 2018 11:37:50 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFi6dHnu_xVc63mdGFywWz7LxSKxW4UeoqHvKkLwKF1LQ@mail.gmail.com>
Message-ID: <CAFp+6iFi6dHnu_xVc63mdGFywWz7LxSKxW4UeoqHvKkLwKF1LQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] scsi: ufs: Add core reset support
To:     Can Guo <cang@codeaurora.org>
Cc:     Subhash Jadavani <subhashj@codeaurora.org>,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        Manu Gautam <mgautam@codeaurora.org>, kishon <kishon@ti.com>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dovl@codeaurora.org, anischal@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:06 AM Can Guo <cang@codeaurora.org> wrote:
>
> From: Dov Levenglick <dovl@codeaurora.org>
>
> Enables core reset support. Add full initialization of the PHY and the
> controller before initializing UFS PHY and during link recovery.
>
> Signed-off-by: Dov Levenglick <dovl@codeaurora.org>
> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufs-qcom.c      | 30 ++++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c | 22 ++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.c        | 13 +++++++++++++
>  drivers/scsi/ufs/ufshcd.h        | 12 ++++++++++++
>  4 files changed, 77 insertions(+)
>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 2b38db2..698b92d 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -616,6 +616,35 @@ static int ufs_qcom_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>         return err;
>  }
>
> +static int ufs_qcom_core_reset(struct ufs_hba *hba)
> +{
> +       int ret = -ENOTSUPP;
> +
> +       if (!hba->core_reset) {

This check doesn't make much sense.
You call this ".core_reset" callback only when "hba->core_reset" is available.
Why do we need to check this again here?

> +               dev_err(hba->dev, "%s: failed, err = %d\n", __func__,
> +                               ret);
> +               goto out;
> +       }
> +
> +       ret = reset_control_assert(hba->core_reset);
> +       if (ret) {
> +               dev_err(hba->dev, "core_reset assert failed, err = %d\n",
> +                               ret);
> +               goto out;
> +       }
> +
> +       /* As per spec, delay is required to let reset assert go through */
> +       usleep_range(1, 2);
> +
> +       ret = reset_control_deassert(hba->core_reset);
> +       if (ret)
> +               dev_err(hba->dev, "core_reset deassert failed, err = %d\n",
> +                               ret);
> +
> +out:
> +       return ret;
> +}
> +
>  struct ufs_qcom_dev_params {
>         u32 pwm_rx_gear;        /* pwm rx gear to work in */
>         u32 pwm_tx_gear;        /* pwm tx gear to work in */
> @@ -1670,6 +1699,7 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
>         .apply_dev_quirks       = ufs_qcom_apply_dev_quirks,
>         .suspend                = ufs_qcom_suspend,
>         .resume                 = ufs_qcom_resume,
> +       .core_reset             = ufs_qcom_core_reset,
>         .dbg_register_dump      = ufs_qcom_dump_dbg_regs,
>  };
>
> diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
> index e82bde0..dab11a7 100644
> --- a/drivers/scsi/ufs/ufshcd-pltfrm.c
> +++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
> @@ -42,6 +42,22 @@
>
>  #define UFSHCD_DEFAULT_LANES_PER_DIRECTION             2
>
> +static int ufshcd_parse_reset_info(struct ufs_hba *hba)
> +{
> +       int ret = 0;
> +
> +       hba->core_reset = devm_reset_control_get_optional_exclusive(hba->dev,
> +                               "rst");
> +       if (IS_ERR(hba->core_reset)) {
> +               ret = PTR_ERR(hba->core_reset);

First thing, you need to check here for EPROBE_DEFER, and return that
as reset framework may not be probed when this is probing.

Secondly, this whole parse thing can as well be moved to vops (variant ops) as
that's the device having knowledge of resets. Moreover, not all qcom
ufs controllers
have the reset, so I am tilting towards adding a of_match_data field and
corresponding compatible binding for sdm845 (and may be for future
SoCs too) so that we can make this reset mandatory for SoCs
where things won't work without it.
Simply acknowledging the absence of the reset and marking it as NULL
won't help 845 and brothers that need the reset.

Or, do we have any other solution to make this reset mandatory for 845?

> +               dev_err(hba->dev, "core_reset unavailable,err = %d\n",
> +                               ret);
> +               hba->core_reset = NULL;
> +       }
> +
> +       return ret;
> +}
> +
>  static int ufshcd_parse_clock_info(struct ufs_hba *hba)
>  {
>         int ret = 0;
> @@ -340,6 +356,12 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
>                 goto dealloc_host;
>         }
>
> +       err = ufshcd_parse_reset_info(hba);
> +       if (err) {
> +               dev_err(&pdev->dev, "%s: reset parse failed %d\n",
> +                               __func__, err);
> +       }
> +
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
>
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index a355d98..d18c3af 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -3657,6 +3657,15 @@ static int ufshcd_link_recovery(struct ufs_hba *hba)
>         ufshcd_set_eh_in_progress(hba);
>         spin_unlock_irqrestore(hba->host->host_lock, flags);
>
> +       if (hba->core_reset) {
> +               ret = ufshcd_vops_core_reset(hba);
> +               if (ret)
> +                       dev_err(hba->dev,
> +                               "full reset returned %d, trying to recover the link\n",
> +                               ret);
> +               return ret;
> +       }
> +
>         ret = ufshcd_host_reset_and_restore(hba);
>
>         spin_lock_irqsave(hba->host->host_lock, flags);
> @@ -7948,6 +7957,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>                 goto exit_gating;
>         }
>
> +       /* Reset controller to power on reset (POR) state */
> +       if (hba->core_reset)
> +               ufshcd_vops_core_reset(hba);
> +
>         /* Host controller enable */
>         err = ufshcd_hba_enable(hba);
>         if (err) {
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 1332e54..aa046a1 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -55,6 +55,7 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include "unipro.h"
>
>  #include <asm/irq.h>
> @@ -295,6 +296,8 @@ struct ufs_pwr_mode_info {
>   * @apply_dev_quirks: called to apply device specific quirks
>   * @suspend: called during host controller PM callback
>   * @resume: called during host controller PM callback
> + * @core_reset:  called before UFS PHY init and during link recovery for
> + *              handling variant specific implementations of resetting the hci
>   * @dbg_register_dump: used to dump controller debug information
>   * @phy_initialization: used to initialize phys
>   */
> @@ -323,6 +326,7 @@ struct ufs_hba_variant_ops {
>         int     (*apply_dev_quirks)(struct ufs_hba *);
>         int     (*suspend)(struct ufs_hba *, enum ufs_pm_op);
>         int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
> +       int     (*core_reset)(struct ufs_hba *);
>         void    (*dbg_register_dump)(struct ufs_hba *hba);
>         int     (*phy_initialization)(struct ufs_hba *);
>  };
> @@ -678,6 +682,7 @@ struct ufs_hba {
>         bool is_urgent_bkops_lvl_checked;
>
>         struct rw_semaphore clk_scaling_lock;
> +       struct reset_control *core_reset;
>         struct ufs_desc_size desc_size;
>  };
>
> @@ -979,6 +984,13 @@ static inline int ufshcd_vops_resume(struct ufs_hba *hba, enum ufs_pm_op op)
>         return 0;
>  }
>
> +static inline int ufshcd_vops_core_reset(struct ufs_hba *hba)
> +{
> +       if (hba->vops && hba->vops->core_reset)
> +               return hba->vops->core_reset(hba);
> +       return 0;
> +}
> +
>  static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
>  {
>         if (hba->vops && hba->vops->dbg_register_dump)
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
